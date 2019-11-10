{-# LANGUAGE OverloadedStrings #-}

module LightStep.Propagation where

import Control.Lens
import Data.Bits
import qualified Data.ByteString as BS
import Data.List (foldl')
import Data.ProtoLens.Message (defMessage)
import GHC.Word
import Network.HTTP.Types
import Network.Wai
import Proto.Collector
import Proto.Collector_Fields

extractSpanContextFromRequest :: Request -> Maybe SpanContext
extractSpanContextFromRequest = extractSpanContextFromRequestHeaders . requestHeaders

extractSpanContextFromRequestHeaders :: RequestHeaders -> Maybe SpanContext
extractSpanContextFromRequestHeaders hdrs =
  case foldl' go (Nothing, Nothing) hdrs of
    (Just tid, Just sid) ->
      defMessage
        & traceId .~ tid
        & spanId .~ sid
        & Just
    _ -> Nothing
  where
    -- TODO: 128-bit x-b3-traceid
    go (_, sid) ("x-b3-traceid", decode_u64 -> Just tid) = (Just tid, sid)
    go (tid, _) ("x-b3-spanid", decode_u64 -> Just sid) = (tid, Just sid)
    go (_, sid) ("ot-tracer-traceid", decode_u64 -> Just tid) = (Just tid, sid)
    go (tid, _) ("ot-tracer-spanid", decode_u64 -> Just sid) = (tid, Just sid)
    -- TODO: Propagation of the whole span context in a single header
    -- go _ ("x-ot-span-context", parse128 -> Just (tid, sid)) = (Just tid, Just sid)

    go acc _ = acc

-- parse128 :: BS.ByteString -> Maybe (Word64, Word64)
-- parse128 _ = Nothing -- TODO

headersForSpanContext :: SpanContext -> [(BS.ByteString, BS.ByteString)]
headersForSpanContext ctx =
  [ ("ot-tracer-traceid", encode_u64 $ ctx ^. traceId),
    ("ot-tracer-spanid", encode_u64 $ ctx ^. spanId)
  ]

b3headersForSpanContext :: SpanContext -> [(BS.ByteString, BS.ByteString)]
b3headersForSpanContext ctx =
  [ ("x-b3-traceid", encode_u64 $ ctx ^. traceId),
    ("x-b3-spanid", encode_u64 $ ctx ^. spanId),
    ("x-b3-sampled", "true")
  ]

encode_u64 :: Word64 -> BS.ByteString
-- TODO: a better way to encode base16
encode_u64 x =
  let encodeChar :: Word8 -> Word8
      encodeChar c | c < 10 = 48 + c
      encodeChar c = 87 + c
      hexDigits = go 16 [] x
      go :: Int -> [Word8] -> Word64 -> [Word8]
      go 0 acc _ = acc
      go n acc v = go (n - 1) (encodeChar (fromIntegral v .&. 0x0f) : acc) (v `div` 16)
   in BS.pack hexDigits

decode_u64 :: BS.ByteString -> Maybe Word64
decode_u64 bytes | BS.length bytes /= 16 = Nothing
decode_u64 bytes = BS.foldl' go (Just 0) bytes
  where
    go Nothing _ = Nothing
    go (Just !result) d | d >= 48 && d < 58 = Just $ result * 16 + fromIntegral d - 48
    go (Just result) d | d >= 97 && d < 124 = Just $ result * 16 + fromIntegral d - 87
    go _ _ = Nothing
