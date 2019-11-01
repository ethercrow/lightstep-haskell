
[![CI Status](https://github.com/ethercrow/lightstep-haskell/workflows/ci/badge.svg)](https://github.com/ethercrow/lightstep-haskell/actions)
![Hackage](https://img.shields.io/hackage/v/lightstep-haskell)
[![lightstep-haskell on Stackage Nightly](http://stackage.org/package/lightstep-haskell/badge/nightly)](http://stackage.org/nightly/package/lightstep-haskell)

# What is it?

A library for instrumenting your code and sending traces to [LightStep](https://lightstep.com/).


# How to use it?

Example usage:

```haskell
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Control.Concurrent.Async
import Data.Maybe
import qualified Data.Text as T
import LightStep.HighLevel.IO (LightStepConfig (..), setTag, withSingletonLightStep, withSpan)
import System.Environment
import System.Exit

seriousBusinessMain :: IO ()
seriousBusinessMain = concurrently_ frontend backend
  where
    frontend =
      withSpan "RESTful API" $ do
        threadDelay 10000
        setTag "foo" "bar"
        withSpan "Kafka" $ do
          threadDelay 20000
          setTag "foo" "baz"
        threadDelay 30000
        withSpan "GraphQL" $ do
          threadDelay 40000
          setTag "foo" "quux"
          withSpan "Mongodb" $ do
            threadDelay 50000
          setTag "lorem" "ipsum"
          threadDelay 60000
        withSpan "data->json" $ pure ()
        withSpan "json->yaml" $ pure ()
        withSpan "yaml->xml" $ pure ()
        withSpan "xml->protobuf" $ pure ()
        withSpan "protobuf->thrift" $ pure ()
        withSpan "thrift->base64" $ pure ()
        threadDelay 70000
    backend =
      withSpan "Background Data Science" $ do
        threadDelay 10000
        withSpan "Tensorflow" $ do
          threadDelay 100000
          setTag "learning" "deep"
        withSpan "Torch" $ do
          threadDelay 100000
          setTag "learning" "very_deep"
        withSpan "Hadoop" $ do
          threadDelay 100000
          setTag "learning" "super_deep"

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
  let lsConfig = LightStepConfig host port token "helloworld" 5
  withSingletonLightStep lsConfig seriousBusinessMain
  putStrLn "All done"
```
