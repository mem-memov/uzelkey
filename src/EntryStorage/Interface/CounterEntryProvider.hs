module EntryStorage.Interface.CounterEntryProvider 
( Interface
, providePositiveBackwardEntry
, providePositiveForwardEntry
, provideNegativeBackwardEntry
, provideNegativeForwardEntry ) where

import qualified Memory
import Control.Monad.State (State)

class Interface a where
    providePositiveBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    providePositiveForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeBackwardEntry :: a -> State Memory.ChunkStorage (Maybe a)
    provideNegativeForwardEntry :: a -> State Memory.ChunkStorage (Maybe a)