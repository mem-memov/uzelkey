module Main where

import qualified Memory
import Data.Maybe (fromJust)
import qualified EntryStorage
import qualified EntryStorage.Serializer  as Serializer
import Control.Monad.State (evalState)

main :: IO ()
main = do
    let entry = do
                    byteStorage <- Memory.create 4 100000000
                    entry <- (flip evalState) byteStorage $ do 
                                                                EntryStorage.writeEntry 0 (Serializer.deserialize [1,1,1,1,1,1])
                                                                entry <- EntryStorage.readEntry 0
                                                                return $ entry -- from State
                    return entry -- from Maybe
    print entry
    a <- getLine
    if a == "exit" then return () else main 
