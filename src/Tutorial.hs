module Tutorial where

import Numeric.LinearAlgebra

vec :: Vector R -- Real ~ Double
vec = vector [1 .. 5]

mat :: Matrix R
mat = (2 >< 3) [1 ..] -- size is determined by (><) and requires a '[a]' to complete

squareMat :: Matrix R
squareMat =
  build (3, 3) (*)

complexMat :: Matrix (Complex Double)
complexMat =
  build (2, 4) (\a b -> a + b * iC)

hermitianComplexMat :: Matrix (Complex Double)
hermitianComplexMat = (2 >< 2) [3 + 0 * iC, 3 - 2 * iC, 3 + 2 * iC, 2 + 0 * iC]
