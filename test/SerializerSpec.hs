module SerializerSpec where

import Test.Hspec
import qualified Serializer
import qualified Entry
import qualified Pointer
import qualified PositivePointer
import qualified NegativePointer
import qualified Link
import qualified NodeLink
import qualified BackwardLink
import qualified ForwardLink

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