module Graph where

import qualified EntryStorage
import qualified Serializer
import qualified Node
import qualified Memory
import Control.Monad.State (State, get)


addNode :: State Memory.ChunkStorage (Maybe Node.Type)
addNode = undefined

getNode :: Int -> State Memory.ChunkStorage (Maybe Node.Type)
getNode identifier = do
    maybeEntry <- EntryStorage.readEntry identifier
    return $ fmap Node.construct maybeEntry