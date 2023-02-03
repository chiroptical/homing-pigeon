module Main where

import Numeric.LinearAlgebra
import Numeric.Util
import Tutorial

main :: IO ()
main = do
  print vec
  print mat
  print squareMat

  print $ determinant mat
  print $ determinant squareMat

  print $ transpose complexMat
  print $ conjugateTranspose complexMat

  let cm = classifyMatrix hermitianComplexMat
  print $ eigen cm
