{-# LANGUAGE FlexibleContexts #-}

module ParsecTest where

import Data.Char
import Control.Applicative hiding (many)
import Text.Parsec
import Text.Parsec.Char

num :: Stream s m Char => ParsecT s u m Int
num =  digitToInt <$> digit

op :: (Num a, Stream s m Char) => ParsecT s u m (a -> a -> a)
op =  const (+) <$> char '+'

expr :: Stream s m Char => ParsecT s u m Int
expr =  num `chainl1` op
