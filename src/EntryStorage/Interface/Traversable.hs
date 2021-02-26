module EntryStorage.Interface.Traversable
( ConnectableInterface 
, getPositiveCounter
, getPreviousPositiveConnector
, getNextPositiveConnector
, getNegativeCounter
, getPreviousNegativeConnector
, getNextNegativeConnector 
, CountableInterface
, getPreviousCounter
, getNextCounter
, countPositiveConnectors
, getPositiveConnector
, countNegativeConnectors
, getNegativeConnector
, ChainableInterface
, getPrevious
, getNext
, CounterProducibleInterface
, getCounter
, AccumulatableInterface
, countConnectors
, ConnectorProducibleInterface
, getConnector ) where

import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Data.Count as Count
import qualified Memory
import Control.Monad.State (State)

class (Serializable.Interface a) => ConnectableInterface a where
    getPositiveCounter :: CountableInterface b => a -> State Memory.ChunkStorage (Either String b)
    getPreviousPositiveConnector :: a -> State Memory.ChunkStorage (Either String a)
    getNextPositiveConnector :: a -> State Memory.ChunkStorage (Either String a)
    getNegativeCounter :: CountableInterface b => a -> State Memory.ChunkStorage (Either String b)
    getPreviousNegativeConnector :: a -> State Memory.ChunkStorage (Either String a)
    getNextNegativeConnector :: a -> State Memory.ChunkStorage (Either String a)

class (Serializable.Interface a) => CountableInterface a where
    getPreviousCounter :: a -> State Memory.ChunkStorage (Either String a) 
    getNextCounter :: a -> State Memory.ChunkStorage (Either String a) 
    countPositiveConnectors :: a -> State Memory.ChunkStorage (Either String Count.Type)
    getPositiveConnector :: ConnectableInterface b => a -> State Memory.ChunkStorage (Either String b)
    countNegativeConnectors :: a -> State Memory.ChunkStorage (Either String Count.Type)
    getNegativeConnector :: ConnectableInterface b => a -> State Memory.ChunkStorage (Either String b)

class (Serializable.Interface a) => ChainableInterface a where
    getPrevious :: a -> State Memory.ChunkStorage (Either String a) 
    getNext :: a -> State Memory.ChunkStorage (Either String a) 

class (Serializable.Interface a) => CounterProducibleInterface a where
    getCounter :: CountableInterface b => a -> State Memory.ChunkStorage (Either String b)

class (Serializable.Interface a) => AccumulatableInterface a where
    countConnectors :: a -> State Memory.ChunkStorage (Either String Count.Type)

class (Serializable.Interface a) => ConnectorProducibleInterface a where
    getConnector :: ConnectableInterface b => a -> State Memory.ChunkStorage (Either String b)