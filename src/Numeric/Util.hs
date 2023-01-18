module Numeric.Util where

import Numeric.LinearAlgebra

determinant :: Field t => Matrix t -> Maybe t
determinant m =
  if rows m == cols m
    then Just $ det m
    else Nothing

transpose :: Transposable m mt => m -> mt
transpose = tr'

conjugateTranspose :: Transposable m mt => m -> mt
conjugateTranspose = tr
