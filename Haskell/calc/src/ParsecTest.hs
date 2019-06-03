{-# LANGUAGE FlexibleContexts #-}

module ParsecTest where

import Data.Char
import Control.Applicative hiding (many)
import Text.Parsec hiding ((<|>))

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

op :: (Num a, Stream s m Char) => ParsecT s u m (a -> a -> a)
op =  (const (+) <$> symbol "+") <|>
      (const (-) <$> symbol "-")

expr :: Stream s m Char => ParsecT s u m Double
expr =  num `chainl1` op

printParse str = print $ parse expr "" str
