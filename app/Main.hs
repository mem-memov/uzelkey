module Main where

import qualified Memory
import Data.Maybe (fromJust)
import qualified EntryStorage.Entry as Entry
import qualified EntryStorage
import qualified EntryStorage.Interface.Serializer  as Serializer
import Control.Monad.State (evalState)

main :: IO ()
main = do -- IO
    let entry = do -- Maybe
                    byteStorage <- Memory.create 4 100000000
                    entry <- (flip evalState) byteStorage $ do -- State
                                                                EntryStorage.writeEntry 1 ((Serializer.deserialize [1,1,1,1,1,1]) :: Entry.Type)
                                                                entry <- EntryStorage.readEntry 1
                                                                return $ entry
                    return entry
    print (entry :: (Maybe Entry.Type))
    a <- getLine
    if a == "exit" then return () else main 
