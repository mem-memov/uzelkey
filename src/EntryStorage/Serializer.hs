module EntryStorage.Serializer 
( Interface
, serialize
, deserialize
) where

class Interface a where
    serialize :: a -> [Word]
    deserialize :: [Word] -> a