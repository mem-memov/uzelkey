module EntryStorage.Interface.EntryProvider.Link.Counter
( Interface
, provideEntry ) where

import qualified EntryStorage.Interface.CounterEntryProvider as CounterEntryProvider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideCounterEntry :: 
        (Serializer.Interface b, CounterEntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)