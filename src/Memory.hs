module Memory (create) where

import Data.Array.ST 
import Data.Array.Unboxed
import Control.Monad 
import Control.Monad.ST
import Data.Word
import Converter (word8ListToWord)

newtype ByteStorage = ByteStorage (UArray Word Word8)

create :: Word -> ByteStorage
create lastIndex = ByteStorage $ runSTUArray $ do
    stuArray <- newArray (minBound :: Word, lastIndex) 1
    return stuArray

read :: ByteStorage -> Word -> Word -> Maybe Word
read (ByteStorage uArray) firstIndex length = 
    if isOutOfBounds || length <= 0
        then 
            Nothing
        else
            Just $ word8ListToWord word8List
    where
        lastIndex = firstIndex + length - 1

        (minIndex, maxIndex) = bounds uArray
        isOutOfBounds = firstIndex < fromIntegral minIndex || lastIndex > fromIntegral maxIndex

        word8List = fmap (uArray !) [firstIndex .. lastIndex]


-- write :: ByteStorage -> Word -> Word -> Maybe ByteStorage
-- write (ByteStorage uArray) index value = 
--     if isOutOfBounds
--         then 
--             Nothing
--         else
--             Just (ByteStorage uArray)
--     where
--         (minIndex, maxIndex) = bounds uArray
--         isOutOfBounds = index < fromIntegral minIndex || index > fromIntegral maxIndex