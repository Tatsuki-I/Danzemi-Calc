{-# LANGUAGE FlexibleContexts #-}

module AST where

import Data.Ratio
import Data.Char
import Data.Fixed
import Data.Either
import Control.Applicative hiding (many)
import Text.Parsec hiding ((<|>))

data Expr = Value  Rational
          | Plus   Expr Expr
          | Minus  Expr Expr
          | Times  Expr Expr
          | Divide Expr Expr
          | Modulo Expr Expr
          | Power  Expr Expr
            deriving ( Show
                     , Eq )

symbol    :: Stream s m Char => String -> ParsecT s u m String
symbol xs =  do result <- string xs
                spaces
                return result

digitToIntegral :: Num a => Char -> a
digitToIntegral =  fromIntegral . digitToInt

num :: Stream s m Char => ParsecT s u m Expr
num =  do xs  <- many $ digitToIntegral <$> digit
          spaces
          dot <- optionMaybe (char '.')
          spaces
          ys  <- many $ digitToIntegral <$> digit
          spaces
          return $ Value $ toRational $ buildDouble xs ys
          where f x y             = x * 10 + y
                g x y             = x + y * 0.1
                buildDouble xs ys = foldl f 0 xs + foldl g 0 ys

parens :: Stream s m Char => ParsecT s u m Expr
parens =  do symbol "("
             result <- expr
             symbol ")"
             return result

term :: Stream s m Char => ParsecT s u m Expr
term =  try parens <|> num

op3 :: (Stream s m Char) => ParsecT s u m (Expr -> Expr -> Expr)
op3 =  (Power <$ symbol "^") <|>
       (Power <$ symbol "**")

op2 :: (Stream s m Char) => ParsecT s u m (Expr -> Expr -> Expr)
op2 =  (Times <$ symbol "*") <|>
       (Divide <$ symbol "/") <|>
       (Modulo <$ symbol "%")

op1 :: (Stream s m Char) => ParsecT s u m (Expr -> Expr -> Expr)
op1 =  (Plus <$ symbol "+") <|>
       (Minus <$ symbol "-")

expr :: Stream s m Char => ParsecT s u m Expr
expr =  do spaces
           term `chainl1` op3
                `chainl1` op2
                `chainl1` op1

rPow     :: Rational -> Rational -> Rational
rPow a b =  toRational (fromRational a ** fromRational b)

execExpr             :: Expr -> Rational
execExpr (Value  a)   =  a
execExpr (Plus   a b) =  execExpr a + execExpr b
execExpr (Minus  a b) =  execExpr a - execExpr b
execExpr (Times  a b) =  execExpr a * execExpr b
execExpr (Divide a b) =  execExpr a / execExpr b
execExpr (Modulo a b) =  mod' (execExpr a) (execExpr b)
execExpr (Power  a b) =  rPow (execExpr a) (execExpr b)

printParse str = do putStrLn $ either show show                res
                    putStrLn $ either show (show . execExpr) res
                    putStrLn $ either show (show . fromRational . execExpr) res
                    where res = parse expr "" str
