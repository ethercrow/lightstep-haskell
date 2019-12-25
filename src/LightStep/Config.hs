{-# LANGUAGE OverloadedStrings #-}

module LightStep.Config where

import Control.Monad.IO.Class
import Data.Foldable
import Data.Maybe
import qualified Data.Text as T
import Network.HTTP2.Client
import System.Environment
import System.IO

data LightStepConfig
  = LightStepConfig
      { lsHostName :: HostName,
        lsPort :: PortNumber,
        lsToken :: T.Text,
        lsServiceName :: T.Text,
        lsGlobalTags :: [(T.Text, T.Text)],
        lsGracefulShutdownTimeoutSeconds :: Int
      }

getEnvConfig :: MonadIO m => m (Maybe LightStepConfig)
getEnvConfig = liftIO $ do
  maybe_token_from_env <- asum <$> traverse lookupEnv ["LIGHTSTEP_TOKEN", "LIGHTSTEP_ACCESS_TOKEN"]
  case maybe_token_from_env of
    Just t -> do
      host <- fromMaybe "ingest.lightstep.com" <$> lookupEnv "LIGHTSTEP_HOST"
      port <- maybe 443 read <$> lookupEnv "LIGHTSTEP_PORT"
      service <- fromMaybe "example-haskell-service" <$> lookupEnv "LIGHTSTEP_SERVICE"
      pure $ Just $ LightStepConfig host port (T.pack t) (T.pack service) [] 5
    Nothing -> do
      hPutStrLn stderr "LIGHTSTEP_ACCESS_TOKEN environment variable not defined"
      pure Nothing
