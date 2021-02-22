module EntryStorage.EntryProvider
( Interface
, provideEntry ) where

import qualified EntryStorage.Entry as Entry
import qualified Memory

class Interface a where
    provideEntry :: a -> State Memory.ChunkStorage (Maybe Entry.Type)