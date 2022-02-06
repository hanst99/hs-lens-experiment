{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TypeFamilies #-}

module Dog where

import HasField
import Person (Person)

data Dog = Dog {name_ :: String, age_ :: Double, owner_ :: Person}

instance HasField "name" Dog where
  type FieldType "name" Dog = String
  getField Dog {name_} = name_
  setField name d = d {name_ = name}

instance HasField "age" Dog where
  type FieldType "age" Dog = Double
  getField Dog {age_} = age_
  setField age d = d {age_ = age}

instance HasField "owner" Dog where
  type FieldType "owner" Dog = Person
  getField Dog {owner_} = owner_
  setField owner d = d {owner_ = owner}
