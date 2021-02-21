module Link 
( Link.Type ) where

import qualified Serializer

newtype Type = Type Word deriving (Show, Eq)

instance Serializer.Interface Link.Type where
    serialize (Link.Type word) = [word]
    deserialize [word] = Link.Type word