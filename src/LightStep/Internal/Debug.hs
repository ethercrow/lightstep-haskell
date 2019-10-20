module LightStep.Internal.Debug where

import Control.Concurrent
import Control.Monad.IO.Class
import System.Environment
import System.IO
import System.IO.Unsafe

{-# NOINLINE d_ #-}
d_ :: MonadIO m => String -> m ()
d_ = unsafePerformIO $
  lookupEnv "LIGHTSTEP_DEBUG" >>= \case
    Nothing -> pure $ const (pure ())
    Just "0" -> pure $ const (pure ())
    Just "false" -> pure $ const (pure ())
    _ -> pure $ \s -> liftIO $ do
      tid <- myThreadId
      hPutStrLn stderr (show tid <> ": " <> s)
