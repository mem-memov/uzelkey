module EntryStorage.Interface.Countering
( Interface
, getPreviousCounter
, getNextCounter
, countPositiveConnectors
, getPositiveConnector
, countNegativeConnectors
, getNegativeConnector ) where

import qualified EntryStorage.Connecting as Connecting
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    getPreviousCounter :: a -> State Memory.ChunkStorage (Maybe a) 
    getNextCounter :: a -> State Memory.ChunkStorage (Maybe a) 
    countPositiveConnectors :: a -> State Memory.ChunkStorage (Maybe Count)
    getPositiveConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)
    countNegativeConnectors :: a -> State Memory.ChunkStorage (Maybe Count)
    getNegativeConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)