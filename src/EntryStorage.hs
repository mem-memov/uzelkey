module EntryStorage
( readCounter
, readConnector
, writeEntry ) where

import qualified Memory
import qualified EntryStorage.Interface.Traversable as Traversable
import qualified EntryStorage.Interface.Serializable as Serializable
import Control.Monad.State (State, get, put)

readCounter :: 
    (Serializable.Interface a, Traversable.CountableInterface a) => 
    Int -> State Memory.ChunkStorage (Either String a)
readCounter address = do -- State
    storage <- get
    return $ do -- Either
                words <- Memory.read storage address 6
                entry <- Serializable.deserialize words
                return entry

readConnector :: 
    (Serializable.Interface a, Traversable.ConnectableInterface a) => 
    Int -> State Memory.ChunkStorage (Either String a)
readConnector address = do -- State
    storage <- get
    return $ do -- Either
                words <- Memory.read storage address 6
                entry <- Serializable.deserialize words
                return entry

writeEntry :: 
    Serializable.Interface a => 
    Int -> a -> State Memory.ChunkStorage (Either String ())
writeEntry address entry = do -- State
    storage <- get
    let words = Serializable.serialize entry
    let modifiedStorage = Memory.write storage address words
    case modifiedStorage of
        Left errorMessage -> return (Left errorMessage)
        Right newStorage -> put newStorage >> return (Right ())
