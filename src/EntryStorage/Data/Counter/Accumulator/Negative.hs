module EntryStorage.Data.Counter.Accumulator.Negative 
( Type ) where

import qualified EntryStorage.Data.Counter.Accumulator as Accumulator
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified EntryStorage.Interface.Traversable as Traversable

newtype Type = Type Accumulator.Type deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type accumulator) = Serializable.serialize accumulator
    deserialize words = 
        case Serializable.deserialize words of
            Right accumulator -> Right (Type accumulator)
            Left errorMessage -> Left $ "Error deserializing negative counter accumulator. " ++ errorMessage

instance Erasable.Interface Type where
    erase (Type accumulator) = Type $ Erasable.erase accumulator
    isBlank (Type accumulator) = Erasable.isBlank accumulator

instance Traversable.AccumulatableInterface Type where
    countConnectors (Type accumulator) = Traversable.countConnectors accumulator

instance Traversable.ConnectorProducibleInterface Type where
    getConnector (Type accumulator) = Traversable.getConnector accumulator