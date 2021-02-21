module EntryStorage.Pointer (Type) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.NodeLink as NodeLink
import qualified EntryStorage.BackwardLink as BackwardLink
import qualified EntryStorage.ForwardLink as ForwardLink

data Type = 
    Type 
        NodeLink.Type 
        BackwardLink.Type 
        ForwardLink.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type nodeLink backwardLink forwardLink)
        = Serializer.serialize nodeLink ++ Serializer.serialize backwardLink ++ Serializer.serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Type 
                (Serializer.deserialize [words !! 0])
                (Serializer.deserialize [words !! 1])
                (Serializer.deserialize [words !! 2])

instance Show Type where
    show (Type nodeLink backwardLink forwardLink) = 
        "(Pointer " ++ show nodeLink ++ " " ++ show backwardLink ++ " " ++ show forwardLink ++ ")"
