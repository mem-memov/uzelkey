module EntryStorage.BackwardLink 
( Type ) where

import qualified EntryStorage.Link as Link
import qualified EntryStorage.Serializer as Serializer

newtype Type = Type Link.Type deriving (Eq)

instance Serializer.Interface Type where
    serialize (Type link) = Serializer.serialize link
    deserialize words = Type $ Serializer.deserialize words

instance Show Type where
    show (Type link) = "(BackwardLink " ++ show link ++ ")"