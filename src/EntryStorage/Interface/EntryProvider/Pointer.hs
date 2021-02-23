module EntryStorage.Interface.EntryProvider.Pointer 
( Interface
, provideNodeEntry
, provideBackwardEntry
, provideForwardEntry ) where

import qualified EntryStorage.Interface.ConnectorEntryProvider as ConnectorEntryProvider
import qualified EntryStorage.Interface.CounterEntryProvider as CounterEntryProvider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideNodeEntry :: 
        (Serializer.Interface b, CounterEntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)
    provideBackwardEntry :: 
        (Serializer.Interface b, ConnectorEntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)
    provideForwardEntry :: 
        (Serializer.Interface b, ConnectorEntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)