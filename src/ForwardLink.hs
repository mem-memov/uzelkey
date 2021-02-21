module ForwardLink 
( ForwardLink.Type ) where

import qualified Link
import qualified Serializer

newtype Type = Type Link.Type deriving (Show, Eq)

instance Serializer.Interface ForwardLink.Type where
    serialize (ForwardLink.Type link) = Serializer.serialize link
    deserialize words = ForwardLink.Type $ Serializer.deserialize words