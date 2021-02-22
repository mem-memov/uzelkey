module EntryStorage
( EntryStorage.readEntry
, EntryStorage.writeEntry ) where

import qualified Memory
import qualified EntryStorage.Provider as Provider
import qualified EntryStorage.Serializer as Serializer
import Control.Monad.State (State, get, put)

readEntry :: 
    (Serializer.Interface a, Provider.Interface a) => 
    Int -> State Memory.ChunkStorage (Maybe a)
readEntry address = do -- State
    storage <- get
    return $ do -- Maybe
                words <- Memory.read storage address 6
                return $ Serializer.deserialize words

writeEntry :: 
    Serializer.Interface a => 
    Int -> a -> State Memory.ChunkStorage ()
writeEntry address entry = do
    storage <- get
    let words = Serializer.serialize entry
    let maybeStorage = Memory.write storage address words
    case maybeStorage of
        Nothing -> return ()
        Just newStorage -> put newStorage
