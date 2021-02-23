module EntryStorage.Counter where

import qualified EntryStorage.Chain as Chain
import qualified EntryStorage.Count as Count
import qualified EntryStorage.Link as Link
import qualified EntryStorage.Link.Backward as BackwardLink
import qualified EntryStorage.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Chain as ChainEntryProvider

data Type = 
    Type 
        Count.Type 
        Chain.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type count chain)
        = [count] ++ Serializer.serialize chain
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in counter deserializing."
            | otherwise 
            = Type 
                (words !! 0)
                (Serializer.deserialize [words !! 1, words !! 2])

instance Show Type where
    show (Type count chain) = 
        "(Counter " ++ show count ++ " " ++ show chain ++ ")"

instance Eraser.Interface Type where
    erase (Type _ chain) =
        Type 
            0
            (Eraser.erase chain)
    isBlank (Type count chain) =
        (count == 0) 
        && Eraser.isBlank chain

instance ChainEntryProvider.Interface Type where
    provideBackwardEntry (Type _ chain) = ChainEntryProvider.provideBackwardEntry chain
    provideForwardEntry (Type _ chain) = ChainEntryProvider.provideForwardEntry chain