module EntryStorage.Counter.Negative ( Type ) where

import qualified EntryStorage.Counter as Counter
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Counter as CounterEntryProvider

newtype Type = Type Counter.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type counter) = Serializer.serialize counter
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type counter) = "(NegativeCounter " ++ show counter ++ ")"

instance Eraser.Interface Type where
    erase (Type counter) = Type $ Eraser.erase counter
    isBlank (Type counter) = Eraser.isBlank counter

instance CounterEntryProvider.Interface Type where
    provideBackwardEntry (Type counter) = CounterEntryProvider.provideBackwardEntry counter
    provideForwardEntry (Type counter) = CounterEntryProvider.provideForwardEntry counter