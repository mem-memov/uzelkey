module NodeLink 
( NodeLink.Type ) where

import qualified Link
import qualified Serializer

newtype Type = Type Link.Type deriving (Show, Eq)

instance Serializer.Interface NodeLink.Type where
    serialize (NodeLink.Type link) = Serializer.serialize link
    deserialize words = NodeLink.Type $ Serializer.deserialize words