module EntryStorage.Chain (Type) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Link.Node as NodeLink
import qualified EntryStorage.Link.Backward as BackwardLink
import qualified EntryStorage.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Link as LinkEntryProvider
import qualified EntryStorage.Interface.EntryProvider.Pointer as PointerEntryProvider
import qualified EntryStorage.Interface.EntryProvider.Chain as ChainEntryProvider

data Type = 
    Type 
        BackwardLink.Type 
        ForwardLink.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type backwardLink forwardLink)
        = Serializer.serialize backwardLink ++ Serializer.serialize forwardLink
    deserialize 
        words 
            | length words /= 2 
            = error "Wrong number of words in chain deserializing."
            | otherwise 
            = Type 
                (Serializer.deserialize [words !! 0])
                (Serializer.deserialize [words !! 1])

instance Show Type where
    show (Type backwardLink forwardLink) = 
        "(Chain " ++ show backwardLink ++ " " ++ show forwardLink ++ ")"

instance Eraser.Interface Type where
    erase (Type backwardLink forwardLink) =
        Type 
            (Eraser.erase backwardLink)
            (Eraser.erase forwardLink)
    isBlank (Type nodeLink backwardLink forwardLink) =
        Eraser.isBlank backwardLink 
        && Eraser.isBlank forwardLink

instance ChainEntryProvider.Interface Type where
    provideBackwardEntry (Type _ backwardLink _) = LinkEntryProvider.provideEntry backwardLink
    provideForwardEntry (Type _ _ forwardLink) = LinkEntryProvider.provideEntry forwardLink