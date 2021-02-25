module EntryStorage.Interface.Serializable
( Interface
, serialize
, deserialize
) where

class Interface a where
    serialize :: a -> [Word]
    deserialize :: [Word] -> Either String a