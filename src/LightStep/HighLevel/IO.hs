{-# LANGUAGE OverloadedStrings #-}
module LightStep.HighLevel.IO 
  ( module LightStep.HighLevel.IO
  , module LightStep.LowLevel
  ) where

import Control.Concurrent
import Control.Concurrent.Async
import Control.Concurrent.STM
import Control.Lens
import Control.Exception.Safe
import Control.Monad.Except
import GHC.Conc
import Data.Maybe
import Data.ProtoLens.Message (defMessage)
import LightStep.Internal.Debug
import LightStep.LowLevel
import Proto.Collector
import Proto.Collector_Fields
import System.IO.Unsafe
import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T
import System.Timeout

{-# noinline globalSharedMutableSpanStacks #-}
globalSharedMutableSpanStacks :: MVar (HM.HashMap ThreadId [Span])
globalSharedMutableSpanStacks = unsafePerformIO (newMVar mempty)

withSpan :: MonadIO m => MonadMask m => T.Text -> m a -> m a
withSpan opName action =
  bracket
    (pushSpan opName)
    popSpan 
    (const (onException action (setTag "error" "true")))

pushSpan :: MonadIO m => T.Text -> m ()
pushSpan opName = liftIO $ do
  sp <- startSpan opName
  tId <- myThreadId
  modifyMVar_ globalSharedMutableSpanStacks $ \stacks ->
    case fromMaybe [] (HM.lookup tId stacks) of
      [] -> do
        pure $! HM.insert tId [sp] stacks
      (psp : _) ->
        let !sp' = sp
              & references .~ [defMessage & relationship .~ Reference'CHILD_OF & spanContext .~ (psp ^. spanContext)]
              & spanContext.traceId .~ (psp ^. spanContext.traceId)
        in pure $! HM.update (Just . (sp' :)) tId stacks

popSpan :: MonadIO m => () -> m ()
popSpan () = liftIO $ do
  tId <- myThreadId
  sp <- modifyMVar globalSharedMutableSpanStacks
    (\stacks ->
      let (sp : sps) = stacks HM.! tId
          !stacks' = HM.insert tId sps stacks
      in pure (stacks', sp))
  sp' <- finishSpan sp
  submitSpan sp'

modifyCurrentSpan :: MonadIO m => (Span -> Span) -> m ()
modifyCurrentSpan f = liftIO $ do
  tId <- myThreadId
  modifyMVar_ globalSharedMutableSpanStacks
    (\stacks ->
      let (sp : sps) = stacks HM.! tId
          !stacks' = HM.insert tId (f sp : sps) stacks
      in pure stacks')

setTag :: MonadIO m => T.Text -> T.Text -> m ()
setTag k v =
  modifyCurrentSpan (tags %~ (<> [defMessage & key .~ k & stringValue .~ v]))


{-# NOINLINE globalSharedMutableSingletonState #-}
globalSharedMutableSingletonState :: TBQueue Span
globalSharedMutableSingletonState = unsafePerformIO $ newTBQueueIO 100

withSingletonLightStep :: LightStepConfig -> IO () -> IO ()
withSingletonLightStep cfg action = do
  runExceptT (mkClient cfg) >>= \case
    Left err -> do
      d_ $ "Failed to start LightStep client: " <> show err
      action
    Right client -> do
      d_ $ "Connected to LightStep " <> lsHostName cfg <> ":" <> show (lsPort cfg)
      doneVar <- newEmptyMVar
      let work = do
            d_ "Getting more spans"
            sps <- liftIO $ atomically $ do
              x <- readTBQueue globalSharedMutableSingletonState
              xs <- flushTBQueue globalSharedMutableSingletonState
              pure (x : xs)
            d_ $ "Got " <> show (length sps) <> " spans"
            reportSpansRes <- tryAny (reportSpans client sps)
            case reportSpansRes of
              Right () ->
                d_ $ "Reported " <> show (length sps) <> " spans"
              Left err ->
                d_ $ "Error while reporting spans: " <> show err
          shutdown = do
            d_ "Getting the last spans before shutdown"
            sps <- liftIO $ atomically $ flushTBQueue globalSharedMutableSingletonState
            when (not $ null sps) $ do
              d_ $ "Got " <> show (length sps) <> " spans"
              reportSpans client sps
              d_ $ "Reported " <> show (length sps) <> " spans"
            d_ "No more spans"
            closeClient client
            d_ "Client closed"
            liftIO $ putMVar doneVar ()
      race_ action $ do
        tid <- myThreadId
        labelThread tid "LightStep reporter"
        runExceptT . fix $ \loop -> do
          work
          loop
      race_
        (runExceptT shutdown)
        (waitUntilDone (lsGracefulShutdownTimeoutSeconds cfg) doneVar)

submitSpan :: Span -> IO ()
submitSpan sp = do
  written <- atomically $ tryWriteTBQueue globalSharedMutableSingletonState sp
  when (not written) $ do
    d_ "internal span queue is full, dropping the span"

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
