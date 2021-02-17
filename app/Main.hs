module Main where

import qualified Types
import qualified Memory
import Data.Maybe (fromJust)
import qualified EntryStorage
import qualified Serializer
import Control.Monad.State (evalState)
import qualified MonadStack
import Control.Monad.Trans.Reader (runReaderT)
import Control.Monad.Trans.State (runStateT)
import Control.Monad.Trans.Except (runExceptT)

writeReadFirstEntry :: MonadStack.ReaderStateIOStack Int
writeReadFirstEntry = do
    return 1

main :: IO ()
main = do
    let configuration = MonadStack.Configuration { MonadStack.aParam = 5 }
    let runReaderMonad = runReaderT writeReadFirstEntry configuration
    let runStateMonad = runStateT runReaderMonad (fromJust (Memory.create 4 100000000))
    e <- runStateMonad
    print e


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
