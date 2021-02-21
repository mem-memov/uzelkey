module EntryStorage.SerializerSpec where

import Test.Hspec
import qualified EntryStorage.Serializer as Serializer
import qualified EntryStorage.Entry as Entry
import qualified EntryStorage.Pointer as Pointe
import qualified EntryStorage.PositivePointer as PositivePointer
import qualified EntryStorage.NegativePointer as NegativePointer
import qualified EntryStorage.Link as Link 
import qualified EntryStorage.NodeLink as NodeLink
import qualified EntryStorage.BackwardLink as BackwardLink
import qualified EntryStorage.ForwardLink as ForwardLink

spec :: Spec
spec = do

  describe "Serializer.Entry" $ do

    it "serializes an entry to an array of machine words" $ do
      let entry = Entry.Type 
            (PositivePointer.Type 
                (Pointer.Type 
                    (NodeLink.Type
                        (Link.Type 1)
                    ) 
                    (BackwardLink.Type
                        (Link.Type 2)
                    )
                    (ForwardLink.Type
                        (Link.Type 3)
                    )
                )
            ) 
            (NegativePointer.Type
                (Pointer.Type 
                    (NodeLink.Type
                        (Link.Type 4)
                    ) 
                    (BackwardLink.Type
                        (Link.Type 5)
                    )
                    (ForwardLink.Type
                        (Link.Type 6)
                    )
                )
            )
      Serializer.serialize entry `shouldBe` [1,2,3,4,5,6]


    it "deserializes an array of machine words to an entry" $ do
      Serializer.deserialize [1,2,3,4,5,6] 
        `shouldBe` 
        Entry.Type 
            (PositivePointer.Type 
                (Pointer.Type 
                    (NodeLink.Type
                        (Link.Type 1)
                    ) 
                    (BackwardLink.Type
                        (Link.Type 2)
                    )
                    (ForwardLink.Type
                        (Link.Type 3)
                    )
                )
            ) 
            (NegativePointer.Type
                (Pointer.Type 
                    (NodeLink.Type
                        (Link.Type 4)
                    ) 
                    (BackwardLink.Type
                        (Link.Type 5)
                    )
                    (ForwardLink.Type
                        (Link.Type 6)
                    )
                )
            )