{-# LANGUAGE OverloadedStrings #-}

module Network.Wai.Middleware.LightStep where

import qualified Data.Text.Encoding as T
import LightStep.HighLevel.IO
import LightStep.Internal.Debug
import LightStep.Propagation
import Network.HTTP.Types
import Network.Wai

-- Semantic conventions for HTTP spans:
-- https://github.com/open-telemetry/opentelemetry-specification/blob/master/specification/data-http.md

tracingMiddleware :: Application -> Application
tracingMiddleware app = \req sendResp -> do
  withSpan "WAI handler" $ do
    case extractSpanContextFromRequest req of
      Just ctx -> do
        d_ $ "Extracted context: " <> show ctx
        setParentSpanContext ctx
      _ -> do
        d_ $ "Failed to extract context from headers " <> show (requestHeaders req)
    setTags
      [ ("span.kind", "server")
      , ("http.method", T.decodeUtf8 (requestMethod req))
      , ("http.target", T.decodeUtf8 (rawPathInfo req))
      ]
    app req $ \resp -> do
      setTag "http.status_code" (statusCode $ responseStatus resp)
      sendResp resp

