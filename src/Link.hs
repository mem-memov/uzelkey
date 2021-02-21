module Link (Link.Type) where

import qualified Serializer

newtype Type = Type Word deriving (Eq)

instance Serializer.Interface Link.Type where
    serialize (Link.Type word) = [word]
    deserialize [word] = Link.Type word

instance Show Link.Type where
    show (Link.Type word) = "(Link " ++ show word ++ ")"