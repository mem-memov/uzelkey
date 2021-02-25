module EntryStorage.Data.Connector.Pointer
( Type ) where

import qualified EntryStorage.Data.Counter.Link as CounterLink
import qualified EntryStorage.Data.Connector.Chain as Chain
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

data Type = 
    Type 
        CounterLink.Type 
        Chain.Type 
        deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type counterLink chain) = (Serializable.serialize counterLink) ++ (Serializable.serialize chain)
    deserialize words
        | length words == 3 
        = do
            counterLink <- Serializable.deserialize [words !! 0]
            chain <- Serializable.deserialize [words !! 1, words !! 2]
            return (Type counterLink chain)
        | otherwise 
        = Left $ "Wrong number of words when deserializing connector pointer - " ++ (show . length) words ++ " Starting with: " ++ (show . take 3) words

instance Erasable.Interface Type where
    erase (Type counterLink chain) = Type (Erasable.erase counterLink) (Erasable.erase chain)
    isBlank (Type counterLink chain) = Erasable.isBlank counterLink && Erasable.isBlank chain
