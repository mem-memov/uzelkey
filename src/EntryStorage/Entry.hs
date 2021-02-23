module EntryStorage.Entry 
( Type ) where

import qualified EntryStorage.Pointer.Positive as PositivePointer
import qualified EntryStorage.Pointer.Negative as NegativePointer
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider as EntryProvider
import qualified EntryStorage.Interface.EntryProvider.Pointer as PointerEntryProvider

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

instance Eraser.Interface Type where
    erase (Type positivePointer negativePointer) = Type (Eraser.erase positivePointer) (Eraser.erase negativePointer)
    isBlank (Type positivePointer negativePointer) = Eraser.isBlank positivePointer && Eraser.isBlank negativePointer

instance EntryProvider.Interface Type where
    providePositiveNodeEntry (Type positivePointer _) = PointerEntryProvider.provideNodeEntry positivePointer
    providePositiveBackwardEntry (Type positivePointer _) = PointerEntryProvider.provideBackwardEntry positivePointer
    providePositiveForwardEntry (Type positivePointer _) = PointerEntryProvider.provideForwardEntry positivePointer
    provideNegativeNodeEntry (Type _ negativePointer) = PointerEntryProvider.provideNodeEntry negativePointer
    provideNegativeBackwardEntry (Type _ negativePointer) = PointerEntryProvider.provideBackwardEntry negativePointer
    provideNegativeForwardEntry (Type _ negativePointer) = PointerEntryProvider.provideForwardEntry negativePointer