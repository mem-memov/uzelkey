module EntryStorage.Pointer.Negative (Type) where

import qualified EntryStorage.Pointer as Pointer
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Chain as ChainEntryProvider

newtype Type = Type Pointer.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type pointer) = Serializer.serialize pointer
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type pointer) = "(NegativePointer " ++ show pointer ++ ")"

instance Eraser.Interface Type where
    erase (Type pointer) = Type $ Eraser.erase pointer
    isBlank (Type pointer) = Eraser.isBlank pointer

instance ChainEntryProvider.Interface Type where
    provideBackwardEntry (Type pointer) = ChainEntryProvider.provideBackwardEntry pointer
    provideForwardEntry (Type pointer) = ChainEntryProvider.provideForwardEntry pointer