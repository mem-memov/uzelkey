module EntryStorage.Interface.EntryProvider.Pointer 
( Interface
, provideNodeEntry
, provideBackwardEntry
, provideForwardEntry ) where

import qualified EntryStorage.Interface.EntryProvider as EntryProvider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideNodeEntry :: (Serializer.Interface b, EntryProvider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideBackwardEntry :: (Serializer.Interface b, EntryProvider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideForwardEntry :: (Serializer.Interface b, EntryProvider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)