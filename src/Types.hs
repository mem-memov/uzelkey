module Types where

data Entry = Entry PositivePointer NegativePointer deriving (Show, Eq)

newtype PositivePointer = PositivePointer Pointer deriving (Show, Eq)
newtype NegativePointer = NegativePointer Pointer deriving (Show, Eq)

data Pointer = Pointer NodeLink BackwardLink ForwardLink deriving (Show, Eq)

newtype NodeLink = NodeLink Link deriving (Show, Eq)
newtype BackwardLink = BackwardLink Link deriving (Show, Eq)
newtype ForwardLink = ForwardLink Link deriving (Show, Eq)

newtype Link = Link Word deriving (Show, Eq)

