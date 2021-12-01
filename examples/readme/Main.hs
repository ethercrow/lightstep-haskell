{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

import Data.Text
import Control.Concurrent
import Control.Concurrent.Async
import LightStep.HighLevel.IO (LogEntryKey (Message), addLog, currentSpanContext, getEnvConfig, setParentSpanContext, setTag, withSingletonLightStep, withSpan)

seriousBusinessMain :: IO ()
seriousBusinessMain = concurrently_ frontend backend >> threadDelay 1000000
  where
    frontend =
      withSpan "RESTful API" $ do
        threadDelay 10000
        setTag @String "foo" "bar"
        withSpan "Kafka" $ do
          threadDelay 20000
          setTag @String "foo" "baz"
        threadDelay 30000
        withSpan "GraphQL" $ do
          threadDelay 40000
          setTag @Int "foo" 42
          addLog Message "bar"
          withSpan "Mongodb" $ do
            threadDelay 50000
          setTag @Bool "lorem" True
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
          setTag @Text "learning" "deep"
        withSpan "Torch" $ do
          threadDelay 100000
          setTag @Text "learning" "very_deep"
        withSpan "Hadoop" $ do
          threadDelay 100000
          setTag @Text "learning" "super_deep"
        withSpan "Parallel map reduce" $ do
          result <- withSpan "Reduce" $ do
            Just ctx <- currentSpanContext
            (a :: Text, b) <- do
              threadDelay 100000
              concurrently
                ( withSpan "Calculate a" $ do
                    setParentSpanContext ctx
                    threadDelay 100000
                    return "Lorem "
                )
                ( withSpan "Calculate b" $ do
                    setParentSpanContext ctx
                    threadDelay 100000
                    return "ipsum"
                )
            threadDelay 100000
            pure (a <> b)
          setTag "result" result

main :: IO ()
main = do
  -- Construct a config from env variables
  -- - LIGHTSTEP_ACCESS_TOKEN
  -- - LIGHTSTEP_HOST (optional)
  -- - LIGHTSTEP_PORT (optional)
  -- - LIGHTSTEP_SERVICE (optional)
  Just lsConfig <- getEnvConfig
  withSingletonLightStep lsConfig seriousBusinessMain
  putStrLn "All done"
