module EntryStorage.Link 
( Type ) where

import qualified EntryStorage.Address as Address
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Link as LinkEntryProvider
import qualified EntryStorage

newtype Type = Type Address.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type address) = [address]
    deserialize [address] = Type address

instance Show Type where
    show (Type address) = "(Link " ++ show address ++ ")"

instance Eraser.Interface Type where
    erase _ = Type 0
    isBlank (Type address) = address == 0

instance LinkEntryProvider.Interface Type where
    provideEntry (Type address) = EntryStorage.readEntry (fromEnum address)
