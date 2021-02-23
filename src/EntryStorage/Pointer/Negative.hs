module EntryStorage.Pointer.Negative (Type) where

import qualified EntryStorage.Pointer as Pointer
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Pointer as PointerEntryProvider

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type pointer) = Serializer.serialize pointer
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type pointer) = "(NegativePointer " ++ show pointer ++ ")"

instance Eraser.Interface Type where
    erase (Type pointer) = Type $ Eraser.erase pointer
    isBlank (Type pointer) = Eraser.isBlank pointer

instance PointerEntryProvider.Interface Type where
    provideNodeEntry (Type pointer) = PointerEntryProvider.provideNodeEntry pointer
    provideBackwardEntry (Type pointer) = PointerEntryProvider.provideBackwardEntry pointer
    provideForwardEntry (Type pointer) = PointerEntryProvider.provideForwardEntry pointer