module MemorySpec where

import Test.Hspec
import Memory

spec :: Spec
spec = do
  describe "Memory.create" $ do

    it "allocates space in memory" $ do
      True `shouldBe` True