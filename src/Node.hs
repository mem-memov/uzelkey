module Node 
( Type
, construct
, connect
) where

import qualified EntryStorage.Entry as Entry
import qualified EntryStorage.Interface.Provider as Provider
import qualified Memory
import Control.Monad.State (State, get)

data Type = Type Entry.Type

construct :: Entry.Type -> Type
construct entry = Type entry

connect :: Type -> Type -> ()
connect origin target = undefined

getLastDirectConnection :: Type -> State Memory.ChunkStorage (Maybe Type)
getLastDirectConnection (Type entry) = 
    do
        maybeBackwardEntry <- Provider.providePositiveBackwardEntry entry
        return Nothing
