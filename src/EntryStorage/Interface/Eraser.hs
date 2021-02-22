module EntryStorage.Interface.Eraser 
( Interface
, erase
, isBlank) where

class Interface a where
    erase :: a -> a
    isBlank :: a -> Bool