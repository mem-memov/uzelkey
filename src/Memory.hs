module Memory (create) where

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Data.Array.Base
import Data.Array.ST 
import Data.Array.Unboxed
import Control.Monad 
import Control.Monad.ST
import Data.Word
import Converter (word8ListToWord, wordToWord8List)
import Data.List.Split (chunksOf)
import Data.Maybe (catMaybes, isJust, fromJust)

type ByteStorage s = ST s (STUArray s Word Word8)

create :: Word -> ST s (STUArray s Word Word)
create lastIndex = do
    stuArray <- newArray (minBound :: Word, lastIndex) 0
    return stuArray

read :: ST s (STUArray s Word Word) -> Word -> ST s (STUArray s Word Word)
read byteStorage i = byteStorage >>= \stuArray -> do 
    let val = (unsafeRead stuArray 1) :: (ST s Word)
    return stuArray

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