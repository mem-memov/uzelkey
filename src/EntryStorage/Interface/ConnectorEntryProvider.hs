module EntryStorage.Interface.ConnectorEntryProvider 
( Interface
, providePositiveNodeEntry
, provideNegativeNodeEntry ) where

import qualified EntryStorage.Interface.CounterEntryProvider as CounterEntryProvider
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    providePositiveNodeEntry :: CounterEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)
    providePositiveBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    providePositiveForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeNodeEntry :: CounterEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)
    provideNegativeBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)