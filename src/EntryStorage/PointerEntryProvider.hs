module EntryStorage.PointerEntryProvider 
( Interface
, provideForwardEntry
, provideForwardEntry
, provideBackwardEntry ) where

import qualified EntryStorage.Entry as Entry
import qualified Memory

class Interface a where
    provideNodeEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    provideForwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    provideBackwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)