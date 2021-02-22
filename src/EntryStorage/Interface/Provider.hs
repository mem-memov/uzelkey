module EntryStorage.Interface.Provider 
( Interface
, providePositiveNodeEntry
, providePositiveBackwardEntry
, providePositiveForwardEntry
, provideNegativeNodeEntry
, provideNegativeBackwardEntry
, provideNegativeForwardEntry ) where

import qualified Memory
import Control.Monad.State (State)

class Interface a where
    providePositiveNodeEntry :: a -> State Memory.ChunkStorage (Maybe a)
    providePositiveBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    providePositiveForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeNodeEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)