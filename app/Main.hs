module Main where

import qualified Memory
import Data.Maybe (fromJust)
import qualified EntryStorage
import Control.Monad.State (evalState)

main :: IO ()
main = do -- IO
    -- let entry = do -- Either
    --                 byteStorage <- Memory.create 4 100000000
    --                 entry <- (flip evalState) byteStorage $ do -- State
    --                                                             let counter = (Serializable.deserialize [1,1,1,1,1,1]) :: Counter.Type
    --                                                             case counter of
    --                                                                 Right entry -> EntryStorage.writeEntry 1 entry
                                                                
    --                                                             entry <- EntryStorage.readCounter 1
    --                                                             return $ entry
    --                 return entry
    -- print (entry :: (Either String Counter.Type))
    a <- getLine
    if a == "exit" then return () else main 
