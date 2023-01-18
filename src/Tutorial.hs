module Tutorial where

import Numeric.LinearAlgebra

vec :: Vector R -- Real ~ Double
vec = vector [1 .. 5]

mat :: Matrix R
mat = 2 >< 3 $ [1 ..] -- size is determined by (><) and requires a '[a]' to continue

arr3 :: Matrix R
arr3 =
  -- makeArrayR D Seq (Sz (3 :> 2 :. 5)) (\(i :> j :. k) -> i * j + k)
  build (3, 2) (\i j -> i * j)
