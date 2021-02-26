module EntryStorage.Data.Count
( Type ) where

import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable

newtype Type = Type Word deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type word) = [word]
    deserialize words 
        | length words == 1 
        = Right $ Type (words !! 0)
        | otherwise 
        = Left $ "Wrong number of words when deserializing count - " ++ (show . length) words ++ ". Starting with: " ++ (show . take 1) words
        
instance Erasable.Interface Type where
    erase _ = Type 0
    isBlank (Type word) = word == 0


