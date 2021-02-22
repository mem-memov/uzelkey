module EntryStorage.ForwardLink 
( Type ) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.LinkEntryProvider as LinkEntryProvider

newtype Type = Type Link.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type link) = Serializer.serialize link
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type link) = "(ForwardLink " ++ show link ++ ")"

instance Eraser.Interface Type where
    erase (Type link) = Type $ Eraser.erase link
    isBlank (Type link) = Eraser.isBlank link

instance LinkEntryProvider.Interface Type where
    provideEntry (Type link) = LinkEntryProvider.provideEntry link