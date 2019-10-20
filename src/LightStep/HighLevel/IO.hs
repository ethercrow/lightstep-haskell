module LightStep.HighLevel.IO 
  ( module LightStep.HighLevel.IO
  , module LightStep.LowLevel
  ) where

import Control.Concurrent
import Control.Concurrent.Async
import Control.Concurrent.STM
import Control.Lens
import Control.Monad.Catch
import Control.Monad.Except
import Data.Maybe
import Data.ProtoLens.Message (defMessage)
import LightStep.Internal.Debug
import LightStep.LowLevel
import Proto.Collector
import Proto.Collector_Fields
import System.IO.Unsafe
import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T

{-# noinline globalSharedMutableSpanStacks #-}
globalSharedMutableSpanStacks :: MVar (HM.HashMap ThreadId [Span])
globalSharedMutableSpanStacks = unsafePerformIO (newMVar mempty)

withSpan :: T.Text -> IO a -> IO a
withSpan opName action =
  bracket
    (pushSpan opName)
    popSpan 
    (const action)

pushSpan :: T.Text -> IO ()
pushSpan opName = do
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

popSpan :: () -> IO ()
popSpan () = do
  tId <- myThreadId
  sp <- modifyMVar globalSharedMutableSpanStacks
    (\stacks ->
      let (sp : sps) = stacks HM.! tId
          !stacks' = HM.insert tId sps stacks
      in pure (stacks', sp))
  sp' <- finishSpan sp
  submitSpan sp'

modifyCurrentSpan :: (Span -> Span) -> IO ()
modifyCurrentSpan f = do
  tId <- myThreadId
  modifyMVar_ globalSharedMutableSpanStacks
    (\stacks ->
      let (sp : sps) = stacks HM.! tId
          !stacks' = HM.insert tId (f sp : sps) stacks
      in pure stacks')

setTag :: T.Text -> T.Text -> IO ()
setTag k v =
  modifyCurrentSpan (tags %~ (<> [defMessage & key .~ k & stringValue .~ v]))


{-# NOINLINE globalSharedMutableSingletonState #-}
globalSharedMutableSingletonState :: TBQueue Span
globalSharedMutableSingletonState = unsafePerformIO $ newTBQueueIO 100

withSingletonLightStep :: LightStepConfig -> IO () -> IO ()
withSingletonLightStep cfg action = do
  doneVar <- newEmptyMVar
  race_ (action >> waitUntilDone (lsGracefulShutdownTimeoutSeconds cfg) doneVar) $ do
    let work client = do
          d_ "Getting more spans"
          spans <- liftIO $ atomically $ do
            x <- readTBQueue globalSharedMutableSingletonState
            xs <- flushTBQueue globalSharedMutableSingletonState
            pure (x : xs)
          d_ $ "Got " <> show (length spans) <> " spans"
          reportSpansRes <- try (reportSpans client spans)
          case reportSpansRes of
            Right () ->
              d_ $ "Reported " <> show (length spans) <> " spans"
            Left (err :: SomeException) ->
              d_ $ "Error while reporting spans: " <> show err
        shutdown client = do
          d_ "Getting the last spans before shutdown"
          spans <- liftIO $ atomically $ flushTBQueue globalSharedMutableSingletonState
          d_ $ "Got " <> show (length spans) <> " spans"
          when (not $ null spans) $
            reportSpans client spans
          d_ $ "Reported " <> show (length spans) <> " spans"
          closeClient client
          d_ "Client closed"
          liftIO $ putMVar doneVar ()
    runExceptT
      $ bracket
        (mkClient cfg)
        shutdown
      $ \client -> do
        let loop = do
              work client
              loop
        loop
    pure ()

submitSpan :: Span -> IO ()
submitSpan = atomically . writeTBQueue globalSharedMutableSingletonState

-- TODO: handle span batches larger that queue size
submitSpans :: Foldable f => f Span -> IO ()
submitSpans = atomically . mapM_ (writeTBQueue globalSharedMutableSingletonState)

waitUntilDone :: Int -> MVar () -> IO ()
waitUntilDone timeoutSeconds doneVar =
  race_
    ( do
        threadDelay $ 1_000_000 * timeoutSeconds
        d_ "waitUntilDone: timeout"
    )
    ( do
        takeMVar doneVar
        d_ "waitUntilDone: done"
    )
