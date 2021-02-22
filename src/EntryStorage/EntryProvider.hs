module EntryStorage.EntryProvider
( Interface
, provideEntry ) where

import qualified EntryStorage.Provider as Provider
import qualified Memory
import Control.Monad.State (State)

class Provider.Interface a => Interface a where
    provideEntry :: a -> State Memory.ChunkStorage (Maybe a)