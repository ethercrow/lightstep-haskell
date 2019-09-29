{-# language DataKinds #-}
{-# language LambdaCase #-}
{-# language OverloadedStrings #-}
{-# language NumericUnderscores #-}

module LightStep where

import Control.Monad.IO.Class
import Control.Lens
import Data.ProtoLens.Message (defMessage)
import qualified Data.Text as T
import Chronos

import Proto.Google.Protobuf.Timestamp_Fields
import Proto.Collector
import Proto.Collector_Fields

import Network.HTTP2.Client
import Network.GRPC.Client
import Network.GRPC.Client.Helpers

data LightStepClient = LightStepClient GrpcClient T.Text Reporter

reportSpans :: LightStepClient -> [Span] -> ExceptT ClientError IO ()
reportSpans (LightStepClient grpc token rep) sps = do
  ret <- rawUnary (RPC :: RPC CollectorService "report") grpc (
      defMessage
        & auth .~ (defMessage & accessToken .~ token)
        & spans .~ sps
        & reporter .~ rep
    )

  liftIO $ print ret

  -- FIXME: handle errors

  pure ()

mkClient :: HostName -> PortNumber -> Bool -> T.Text -> T.Text -> ClientIO LightStepClient
mkClient host port doCompress token serviceName = do
    grpc <- setupGrpcClient ((grpcClientConfigSimple host port True) { _grpcClientConfigCompression = compression })
    pure $ LightStepClient grpc token rep
  where
    compression = if doCompress then gzip else uncompressed
    rep = defMessage
      & reporterId .~ 2
      & tags .~
        [ defMessage & key .~ "span.kind" & stringValue .~ "server"
        , defMessage & key .~ "lightstep.component_name" & stringValue .~ serviceName
        , defMessage & key .~ "lightstep.tracer_platform" & stringValue .~ "haskell"
        ]

closeClient :: LightStepClient -> ClientIO ()
closeClient (LightStepClient grpc _ _) = close grpc

startSpan :: T.Text -> IO Span
startSpan op = do
  nanosSinceEpoch <- getTime <$> now
  let sid = fromIntegral nanosSinceEpoch
      tid = fromIntegral nanosSinceEpoch
  pure $ defMessage
    & operationName .~ op
    & startTimestamp .~ (defMessage
      & seconds .~ (nanosSinceEpoch `div` 1_000_000_000)
      & nanos .~ fromIntegral (rem nanosSinceEpoch 1_000_000_000))
    & spanContext .~
      (defMessage & traceId .~ tid & spanId .~ sid)

finishSpan :: Span -> IO Span
finishSpan sp = do
  nanosSinceEpoch <- getTime <$> now
  let dur = (nanosSinceEpoch - (sp ^. startTimestamp . seconds) * 1_000_000_000 - fromIntegral (sp ^. startTimestamp . nanos))
            & (`div` 1000)
            & fromIntegral
  pure $ sp
    & durationMicros .~ dur
