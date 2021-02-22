module EntryStorage.Provider 
( Interface
, providePositiveNodeEntry
, providePositiveBackwardEntr
, providePositiveForwardEntry
, provideNegativeNodeEntry
, provideNegativeBackwardEntry
, provideNegativeForwardEntry ) where

import qualified EntryStorage.Entry as Entry
import qualified Memory

class Interface a where
    providePositiveNodeEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    providePositiveBackwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    providePositiveForwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    provideNegativeNodeEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    provideNegativeBackwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)
    provideNegativeForwardEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)