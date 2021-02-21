module NodeLink 
( NodeLink.Type ) where

import qualified Link
import qualified Serializer

newtype Type = Type Link.Type deriving (Eq)

instance Serializer.Interface NodeLink.Type where
    serialize (NodeLink.Type link) = Serializer.serialize link
    deserialize words = NodeLink.Type $ Serializer.deserialize words

instance Show NodeLink.Type where
    show (NodeLink.Type link) = "(NodeLink " ++ show link ++ ")"