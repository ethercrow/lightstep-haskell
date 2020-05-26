{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Control.Concurrent.Async
import Control.Monad
import GHC.Stats
import LightStep.Diagnostics
import LightStep.HighLevel.IO (LogEntryKey (..), addLog, getEnvConfig, setTag, withSingletonLightStep, withSpan)
import System.Exit
import Text.Printf

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
          addLog Event "monkey-job"
          addLog (Custom "foo") "bar"
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

reportMemoryUsage :: IO ()
reportMemoryUsage = do
  RTSStats {..} <- getRTSStats
  let GCDetails {..} = gc
  printf "max_live_bytes %d\n" max_live_bytes
  printf "gcdetails_live_bytes %d\n" gcdetails_live_bytes
  when (max_live_bytes > 10_000_000) $ do
    putStrLn "Ate too much memory"
    exitFailure

main :: IO ()
main = do
  Just lsConfig <- getEnvConfig
  withSingletonLightStep lsConfig $ do
    replicateM_ 10 $ do
      reportMemoryUsage
      replicateM_ 1000 $ do
        _ <- async seriousBusinessMain
        threadDelay 10000
  getDiagnostics >>= print
  putStrLn "All done"
