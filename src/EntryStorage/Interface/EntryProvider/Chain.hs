module EntryStorage.Interface.EntryProvider.Chain
( Interface
, provideBackwardEntry
, provideForwardEntry ) where

import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)