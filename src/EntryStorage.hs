module EntryStorage
( EntryStorage.readEntry
, EntryStorage.writeEntry ) where

import qualified Memory
import qualified Types
import qualified Serializer
import Control.Monad.State (State, get, put)

readEntry :: Int -> State Memory.ChunkStorage (Maybe Types.Entry)
readEntry address = do
    storage <- get
    return $ do
                words <- Memory.read storage address 6
                return $ Serializer.deserialize words

writeEntry :: Int -> Types.Entry -> State Memory.ChunkStorage ()
writeEntry address entry = do
    storage <- get
    let words = Serializer.serialize entry
    let maybeStorage = Memory.write storage address words
    case maybeStorage of
        Nothing -> return ()
        Just newStorage -> put newStorage
