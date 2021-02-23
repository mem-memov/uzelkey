module EntryStorage.Interface.EntryProvider.Link.Connector
( Interface
, provideEntry ) where

import qualified EntryStorage.Interface.ConnectorEntryProvider as ConnectorEntryProvider
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    provideConnectorEntry :: 
        (Serializer.Interface b, ConnectorEntryProvider.Interface b) => 
        a -> State Memory.ChunkStorage (Maybe b)