module PositivePointer (PositivePointer.Type) where

import qualified Pointer
import qualified Serializer

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface PositivePointer.Type where
    serialize (PositivePointer.Type pointer) = Serializer.serialize pointer
    deserialize words = PositivePointer.Type $ Serializer.deserialize words

instance Show PositivePointer.Type where
    show (PositivePointer.Type pointer) = "(PositivePointer " ++ show pointer ++ ")"