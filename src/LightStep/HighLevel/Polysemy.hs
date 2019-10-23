module LightStep.HighLevel.Polysemy 
  ( runOpenTracingWithLightStep
  , module LightStep.LowLevel
  ) where

import Polysemy
import Polysemy.OpenTracing
import LightStep.LowLevel (LightStepConfig (..))

runOpenTracingWithLightStep ::
  Member (Embed IO) r =>
  LightStepConfig ->
  Sem (OpenTracing : r) a -> Sem r a
runOpenTracingWithLightStep = error "not implemented yet"
