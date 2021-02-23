module EntryStorage.Interface.ConnectorEntryProvider 
( Interface
, providePositiveNodeEntry
, provideNegativeNodeEntry ) where

import EntryStorage.Interface.CounterEntryProvider as CounterEntryProvider
import qualified Memory
import Control.Monad.State (State)

class CounterEntryProvider a => Interface a where
    providePositiveNodeEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeNodeEntry :: a -> State Memory.ChunkStorage (Maybe a)