{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TypeFamilies #-}

module Person where

import HasField

data Person = Person {name_ :: String, age_ :: Int}
  deriving (Show)

instance HasField "name" Person where
  type FieldType "name" Person = String

  getField Person {name_} = name_
  setField name p = p {name_ = name}

instance HasField "age" Person where
  type FieldType "age" Person = Int

  getField Person {age_} = age_
  setField age p = p {age_ = age}
