{-# language OverloadedStrings #-}

module LightStep.Propagation where

import Control.Lens
import Data.List (foldl')
import qualified Data.ByteString as BS
import Data.ProtoLens.Message (defMessage)
import Network.HTTP.Types
import Network.Wai
import Proto.Collector
import Proto.Collector_Fields
import GHC.Word

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
  parse64 bytes = case BS.unpack bytes of
    -- TODO: a better way to decode base16
    [b0, b1, b2, b3, b4, b5, b6, b7] | BS.all (\d -> (d >= 48 && d < 57) || (d >= 97 && d < 123)) bytes ->
      Just $
        convertByte b0 * 256 * 256 * 256 * 16 +
        convertByte b1 * 256 * 256 * 256 +
        convertByte b2 * 256 * 256 * 16 +
        convertByte b3 * 256 * 256 +
        convertByte b4 * 256 * 16 +
        convertByte b5 * 256 +
        convertByte b6 * 16 +
        convertByte b7
    _ -> Nothing

  -- parse128 :: BS.ByteString -> Maybe (Word64, Word64)
  -- parse128 _ = Nothing -- TODO

  convertByte :: Word8 -> Word64
  convertByte d | d < 57 = fromIntegral d - 48
  convertByte d = fromIntegral d - 87
