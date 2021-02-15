module MonadStack where

import qualified Memory
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Except
import Control.Monad.Trans.Except
import Control.Monad.Trans.State
import Control.Monad.Trans.Reader

data Configuration = Configuration 
    {  aParam :: Int }

data ApplicationError = SomeError | AnotherError deriving Show

type ExceptIOStack = ExceptT ApplicationError IO
type StateExceptIOStack = StateT Memory.ChunkStorage ExceptIOStack
type ReaderStateExceptIOStack a = ReaderT Configuration StateExceptIOStack a

runIO :: IO a -> ReaderStateExceptIOStack a
runIO = lift . lift. lift

-- runExcept :: Except a -> ReaderStateExceptIOStack a
-- runExcept = lift . lift

-- runState :: State a -> ReaderStateExceptIOStack a
-- runState = lift

-- runReader :: Reader a -> ReaderStateExceptIOStack a
-- runReader = id