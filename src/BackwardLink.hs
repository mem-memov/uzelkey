module BackwardLink 
( BackwardLink.Type ) where

import qualified Link
import qualified Serializer

newtype Type = Type Link.Type deriving (Show, Eq)

instance Serializer.Interface BackwardLink.Type where
    serialize (BackwardLink.Type link) = Serializer.serialize link
    deserialize words = BackwardLink.Type $ Serializer.deserialize words