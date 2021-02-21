module EntryStorage.Link (Type) where

import qualified EntryStorage.Serializer as Serializer

newtype Type = Type Word deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type word) = [word]
    deserialize [word] = Type word

instance Show Type where
    show (Type word) = "(Link " ++ show word ++ ")"