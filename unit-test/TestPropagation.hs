{-# LANGUAGE OverloadedStrings #-}

module TestPropagation where

import Control.Lens
import Data.Function
import Data.ProtoLens.Message (defMessage)
import Data.Word
import LightStep.Propagation
import Test.Tasty.HUnit
import Text.Printf

prop_u64_roundtrip :: Word64 -> Bool
prop_u64_roundtrip x =
  Just x == decode_u64 (encode_u64 x)

prop_ot_headers_roundtrip :: Word64 -> Word64 -> Bool
prop_ot_headers_roundtrip tid sid =
  let c =
        defMessage
          & traceId .~ tid
          & spanId .~ sid
   in Just c == extractSpanContextFromRequestHeaders (headersForSpanContext c)

prop_b3_headers_roundtrip :: Word64 -> Word64 -> Bool
prop_b3_headers_roundtrip tid sid =
  let c =
        defMessage
          & traceId .~ tid
          & spanId .~ sid
   in Just c == extractSpanContextFromRequestHeaders (b3headersForSpanContext c)
