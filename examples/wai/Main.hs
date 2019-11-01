{-# LANGUAGE OverloadedStrings #-}

import Data.Maybe (fromMaybe)
import System.Environment
import System.Exit
import LightStep.HighLevel.IO (LightStepConfig (..), withSingletonLightStep)
import Network.Wai.Middleware.LightStep
import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)
import qualified Data.Text as T

robustScalableProductionReadyMicroservice :: Application
robustScalableProductionReadyMicroservice = \_req respond -> do
  putStrLn "Disrupting the industry"
  respond $ responseLBS
    status200
    [("Content-Type", "text/plain")]
    "It's all data!"

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
