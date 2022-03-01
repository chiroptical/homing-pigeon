{-# LANGUAGE TemplateHaskell #-}

module Main where

import Hedgehog
import Hedgehog.Main
import HomingPigeon (doHomingPigeon)

prop_test :: Property
prop_test = property $ do
  doHomingPigeon === "HomingPigeon"

main :: IO ()
main = defaultMain [checkParallel $$(discover)]
