module LightStep.Diagnostics where

import Control.Concurrent.STM
import System.IO.Unsafe

inc :: Int -> TVar Int -> IO ()
inc n var = atomically $ do
  value <- readTVar var
  writeTVar var $! value + n

reconnectCountVar :: TVar Int
reconnectCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE reconnectCountVar #-}

startedSpanCountVar :: TVar Int
startedSpanCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE startedSpanCountVar #-}

finishedSpanCountVar :: TVar Int
finishedSpanCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE finishedSpanCountVar #-}

droppedSpanCountVar :: TVar Int
droppedSpanCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE droppedSpanCountVar #-}

reportedSpanCountVar :: TVar Int
reportedSpanCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE reportedSpanCountVar #-}

rejectedSpanCountVar :: TVar Int
rejectedSpanCountVar = unsafePerformIO $ newTVarIO 0
{-# NOINLINE rejectedSpanCountVar #-}

data Diagnostics
  = Diagnostics
      { diagReconnectCount :: !Int,
        diagStartedSpanCount :: !Int,
        diagFinishedSpanCount :: !Int,
        diagDroppedSpanCount :: !Int,
        diagReportedSpanCount :: !Int,
        diagRejectedSpanCount :: !Int
      }

getDiagnostics :: IO Diagnostics
getDiagnostics =
  atomically $
    Diagnostics
      <$> readTVar reconnectCountVar
      <*> readTVar startedSpanCountVar
      <*> readTVar finishedSpanCountVar
      <*> readTVar droppedSpanCountVar
      <*> readTVar reportedSpanCountVar
      <*> readTVar rejectedSpanCountVar
