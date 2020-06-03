{-# LANGUAGE OverloadedStrings #-}

module LightStep.LowLevel
  ( module LightStep.LowLevel,
    Span,
  )
where

import Chronos
import Control.Concurrent
import Control.Monad.Catch
import Control.Lens hiding (op)
import Data.ProtoLens.Message (defMessage)
import qualified Data.Text as T
import Data.Version (showVersion)
import LightStep.Config
import LightStep.Diagnostics
import LightStep.Internal.Debug
import Network.GRPC.Client
import Network.GRPC.Client.Helpers
import Network.GRPC.HTTP2.ProtoLens
import Network.HTTP2.Client
import Paths_lightstep_haskell (version)
import Proto.Collector
import Proto.Collector_Fields
import Proto.Google.Protobuf.Timestamp_Fields
import System.Random
import System.Timeout

data LightStepClient
  = LightStepClient
      { lscGrpcVar :: MVar GrpcClient,
        lscToken :: T.Text,
        lscReporter :: Reporter,
        lscConfig :: LightStepConfig
      }

reportSpans :: LightStepClient -> [Span] -> IO ()
reportSpans client@LightStepClient {..} sps = do
  let tryOnce = do
        grpc <- readMVar lscGrpcVar
        let req =
              timeout 3_000_000 . runExceptT $
                rawUnary
                  (RPC :: RPC CollectorService "report")
                  grpc
                  ( defMessage
                      & auth .~ (defMessage & accessToken .~ lscToken)
                      & spans .~ sps
                      & reporter .~ lscReporter
                  )
        req
  inc (length sps) reportedSpanCountVar
  ret <- tryOnce
  ret2 <- case ret of
    Nothing -> do
      d_ "GRPC client is stuck, trying to reconnect"
      reconnectClient client
      -- one retry after reconnect
      tryOnce
    _ -> pure ret
  case ret2 of
    Nothing ->
      inc (length sps) rejectedSpanCountVar
    _ -> pure ()
  d_ $ show ret2
  pure ()

mkClient :: LightStepConfig -> IO LightStepClient
mkClient cfg@LightStepConfig {..} = do
  reporter_id <- randomIO
  let rep =
        defMessage
          & reporterId .~ reporter_id
          & tags
            .~ ( [ defMessage & key .~ "lightstep.component_name" & stringValue .~ lsServiceName,
                   defMessage & key .~ "lightstep.tracer_platform" & stringValue .~ "haskell",
                   defMessage & key .~ "lightstep.tracer_version" & stringValue .~ (T.pack $ showVersion version)
                 ]
                   <> [ defMessage & key .~ k & stringValue .~ v
                        | (k, v) <- lsGlobalTags
                      ]
               )
  grpcVar <- newEmptyMVar
  let client = LightStepClient grpcVar lsToken rep cfg
  grpc <- makeGrpcClient client
  putMVar grpcVar grpc
  pure client

makeGrpcClient :: LightStepClient -> IO GrpcClient
makeGrpcClient client = do
  let LightStepConfig {..} = lscConfig client
      compression = case lsCompression of
        NoCompression -> uncompressed
        GzipCompression -> gzip
  newGrpcOrError <-
    runExceptT $
      setupGrpcClient
        ( (grpcClientConfigSimple lsHostName lsPort True)
            { _grpcClientConfigCompression = compression,
              _grpcClientConfigTimeout = Timeout 5, -- seconds
              _grpcClientConfigGoAwayHandler = \_ -> d_ "GoAway handler fired"
            }
        )
  case newGrpcOrError of
    Right newGrpc -> pure newGrpc
    Left err -> throwM err

reconnectClient :: LightStepClient -> IO ()
reconnectClient client@LightStepClient {lscGrpcVar} = do
  d_ "reconnectClient begin"
  inc 1 reconnectCountVar
  newClient <- makeGrpcClient client
  oldClient <- swapMVar lscGrpcVar newClient
  _ <- runExceptT $ close oldClient
  d_ "reconnectClient end"

closeClient :: LightStepClient -> IO ()
closeClient LightStepClient {lscGrpcVar} = do
  grpc <- readMVar lscGrpcVar
  _ <- runExceptT $ close grpc
  pure ()

startSpan :: T.Text -> IO Span
startSpan op = do
  inc 1 startedSpanCountVar
  nanosSinceEpoch <- getTime <$> now
  sid <- randomIO
  let tid = sid
  pure $
    defMessage
      & operationName .~ op
      & startTimestamp
        .~ ( defMessage
               & seconds .~ (nanosSinceEpoch `div` 1_000_000_000)
               & nanos .~ fromIntegral (rem nanosSinceEpoch 1_000_000_000)
           )
      & spanContext
        .~ (defMessage & traceId .~ tid & spanId .~ sid)

finishSpan :: Span -> IO Span
finishSpan sp = do
  inc 1 finishedSpanCountVar
  nanosSinceEpoch <- getTime <$> now
  let dur =
        (nanosSinceEpoch - (sp ^. startTimestamp . seconds) * 1_000_000_000 - fromIntegral (sp ^. startTimestamp . nanos))
          & (`div` 1000)
          & fromIntegral
  pure $
    sp
      & durationMicros .~ dur
