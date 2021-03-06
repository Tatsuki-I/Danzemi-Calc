module Main where

import AST
import System.IO
import System.Console.Haskeline

main :: IO ()
main =  do putStrLn "Hello!"
           putStr "> "
           hFlush stdout
           expr <- getLine
           calc expr
           return ()

calc "exit" = return ()
calc "quit" = return ()
calc ":q" = return ()
calc expr = do printParse expr
               putStr "> "
               hFlush stdout
               next <- getLine
               calc next
