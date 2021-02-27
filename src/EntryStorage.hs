module EntryStorage
( Entry(..)
, readEntry
, writeEntry ) where

import qualified Memory
import Control.Monad.State (State, get, put)

data Entry = Entry [Word] deriving (Eq, Show)

readEntry :: Int -> State Memory.ChunkStorage (Either String Entry)
readEntry address = do -- State
    storage <- get
    return $ do -- Either
                words <- Memory.read storage address 6
                return (Entry words)

writeEntry :: Int -> Entry -> State Memory.ChunkStorage (Either String ())
writeEntry address (Entry words)
    | length words /= 6 = return $ Left $ "Length of entry should be 6. Length " ++ (show . length) words ++ ". Entry content " ++ (show . take 100) words ++ "."
    | otherwise = do -- State
        storage <- get
        let modifiedStorage = Memory.write storage address words
        case modifiedStorage of
            Left errorMessage ->
                do -- State
                    return (Left errorMessage)
            Right newStorage -> 
                do -- State
                    put newStorage 
                    return (Right ())
