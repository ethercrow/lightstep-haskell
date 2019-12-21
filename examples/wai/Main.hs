{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as LBS
import Data.Maybe (fromMaybe)
import qualified Data.Text as T
import GHC.Stats
import LightStep.HighLevel.IO (LightStepConfig (..), withSingletonLightStep)
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.LightStep
import System.Environment
import System.Exit

robustScalableProductionReadyMicroservice :: Application
robustScalableProductionReadyMicroservice = \_req respond -> do
  rtsStats <- getRTSStats
  respond $
    responseLBS
      status200
      [("Content-Type", "text/plain")]
      (LBS.pack $ "RAM usage: " <> show (max_live_bytes rtsStats `div` 1_000) <> " KB")

main :: IO ()
main = do
  token <-
    lookupEnv "LIGHTSTEP_TOKEN" >>= \case
      Just t -> pure $ T.pack t
      Nothing -> do
        putStrLn "LIGHTSTEP_TOKEN environment variable not defined"
        exitFailure
  host <- fromMaybe "ingest.lightstep.com" <$> lookupEnv "LIGHTSTEP_HOST"
  port <- maybe 443 read <$> lookupEnv "LIGHTSTEP_PORT"
  let lsConfig = LightStepConfig host port token "example-wai-service" 5
      microserviceWithTracing = tracingMiddleware robustScalableProductionReadyMicroservice
  withSingletonLightStep lsConfig $
    run 8736 microserviceWithTracing
