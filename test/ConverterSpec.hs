module ConverterSpec where

import Test.Hspec
import Converter
import Data.Word
import Data.Maybe (fromJust)

-- TODO: take machine arity into account

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

    it "converts [1,0,0,0,0,0,0,0] to the power 48 of 2" $ do
      word8ListToWord [1,0,0,0,0,0,0,0] `shouldBe` Just (2 ^ 56)

    it "converts [255,255,255,255,255,255,255,255] to the power 64 of 2 without 1" $ do
      word8ListToWord [255,255,255,255,255,255,255,255] `shouldBe` Just (2 ^ 64 - 1)

    it "converts [0,0,0,0,7,91,205,21] to number and back" $ do
      wordToWord8List 8 (fromJust (word8ListToWord [0,0,0,0,7,91,205,21])) `shouldBe` Just [0,0,0,0,7,91,205,21]

  describe "Converter.wordToWord8List" $ do

    it "returns nothing if resulting list of no length" $ do
      wordToWord8List 0 12345 `shouldBe` Nothing

    it "returns nothing if resulting list exceeds maximum length" $ do
      wordToWord8List 9 12345 `shouldBe` Nothing

    it "converts 0 to [0]" $ do
      wordToWord8List 1 0 `shouldBe` Just [0]

    it "converts 0 to [0,0,0,0,0,0,0,0]" $ do
      wordToWord8List 8 0 `shouldBe` Just [0,0,0,0,0,0,0,0]

    it "converts the power 0 of 2 to [0,0,0,0,0,0,0,1]" $ do
      wordToWord8List 8 (2 ^ 0) `shouldBe` Just [0,0,0,0,0,0,0,1]

    it "converts the power 8 of 2 to [0,0,0,0,0,0,1,0]" $ do
      wordToWord8List 8 (2 ^ 8) `shouldBe` Just [0,0,0,0,0,0,1,0]

    it "converts the power 16 of 2 to [0,0,0,0,0,1,0,0]" $ do
      wordToWord8List 8 (2 ^ 16) `shouldBe` Just [0,0,0,0,0,1,0,0]

    it "converts the power 24 of 2 to [0,0,0,0,1,0,0,0]" $ do
      wordToWord8List 8 (2 ^ 24) `shouldBe` Just [0,0,0,0,1,0,0,0]

    it "converts the power 32 of 2 to [0,0,0,1,0,0,0,0]" $ do
      wordToWord8List 8 (2 ^ 32) `shouldBe` Just [0,0,0,1,0,0,0,0]

    it "converts the power 40 of 2 to [0,0,1,0,0,0,0,0]" $ do
      wordToWord8List 8 (2 ^ 40) `shouldBe` Just [0,0,1,0,0,0,0,0]

    it "converts the power 48 of 2 to [0,1,0,0,0,0,0,0]" $ do
      wordToWord8List 8 (2 ^ 48) `shouldBe` Just [0,1,0,0,0,0,0,0]

    it "converts the power 56 of 2 to [1,0,0,0,0,0,0,0]" $ do
      wordToWord8List 8 (2 ^ 56) `shouldBe` Just [1,0,0,0,0,0,0,0]

    it "converts the power 64 of 2 without 1 to [255,255,255,255,255,255,255,255]" $ do
      wordToWord8List 8 (2 ^ 64 - 1) `shouldBe` Just [255,255,255,255,255,255,255,255]

    it "converts 123456789 to bytes and back" $ do
      word8ListToWord (fromJust (wordToWord8List 8 123456789)) `shouldBe` Just 123456789