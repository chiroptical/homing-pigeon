module HomingPigeon where

import Torch hiding (trace)

a :: Tensor
a = asTensor @[[Float]] [[1, 2], [3, 4]]

b :: Tensor
b = asTensor @[[Float]] [[6, 0], [2, -1]]

-- element-wise addition
c :: Tensor
c = a + b

trace :: Tensor -> Tensor
trace = sumAll . diag (Diag 0)

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

-- On orthogonality section
