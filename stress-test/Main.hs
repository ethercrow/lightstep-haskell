{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent
import Control.Concurrent.Async
import Control.Monad
import Data.Maybe
import qualified Data.Text as T
import GHC.Stats
import LightStep.HighLevel.IO (LogEntryKey (..), addLog, getEnvConfig, setTag, withSingletonLightStep, withSpan)
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
  print ("max_live_bytes", max_live_bytes)
  print ("gcdetails_live_bytes", gcdetails_live_bytes)
  when (max_live_bytes > 6_000_000) $ do
    putStrLn "Ate too much memory"
    exitFailure

main :: IO ()
main = do
  Just lsConfig <- getEnvConfig
  withSingletonLightStep lsConfig $ do
    forM_ [0 .. 10] $ \_ -> do
      reportMemoryUsage
      forM_ [0 .. 1000] $ \_ -> do
        async seriousBusinessMain
        threadDelay 10000
  putStrLn "All done"
