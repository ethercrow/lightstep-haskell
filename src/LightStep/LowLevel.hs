{-# LANGUAGE OverloadedStrings #-}

module LightStep.LowLevel
  ( module LightStep.LowLevel,
    Span,
  )
where

import Chronos
import Control.Concurrent
import Control.Exception.Safe
import Control.Lens hiding (op)
import Data.ProtoLens.Message (defMessage)
import qualified Data.Text as T
import LightStep.Internal.Debug
import Network.GRPC.Client
import Network.GRPC.Client.Helpers
import Network.HTTP2.Client
import Proto.Collector
import Proto.Collector_Fields
import Proto.Google.Protobuf.Timestamp_Fields
import System.Timeout

data LightStepClient
  = LightStepClient
      { lscGrpcVar :: MVar GrpcClient,
        lscToken :: T.Text,
        lscReporter :: Reporter,
        lscConfig :: LightStepConfig
      }

data LightStepConfig
  = LightStepConfig
      { lsHostName :: HostName,
        lsPort :: PortNumber,
        lsToken :: T.Text,
        lsServiceName :: T.Text,
        lsGracefulShutdownTimeoutSeconds :: Int
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
        req `withException` (\err -> d_ $ "reportSpans failed: " <> show (err :: SomeException))
  ret <- tryOnce
  ret2 <- case ret of
    Nothing -> do
      d_ "GRPC client is stuck, trying to reconnect"
      reconnectClient client
      -- one retry after reconnect
      tryOnce
    _ -> pure ret
  d_ $ show ret2
  pure ()

mkClient :: LightStepConfig -> IO LightStepClient
mkClient cfg@LightStepConfig {..} = do
  grpcVar <- newEmptyMVar
  let client = LightStepClient grpcVar lsToken rep cfg
  grpc <- makeGrpcClient client
  putMVar grpcVar grpc
  pure client
  where
    rep =
      defMessage
        & reporterId .~ 2
        & tags
          .~ [ defMessage & key .~ "span.kind" & stringValue .~ "server",
               defMessage & key .~ "lightstep.component_name" & stringValue .~ lsServiceName,
               defMessage & key .~ "lightstep.tracer_platform" & stringValue .~ "haskell"
             ]

makeGrpcClient :: LightStepClient -> IO GrpcClient
makeGrpcClient client = do
  let LightStepConfig {..} = lscConfig client
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
    Left err -> throwIO err
  where
    compression = if False then gzip else uncompressed

reconnectClient :: LightStepClient -> IO ()
reconnectClient client@LightStepClient {lscGrpcVar} = do
  d_ "reconnectClient begin"
  newClient <- makeGrpcClient client
  oldClient <- swapMVar lscGrpcVar newClient
  runExceptT $ close oldClient
  d_ "reconnectClient end"

closeClient :: LightStepClient -> IO ()
closeClient LightStepClient {lscGrpcVar} = do
  grpc <- readMVar lscGrpcVar
  runExceptT $ close grpc
  pure ()

startSpan :: T.Text -> IO Span
startSpan op = do
  nanosSinceEpoch <- getTime <$> now
  let sid = fromIntegral nanosSinceEpoch
      tid = fromIntegral nanosSinceEpoch
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
  nanosSinceEpoch <- getTime <$> now
  let dur =
        (nanosSinceEpoch - (sp ^. startTimestamp . seconds) * 1_000_000_000 - fromIntegral (sp ^. startTimestamp . nanos))
          & (`div` 1000)
          & fromIntegral
  pure $
    sp
      & durationMicros .~ dur
