module EntryStorage.PositivePointer (Type) where

import qualified EntryStorage.Pointer as Pointer
import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.Eraser as Eraser

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type pointer) = Serializer.serialize pointer
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type pointer) = "(PositivePointer " ++ show pointer ++ ")"

instance Eraser.Interface Type where
    erase (Type pointer) = Type $ Eraser.erase pointer
    isBlank (Type pointer) = Eraser.isBlank pointer