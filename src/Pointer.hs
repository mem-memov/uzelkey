module Pointer (Pointer.Type) where

import qualified Link
import qualified Serializer
import qualified NodeLink
import qualified BackwardLink
import qualified ForwardLink

data Type = 
    Type 
        NodeLink.Type 
        BackwardLink.Type 
        ForwardLink.Type 
        deriving (Eq)

instance Serializer.Interface Pointer.Type where
    serialize 
        (Pointer.Type nodeLink backwardLink forwardLink)
        = Serializer.serialize nodeLink ++ Serializer.serialize backwardLink ++ Serializer.serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Pointer.Type 
                (Serializer.deserialize [words !! 0])
                (Serializer.deserialize [words !! 1])
                (Serializer.deserialize [words !! 2])

instance Show Pointer.Type where
    show (Pointer.Type nodeLink backwardLink forwardLink) = 
        "(Pointer " ++ show nodeLink ++ " " ++ show backwardLink ++ " " ++ show forwardLink ++ ")"
