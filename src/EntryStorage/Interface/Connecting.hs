module EntryStorage.Interface.Connecting 
( Interface 
, getPositiveCounter
, getPreviousPositiveConnector
, getNextPositiveConnector
, getNegativeCounter
, getPreviousNegativeConnector
, getNextNegativeConnector ) where

import qualified EntryStorage.Counting as Counting
import qualified Memory
import Control.Monad.State (State)

class Interface a where
    getPositiveCounter :: Counting b => a -> State Memory.ChunkStorage (Maybe b)
    getPreviousPositiveConnector :: a -> State Memory.ChunkStorage (Maybe a)
    getNextPositiveConnector :: a -> State Memory.ChunkStorage (Maybe a)
    getNegativeCounter :: Counting b => a -> State Memory.ChunkStorage (Maybe b)
    getPreviousNegativeConnector :: a -> State Memory.ChunkStorage (Maybe a)
    getNextNegativeConnector :: a -> State Memory.ChunkStorage (Maybe a)