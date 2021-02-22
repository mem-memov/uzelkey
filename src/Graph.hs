module Graph
( addNode
, getNode
) where

import qualified EntryStorage
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified Node
import qualified Memory
import Control.Monad.State (State, get)

addNode :: State Memory.ChunkStorage (Maybe Node.Type)
addNode = do
    maybeFirstNode <- getNode 0
    return Nothing

getNode :: Int -> State Memory.ChunkStorage (Maybe Node.Type)
getNode identifier = do
    maybeEntry <- EntryStorage.readEntry identifier
    return $ fmap Node.construct maybeEntry