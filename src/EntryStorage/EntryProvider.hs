module EntryStorage.EntryProvider
( Interface
, provideEntry ) where

import qualified EntryStorage.Provider as Provider
import qualified EntryStorage.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideEntry :: 
        (Serializer.Interface b, Provider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)