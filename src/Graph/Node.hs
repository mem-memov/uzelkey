module Graph.Node where
-- ( Type
-- , construct
-- , connect
-- ) where

-- import qualified EntryStorage.Data.Counter as Counter
-- import qualified Memory
-- import Control.Monad.State (State, get)

-- data Type = Type Counter.Type

-- construct :: Counter.Type -> Type
-- construct entry = Type entry

-- connect :: Type -> Type -> ()
-- connect origin target = undefined

-- getLastPositiveConnection :: Type -> State Memory.ChunkStorage (Maybe Type)
-- getLastPositiveConnection (Type entry) = 
--     do
--         maybeBackwardEntry <- EntryProvider.providePositiveBackwardEntry entry
--         let a = do
--             backwardEntry <- maybeBackwardEntry
--             EntryProvider.providePositive
--         return Nothing
