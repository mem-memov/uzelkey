module EntryStorage.Interface.PointerEntryProvider 
( Interface
, provideNodeEntry
, provideBackwardEntry
, provideForwardEntry ) where

import qualified EntryStorage.Interface.Provider as Provider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideNodeEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideBackwardEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)
    provideForwardEntry :: (Serializer.Interface b, Provider.Interface b) => a -> State Memory.ChunkStorage (Maybe b)