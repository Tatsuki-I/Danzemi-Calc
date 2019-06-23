{-# LANGUAGE FlexibleContexts #-}

module Calc where

import Data.Ratio
import Data.Char
import Control.Applicative hiding (many)
import Text.Parsec hiding ((<|>))

data Expr = Value  Rational
          | Plus   Expr Expr
          | Minus  Expr Expr
          | Times  Expr Expr
          | Divide Expr Expr
          | Modulo Expr Expr
            deriving ( Show
                     )

symbol    :: Stream s m Char => String -> ParsecT s u m String
symbol xs =  do result <- string xs
                spaces
                return result

digitToIntegral :: Num a => Char -> a
digitToIntegral =  fromIntegral . digitToInt

num :: Stream s m Char => ParsecT s u m Rational
num =  do xs  <- many $ digitToIntegral <$> digit
          spaces
          dot <- optionMaybe (char '.')
          spaces
          ys  <- many $ digitToIntegral <$> digit
          spaces
          return $ toRational $ buildDouble xs ys
          where f x y             = x * 10 + y
                g x y             = x + y * 0.1
                buildDouble xs ys = foldl f 0 xs + foldl g 0 ys

parens :: Stream s m Char => ParsecT s u m Rational
parens =  do symbol "("
             result <- expr
             symbol ")"
             return result

term :: Stream s m Char => ParsecT s u m Rational
term =  try parens <|> num

--op3 :: (Stream s m Char) => ParsecT s u m (Rational -> Rational -> Rational)
--op3 =  ((^) <$ symbol "^")
--       where f a b = fromRational

op2 :: (Stream s m Char) => ParsecT s u m (Rational -> Rational -> Rational)
op2 =  ((*) <$ symbol "*") <|>
       ((/) <$ symbol "/")

op1 :: (Stream s m Char) => ParsecT s u m (Rational -> Rational -> Rational)
op1 =  ((+) <$ symbol "+") <|>
       ((-) <$ symbol "-")

expr :: Stream s m Char => ParsecT s u m Rational
expr =  do spaces
           term `chainl1` op2 `chainl1` op1

printParse str = print $ parse expr "" str
