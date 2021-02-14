module Memory 
    ( Memory.ChunkStorage
    , Memory.create
    , Memory.read
    , Memory.write
    ) where

import qualified Data.Vector.Unboxed as VU
import qualified Data.Vector.Unboxed.Mutable as VUM
import Data.List.Split (chunksOf)
import Data.Maybe (catMaybes, isJust, fromJust)
import Data.Word (Word8)
import Control.Monad.ST (runST)
import Control.Monad (forM_)
import qualified Converter (word8ListToWord, wordToWord8List)

type BytesInChunk = Int
type ChunksInStorage = Int
type ByteVector = VU.Vector Word8
data ChunkStorage = ChunkStorage BytesInChunk ChunksInStorage ByteVector deriving (Eq)

instance Show ChunkStorage where
    show (ChunkStorage bytesInChunk chunksInStorage _) = "ChunkStorage with " ++ show chunksInStorage ++ " chunks of " ++ show bytesInChunk ++ " bytes each" 

create :: BytesInChunk -> ChunksInStorage -> Maybe ChunkStorage
create bytesInChunk chunksInStorage = 
    if bytesInChunk < 1 || chunksInStorage < 1
        then 
            Nothing
        else 
            Just $ ChunkStorage bytesInChunk chunksInStorage $ runST $ do
                vector <- VUM.replicate (bytesInChunk * chunksInStorage) (0 :: Word8)
                VU.unsafeFreeze vector

read :: ChunkStorage -> Int -> Int -> Maybe [Word]
read (ChunkStorage bytesInChunk chunksInStorage byteVector) index length = 
    if index < 0 || (index + length) > chunksInStorage || length < 1
        then 
            Nothing
        else
            Just wordList
    where
        word8List = (VU.toList . (VU.unsafeSlice (index * bytesInChunk) (length * bytesInChunk))) byteVector
        wordList = (catMaybes . (map Converter.word8ListToWord) . (chunksOf bytesInChunk)) word8List

write :: ChunkStorage -> Int -> [Word] -> Maybe ChunkStorage
write (ChunkStorage bytesInChunk chunksInStorage byteVector) index wordList =
    if index < 0 || index > (chunksInStorage - 1) || length wordList < 1 || not chunksOk
        then 
            Nothing
        else
            Just $ (ChunkStorage bytesInChunk chunksInStorage updatedVector)
    where
        firstIndex = index * bytesInChunk
        word8ListChunks = map (Converter.wordToWord8List bytesInChunk) wordList
        chunksOk = all isJust word8ListChunks
        chunks = map fromJust word8ListChunks
        word8List = concat chunks
        updatedVector = runST $ do
            vector <- VU.unsafeThaw byteVector
            let end = (length word8List) - 1
            forM_ [0 .. end] $ \i -> do
                let index = firstIndex + i
                let word8 = word8List !! i
                VUM.unsafeWrite vector index word8
            VU.unsafeFreeze vector

