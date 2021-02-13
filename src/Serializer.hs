module Serializer where

import Types

class Serializer a where
    serialize :: a -> [Word]
    deserialize :: [Word] -> a

instance Serializer Link where
    serialize (Link word) = [word]
    deserialize [word] = Link word

instance Serializer NodeLink where
    serialize (NodeLink link) = serialize link
    deserialize words = NodeLink $ deserialize words

instance Serializer BackwardLink where
    serialize (BackwardLink link) = serialize link
    deserialize words = BackwardLink $ deserialize words

instance Serializer ForwardLink where
    serialize (ForwardLink link) = serialize link
    deserialize words = ForwardLink $ deserialize words

instance Serializer Pointer where
    serialize 
        (Pointer nodeLink backwardLink forwardLink)
        = serialize nodeLink ++ serialize backwardLink ++ serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Pointer 
                (deserialize [words !! 0])
                (deserialize [words !! 1])
                (deserialize [words !! 2])

instance Serializer PositivePointer where
    serialize (PositivePointer pointer) = serialize pointer
    deserialize words = PositivePointer $ deserialize words

instance Serializer NegativePointer where
    serialize (NegativePointer pointer) = serialize pointer
    deserialize words = NegativePointer $ deserialize words

instance Serializer Entry where
    serialize
        (Entry positivePointer negativePointer)
        = serialize positivePointer ++ serialize negativePointer
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in entry deserializing."
        | otherwise 
        = Entry 
            (deserialize (take 3 words))
            (deserialize (drop 3 words))
