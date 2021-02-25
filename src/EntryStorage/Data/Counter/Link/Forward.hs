module EntryStorage.Data.Counter.Link.Forward
( Type ) where

import qualified EntryStorage.Data.Counter.Link as Link
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

newtype Type = Type Link.Type deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type link) = Serializable.serialize link
    deserialize words = 
        case Serializable.deserialize words of
            Right link -> Right $ Type link
            Left errorMessage -> Left $ "Error deserializing forward counter link. " ++ errorMessage

instance Erasable.Interface Type where
    erase (Type link) = Type $ Erasable.erase link
    isBlank (Type link) = Erasable.isBlank link