module EntryStorage.Interface.EntryProvider.Link
( Interface
, provideEntry ) where

import qualified EntryStorage.Interface.EntryProvider as EntryProvider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideEntry :: 
        (Serializer.Interface b, EntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)