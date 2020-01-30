{-# LANGUAGE OverloadedStrings #-}

module LightStep.Propagation
  ( module P
  , module LightStep.Propagation
  ) where

import Control.Lens
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8
import Data.List (foldl')
import Data.ProtoLens.Message (defMessage)
import GHC.Word
import Network.Wai
import Proto.Collector as P
import Proto.Collector_Fields as P
import Data.String
import Text.Printf

extractSpanContextFromRequest :: Request -> Maybe SpanContext
extractSpanContextFromRequest = extractSpanContextFromRequestHeaders . requestHeaders

extractSpanContextFromRequestHeaders :: (IsString key, Eq key) => [(key, BS.ByteString)] -> Maybe SpanContext
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
encode_u64 x = BS8.pack (printf "%016x" x)

decode_u64 :: BS.ByteString -> Maybe Word64
decode_u64 bytes | BS.length bytes > 16 = Nothing
decode_u64 bytes = BS.foldl' go (Just 0) bytes
  where
    go Nothing _ = Nothing
    go (Just !result) d | d >= 48 && d < 58 = Just $ result * 16 + fromIntegral d - 48
    go (Just result) d | d >= 97 && d < 124 = Just $ result * 16 + fromIntegral d - 87
    go _ _ = Nothing
