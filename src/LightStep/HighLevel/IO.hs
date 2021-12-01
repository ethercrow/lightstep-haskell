{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnliftedFFITypes #-}

module LightStep.HighLevel.IO
  ( module LightStep.HighLevel.IO,
    module OpenTelemetry.Lightstep.Config,
    SpanContext,
  )
where

import Foreign.C.Types
import GHC.Prim
import Data.Word
import Data.IORef
import Control.Concurrent
import Control.Concurrent.Async
import Control.Concurrent.STM
import Control.Monad.Catch
import Control.Monad.Except
import qualified Data.HashMap.Strict as HM
import Data.Maybe
import qualified Data.Text as T
import GHC.Conc
import qualified LightStep.Diagnostics as Diag
import LightStep.Internal.Debug
import System.IO.Unsafe
import System.Timeout
import OpenTelemetry.Common hiding (Event(Event))
import OpenTelemetry.SpanContext
import OpenTelemetry.Lightstep.Exporter
import OpenTelemetry.Lightstep.Config
import System.Random

{-# NOINLINE globalSharedMutableSpanStacks #-}
globalSharedMutableSpanStacks :: IORef (HM.HashMap Word32 [Span])
globalSharedMutableSpanStacks = unsafePerformIO (newIORef mempty)

withSpan :: forall m a. MonadIO m => MonadMask m => T.Text -> m a -> m a
withSpan opName action = withSpanAndTags opName [] action

withSpanAndTags :: forall m a. MonadIO m => MonadMask m => T.Text -> [(T.Text, T.Text)] -> m a -> m a
withSpanAndTags opName initialTags action = do
   bytes_before <- liftIO getAllocationCounter
   fst <$> generalBracket
        (pushSpan opName initialTags)
        (\sp exitcase -> do
          bytes_after <- liftIO getAllocationCounter
          let alloc = T.pack $ show $ bytes_before - bytes_after
          case exitcase of
            ExitCaseSuccess _ -> setTag "alloc" alloc
            ExitCaseException ex -> do
              setTags [
                ("alloc", alloc),
                ("error", "true"),
                ("error.message", (T.pack $ displayException ex))]
            ExitCaseAbort -> do
              setTags [
                ("alloc", alloc),
                ("error", "true"),
                ("error.message", "abort")]
          popSpan)
        (\_ -> action)

pushSpan :: (MonadIO m, ToTagValue v) => T.Text -> [(T.Text, v)] -> m Span
pushSpan opName initialTags = liftIO $ do
  ts <- now64
  thId <- myThreadId_Word32
  sid <- randomIO
  let sp = Span ctx opName thId thId ts 0 tags [] OK Nothing 0
      tags = HM.fromList [(TagName k, toTagValue v) | (k, v) <- initialTags]
      ctx = SpanContext (SId sid) (TId sid)
  atomicModifyIORef' globalSharedMutableSpanStacks $ \stacks ->
    case fromMaybe [] (HM.lookup thId stacks) of
      [] -> do
        (HM.insert thId [sp] stacks, ())
      (psp : _) ->
        let SpanContext psid tid = spanContext psp
            SpanContext sid _ = spanContext sp
            !sp' = sp { spanContext = SpanContext sid tid, spanParentId = Just psid }
         in (HM.update (Just . (sp' :)) thId stacks, ())
  Diag.inc 1 Diag.startedSpanCountVar
  pure sp

popSpan :: MonadIO m => m ()
popSpan = liftIO $ do
  tId <- myThreadId_Word32
  sp <-
    atomicModifyIORef'
      globalSharedMutableSpanStacks
      ( \stacks ->
          let (sp : sps) = stacks HM.! tId
              !stacks' = case sps of
                [] -> HM.delete tId stacks
                _ -> HM.insert tId sps stacks
           in (stacks', sp)
      )
  ts <- now64
  Diag.inc 1 Diag.finishedSpanCountVar
  submitSpan sp { spanFinishedAt = ts }

modifyCurrentSpan :: MonadIO m => (Span -> Span) -> m ()
modifyCurrentSpan f = liftIO $ do
  tId <- myThreadId_Word32
  atomicModifyIORef'
    globalSharedMutableSpanStacks
    ( \stacks -> case HM.lookup tId stacks of
        Just (sp : sps) -> (HM.insert tId (f sp : sps) stacks, ())
        _ -> (stacks, ())
    )

currentSpanContext :: MonadIO m => m (Maybe SpanContext)
currentSpanContext = liftIO $ do
  tId <- myThreadId_Word32
  stacks <- readIORef globalSharedMutableSpanStacks
  let ctx =
        case HM.lookup tId stacks of
          Just (sp : _) -> Just $ spanContext sp
          _ -> Nothing
  pure ctx

setTag :: (ToTagValue v, MonadIO m) => T.Text -> v -> m ()
setTag k v =
  modifyCurrentSpan (\sp -> sp { spanTags = HM.insert (TagName k) (toTagValue v) (spanTags sp) })

setTags :: (ToTagValue v, MonadIO m) => [(T.Text, v)] -> m ()
setTags kvs =
  modifyCurrentSpan (\sp -> sp { spanTags = foldr (\(k,v) ts -> HM.insert (TagName k) (toTagValue v) ts) (spanTags sp) kvs})

data LogEntryKey = ErrorKind | Event | Message | Stack | Custom T.Text

addLog :: MonadIO m => LogEntryKey -> T.Text -> m ()
addLog k msg = do
  ts <- liftIO now64
  modifyCurrentSpan (\sp -> sp { spanEvents = SpanEvent ts (EventName k_string) (EventVal msg) : spanEvents sp })
  where
  k_string = case k of
    ErrorKind -> "error.kind"
    Event -> "event"
    Message -> "message"
    Stack -> "stack"
    Custom x -> x

setParentSpanContext :: MonadIO m => SpanContext -> m ()
setParentSpanContext (SpanContext psid tid) = modifyCurrentSpan $ \sp ->
  let SpanContext sid _ = spanContext sp
  in sp { spanContext = SpanContext sid tid, spanParentId = Just psid }

{-# NOINLINE globalSharedMutableSingletonState #-}
globalSharedMutableSingletonState :: TBQueue Span
globalSharedMutableSingletonState = unsafePerformIO $ newTBQueueIO 1000

withSingletonLightStep :: LightstepConfig -> IO () -> IO ()
withSingletonLightStep cfg action = do
  client <- createLightstepSpanExporter cfg
  d_ $ "Connected to LightStep " <> lsHostName cfg <> ":" <> show (lsPort cfg)
  doneVar <- newEmptyMVar
  let work = do
        d_ "Getting more spans"
        sps <- atomically $ do
          some_spans <- replicateM
            10 -- (lsMinimumBatchSize cfg)
            $ readTBQueue globalSharedMutableSingletonState
          some_more_spans <- flushTBQueue globalSharedMutableSingletonState
          pure (some_spans <> some_more_spans)
        let !sps_count = length sps
        d_ $ "Got " <> show sps_count <> " spans"
        Diag.inc 1 Diag.sentBatchesCountVar
        reportSpansRes <- try (export client sps)
        case reportSpansRes of
          Right ExportSuccess -> do
            Diag.inc 1 Diag.sentBatchesCountVar
            Diag.inc sps_count Diag.reportedSpanCountVar
            d_ $ "Reported " <> show sps_count <> " spans"
          Right _ -> do
            Diag.inc sps_count Diag.rejectedSpanCountVar
            d_ $ "Error while reporting spans."
          Left (exc :: IOError) -> do
            Diag.inc sps_count Diag.rejectedSpanCountVar
            d_ $ "Error while reporting spans: " <> show exc
      finish = do
        d_ "Getting the last spans before shutdown"
        sps <- atomically $ flushTBQueue globalSharedMutableSingletonState
        when (not $ null sps) $ do
          let !sps_count = length sps
          d_ $ "Got " <> show sps_count <> " spans"
          export client sps
          d_ $ "Reported " <> show sps_count <> " spans"
        d_ "No more spans"
        shutdown client
        d_ "Client closed"
        putMVar doneVar ()
  race_ action $ do
    tid <- myThreadId
    labelThread tid "LightStep reporter"
    fix $ \loop -> do
      work
      loop
  race_
    finish
    (waitUntilDone (lsGracefulShutdownTimeoutSeconds cfg) doneVar)

submitSpan :: Span -> IO ()
submitSpan sp = do
  written <- atomically $ tryWriteTBQueue globalSharedMutableSingletonState sp
  when (not written) $ do
    d_ "internal span queue is full, dropping the span"
    Diag.inc 1 Diag.droppedSpanCountVar

tryWriteTBQueue :: TBQueue a -> a -> STM Bool
tryWriteTBQueue q a = isFullTBQueue q >>= \case
  True -> pure False
  _ -> do
    writeTBQueue q a
    pure True

submitSpans :: Foldable f => f Span -> IO ()
submitSpans = atomically . mapM_ (tryWriteTBQueue globalSharedMutableSingletonState)

waitUntilDone :: Word -> MVar () -> IO ()
waitUntilDone timeoutSeconds doneVar = do
  d_ "waitUntilDone begin"
  timeout (fromIntegral $ 1_000_000 * timeoutSeconds) $ do
    takeMVar doneVar
  d_ "waitUntilDone: done"

myThreadId_Word32 :: IO Word32
myThreadId_Word32 = do
  ThreadId tid <- myThreadId
  pure $ fromIntegral $ getThreadId tid

foreign import ccall unsafe "rts_getThreadId" getThreadId :: ThreadId# -> CInt
