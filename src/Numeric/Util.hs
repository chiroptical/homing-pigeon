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

{- | We classify a matrix so that we can dispatch to appropriate functions when
 needed. For example, we can't compute eigenvectors for a non-square matrix.
-}
data ClassifiedMatrix = ClassifiedMatrix MatrixKind (Matrix (Complex Double))
  deriving stock (Show)

-- | The type of matrix
data MatrixKind
  = NonSquareKind
  | SquareKind
  | HermitianKind
  deriving stock (Show)

-- | Classify a matrix
classifyMatrix :: Matrix (Complex Double) -> ClassifiedMatrix
classifyMatrix cm =
  if isSymmetric
    then
      if isHermitian
        then ClassifiedMatrix HermitianKind cm
        else ClassifiedMatrix SquareKind cm
    else ClassifiedMatrix NonSquareKind cm
  where
    rs = rows cm
    cs = cols cm
    isSymmetric = rs == cs
    isHermitian = conjugateTranspose cm == cm

-- | A 'MatrixKind' determines the output of the 'eigen' function.
data EigenResult
  = NonSquareNoResult
  | SquareComplexEigenvalues (Vector (Complex Double), Matrix (Complex Double))
  | HermitianRealEigenvalues (Vector Double, Matrix (Complex Double))
  deriving stock (Show)

-- | Dispatch to the appropriate eig function
eigen :: ClassifiedMatrix -> EigenResult
eigen = \case
  ClassifiedMatrix NonSquareKind _ -> NonSquareNoResult
  ClassifiedMatrix SquareKind mat -> SquareComplexEigenvalues $ eig mat
  ClassifiedMatrix HermitianKind mat -> HermitianRealEigenvalues . eigSH $ trustSym mat
