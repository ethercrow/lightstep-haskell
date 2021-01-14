{-# LANGUAGE OverloadedStrings #-}

module LightStep.HighLevel.IO
  ( module LightStep.HighLevel.IO,
    module LightStep.LowLevel,
    module LightStep.Config,
    SpanContext,
  )
where

import Control.Concurrent
import Control.Concurrent.Async
import Control.Concurrent.STM
import Control.Monad.Catch
import Control.Lens
import Control.Monad.Except
import qualified Data.HashMap.Strict as HM
import Data.Maybe
import Data.ProtoLens.Message (defMessage)
import qualified Data.Text as T
import GHC.Conc
import LightStep.Config
import LightStep.Diagnostics
import LightStep.Internal.Debug
import LightStep.LowLevel
import Proto.Collector
import Proto.Collector_Fields
import System.IO.Unsafe
import System.Timeout
import TextShow

{-# NOINLINE globalSharedMutableSpanStacks #-}
globalSharedMutableSpanStacks :: MVar (HM.HashMap ThreadId [Span])
globalSharedMutableSpanStacks = unsafePerformIO (newMVar mempty)

data LogEntryKey = ErrorKind | Event | Message | Stack | Custom T.Text

showLogEntryKey :: LogEntryKey -> T.Text
showLogEntryKey ErrorKind = T.pack "error.kind"
showLogEntryKey Event = T.pack "event"
showLogEntryKey Message = T.pack "message"
showLogEntryKey Stack = T.pack "stack"
showLogEntryKey (Custom x) = x

withSpan :: forall m a. MonadIO m => MonadMask m => T.Text -> m a -> m a
withSpan opName action = withSpanAndTags opName [] action

withSpanAndTags :: forall m a. MonadIO m => MonadMask m => T.Text -> [(T.Text, T.Text)] -> m a -> m a
withSpanAndTags opName initialTags action = do
   bytes_before <- liftIO getAllocationCounter
   fst <$> generalBracket
        (pushSpan opName initialTags)
        (\sp exitcase -> do
          bytes_after <- liftIO getAllocationCounter
          let alloc = showt $ bytes_before - bytes_after
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
          popSpan sp)
        (\_ -> action)

pushSpan :: MonadIO m => T.Text -> [(T.Text, T.Text)] -> m ()
pushSpan opName initialTags = liftIO $ do
  sp <- startSpan opName
  tId <- myThreadId
  modifyMVar_ globalSharedMutableSpanStacks $ \stacks ->
    case fromMaybe [] (HM.lookup tId stacks) of
      [] -> do
        let !sp' =
              sp
                & tags .~
                  ( (defMessage & key .~ "thread" & stringValue .~ T.pack (show tId))
                  : [(defMessage & key .~ k & stringValue .~ v) | (k, v) <- initialTags]
                  )
        pure $! HM.insert tId [sp'] stacks
      (psp : _) ->
        let !sp' =
              sp
                & references .~ [defMessage & relationship .~ Reference'CHILD_OF & spanContext .~ (psp ^. spanContext)]
                & spanContext . traceId .~ (psp ^. spanContext . traceId)
                & tags .~ [(defMessage & key .~ k & stringValue .~ v) | (k, v) <- initialTags]
         in pure $! HM.update (Just . (sp' :)) tId stacks

popSpan :: MonadIO m => () -> m ()
popSpan () = liftIO $ do
  tId <- myThreadId
  sp <-
    modifyMVar
      globalSharedMutableSpanStacks
      ( \stacks ->
          let (sp : sps) = stacks HM.! tId
              !stacks' = case sps of
                [] -> HM.delete tId stacks
                _ -> HM.insert tId sps stacks
           in pure (stacks', sp)
      )
  sp' <- finishSpan sp
  submitSpan sp'

modifyCurrentSpan :: MonadIO m => (Span -> Span) -> m ()
modifyCurrentSpan f = liftIO $ do
  tId <- myThreadId
  modifyMVar_
    globalSharedMutableSpanStacks
    ( \stacks -> case HM.lookup tId stacks of
        Just (sp : sps) -> pure $! HM.insert tId (f sp : sps) stacks
        _ -> pure stacks
    )

currentSpanContext :: MonadIO m => m (Maybe SpanContext)
currentSpanContext = liftIO $ do
  tId <- myThreadId
  stacks <- readMVar globalSharedMutableSpanStacks
  let ctx =
        case HM.lookup tId stacks of
          Just (sp : _) -> Just $ sp ^. spanContext
          _ -> Nothing
  pure ctx

setTag :: MonadIO m => T.Text -> T.Text -> m ()
setTag k v =
  modifyCurrentSpan (tags %~ ((defMessage & key .~ k & stringValue .~ v) :))

setTags :: MonadIO m => [(T.Text, T.Text)] -> m ()
setTags kvs =
  modifyCurrentSpan (tags %~ ([defMessage & key .~ k & stringValue .~ v | (k, v) <- kvs] <>))

addLog :: MonadIO m => LogEntryKey -> T.Text -> m ()
addLog k v =
  modifyCurrentSpan (logs %~ (<> [defMessage & fields .~ [defMessage & key .~ showLogEntryKey k & stringValue .~ v]]))

setParentSpanContext :: MonadIO m => SpanContext -> m ()
setParentSpanContext ctx = modifyCurrentSpan $ \sp ->
  sp
    & references .~ [defMessage & relationship .~ Reference'CHILD_OF & spanContext .~ ctx]
    & spanContext . traceId .~ (ctx ^. traceId)

{-# NOINLINE globalSharedMutableSingletonState #-}
globalSharedMutableSingletonState :: TBQueue Span
globalSharedMutableSingletonState = unsafePerformIO $ newTBQueueIO 1000

withSingletonLightStep :: LightStepConfig -> IO () -> IO ()
withSingletonLightStep cfg action = do
  clientOrError <- try (mkClient cfg)
  case clientOrError of
    Left (err :: IOError) -> do
      d_ $ "Not connected to LightStep " <> lsHostName cfg <> ":" <> show (lsPort cfg)
      d_ $ "Reason: " <> show err
      d_ $ "Continuing without tracing"
      action
    Right client -> do
      d_ $ "Connected to LightStep " <> lsHostName cfg <> ":" <> show (lsPort cfg)
      doneVar <- newEmptyMVar
      let work = do
            d_ "Getting more spans"
            sps <- atomically $ do
              some_spans <- replicateM (lsMinimumBatchSize cfg) $ readTBQueue globalSharedMutableSingletonState
              some_more_spans <- flushTBQueue globalSharedMutableSingletonState
              pure (some_spans <> some_more_spans)
            d_ $ "Got " <> show (length sps) <> " spans"
            inc 1 sentBatchesCountVar
            reportSpansRes <- try (reportSpans client sps)
            case reportSpansRes of
              Right () ->
                d_ $ "Reported " <> show (length sps) <> " spans"
              Left (err :: SomeException) ->
                d_ $ "Error while reporting spans: " <> show err
          shutdown = do
            d_ "Getting the last spans before shutdown"
            sps <- atomically $ flushTBQueue globalSharedMutableSingletonState
            when (not $ null sps) $ do
              d_ $ "Got " <> show (length sps) <> " spans"
              reportSpans client sps
              d_ $ "Reported " <> show (length sps) <> " spans"
            d_ "No more spans"
            closeClient client
            d_ "Client closed"
            putMVar doneVar ()
      race_ action $ do
        tid <- myThreadId
        labelThread tid "LightStep reporter"
        fix $ \loop -> do
          work
          loop
      race_
        shutdown
        (waitUntilDone (lsGracefulShutdownTimeoutSeconds cfg) doneVar)

submitSpan :: Span -> IO ()
submitSpan sp = do
  written <- atomically $ tryWriteTBQueue globalSharedMutableSingletonState sp
  when (not written) $ do
    d_ "internal span queue is full, dropping the span"
    inc 1 droppedSpanCountVar

tryWriteTBQueue :: TBQueue a -> a -> STM Bool
tryWriteTBQueue q a = isFullTBQueue q >>= \case
  True -> pure False
  _ -> do
    writeTBQueue q a
    pure True

submitSpans :: Foldable f => f Span -> IO ()
submitSpans = atomically . mapM_ (tryWriteTBQueue globalSharedMutableSingletonState)

waitUntilDone :: Int -> MVar () -> IO ()
waitUntilDone timeoutSeconds doneVar = do
  d_ "waitUntilDone begin"
  timeout (1_000_000 * timeoutSeconds) $ do
    takeMVar doneVar
  d_ "waitUntilDone: done"
