module EntryStorage.Entry.Counter
( Type ) where

import qualified EntryStorage.Counter.Positive as PositiveCounter
import qualified EntryStorage.Counter.Negative as NegativeCounter
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider as EntryProvider
import qualified EntryStorage.Interface.EntryProvider.Counter as CounterEntryProvider

data Type = 
    Type 
        PositiveCounter.Type 
        NegativeCounter.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize
        (Type positiveCounter negativeCounter)
        = Serializer.serialize positiveCounter ++ Serializer.serialize negativeCounter
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in entry deserializing."
        | otherwise 
        = Type
            (Serializer.deserialize (take 3 words))
            (Serializer.deserialize (drop 3 words))

instance Show Type where
    show (Type positiveCounter negativeCounter) = 
        "(CounterEntry " ++ show positiveCounter ++ " " ++ show negativeCounter ++ ")"

instance Eraser.Interface Type where
    erase (Type positiveCounter negativeCounter) = Type (Eraser.erase positiveCounter) (Eraser.erase negativeCounter)
    isBlank (Type positiveCounter negativeCounter) = Eraser.isBlank positiveCounter && Eraser.isBlank negativeCounter

instance EntryProvider.Interface Type where
    countPositiveEntries (Type positiveCounter _) = Counter.countEntries positiveCounter
    countNegativeEntries (Type _ negativeCounter) = Counter.countEntries negativeCounter
    providePositiveNodeEntry entry = entry
    providePositiveBackwardEntry (Type positiveCounter _) = CounterEntryProvider.provideBackwardEntry positiveCounter
    providePositiveForwardEntry (Type positiveCounter _) = CounterEntryProvider.provideForwardEntry positiveCounter
    provideNegativeNodeEntry entry = entry
    provideNegativeBackwardEntry (Type _ negativeCounter) = CounterEntryProvider.provideBackwardEntry negativeCounter
    provideNegativeForwardEntry (Type _ negativeCounter) = CounterEntryProvider.provideForwardEntry negativeCounter