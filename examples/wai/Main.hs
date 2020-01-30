{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as LBS
import GHC.Stats
import LightStep.Diagnostics
import LightStep.HighLevel.IO (getEnvConfig, withSingletonLightStep, withSpan)
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.LightStep

robustScalableProductionReadyMicroservice :: Application
robustScalableProductionReadyMicroservice = \_req respond -> do
  rtsStats <- withSpan "getRTSStats" getRTSStats
  diagnostics <- getDiagnostics
  respond $
    responseLBS
      status200
      [("Content-Type", "text/plain")]
      ( LBS.pack $
          unlines
            [ "RAM usage: " <> show (max_live_bytes rtsStats `div` 1_000) <> " KB",
              "Reconnect count: " <> show (diagReconnectCount diagnostics),
              "Started span count: " <> show (diagStartedSpanCount diagnostics),
              "Finished span count: " <> show (diagFinishedSpanCount diagnostics),
              "Reported span count: " <> show (diagReportedSpanCount diagnostics),
              "Rejected span count: " <> show (diagRejectedSpanCount diagnostics),
              "Dropped span count: " <> show (diagDroppedSpanCount diagnostics)
            ]
      )

main :: IO ()
main = do
  Just lsConfig <- getEnvConfig
  let microserviceWithTracing = tracingMiddleware robustScalableProductionReadyMicroservice
  withSingletonLightStep lsConfig $
    run 8736 microserviceWithTracing
