module EntryStorage.Data.Counter.Accumulator
( Type ) where

import qualified EntryStorage.Data.Count as Count
import qualified EntryStorage.Data.Connector.Link as ConnectorLink
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

data Type =
    Type
        Count.Type
        ConnectorLink.Type
        deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type count connectorLink) = (Serializable.serialize count) ++ (Serializable.serialize connectorLink)
    deserialize words
        | length words == 2 
        = do
            count <- Serializable.deserialize [words !! 0]
            connectorLink <- Serializable.deserialize [words !! 1]
            return (Type count connectorLink)
        | otherwise 
        = Left $ "Wrong number of words when deserializing counter accumulator - " ++ (show . length) words ++ " Starting with: " ++ (show . take 2) words


instance Erasable.Interface Type where
    erase (Type count connectorLink) = Type (Erasable.erase count) (Erasable.erase connectorLink)
    isBlank (Type count connectorLink) = Erasable.isBlank count && Erasable.isBlank connectorLink