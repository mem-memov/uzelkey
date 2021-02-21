module NegativePointer (NegativePointer.Type) where

import qualified Pointer
import qualified Serializer

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface NegativePointer.Type where
    serialize (NegativePointer.Type pointer) = Serializer.serialize pointer
    deserialize words = NegativePointer.Type $ Serializer.deserialize words

instance Show NegativePointer.Type where
    show (NegativePointer.Type pointer) = "(NegativePointer " ++ show pointer ++ ")"