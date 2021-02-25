module EntryStorage.Interface.Erasable
( Interface
, erase
, isBlank) where

class Interface a where
    erase :: a -> a
    isBlank :: a -> Bool