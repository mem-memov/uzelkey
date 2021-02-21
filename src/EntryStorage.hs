module EntryStorage
( EntryStorage.readEntry
, EntryStorage.writeEntry ) where

import qualified Memory
import qualified Entry
import qualified Serializer
import Control.Monad.State (State, get, put)

readEntry :: Int -> State Memory.ChunkStorage (Maybe Entry.Type)
readEntry address = do -- State
    storage <- get
    return $ do -- Maybe
                words <- Memory.read storage address 6
                return $ Serializer.deserialize words

writeEntry :: Int -> Entry.Type -> State Memory.ChunkStorage ()
writeEntry address entry = do
    storage <- get
    let words = Serializer.serialize entry
    let maybeStorage = Memory.write storage address words
    case maybeStorage of
        Nothing -> return ()
        Just newStorage -> put newStorage
