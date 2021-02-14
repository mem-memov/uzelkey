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
                    return $ evalState (
                            do 
                                EntryStorage.writeEntry 0 (Serializer.deserialize [1,1,1,1,1,1])
                                entry <- EntryStorage.readEntry 0
                                return $ fromJust $ entry
                        ) byteStorage

    -- let byteStorage_1 = fromJust $ Memory.create 4 100000000
    -- let byteStorage_2 = execState (EntryStorage.writeEntry 0 (Serializer.deserialize [1,1,1,1,1,1])) byteStorage_1
    -- let (entry, byteStorage_3) = runState (EntryStorage.readEntry 0) byteStorage_2
    print entry
    a <- getLine
    if a == "exit" then return () else main 
