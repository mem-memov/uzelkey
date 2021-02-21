module EntryStorage.PositivePointer (Type) where

import qualified EntryStorage.Pointer as Pointer
import qualified EntryStorage.Serializer as Serializer

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type pointer) = Serializer.serialize pointer
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type pointer) = "(PositivePointer " ++ show pointer ++ ")"