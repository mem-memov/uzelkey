module EntryStorage.PointerEntryProvider 
( EntryStorage.PointerEntryProvider.Interface
, EntryStorage.PointerEntryProvider.provideNodeEntry
, EntryStorage.PointerEntryProvider.provideBackwardEntry
, EntryStorage.PointerEntryProvider.provideForwardEntry ) where

import qualified EntryStorage.Provider as Provider
import qualified EntryStorage.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideNodeEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideBackwardEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideForwardEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)