module Serializer where

class Serializer a where
    serialize :: a -> [Word]
    deserialize :: [Word] -> a