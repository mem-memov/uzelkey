module EntryStorage.Pointer (Type) where

import qualified EntryStorage.Chain as Chain
import qualified EntryStorage.Link as Link
import qualified EntryStorage.Link.Node as NodeLink
import qualified EntryStorage.Link.Backward as BackwardLink
import qualified EntryStorage.Link.Forward as ForwardLink
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Chain as ChainEntryProvider

data Type = 
    Type 
        NodeLink.Type 
        Chain.Type 
        deriving (Eq)

instance Serializer.Interface Type where
    serialize 
        (Type nodeLink chain)
        = Serializer.serialize nodeLink ++ Serializer.serialize chain
    deserialize 
        words 
            | length words /= 3 
            = error "Wrong number of words in pointer deserializing."
            | otherwise 
            = Type 
                (Serializer.deserialize [words !! 0])
                (Serializer.deserialize [words !! 1, words !! 2])

instance Show Type where
    show (Type nodeLink chain) = 
        "(Pointer " ++ show nodeLink ++ " " ++ show chain ++ ")"

instance Eraser.Interface Type where
    erase (Type nodeLink chain) =
        Type 
            (Eraser.erase nodeLink)
            (Eraser.erase chain)
    isBlank (Type nodeLink backwardLink forwardLink) =
        Eraser.isBlank nodeLink 
        && Eraser.isBlank chain

instance ChainEntryProvider.Interface Type where
    provideBackwardEntry (Type _ chain) = ChainEntryProvider.provideBackwardEntry chain
    provideForwardEntry (Type _ chain) = ChainEntryProvider.provideForwardEntry chain