module Graph
( addNode
, getNode
) where

import qualified EntryStorage
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified Graph.Node as Node
import qualified Memory
import Control.Monad.State (State, get)

addNode :: State Memory.ChunkStorage (Either String Node.Type)
addNode = do
    maybeFirstNode <- getNode 0
    return $ Left "Error adding node."

getNode :: Int -> State Memory.ChunkStorage (Either String Node.Type)
getNode identifier = do
    maybeCounter <- EntryStorage.readCounter identifier
    return $ fmap Node.construct maybeCounter