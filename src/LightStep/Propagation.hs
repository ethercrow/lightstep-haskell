{-# LANGUAGE OverloadedStrings #-}

module LightStep.Propagation
  ( module P
  , module LightStep.Propagation
  ) where

import Control.Lens
import qualified Data.HashMap.Strict as HM
import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as BS8
import Data.Hashable (Hashable)
import Data.ProtoLens.Message (defMessage)
import GHC.Word
import Network.HTTP.Types.Header (HeaderName)
import Network.Wai
import Proto.Collector as P
import Proto.Collector_Fields as P
import Data.String
import Text.Printf

newtype TextMap = TextMap { hmFromTextMap :: HM.HashMap BS.ByteString BS.ByteString }

newtype HttpHeaders = HttpHeaders { hmFromHttpHeaders :: HM.HashMap HeaderName BS.ByteString }

-- TODO: Binary format. Both go and python basictracers use TracerState
-- protobuf https://github.com/opentracing/basictracer-go/blob/master/wire/wire.proto

data Propagator a = Propagator
  { inject :: SpanContext -> Maybe a -> a,
    extract :: a -> Maybe SpanContext
  }

textPropagator :: Propagator TextMap
textPropagator =
  let prefix = "ot-tracer-" in
    Propagator {
      inject = \ctx maybeTextMap ->
        TextMap $ injectSpanContext prefix ctx (hmFromTextMap <$> maybeTextMap),
      extract = \(TextMap hm) ->
        extractSpanContext prefix hm
      }

httpHeadersPropagator :: Propagator HttpHeaders
httpHeadersPropagator =
  let prefix = "ot-tracer-" in
    Propagator {
      inject = \ctx maybeHeaders ->
        HttpHeaders $ injectSpanContext prefix ctx (hmFromHttpHeaders <$> maybeHeaders),
      extract = \(HttpHeaders hm) ->
        extractSpanContext prefix hm
      }

b3Propagator :: Propagator HttpHeaders
b3Propagator =
  let prefix = "x-b3-" in
    Propagator {
      inject = \ctx maybeHeaders ->
        let
          hm = injectSpanContext prefix ctx (hmFromHttpHeaders <$> maybeHeaders)
          hm' = HM.insert (prefix <> "sampled") "true" hm
        in HttpHeaders hm',
      extract = \(HttpHeaders hm) ->
        extractSpanContext prefix hm
      }

injectSpanContext ::
  (IsString key, Eq key, Hashable key, Semigroup key) =>
  key -> SpanContext -> Maybe (HM.HashMap key BS.ByteString) -> HM.HashMap key BS.ByteString
injectSpanContext prefix ctx (Just hm) =
  let
    hm' = HM.insert (prefix <> "traceid") (encode_u64 $ ctx ^. traceId) hm
    hm'' = HM.insert (prefix <> "spanid") (encode_u64 $ ctx ^. spanId) hm'
  in hm''
injectSpanContext prefix ctx Nothing = injectSpanContext prefix ctx (Just HM.empty)

extractSpanContext ::
  (IsString key, Eq key, Hashable key, Semigroup key) =>
  key -> HM.HashMap key BS.ByteString -> Maybe SpanContext
extractSpanContext prefix hm = do
  tid <- HM.lookup (prefix <> "traceid") hm >>= decode_u64
  sid <- HM.lookup (prefix <> "spanid") hm >>= decode_u64
  return (defMessage & traceId .~ tid & spanId .~ sid)

extractSpanContextFromRequest :: Request -> Maybe SpanContext
extractSpanContextFromRequest =
  extract httpHeadersPropagator . HttpHeaders . HM.fromList . requestHeaders

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
