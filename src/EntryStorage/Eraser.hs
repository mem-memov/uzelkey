module EntryStorage.Eraser 
( Interface
, erase
, isBlank) where

class Interface a where
    erase :: a -> a
    isBlank :: a -> Bool