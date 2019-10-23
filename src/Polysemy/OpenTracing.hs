{-# language TemplateHaskell #-}
{-# OPTIONS_GHC -fplugin=Polysemy.Plugin #-}

module Polysemy.OpenTracing where

import Data.Kind
import Polysemy
import Polysemy.Trace

data Span = Span String

data OpenTracing (m :: Type -> Type) (a :: Type) where
  WithSpan :: String -> m a -> OpenTracing m a
  SetTag :: String -> String -> OpenTracing m ()

makeSem ''OpenTracing

openTracingToTrace :: Member Trace r => Sem (OpenTracing : r) a -> Sem r a
openTracingToTrace = interpretH $ \case
  WithSpan name action -> do
    action' <- runT action
    let run_ = raise . openTracingToTrace
    trace $ show ("begin", name)
    result <- run_ action'
    trace $ show ("end", name)
    pure result
  SetTag k v -> do
    trace $ show ("setTag", k, v)
    pureT ()

-- withSpan :: Member OpenTracing r => String -> Sem r a -> Sem r a
-- setTag :: Member OpenTracing r => String -> String -> Sem r ()
