module Memory 
    ( Memory.createStorage
    , Memory.readStorage
    , Memory.writeStorage
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
data ChunkStorage = ChunkStorage BytesInChunk ChunksInStorage ByteVector

instance Show ChunkStorage where
    show (ChunkStorage bytesInChunk chunksInStorage _) = "ChunkStorage with " ++ show chunksInStorage ++ " chunks of " ++ show bytesInChunk ++ " bytes each" 

createStorage :: BytesInChunk -> ChunksInStorage -> Maybe ChunkStorage
createStorage bytesInChunk chunksInStorage = 
    if bytesInChunk < 1 || chunksInStorage < 1
        then 
            Nothing
        else 
            Just $ ChunkStorage bytesInChunk chunksInStorage $ runST $ do
                vector <- VUM.replicate (bytesInChunk * chunksInStorage) (0 :: Word8)
                VU.unsafeFreeze vector

readStorage :: ChunkStorage -> Int -> Int -> Maybe [Word]
readStorage (ChunkStorage bytesInChunk chunksInStorage byteVector) index length = 
    if index < 0 || index > (chunksInStorage - 1) || length < 1 || length > (bytesInChunk * chunksInStorage)
        then 
            Nothing
        else
            Just wordList
    where
        word8List = (VU.toList . (VU.unsafeSlice (index * bytesInChunk) (length * bytesInChunk))) byteVector
        wordList = (catMaybes . (map Converter.word8ListToWord) . (chunksOf bytesInChunk)) word8List

writeStorage :: ChunkStorage -> Int -> [Word] -> Maybe ChunkStorage
writeStorage (ChunkStorage bytesInChunk chunksInStorage byteVector) index wordList =
    if index < 0 || index > (chunksInStorage - 1) || length wordList < 1 || not chunksOk
        then 
            Nothing
        else
            Just $ (ChunkStorage bytesInChunk chunksInStorage updatedVector)
    where
        wordListLength = length wordList
        word8ListLength = bytesInChunk * wordListLength
        firstIndex = index * bytesInChunk
        lastIndex = firstIndex + word8ListLength
        word8ListChunks = map (Converter.wordToWord8List bytesInChunk) wordList
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

