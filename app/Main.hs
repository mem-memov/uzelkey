module Main where

import Memory
import Data.Maybe (fromJust)

main :: IO ()
main = do
    let a = fromJust $ Memory.createStorage 4 100000000
    let b = fromJust $ Memory.readStorage a 1 2
    let a2 = fromJust $ Memory.writeStorage a 1 [10,20]
    let b2 = fromJust $ Memory.readStorage a2 1 2
    putStrLn ("Done! " ++ show b ++ " " ++ show b2)
    a <- getLine
    if a == "exit" then return () else main 
