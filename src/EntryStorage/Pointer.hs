module EntryStorage.Pointer (Type) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Link.Node as NodeLink
import qualified EntryStorage.Link.Backward as BackwardLink
import qualified EntryStorage.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.LinkEntryProvider as LinkEntryProvider
import qualified EntryStorage.Interface.PointerEntryProvider as PointerEntryProvider

data Type = 
    Type 
        NodeLink.Type 
        BackwardLink.Type 
        ForwardLink.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type nodeLink backwardLink forwardLink)
        = Serializer.serialize nodeLink ++ Serializer.serialize backwardLink ++ Serializer.serialize forwardLink
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Type 
                (Serializer.deserialize [words !! 0])
                (Serializer.deserialize [words !! 1])
                (Serializer.deserialize [words !! 2])

instance Show Type where
    show (Type nodeLink backwardLink forwardLink) = 
        "(Pointer " ++ show nodeLink ++ " " ++ show backwardLink ++ " " ++ show forwardLink ++ ")"

instance Eraser.Interface Type where
    erase (Type nodeLink backwardLink forwardLink) =
        Type 
            (Eraser.erase nodeLink)
            (Eraser.erase backwardLink)
            (Eraser.erase forwardLink)
    isBlank (Type nodeLink backwardLink forwardLink) =
        Eraser.isBlank nodeLink 
        && Eraser.isBlank backwardLink 
        && Eraser.isBlank forwardLink

instance PointerEntryProvider.Interface Type where
    provideNodeEntry (Type nodeLink _ _) = LinkEntryProvider.provideEntry nodeLink
    provideBackwardEntry (Type _ backwardLink _) = LinkEntryProvider.provideEntry backwardLink
    provideForwardEntry (Type _ _ forwardLink) = LinkEntryProvider.provideEntry forwardLink