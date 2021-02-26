module EntryStorage.Data.Address
( Type ) where

import qualified EntryStorage
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified EntryStorage.Interface.Traversable as Traversable

newtype Type = Type Word deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type word) = [word]
    deserialize words 
        | length words == 1 
        = Right $ Type (words !! 0)
        | otherwise 
        = Left $ "Wrong number of words when deserializing address - " ++ (show . length) words ++ ". Starting with: " ++ (show . take 1) words

instance Erasable.Interface Type where
    erase _ = Type 0
    isBlank (Type word) = word == 0

instance Traversable.CounterProducibleInterface Type where
    getCounter (Type word) = EntryStorage.readCounter (fromEnum word)

instance Traversable.ConnectorProducibleInterface Type where
    getConnector (Type word) = EntryStorage.readConnector (fromEnum word)