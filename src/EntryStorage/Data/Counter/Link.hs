module EntryStorage.Data.Counter.Link
( Type ) where

import qualified EntryStorage.Data.Address as Address
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified EntryStorage.Interface.Traversable as Traversable

newtype Type = Type Address.Type deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type address) = Serializable.serialize address
    deserialize words = 
        case Serializable.deserialize words of
            Right address -> Right (Type address)
            Left errorMessage -> Left $ "Error deserializing counter link. " ++ errorMessage

instance Erasable.Interface Type where
    erase (Type address) = Type $ Erasable.erase address
    isBlank (Type address) = Erasable.isBlank address

instance Traversable.CounterProducibleInterface Type where
    getCounter (Type address) = EntryStorage.getCounter address