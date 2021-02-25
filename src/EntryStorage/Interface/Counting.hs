module EntryStorage.Interface.Countering
( Interface
, providePositiveEntry
, provideNegativeEntry ) where

import qualified EntryStorage.Connecting as Connecting
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    getPreviousCounter :: a -> State Memory.ChunkStorage (Maybe a) 
    getNextCounter :: a -> State Memory.ChunkStorage (Maybe a) 
    countPositiveEntries :: a -> State Memory.ChunkStorage (Maybe Count)
    getPositiveConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)
    countNegativeEntries :: a -> State Memory.ChunkStorage (Maybe Count)
    getNegativeConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)