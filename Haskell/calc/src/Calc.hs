module Calc where

import Control.Applicative hiding (many)

data Expr = Value Int
          | Plus   Expr Expr
          | Minus  Expr Expr
          | Times  Expr Expr
          | Divide Expr Expr
          | Modulo Expr Expr


