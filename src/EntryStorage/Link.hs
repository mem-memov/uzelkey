module EntryStorage.Link (Type) where

import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.Eraser as Eraser

newtype Type = Type Word deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type word) = [word]
    deserialize [word] = Type word

instance Show Type where
    show (Type word) = "(Link " ++ show word ++ ")"

instance Eraser.Interface Type where
    erase _ = Type 0
    isBlank (Type word) = word == 0