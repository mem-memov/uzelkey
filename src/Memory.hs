module Memory (create) where

import Data.Array.ST 
import Data.Array.Unboxed
import Control.Monad 
import Control.Monad.ST
import Data.Word

newtype ByteStorage = ByteStorage (UArray Word Word8)

create :: Word -> ByteStorage
create lastIndex = ByteStorage $ runSTUArray $ do
    stuArray <- newArray (minBound :: Word, lastIndex) 0
    return stuArray

read :: ByteStorage -> Word -> Word -> Maybe Word
read (ByteStorage uArray) firstIndex length = 
    if isOutOfBounds || length <= 0
        then 
            Nothing
        else
            Just $ buildWord bytesInWords indexes
    where
        lastIndex = firstIndex + length - 1

        (minIndex, maxIndex) = bounds uArray
        isOutOfBounds = firstIndex < fromIntegral minIndex || lastIndex > fromIntegral maxIndex

        indexes = [firstIndex .. lastIndex]
        bytesInWords = fmap (fromIntegral . (uArray !)) indexes

        buildWord bytesInWords indexes = 
            let
                indexedBytesInWords  = zip indexes bytesInWords 
                poweredBytesInWords  = map (\(index, byteInWord) -> byteInWord * 2 ^ (index * 8)) indexedBytesInWords 
            in
                sum poweredBytesInWords 