module EntryStorage.Entry 
( Type
, ConnectorType
, CounterType ) where

import qualified EntryStorage.Entry.Connector as ConnectorEntry
import qualified EntryStorage.Entry.Counter as CounterEntry

data Type = ConnectorType ConnectorEntry.Type | CounterType CounterEntry.Type deriving (Eq)
