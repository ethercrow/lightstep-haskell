{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Data.Maybe
import LightStep.HighLevel.IO
import LightStep.Propagation (b3headersForSpanContext)
import Network.HTTP.Req

clientMain :: IO ()
clientMain = do
  withSpan "req-example" $ do
    setTag "span.kind" "client"
    setTag "component" "http"
    Just ctx <- currentSpanContext
    let opts = port 8736 <> foldMap (\(k, v) -> header k v) (b3headersForSpanContext ctx)
        url = http "127.0.0.1" /: "test"
    runReq defaultHttpConfig $ req GET url NoReqBody ignoreResponse opts
  threadDelay 1_000_000

main :: IO ()
main = do
  Just lsConfig <- getEnvConfig
  withSingletonLightStep lsConfig clientMain
