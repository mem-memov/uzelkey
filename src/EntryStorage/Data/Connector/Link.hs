module EntryStorage.Data.Connector.Link
( Type ) where

import qualified EntryStorage.Data.Address as Address
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

newtype Type = Type Address.Type deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type address) = Serializable.serialize address
    deserialize words = 
        case Serializable.deserialize words of
            Right address -> Right (Type address)
            Left errorMessage -> Left $ "Error deserializing connector link. " ++ errorMessage

instance Erasable.Interface Type where
    erase (Type address) = Type $ Erasable.erase address
    isBlank (Type address) = Erasable.isBlank address