module Entry 
( Entry.Type ) where

import qualified Pointer
import qualified Serializer
import qualified PositivePointer
import qualified NegativePointer

data Type = 
    Type 
        PositivePointer.Type 
        NegativePointer.Type 
        deriving (Show, Eq)

instance Serializer.Interface Entry.Type where
    serialize
        (Entry.Type positivePointer negativePointer)
        = Serializer.serialize positivePointer ++ Serializer.serialize negativePointer
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in entry deserializing."
        | otherwise 
        = Entry.Type
            (Serializer.deserialize (take 3 words))
            (Serializer.deserialize (drop 3 words))
