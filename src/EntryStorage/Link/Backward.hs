module EntryStorage.Link.Backward 
( Type ) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Interface.Serializer as Serializer
import qualified EntryStorage.Interface.Eraser as Eraser
import qualified EntryStorage.Interface.EntryProvider.Link as LinkEntryProvider

newtype Type = Type Link.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type link) = Serializer.serialize link
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type link) = "(BackwardLink " ++ show link ++ ")"

instance Eraser.Interface Type where
    erase (Type link) = Type $ Eraser.erase link
    isBlank (Type link) = Eraser.isBlank link

instance LinkEntryProvider.Interface Type where
    provideEntry (Type link) = LinkEntryProvider.provideEntry link