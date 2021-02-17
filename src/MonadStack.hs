module MonadStack where

import qualified Memory
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Trans.State
import Control.Monad.Trans.Reader

data Configuration = Configuration 
    {  aParam :: Int }


type StateIOStack = StateT Memory.ChunkStorage IO
type ReaderStateIOStack a = ReaderT Configuration StateIOStack a

runIO :: IO a -> ReaderStateIOStack a
runIO = lift . lift


-- runState :: State a -> ReaderStateExceptIOStack a
-- runState = lift

-- runReader :: Reader a -> ReaderStateExceptIOStack a
-- runReader = id