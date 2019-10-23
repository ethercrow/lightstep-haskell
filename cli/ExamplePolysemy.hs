{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

import Control.Concurrent
import Data.Function
import Data.Maybe
import LightStep.HighLevel.Polysemy (LightStepConfig (..), runOpenTracingWithLightStep)
import Polysemy
import Polysemy.Async
import Polysemy.OpenTracing
import Polysemy.Trace
import System.Environment
import System.Exit
import qualified Data.Text as T

sleep :: Member (Embed IO) r => Int -> Sem r ()
sleep = embed . threadDelay

seriousBusinessMain :: (Member OpenTracing r, Member (Embed IO) r) => Sem r ()
seriousBusinessMain = frontend >> backend
  where
    frontend :: (Member OpenTracing r, Member (Embed IO) r) => Sem r ()
    frontend =
      withSpan "RESTful API" $ do
        sleep 10000
        setTag "foo" "bar"
        withSpan "Kafka" $ do
          sleep 20000
          setTag "foo" "baz"
        sleep 30000
        withSpan "GraphQL" $ do
          sleep 40000
          setTag "foo" "quux"
          withSpan "Mongodb" $ do
            sleep 50000
          setTag "lorem" "ipsum"
          sleep 60000
        withSpan "data->json" $ pure ()
        withSpan "json->yaml" $ pure ()
        withSpan "yaml->xml" $ pure ()
        withSpan "xml->protobuf" $ pure ()
        withSpan "protobuf->thrift" $ pure ()
        withSpan "thrift->base64" $ pure ()
        sleep 70000
    backend =
      withSpan "Background Data Science" $ do
        sleep 10000
        withSpan "Tensorflow" $ do
          sleep 100000
          setTag "learning" "deep"
        withSpan "Torch" $ do
          sleep 100000
          setTag "learning" "very_deep"
        withSpan "Hadoop" $ do
          sleep 100000
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

  seriousBusinessMain
    & openTracingToTrace
    & traceToIO
    & runM

  putStrLn "All done (stdout reporting)"

  -- seriousBusinessMain
  --   & openTracingToLightStepIO
  --   & traceToIO
  --   & runM

  -- putStrLn "All done (LightStep reporting)"
