module LightStep.HighLevel.Polysemy 
  ( runOpenTracingWithLightStepIO
  , module Export
  ) where

import Control.Monad.Except
import Polysemy
import Polysemy.OpenTracing
import Polysemy.Resource
import Polysemy.Trace
import LightStep.LowLevel as Export (LightStepConfig (..))
import LightStep.LowLevel as LL

runOpenTracingWithLightStepIO ::
  (Member Resource r, Member (Embed IO) r, Member Trace r) =>
  LightStepConfig ->
  Sem (OpenTracing : r) a -> Sem r a
runOpenTracingWithLightStepIO cfg foo = bracket
  (do
    trace "creating client"
    clientOrError <- embed $ runExceptT $ mkClient cfg
    case clientOrError of
      Right client -> do
        trace "created client"
        pure client
      Left err -> do
        trace "failed to create client:"
        trace $ show err
        error $ show err)
  (\client -> do
    trace "closing client"
    embed $ runExceptT $ closeClient client
    trace "closed client")
  (\client -> interpret (\case
    SetTag k v -> do
      -- trace $ show ("setTag", k, v)
      pure ()
    StartSpan spanName -> do
      embed $ LL.startSpan spanName
    FinishSpan span -> do
      -- trace $ show ("finishSpan", spanName span)
      pure span
    SubmitSpan span -> do
      -- trace $ show ("submitSpan", spanName span)
      pure ()) foo)
