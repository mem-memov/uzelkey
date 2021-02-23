module EntryStorage.Interface.Counter
( Interface
, providePositiveEntry
, provideNegativeEntry ) where

import qualified EntryStorage.Count as Count
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    countPositiveEntries :: a -> State Memory.ChunkStorage (Maybe Count)
    countNegativeEntries :: a -> State Memory.ChunkStorage (Maybe Count)