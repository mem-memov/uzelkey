module EntryStorage.Data.Connector
( Type ) where

import qualified EntryStorage.Data.Connector.Pointer.Positive as PositivePointer
import qualified EntryStorage.Data.Connector.Pointer.Negative as NegativePointer
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified EntryStorage.Interface.Traversable as Traversable

data Type = 
    Type 
        PositivePointer.Type 
        NegativePointer.Type 
        deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type positivePointer negativePointer) = (Serializable.serialize positivePointer) ++ (Serializable.serialize negativePointer)
    deserialize words
        | length words == 6 
        = do
            positivePointer <- Serializable.deserialize (take 3 words)
            negativePointer <- Serializable.deserialize (drop 3 words)
            return (Type positivePointer negativePointer)
        | otherwise 
        = Left $ "Wrong number of words when deserializing connector - " ++ (show . length) words ++ " Starting with: " ++ (show . take 6) words

instance Erasable.Interface Type where
    erase (Type positivePointer negativePointer) = Type (Erasable.erase positivePointer) (Erasable.erase negativePointer)
    isBlank (Type positivePointer negativePointer) = Erasable.isBlank positivePointer && Erasable.isBlank negativePointer

instance Traversable.ConnectableInterface Type where
    getPositiveCounter = undefined
    getPreviousPositiveConnector = undefined
    getNextPositiveConnector = undefined
    getNegativeCounter = undefined
    getPreviousNegativeConnector = undefined
    getNextNegativeConnector = undefined

