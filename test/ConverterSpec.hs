module ConverterSpec where

import Test.Hspec
import Converter
import Data.Word

spec :: Spec
spec = do
  describe "Converter.word8ListToWord" $ do

    it "returns nothing if no bytes given" $ do
      word8ListToWord [] `shouldBe` Nothing

    it "returns nothing if too many bytes given" $ do
      word8ListToWord [0,0,0,0,0,0,0,0,0] `shouldBe` Nothing

    it "converts eight zero bytes to a zero word" $ do
      word8ListToWord [0,0,0,0,0,0,0,0] `shouldBe` Just 0

    it "converts one zero byte to a zero word" $ do
      word8ListToWord [0] `shouldBe` Just 0

    it "converts [1] to the power 0 of 2" $ do
      word8ListToWord [1] `shouldBe` Just (2 ^ 0)

    it "converts [1,0] to the power 8 of 2" $ do
      word8ListToWord [1,0] `shouldBe` Just (2 ^ 8)
      
    it "converts [1,0,0] to the power 16 of 2" $ do
      word8ListToWord [1,0,0] `shouldBe` Just (2 ^ 16)

    it "converts [1,0,0,0] to the power 24 of 2" $ do
      word8ListToWord [1,0,0,0] `shouldBe` Just (2 ^ 24)

    it "converts [1,0,0,0,0] to the power 32 of 2" $ do
      word8ListToWord [1,0,0,0,0] `shouldBe` Just (2 ^ 32)

    it "converts [1,0,0,0,0,0] to the power 40 of 2" $ do
      word8ListToWord [1,0,0,0,0,0] `shouldBe` Just (2 ^ 40)

    it "converts [1,0,0,0,0,0,0] to the power 48 of 2" $ do
      word8ListToWord [1,0,0,0,0,0,0] `shouldBe` Just (2 ^ 48)

    it "converts [1,0,0,0,0,0,0,0] to the power 64 of 2" $ do
      word8ListToWord [1,0,0,0,0,0,0,0] `shouldBe` Just (2 ^ 64)