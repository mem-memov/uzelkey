module EntryStorage.Interface.CounterEntryProvider 
( Interface
, providePositiveBackwardEntry
, providePositiveForwardEntry
, provideNegativeBackwardEntry
, provideNegativeForwardEntry ) where

import qualified EntryStorage.Interface.ConnectorEntryProvider as ConnectorEntryProvider
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    providePositiveBackwardEntry :: ConnectorEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)
    providePositiveForwardEntry :: ConnectorEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)
    provideNegativeBackwardEntry :: ConnectorEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)
    provideNegativeForwardEntry :: ConnectorEntryProvider b => a -> State Memory.ChunkStorage (Maybe b)