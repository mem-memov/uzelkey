module Types where


data Entry = Entry PositivePointer NegativePointer

newtype PositivePointer = PositivePointer Pointer
newtype NegativePointer = NegativePointer Pointer

data Pointer = Pointer NodeLink BackwardLink ForwardLink

newtype NodeLink = NodeLink Link
newtype BackwardLink = BackwardLink Link
newtype ForwardLink = ForwardLink Link

newtype Link = Link String