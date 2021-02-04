module Converter where

import Data.Word

word8ListToWord :: [Word8] -> Word
word8ListToWord word8List = 
        sum poweredBytesInWords
    where
        listLength = length word8List
        lastIndex = listLength - 1
        indexes = [0 .. lastIndex]
        bytesInWords = (map fromIntegral word8List) :: [Word]
        indexedBytesInWords  = zip indexes bytesInWords 
        poweredBytesInWords  = map (\(index, byteInWord) -> byteInWord * 2 ^ (index * 8)) indexedBytesInWords 