module EntryStorage.ForwardLink 
( Type ) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.Eraser as Eraser

newtype Type = Type Link.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type link) = Serializer.serialize link
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type link) = "(ForwardLink " ++ show link ++ ")"

instance Eraser.Interface Type where
    erase (Type link) = Type $ Eraser.erase link
    isBlank (Type link) = Eraser.isBlank link