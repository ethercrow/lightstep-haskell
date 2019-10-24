{-# language TemplateHaskell #-}
{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Polysemy.OpenTracing where

import Control.Monad
import Prelude hiding (span)
import Data.Kind
import Polysemy
import Polysemy.Trace
import Polysemy.Resource
import qualified Data.Text as T

type SpanName = T.Text

data Span = Span
  { spanName :: SpanName
  }

data OpenTracing (m :: Type -> Type) (a :: Type) where
  SetTag :: String -> String -> OpenTracing m ()
  StartSpan :: SpanName -> OpenTracing m Span
  FinishSpan :: Span -> OpenTracing m Span
  SubmitSpan :: Span -> OpenTracing m ()

makeSem ''OpenTracing

openTracingToTrace :: Member Trace r => Sem (OpenTracing : r) a -> Sem r a
openTracingToTrace = interpret $ \case
  SetTag k v -> do
    trace $ show ("setTag", k, v)
    pure ()
  StartSpan spanName -> do
    trace $ show ("startSpan", spanName)
    pure (Span spanName)  
  FinishSpan span -> do
    trace $ show ("finishSpan", spanName span)
    pure span
  SubmitSpan span -> do
    trace $ show ("submitSpan", spanName span)
    pure ()

withSpan :: (Member OpenTracing r, Member Resource r) => T.Text -> Sem r a -> Sem r a
withSpan name action =
  bracket 
    (startSpan name)
    (finishSpan >=> submitSpan)
    (const action)
