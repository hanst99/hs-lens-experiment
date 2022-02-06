{-# LANGUAGE RankNTypes #-}

module Lens where

import Data.Functor.Const
import Data.Functor.Identity

type Lens s t a b = forall f. Functor f => (a -> f b) -> s -> f t

type Lens' s a = Lens s s a a

infixr 0 #

(#) = flip ($)

type Getter s a = (a -> Const a a) -> s -> Const a s

view :: Getter s a -> s -> a
view getter obj = getConst $ getter Const obj

infixr 8 ^.

(^.) :: s -> Getter s a -> a
(^.) = flip view

type Setter s a = (a -> Identity a) -> s -> Identity s

set :: Setter s a -> a -> s -> s
set setter x = update setter (const x)

infixr 8 .=

(.=) :: Setter s a -> a -> s -> s
(.=) = set

update :: Setter s a -> (a -> a) -> s -> s
update setter upd obj = runIdentity $ setter (Identity . upd) obj

infixr 8 .~

(.~) :: Setter s a -> (a -> a) -> s -> s
(.~) = update
