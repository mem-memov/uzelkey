module Entry (Entry.Type) where

import Pointer
import Serializer

data Type = Type PositivePointer NegativePointer deriving (Show, Eq)

newtype PositivePointer = PositivePointer Pointer.Type deriving (Show, Eq)
newtype NegativePointer = NegativePointer Pointer.Type deriving (Show, Eq)

instance Serializer Entry.Type where
    serialize
        (Entry.Type positivePointer negativePointer)
        = serialize positivePointer ++ serialize negativePointer
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in entry deserializing."
        | otherwise 
        = Entry.Type
            (deserialize (take 3 words))
            (deserialize (drop 3 words))

instance Serializer PositivePointer where
    serialize (PositivePointer pointer) = serialize pointer
    deserialize words = PositivePointer $ deserialize words

instance Serializer NegativePointer where
    serialize (NegativePointer pointer) = serialize pointer
    deserialize words = NegativePointer $ deserialize words