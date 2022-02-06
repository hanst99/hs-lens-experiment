{-# LANGUAGE DuplicateRecordFields #-}

module Main where

import CommonFields
import Dog
import Lens
import Person

main :: IO ()
main = do
  let dog = Dog {age_ = 1.6, name_ = "Fido", owner_ = (Person {age_ = 10, name_ = "Hannes"})}
      dog2 = dog # age .= 5
  print $ dog2 ^. owner . name
