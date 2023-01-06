module Tutorial where

import Data.Massiv.Array

vec :: Vector D Ix1
vec = makeVectorR D Seq 10 id

mat :: Array D Ix2 Int
mat = makeArrayR D Seq (Sz (3 :. 5)) (\(i :. j) -> i * j)

arr3 :: Array D Ix3 Int
arr3 = makeArrayR D Seq (Sz (3 :> 2 :. 5)) (\(i :> j :. k) -> i * j + k)
