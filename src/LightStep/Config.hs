{-# LANGUAGE OverloadedStrings #-}

module LightStep.Config where

import Control.Monad.IO.Class
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
        lsGracefulShutdownTimeoutSeconds :: Int
      }

getEnvConfig :: MonadIO m => m (Maybe LightStepConfig)
getEnvConfig = liftIO $
  lookupEnv "LIGHTSTEP_TOKEN" >>= \case
    Just t -> do
      host <- fromMaybe "ingest.lightstep.com" <$> lookupEnv "LIGHTSTEP_HOST"
      port <- maybe 443 read <$> lookupEnv "LIGHTSTEP_PORT"
      service <- fromMaybe "helloworld" <$> lookupEnv "LIGHTSTEP_SERVICE"
      pure $ Just $ LightStepConfig host port (T.pack t) (T.pack service) 5
    Nothing -> do
      hPutStrLn stderr "LIGHTSTEP_TOKEN environment variable not defined"
      pure Nothing
