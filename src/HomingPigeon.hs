module HomingPigeon where

import Torch (Tensor, asTensor, asValue)
import Torch.Functional
import Torch.Functional.Internal (trace)

a :: Tensor
a = asTensor @[[Float]] [[1, 2], [3, 4]]

b :: Tensor
b = asTensor @[[Float]] [[6, 0], [2, -1]]

-- element-wise addition
c :: Tensor
c = a + b

-- trace :: Tensor -> Tensor
-- trace = sumAll . diag (Diag 0)

traceA :: Tensor -> Tensor
traceA = sumAll . diag (Diag 1)

d :: Tensor
d = a * 2

-- `tensor * tensor` is element-wise as well

e :: Tensor
e = matmul a b

f :: Tensor
f = matmul b a

g :: Tensor
g = asTensor @[[Float]] [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

-- pull the first value from the tensor
-- useful when doing reductions
traceToValue :: Tensor -> Float
traceToValue = asValue . trace

-- default: single dimension tensors are rows
h :: Tensor
h = asTensor @[Float] [1, 2]

i :: Tensor
i = asTensor @[[Float]] [[1, 2, 3], [4, 5, 6]]

-- inverses in libtorch expect square inputs

oneOverSqrt :: Float -> Float
oneOverSqrt = (1 /) . Prelude.sqrt

-- j, k, l are row vectors in a orthogonal 3x3 matrix
j :: Tensor
j =
  asTensor @[Float]
    [oneOverSqrt 3, oneOverSqrt 2, oneOverSqrt 6]

k :: Tensor
k =
  asTensor @[Float]
    [oneOverSqrt 3, - (oneOverSqrt 2), oneOverSqrt 6]

l :: Tensor
l =
  asTensor @[Float]
    [oneOverSqrt 3, 0, -2 * oneOverSqrt 6]

-- m, n, o are column vectors in a orthogonal 3x3 matrix
m :: Tensor
m =
  asTensor @[Float]
    [oneOverSqrt 3, oneOverSqrt 3, oneOverSqrt 3]

n :: Tensor
n =
  asTensor @[Float]
    [oneOverSqrt 2, - (oneOverSqrt 2), 0]

o :: Tensor
o =
  asTensor @[Float]
    [oneOverSqrt 6, oneOverSqrt 6, -2 * oneOverSqrt 6]

-- If you take the scalar product ('dot' in Hasktorch) between any of the row
-- vectors with eachother you will get zero, same is true for the column
-- vectors. This is orthogonality. Normalized means that the dot product of
-- each vector with itself is one. This is where the term orthonormal comes
-- from.

p :: Tensor
p = asTensor @[[Float]] [[1, 2], [3, 4]]

-- Compute inverse of A in linear equation system with Hasktorch
-- Try to solve the linear system Ax = b in Hasktorch
-- Move onto Eigenvalues, Eigenvectors, and Functions of Matrices
