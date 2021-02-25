module EntryStorage.Data.Connector.Pointer.Positive
( Type ) where

import qualified EntryStorage.Data.Connector.Pointer as Pointer
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type pointer) = Serializable.serialize pointer
    deserialize words = 
        case Serializable.deserialize words of
            Right pointer -> Right (Type pointer)
            Left errorMessage -> Left $ "Error deserializing positive connector pointer. " ++ errorMessage

instance Erasable.Interface Type where
    erase (Type pointer) = Type $ Erasable.erase pointer
    isBlank (Type pointer) = Erasable.isBlank pointer