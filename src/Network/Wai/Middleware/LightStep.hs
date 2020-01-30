{-# LANGUAGE OverloadedStrings #-}

module Network.Wai.Middleware.LightStep where

import qualified Data.Text as T
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
        d_ $ "extracted context: " <> show ctx
        setParentSpanContext ctx
      _ -> pure ()
    setTag "span.kind" "server"
    setTag "component" "http"
    setTag "http.method" $ T.decodeUtf8 (requestMethod req)
    setTag "http.target" $ T.decodeUtf8 (rawPathInfo req)
    setTag "http.flavor" $ showT (httpVersion req)
    app req $ \resp -> do
      setTag "http.status_code" $ showT (statusCode $ responseStatus resp)
      sendResp resp

showT :: Show a => a -> T.Text
showT = T.pack . show
