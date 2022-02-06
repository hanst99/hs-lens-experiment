{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeApplications #-}

module CommonFields where

import HasField
import Lens

name :: forall r. HasField "name" r => Lens' r (FieldType "name" r)
name = field @"name"

age :: forall r. HasField "age" r => Lens' r (FieldType "age" r)
age = field @"age"

owner :: forall r. HasField "owner" r => Lens' r (FieldType "owner" r)
owner = field @"owner"
