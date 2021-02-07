module Converter (word8ListToWord, wordToWord8List) where

import Data.Word
import Data.Bits

word8ListToWord :: [Word8] -> Maybe Word
word8ListToWord word8List = 
    if listLength == 0 || listLength > maxLength
        then 
            Nothing
        else
            Just $ word
    where
        listLength = length word8List
        lastIndex = listLength - 1
        indexes = reverse [0 .. lastIndex]
        bytesInWords = map word8ToWord word8List
        indexedBytesInWords  = zip indexes bytesInWords 
        poweredBytesInWords  = map (\(index, byteInWord) -> byteInWord * 2 ^ (index * 8)) indexedBytesInWords 
        word = sum poweredBytesInWords

wordToWord8List :: Int -> Word -> Maybe [Word8]
wordToWord8List listLength word =
    if listLength == 0 || listLength > maxLength
        then
            Nothing
        else
            Just $ reverse result
    where
        lastIndex = listLength - 1
        indexes = [0 .. lastIndex]
        (result, rest) = foldr collect ([], word) indexes

collect :: Int -> ([Word8], Word) -> ([Word8], Word)
collect index (word8List, rest) = 
    let 
        (byteWord, unprocessed) = getUnprocessedAndByteWord rest index 
        word8 = wordToWord8 byteWord
    in 
        (word8 : word8List, unprocessed)

word8ToWord :: Word8 -> Word
word8ToWord word8 = (fromIntegral word8) :: Word

wordToWord8 :: Word -> Word8
wordToWord8 word = (fromIntegral word) :: Word8

getUnprocessedAndByteWord :: Word -> Int -> (Word, Word)
getUnprocessedAndByteWord word index = word `divMod` ((2 ^ (index * 8)) :: Word)

maxLength :: Int
maxLength = finiteBitSize (minBound :: Word) `div` finiteBitSize (minBound :: Word8)