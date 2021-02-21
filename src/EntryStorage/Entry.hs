module EntryStorage.Entry 
( Type ) where

import qualified EntryStorage.Pointer as Pointer
import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.Eraser as Eraser
import qualified EntryStorage.PositivePointer as PositivePointer
import qualified EntryStorage.NegativePointer as NegativePointer

data Type = 
    Type 
        PositivePointer.Type 
        NegativePointer.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize
        (Type positivePointer negativePointer)
        = Serializer.serialize positivePointer ++ Serializer.serialize negativePointer
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in entry deserializing."
        | otherwise 
        = Type
            (Serializer.deserialize (take 3 words))
            (Serializer.deserialize (drop 3 words))

instance Show Type where
    show (Type positivePointer negativePointer) = 
        "(Entry " ++ show positivePointer ++ " " ++ show negativePointer ++ ")"