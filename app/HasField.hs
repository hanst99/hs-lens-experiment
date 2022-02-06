{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeFamilies #-}

module HasField where

import GHC.OverloadedLabels
import GHC.TypeLits
import Lens

class HasField (s :: Symbol) r where
  type FieldType s r

  getField :: r -> FieldType s r
  setField :: FieldType s r -> r -> r

field :: forall (s :: Symbol) r. HasField s r => Lens' r (FieldType s r)
field into from = fmap (\b -> setField @s b from) $ into (getField @s from)
