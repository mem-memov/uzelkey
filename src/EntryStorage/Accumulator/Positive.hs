module EntryStorage.Accumulator.Positive ( Type ) where

import qualified EntryStorage.Accumulator as Accumulator
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Counter as ChainEntryProvider

newtype Type = Type Accumulator.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type accumulator) = Serializer.serialize accumulator
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type accumulator) = "(PositiveAccumulator " ++ show accumulator ++ ")"

instance Eraser.Interface Type where
    erase (Type accumulator) = Type $ Eraser.erase accumulator
    isBlank (Type accumulator) = Eraser.isBlank accumulator

instance ChainEntryProvider.Interface Type where
    provideBackwardEntry (Type accumulator) = ChainEntryProvider.provideBackwardEntry accumulator
    provideForwardEntry (Type accumulator) = ChainEntryProvider.provideForwardEntry accumulator