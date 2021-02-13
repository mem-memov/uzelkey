module SerializerSpec where

import Test.Hspec
import qualified Serializer
import qualified Types

spec :: Spec
spec = do
  describe "Serializer.Entry" $ do

    it "serializes an entry to an array of machine words" $ do
      let entry = Types.Entry 
            (Types.PositivePointer 
                (Types.Pointer 
                    (Types.NodeLink
                        (Types.Link 1)
                    ) 
                    (Types.BackwardLink
                        (Types.Link 2)
                    )
                    (Types.ForwardLink
                        (Types.Link 3)
                    )
                )
            ) 
            (Types.NegativePointer
                (Types.Pointer 
                    (Types.NodeLink
                        (Types.Link 4)
                    ) 
                    (Types.BackwardLink
                        (Types.Link 5)
                    )
                    (Types.ForwardLink
                        (Types.Link 6)
                    )
                )
            )
      Serializer.serialize entry `shouldBe` [1,2,3,4,5,6]


    it "deserializes an array of machine words to an entry" $ do
      Serializer.deserialize [1,2,3,4,5,6] 
        `shouldBe` 
        Types.Entry 
            (Types.PositivePointer 
                (Types.Pointer 
                    (Types.NodeLink
                        (Types.Link 1)
                    ) 
                    (Types.BackwardLink
                        (Types.Link 2)
                    )
                    (Types.ForwardLink
                        (Types.Link 3)
                    )
                )
            ) 
            (Types.NegativePointer
                (Types.Pointer 
                    (Types.NodeLink
                        (Types.Link 4)
                    ) 
                    (Types.BackwardLink
                        (Types.Link 5)
                    )
                    (Types.ForwardLink
                        (Types.Link 6)
                    )
                )
            )