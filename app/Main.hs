module Main where

import Memory
import Data.Maybe (fromJust)

main :: IO ()
main = do
    let a = fromJust $ Memory.create 4 100000000
    let b = fromJust $ Memory.read a 1 2
    let a2 = fromJust $ Memory.write a 1 [10,20]
    let b2 = fromJust $ Memory.read a2 1 2
    putStrLn ("Done! " ++ show b ++ " " ++ show b2)
    a <- getLine
    if a == "exit" then return () else main 
