module Memory where

import qualified Data.Vector.Unboxed as VU
import qualified Data.Vector.Unboxed.Mutable as VUM
import Data.Word (Word8)
import Control.Monad.ST (runST)
import Converter (word8ListToWord, wordToWord8List)
import Data.List.Split (chunksOf)
import Data.Maybe (catMaybes, isJust, fromJust)
import Control.Monad (forM_)

type MinIndex = Int
type MaxIndex = Int
type ByteVector = VU.Vector Word8
data ByteStorage = ByteStorage MinIndex MaxIndex ByteVector

instance Show ByteStorage where
    show (ByteStorage minIndex maxIndex byteVector) = "ByteStorage from " ++ show minIndex ++ " to " ++ show maxIndex 

create :: Int -> ByteStorage
create maxIndex = ByteStorage 0 maxIndex $ runST $ do
    let length = maxIndex + 1
    let defaultValue = (0 :: Word8)
    vector <- VUM.replicate length defaultValue
    VU.unsafeFreeze vector

read :: ByteStorage -> Int -> Int -> Int -> Maybe [Word]
read (ByteStorage minIndex maxIndex byteVector) firstIndex chunkLength chunkNumber = 
    if firstIndex < minIndex || lastIndex > maxIndex || word8ListLength <= 0
        then 
            Nothing
        else
            Just wordList
    where
        word8ListLength = chunkLength * chunkNumber
        lastIndex = firstIndex + word8ListLength - 1

        word8List = fmap (byteVector VU.!) [firstIndex .. lastIndex]
        wordList = (catMaybes . (map word8ListToWord) . (chunksOf chunkLength)) word8List

write :: ByteStorage -> Int -> Int -> [Word] -> Maybe ByteStorage
write (ByteStorage minIndex maxIndex byteVector) firstIndex chunkLength wordList = 
    if isOutOfBounds && chunksOk
        then 
            Nothing
        else
            Just (ByteStorage minIndex maxIndex updatedVector)
    where
        wordListLength = length wordList
        word8ListLength = chunkLength * wordListLength
        lastIndex = firstIndex + word8ListLength
        isOutOfBounds = firstIndex < minIndex || lastIndex > maxIndex
        word8ListChunks = map (wordToWord8List chunkLength) wordList
        chunksOk = all isJust word8ListChunks
        chunks = map fromJust word8ListChunks
        updatedVector = runST $ do
            vector <- VU.unsafeThaw byteVector
            let end = (length chunks) -1
            forM_ [0 .. end] $ \i -> do
                let word8List = chunks !! i
                let end = (length word8List) -1
                forM_ [0 .. end] $ \j -> do
                    let index = firstIndex + i * j
                    let word8 = word8List !! j
                    VUM.unsafeWrite vector index word8
            VU.unsafeFreeze vector


-- {-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- import Data.Array.Base
-- import Data.Array.ST 
-- import Data.Array.Unboxed
-- import Control.Monad 
-- import Control.Monad.ST
-- import Data.Word
-- import Converter (word8ListToWord, wordToWord8List)
-- import Data.List.Split (chunksOf)
-- import Data.Maybe (catMaybes, isJust, fromJust)

-- type ByteStorage s = ST s (STUArray s Word Word8)

-- create :: Word -> ByteStorage s
-- create lastIndex = do
--     stuArray <- newArray (minBound :: Word, lastIndex) 0
--     freeze stuArray

-- read :: ByteStorage s -> Word -> ByteStorage s
-- read byteStorage i = byteStorage >>= \stuArray -> do 
--     val <- readArray stuArray i
--     return stuArray

-- read :: ByteStorage -> Word -> Word -> Word -> Maybe [Word]
-- read (ByteStorage uArray) firstIndex chunkLength chunkNumber = 
--     if isOutOfBounds || word8ListLength <= 0
--         then 
--             Nothing
--         else
--             Just wordList
--     where
--         word8ListLength = chunkLength * chunkNumber
--         lastIndex = firstIndex + word8ListLength - 1

--         (minIndex, maxIndex) = bounds uArray
--         isOutOfBounds = firstIndex < fromIntegral minIndex || lastIndex > fromIntegral maxIndex

--         word8List = fmap (uArray !) [firstIndex .. lastIndex]
--         wordList = (catMaybes . (map word8ListToWord) . (chunksOf (fromIntegral chunkNumber))) word8List


-- write :: ByteStorage -> Word -> Word -> [Word] -> Maybe ByteStorage
-- write (ByteStorage uArray) firstIndex chunkLength wordList = 
--     if isOutOfBounds && chunksOk
--         then 
--             Nothing
--         else
--             Just (ByteStorage updatedUArray)
--     where
--         wordListLength = (fromIntegral (length wordList)) :: Word
--         word8ListLength = chunkLength * wordListLength
--         lastIndex = firstIndex + word8ListLength
--         (minIndex, maxIndex) = bounds uArray
--         isOutOfBounds = firstIndex < fromIntegral minIndex || lastIndex > fromIntegral maxIndex
--         word8ListChunks = map (wordToWord8List chunkLength) wordList
--         chunksOk = all isJust word8ListChunks
--         chunks = map fromJust word8ListChunks
--         updatedUArray = runSTUArray $ do
--             stArray <- thaw uArray
--             let end = (fromIntegral ((length chunks) -1) :: Word)
--             forM_ [0 .. end] $ \i -> do
--                 let word8List = chunks !! (fromIntegral i)
--                 let end = (fromIntegral ((length word8List) -1) :: Word)
--                 forM_ [0 .. end] $ \j -> do
--                     let index = (firstIndex + i * j)
--                     let word8 = word8List !! (fromIntegral j)
--                     writeArray stArray index word8
--             return stArray