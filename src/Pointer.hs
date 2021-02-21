module Pointer (Pointer.Type) where

import Link
import Serializer

data Type = Type NodeLink BackwardLink ForwardLink deriving (Show, Eq)

newtype NodeLink = NodeLink Link.Type deriving (Show, Eq)
newtype BackwardLink = BackwardLink Link.Type deriving (Show, Eq)
newtype ForwardLink = ForwardLink Link.Type deriving (Show, Eq)

instance Serializer Pointer.Type where
    serialize 
        (Pointer.Type nodeLink backwardLink forwardLink)
        = serialize nodeLink ++ serialize backwardLink ++ serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Pointer.Type 
                (deserialize [words !! 0])
                (deserialize [words !! 1])
                (deserialize [words !! 2])

instance Serializer NodeLink where
    serialize (NodeLink link) = serialize link
    deserialize words = NodeLink $ deserialize words

instance Serializer BackwardLink where
    serialize (BackwardLink link) = serialize link
    deserialize words = BackwardLink $ deserialize words

instance Serializer ForwardLink where
    serialize (ForwardLink link) = serialize link
    deserialize words = ForwardLink $ deserialize words