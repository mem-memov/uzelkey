module EntryStorage
( readEntry
, readEntry
, writeEntry ) where

import qualified Memory
import Control.Monad.State (State, get, put)

data Entry  = Entry [Word] deriving (Eq)

readEntry :: Int -> State Memory.ChunkStorage (Either String Entry)
readEntry address = do -- State
    storage <- get
    return $ do -- Either
                words <- Memory.read storage address 6
                return (Entry words)

writeEntry :: Int -> Entry -> State Memory.ChunkStorage (Either String ())
writeEntry address (Entry words) = do -- State
    storage <- get
    let modifiedStorage = Memory.write storage address words
    case modifiedStorage of
        Left errorMessage -> return (Left errorMessage)
        Right newStorage -> put newStorage >> return (Right ())
