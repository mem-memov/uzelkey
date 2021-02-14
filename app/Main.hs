module Main where

import qualified Memory
import Data.Maybe (fromJust)
import qualified EntryStorage
import qualified Serializer
import Control.Monad.State (runState, execState, evalState, put)

main :: IO ()
main = do
    let entry = do
                    byteStorage <- Memory.create 4 100000000
                    entry <- (flip evalState) byteStorage $ do 
                                                                EntryStorage.writeEntry 0 (Serializer.deserialize [1,1,1,1,1,1])
                                                                entry <- EntryStorage.readEntry 0
                                                                return $ entry
                    return entry
    print entry
    a <- getLine
    if a == "exit" then return () else main 
