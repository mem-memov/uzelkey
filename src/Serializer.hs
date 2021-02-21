module Serializer 
( Serializer.Interface
, Serializer.serialize
, Serializer.deserialize
) where

class Interface a where
    serialize :: a -> [Word]
    deserialize :: [Word] -> a