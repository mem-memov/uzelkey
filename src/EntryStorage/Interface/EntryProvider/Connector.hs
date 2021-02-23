module EntryStorage.Interface.EntryProvider.Connector
( Interface
, provideEntry ) where

import qualified EntryStorage.Interface.EntryProvider.Chain as ChainEntryProvider
import qualified EntryStorage.Interface.Counter as Counter
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    providePositiveEntry :: 
        (ChainEntryProvider b, Counter b) =>
        a -> State Memory.ChunkStorage (Maybe b)
    provideNegativeEntry :: 
        (ChainEntryProvider b, Counter b) =>
        a -> State Memory.ChunkStorage (Maybe b)