{-# language OverloadedStrings #-}

module LightStep.Propagation where

import Control.Lens
import Data.List (foldl')
import Data.Maybe
import qualified Data.ByteString as BS
import Data.ProtoLens.Message (defMessage)
import Network.HTTP.Types
import Network.Wai
import Proto.Collector
import Proto.Collector_Fields
import GHC.Word
import Proto.Google.Protobuf.Timestamp_Fields
import qualified Data.Text as T

extractSpanContextFromRequest :: Request -> Maybe SpanContext
extractSpanContextFromRequest = extractSpanContextFromRequestHeaders . requestHeaders

extractSpanContextFromRequestHeaders :: RequestHeaders -> Maybe SpanContext
extractSpanContextFromRequestHeaders hdrs =
  case foldl' go (Nothing, Nothing) hdrs of
    (Just tid, Just sid) -> defMessage
      & traceId .~ tid
      & spanId .~ sid
      & Just
    _ -> Nothing
  where
  -- TODO: Zipkin style propagation
  -- go (_, sid) ("x-b3-traceid", parse64 -> Just x) = (Just x, sid)
  -- go (tid, _) ("x-b3-spanid", parse64 -> Just x) = (tid, Just x)

  go (_, sid) ("ot-tracer-traceid", parse64 -> Just tid) = (Just tid, sid)
  go (tid, _) ("ot-tracer-spanid", parse64 -> Just sid) = (tid, Just sid)

  -- TODO: Propagation of the whole span context in a single header
  -- go _ ("x-ot-span-context", parse128 -> Just (tid, sid)) = (Just tid, Just sid)

  go acc _ = acc

  parse64 :: BS.ByteString -> Maybe Word64
  parse64 v = Nothing -- TODO

  parse128 :: BS.ByteString -> Maybe (Word64, Word64)
  parse128 _ = Nothing -- TODO

