{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Data.CaseInsensitive (original)
import LightStep.HighLevel.IO
import LightStep.Propagation (b3Propagator, inject)
import Network.HTTP.Req

clientMain :: IO ()
clientMain = do
  withSpan "req-example" $ do
    setTag "span.kind" "client"
    setTag "component" "http"
    Just ctx <- currentSpanContext
    let opts = port 8736 <> foldMap (\(k, v) -> header (original k) v) (inject b3Propagator ctx Nothing)
        url = http "127.0.0.1" /: "test"
    _ <- runReq defaultHttpConfig $ req GET url NoReqBody ignoreResponse opts
    pure ()
  threadDelay 1_000_000

main :: IO ()
main = do
  Just lsConfig <- getEnvConfig
  withSingletonLightStep lsConfig clientMain
