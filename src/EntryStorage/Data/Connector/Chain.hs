module EntryStorage.Data.Connector.Chain
( Type ) where

import qualified EntryStorage.Data.Connector.Link.Backward as BackwardLink
import qualified EntryStorage.Data.Connector.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

data Type = 
    Type
        BackwardLink.Type
        ForwardLink.Type
        deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type backwardLink forwardLink) = (Serializable.serialize backwardLink) ++ (Serializable.serialize forwardLink)
    deserialize words
        | length words == 2 
        = do
            backwardLink <- Serializable.deserialize [words !! 0]
            forwardLink <- Serializable.deserialize [words !! 1]
            return (Type backwardLink forwardLink)
        | otherwise 
        = Left $ "Wrong number of words when deserializing connector chain - " ++ (show . length) words ++ " Starting with: " ++ (show . take 2) words


instance Erasable.Interface Type where
    erase (Type backwardLink forwardLink) = Type (Erasable.erase backwardLink) (Erasable.erase forwardLink)
    isBlank (Type backwardLink forwardLink) = Erasable.isBlank backwardLink && Erasable.isBlank forwardLink