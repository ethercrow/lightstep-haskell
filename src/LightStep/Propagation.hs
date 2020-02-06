{-# LANGUAGE OverloadedStrings #-}

module LightStep.Propagation
  ( module P
  , module LightStep.Propagation
  ) where

import Control.Lens
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8
import Data.ProtoLens.Message (defMessage)
import GHC.Word
import Network.HTTP.Types.Header (HeaderName)
import Network.Wai
import Proto.Collector as P
import Proto.Collector_Fields as P
import Data.String
import Text.Printf

type TextMap = [(BS.ByteString, BS.ByteString)]

type HttpHeaders = [(HeaderName, BS.ByteString)]

-- TODO: Binary format. Both go and python basictracers use TracerState
-- protobuf https://github.com/opentracing/basictracer-go/blob/master/wire/wire.proto

data Propagator a = Propagator
  { inject :: SpanContext -> a,
    extract :: a -> Maybe SpanContext
  }

textPropagator :: Propagator TextMap
textPropagator =
  let prefix = "Ot-Tracer-" in
    Propagator {
      inject = injectSpanContext prefix,
      extract = extractSpanContext prefix
      }

httpHeadersPropagator :: Propagator HttpHeaders
httpHeadersPropagator =
  let prefix = "Ot-Tracer-" in
    Propagator {
      inject = injectSpanContext prefix,
      extract = extractSpanContext prefix
      }

b3Propagator :: Propagator HttpHeaders
b3Propagator =
  let prefix = "X-B3-" in
    Propagator {
      inject = injectSpanContext prefix,
      extract = extractSpanContext prefix
      }

injectSpanContext ::
  (IsString key, Semigroup key) =>
  key -> SpanContext -> [(key, BS.ByteString)]
injectSpanContext prefix ctx =
  [ (prefix <> "Traceid", encode_u64 $ ctx ^. traceId)
  , (prefix <> "Spanid", encode_u64 $ ctx ^. spanId)
  , (prefix <> "Sampled", "true")
  ]

extractSpanContext ::
  (IsString key, Eq key, Semigroup key) =>
  key -> [(key, BS.ByteString)] -> Maybe SpanContext
extractSpanContext prefix format =
  (\(tid, sid) -> defMessage & traceId .~ tid & spanId .~ sid)
    <$> go format (Nothing, Nothing)
  where
    traceidKey = prefix <> "Traceid"
    spanidKey = prefix <> "Spanid"
    go _ (Just tid, Just sid) = Just (tid, sid)
    go [] _ = Nothing
    go ((k, v):xs) (tid, sid) | k == traceidKey = go xs (decode_u64 v, sid)
                              | k == spanidKey = go xs (tid, decode_u64 v)
                              | otherwise = go xs (tid, sid)

extractSpanContextFromRequest :: Request -> Maybe SpanContext
extractSpanContextFromRequest =
  extract httpHeadersPropagator . requestHeaders

-- parse128 :: BS.ByteString -> Maybe (Word64, Word64)
-- parse128 _ = Nothing -- TODO

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
