module EntryStorage.PointerEntryProvider 
( EntryStorage.PointerEntryProvider.Interface
, EntryStorage.PointerEntryProvider.provideForwardEntry
, EntryStorage.PointerEntryProvider.provideForwardEntry
, EntryStorage.PointerEntryProvider.provideBackwardEntry ) where

import qualified EntryStorage.Provider as Provider
import qualified Memory
import Control.Monad.State (State)

class Provider.Interface a => Interface a where
    provideNodeEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)