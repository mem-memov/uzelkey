module EntryStorage.Counter
( Type ) where

import qualified EntryStorage.Accumulator.Positive as PositiveAccumulator
import qualified EntryStorage.Accumulator.Negative as NegativeAccumulator
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.Counting as Counting

data Type = 
    Type 
        
        PositiveAccumulator.Type 
        NegativeAccumulator.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize
        (Type positiveAccumulator negativeAccumulator)
        = Serializer.serialize positiveAccumulator ++ Serializer.serialize negativeAccumulator
    deserialize words 
        | length words /= 6 
        = error "Wrong number of words in counter entry deserializing."
        | otherwise 
        = Type
            (Serializer.deserialize (take 3 words))
            (Serializer.deserialize (drop 3 words))

instance Show Type where
    show (Type positiveAccumulator negativeAccumulator) = 
        "(CounterEntry " ++ show positiveAccumulator ++ " " ++ show negativeAccumulator ++ ")"

instance Eraser.Interface Type where
    erase (Type positiveAccumulator negativeAccumulator) = Type (Eraser.erase positiveAccumulator) (Eraser.erase negativeAccumulator)
    isBlank (Type positiveAccumulator negativeAccumulator) = Eraser.isBlank positiveAccumulator && Eraser.isBlank negativeAccumulator

instance EntryProvider.Counting Type where
    getPreviousCounter (Type positiveAccumulator negativeAccumulator)
    getNextCounter :: a -> State Memory.ChunkStorage (Maybe a) 
    countPositiveConnectors :: a -> State Memory.ChunkStorage (Maybe Count)
    getPositiveConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)
    countNegativeConnectors :: a -> State Memory.ChunkStorage (Maybe Count)
    getNegativeConnector :: Connecting b => a -> State Memory.ChunkStorage (Maybe b)



    countPositiveEntries (Type positiveCounter _) = Counter.countEntries positiveCounter
    countNegativeEntries (Type _ negativeCounter) = Counter.countEntries negativeCounter
    providePositiveNodeEntry entry = entry
    providePositiveBackwardEntry (Type positiveCounter _) = CounterEntryProvider.provideBackwardEntry positiveCounter
    providePositiveForwardEntry (Type positiveCounter _) = CounterEntryProvider.provideForwardEntry positiveCounter
    provideNegativeNodeEntry entry = entry
    provideNegativeBackwardEntry (Type _ negativeCounter) = CounterEntryProvider.provideBackwardEntry negativeCounter
    provideNegativeForwardEntry (Type _ negativeCounter) = CounterEntryProvider.provideForwardEntry negativeCounter