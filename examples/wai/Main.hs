{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as LBS
import GHC.Stats
import LightStep.HighLevel.IO (getEnvConfig, withSingletonLightStep)
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.LightStep

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
  Just lsConfig <- getEnvConfig
  let microserviceWithTracing = tracingMiddleware robustScalableProductionReadyMicroservice
  withSingletonLightStep lsConfig $
    run 8736 microserviceWithTracing
