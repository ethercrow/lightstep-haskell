{-# language DataKinds #-}
{-# language LambdaCase #-}
{-# language OverloadedStrings #-}

import Control.Monad.IO.Class
import Control.Concurrent
import Control.Lens
import Data.Maybe
import System.Environment
import System.Exit
import Text.Read
import Data.ProtoLens.Message (defMessage)
import qualified Data.Text as T

import Proto.Google.Protobuf.Timestamp_Fields
import Proto.Collector
import Proto.Collector_Fields

import Network.HTTP2.Client

import LightStep

main :: IO ()
main = do
  token <- lookupEnv "LIGHTSTEP_TOKEN" >>= \case
    Just t -> pure $ T.pack t
    Nothing -> do
      putStrLn "LIGHTSTEP_TOKEN environment variable not defined"
      exitFailure
  host <- fromMaybe "ingest.lightstep.com" <$> lookupEnv "LIGHTSTEP_HOST"
  port <- maybe 443 read <$> lookupEnv "LIGHTSTEP_PORT"
  runClientIO $ do
    lsClient <- mkClient
      host
      port -- port
      False -- doCompress
      token
      "helloworld"

    sp1 <- liftIO $ startSpan "haskell_operation_1"

    liftIO $ threadDelay 10000

    sp2 <- liftIO $ startSpan "haskell_operation_2"

    liftIO $ threadDelay 20000

    sp2 <- liftIO $ finishSpan sp2

    liftIO $ threadDelay 30000

    sp1 <- liftIO $ finishSpan sp1

    reportSpans lsClient [sp1, sp2]

    closeClient lsClient

  putStrLn "All done."

