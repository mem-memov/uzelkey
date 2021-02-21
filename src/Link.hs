module Link 
( Link.Type ) where

import Serializer

newtype Type = Type Word deriving (Show, Eq)

instance Serializer Link.Type where
    serialize (Link.Type word) = [word]
    deserialize [word] = Link.Type word