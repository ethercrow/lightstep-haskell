{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Control.Concurrent.Async
import Control.Monad
import GHC.Stats
import LightStep.Diagnostics
import LightStep.HighLevel.IO
import System.Exit
import Text.Printf

seriousBusinessMain :: IO ()
seriousBusinessMain = concurrently_ frontend backend
  where
    frontend =
      withSpanAndTags "RESTful API" [("foo", "bar")] $ do
        threadDelay 10000
        withSpanAndTags "Kafka" [("foo", "baz")] $ do
          threadDelay 20000
        threadDelay 30000
        withSpanAndTags "GraphQL" [("foo", "quux"), ("lorem", "ipsum")] $ do
          threadDelay 40000
          addLog Event "monkey-job"
          addLog (Custom "foo") "bar"
          withSpan "Mongodb" $ do
            threadDelay 50000
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
        withSpanAndTags "Tensorflow" [("learning", "deep")] $ do
          threadDelay 100000
          setTag "learning" "deep"
        withSpanAndTags "Torch" [("learning", "very_deep")] $ do
          threadDelay 100000
        withSpanAndTags "Hadoop" [("learning", "super_deep")]$ do
          threadDelay 100000

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
