module Main where

import Memory

main :: IO ()
main = do
    let a = Memory.create 10000000000
    let b = Memory.read a 1000 4 1
    let (Just a2) = Memory.write a 1000 4 [(1 :: Word)]
    let b2 = Memory.read a 1000 4 1
    let b3 = Memory.read a2 2000 4 1
    let b4 = Memory.read a 1000 4 1
    putStrLn ("Done! " ++ show b ++ " " ++ show b2 ++ " " ++ show b3 ++ " " ++ show b4)
    a <- getLine
    if a == "exit" then return () else main 
