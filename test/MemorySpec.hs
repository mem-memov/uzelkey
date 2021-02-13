module MemorySpec where

import Test.Hspec
import qualified Memory
import Data.Maybe

spec :: Spec
spec = do
  describe "Memory.create" $ do

    it "forbids creating an empty storage" $ do
      let storage = Memory.create 4 0
      storage `shouldBe` Nothing

    it "forbids creating a negative storage" $ do
      let storage = Memory.create 4 (-1)
      storage `shouldBe` Nothing

    it "forbids creating a storage with empty chunks" $ do
      let storage = Memory.create 0 100
      storage `shouldBe` Nothing

    it "forbids creating a storage with negative chunks" $ do
      let storage = Memory.create (-1) 100
      storage `shouldBe` Nothing

  describe "Memory.read" $ do

    it "forbids reading an empty list of machine words" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = Memory.read storage 55 0
      firstWord `shouldBe` Nothing

    it "forbids reading a negative list of machine words" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = Memory.read storage 55 (-1)
      firstWord `shouldBe` Nothing

    it "forbids reading at a negative index" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = Memory.read storage (-1) 1
      firstWord `shouldBe` Nothing

    it "forbids reading a single machine word after the last index" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = Memory.read storage 100 1
      firstWord `shouldBe` Nothing

    it "forbids reading a last machine word after the last index" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = Memory.read storage 99 2
      firstWord `shouldBe` Nothing

    it "reads the first machine word with the default value" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = fromJust $ Memory.read storage 0 1
      firstWord `shouldBe` ([0] :: [Word])

    it "reads the last machine word with the default value" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = fromJust $ Memory.read storage 99 1
      firstWord `shouldBe` ([0] :: [Word])

    it "reads first 6 machine word with default values" $ do
      let storage = fromJust $ Memory.create 4 100
      let firstWord = fromJust $ Memory.read storage 0 6
      firstWord `shouldBe` ([0,0,0,0,0,0] :: [Word])

  describe "Memory.write" $ do

    it "forbids writing at a negative index" $ do
      let storage = fromJust $ Memory.create 4 100
      let storage_2 = Memory.write storage (-1) [123456789]
      storage_2 `shouldBe` Nothing

    it "forbids writing at an index that is too large" $ do
      let storage = fromJust $ Memory.create 4 100
      let storage_2 = Memory.write storage 100 [123456789]
      storage_2 `shouldBe` Nothing

    it "forbids writing an empty list of machine words" $ do
      let storage = fromJust $ Memory.create 4 100
      let storage_2 = Memory.write storage 0 []
      storage_2 `shouldBe` Nothing

    it "writes a machine word [1] at the beginning of chunk list with 8 bytes" $ do
      let storage = fromJust $ Memory.create 1 100
      let storage_2 = fromJust $ Memory.write storage 0 [1]
      let machineWord = fromJust $ Memory.read storage_2 0 1
      machineWord `shouldBe` [1]

    it "writes a machine word [0] at the beginning of chunk list with 8 bytes" $ do
      let storage = fromJust $ Memory.create 1 100
      let storage_2 = fromJust $ Memory.write storage 0 [0]
      let machineWord = fromJust $ Memory.read storage_2 0 1
      machineWord `shouldBe` [0]

    it "writes a machine word [128] at the beginning of chunk list with 8 bytes" $ do
      let storage = fromJust $ Memory.create 1 100
      let storage_2 = fromJust $ Memory.write storage 0 [128]
      let machineWord = fromJust $ Memory.read storage_2 0 1
      machineWord `shouldBe` [128]

    it "writes two machine words [81,92] at the beginning of chunk list with 8 bytes" $ do
      let storage = fromJust $ Memory.create 1 100
      let storage_2 = fromJust $ Memory.write storage 0 [81,92]
      let machineWord = fromJust $ Memory.read storage_2 0 2
      machineWord `shouldBe` [81,92]

    it "writes two machine words [81,92] at the end of chunk list with 8 bytes" $ do
      let storage = fromJust $ Memory.create 1 100
      let storage_2 = fromJust $ Memory.write storage 98 [81,92]
      let machineWord = fromJust $ Memory.read storage_2 98 2
      machineWord `shouldBe` [81,92]

    it "writes two machine words [81,92] at the end of chunk list with 16 bytes" $ do
      let storage = fromJust $ Memory.create 2 100
      let storage_2 = fromJust $ Memory.write storage 98 [600,700]
      let machineWord = fromJust $ Memory.read storage_2 98 2
      machineWord `shouldBe` [600,700]