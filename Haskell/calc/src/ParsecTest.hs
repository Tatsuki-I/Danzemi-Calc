{-# LANGUAGE FlexibleContexts #-}

module ParsecTest where

import Data.Char
import Control.Applicative hiding (many)
import Text.Parsec hiding ((<|>))

data Lambda = Arg String Lambda
            | Expr
              deriving ( Show
                       , Eq)

data Expr = Value Int
          | Function Expr Expr
          | Plus     Expr Expr 
          | Minus    Expr Expr 
          | Times    Expr Expr 
          | Divide   Expr Expr 
          | Modulo   Expr Expr 
          

digitToDouble :: Char -> Double
digitToDouble =  fromIntegral . digitToInt

symbol    :: Stream s m Char => String -> ParsecT s u m String
symbol xs =  do result <- string xs
                spaces
                return result

num :: Stream s m Char => ParsecT s u m Double
num =  do xs <- many $ digitToDouble <$> digit
          dot <- optionMaybe (char '.')
          ys <- many $ digitToDouble <$> digit

          spaces

          return $ foldl f 0 xs + foldl g 0 ys
          where f x y = x * 10 + y
                g x y = x + y * 0.1

op0 :: (Fractional a, Stream s m Char) => ParsecT s u m (a -> a -> a)
op0 =  (const (*) <$> symbol "*") <|>
       (const (/) <$> symbol "/")

op1 :: (Num a, Stream s m Char) => ParsecT s u m (a -> a -> a)
op1 =  (const (+) <$> symbol "+") <|>
       (const (-) <$> symbol "-")

expr :: Stream s m Char => ParsecT s u m Double
expr =  num `chainl1` op0 `chainl1` op1

printParse str = print $ parse expr "" str
