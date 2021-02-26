module EntryStorage.Data.Counter
( Type ) where

import qualified EntryStorage.Data.Counter.Chain as Chain
import qualified EntryStorage.Data.Counter.Accumulator.Positive as PositiveAccumulator
import qualified EntryStorage.Data.Counter.Accumulator.Negative as NegativeAccumulator
import qualified EntryStorage.Interface.Serializable as Serializable
import qualified EntryStorage.Interface.Erasable as Erasable
import qualified EntryStorage.Interface.Traversable as Traversable

data Type =
    Type
        Chain.Type
        PositiveAccumulator.Type
        NegativeAccumulator.Type
        deriving (Eq)

instance Serializable.Interface Type where
    serialize (Type chain positiveAccumulator negativeAccumulator) = (Serializable.serialize chain) ++ (Serializable.serialize positiveAccumulator) ++ (Serializable.serialize negativeAccumulator)
    deserialize words
        | length words == 6 
        = do
            chain <- Serializable.deserialize (take 2 words)
            positiveAccumulator <- Serializable.deserialize ((drop 2 . take 2) words)
            negativeAccumulator <- Serializable.deserialize (drop 4 words)
            return (Type chain positiveAccumulator negativeAccumulator)
        | otherwise 
        = Left $ "Wrong number of words when deserializing counter - " ++ (show . length) words ++ " Starting with: " ++ (show . take 6) words

instance Erasable.Interface Type where
    erase (Type chain positiveAccumulator negativeAccumulator) = Type (Erasable.erase chain) (Erasable.erase positiveAccumulator) (Erasable.erase negativeAccumulator)
    isBlank (Type chain positiveAccumulator negativeAccumulator) = Erasable.isBlank chain && Erasable.isBlank positiveAccumulator && Erasable.isBlank negativeAccumulator

instance Traversable.CountableInterface Type where
    getPreviousCounter (Type chain _ _) = Traversable.getPreviousCounter chain
    getNextCounter (Type chain _ _) = Traversable.getNextCounter chain
    countPositiveConnectors (Type _ positiveAccumulator _) = Traversable.countConnectors positiveAccumulator
    getPositiveConnector (Type _ positiveAccumulator _) = Traversable.getConnector positiveAccumulator
    countNegativeConnectors (Type _ _ negativeAccumulator) = Traversable.countConnectors negativeAccumulator
    getNegativeConnector (Type _ _ negativeAccumulator) = Traversable.getConnector negativeAccumulator

