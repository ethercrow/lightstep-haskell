{-# language OverloadedStrings #-}

import Control.Concurrent
import Data.Maybe
import LightStep.HighLevel.IO
import LightStep.Propagation (b3headersForSpanContext)
import Network.HTTP.Req
import qualified Data.Text as T
import System.Environment
import System.Exit

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
  token <-
    lookupEnv "LIGHTSTEP_TOKEN" >>= \case
      Just t -> pure $ T.pack t
      Nothing -> do
        putStrLn "LIGHTSTEP_TOKEN environment variable not defined"
        exitFailure
  host <- fromMaybe "ingest.lightstep.com" <$> lookupEnv "LIGHTSTEP_HOST"
  lsport <- maybe 443 read <$> lookupEnv "LIGHTSTEP_PORT"
  let lsConfig = LightStepConfig host lsport token "example-req-client" 5
  withSingletonLightStep lsConfig clientMain
