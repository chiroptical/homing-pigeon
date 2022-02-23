{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import HomingPigeon
import qualified ArrayFire as A
import Control.Exception (catch)

main :: IO ()
main = print newArray `catch` (\(e :: A.AFException) -> print e)
  where
    newArray = A.matrix @Double (2,2) [ [1..], [1..] ] * A.matrix @Double (2,2) [ [2..], [2..] ]
