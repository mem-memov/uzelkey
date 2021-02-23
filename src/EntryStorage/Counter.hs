module EntryStorage.Counter where

import qualified EntryStorage.Count as Count
import qualified EntryStorage.Link as Link
import qualified EntryStorage.Link.Backward as BackwardLink
import qualified EntryStorage.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Link as LinkEntryProvider
import qualified EntryStorage.Interface.EntryProvider.Counter as CounterEntryProvider

data Type = 
    Type 
        Count.Type 
        BackwardLink.Type 
        ForwardLink.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type count backwardLink forwardLink)
        = [count] ++ Serializer.serialize backwardLink ++ Serializer.serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Type 
                (words !! 0)
                (Serializer.deserialize [words !! 1])
                (Serializer.deserialize [words !! 2])

instance Show Type where
    show (Type count backwardLink forwardLink) = 
        "(Counter " ++ show count ++ " " ++ show backwardLink ++ " " ++ show forwardLink ++ ")"

instance Eraser.Interface Type where
    erase (Type _ backwardLink forwardLink) =
        Type 
            0
            (Eraser.erase backwardLink)
            (Eraser.erase forwardLink)
    isBlank (Type count backwardLink forwardLink) =
        (count == 0) 
        && Eraser.isBlank backwardLink 
        && Eraser.isBlank forwardLink

instance CountEntryProvider.Interface Type where
    provideBackwardEntry (Type _ backwardLink _) = LinkEntryProvider.provideEntry backwardLink
    provideForwardEntry (Type _ _ forwardLink) = LinkEntryProvider.provideEntry forwardLink