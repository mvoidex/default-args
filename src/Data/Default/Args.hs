{-# LANGUAGE TypeFamilies, FlexibleInstances #-}

module Data.Default.Args (
	DefaultArgs(..)
	) where

import Data.Default

type family Result a where
	Result (a → r) = Result r
	Result a = a

-- | Applies default values to function/constructor
-- This allows creating data with specific constructor and default arguments
-- For example
--
-- >>> defArgs Left ∷ Either Int String
-- Left 0
class DefaultArgs a where
	defArgs ∷ a → Result a

instance {-# OVERLAPPABLE #-} (a ~ Result a) ⇒ DefaultArgs a where
	defArgs = id

instance (Default a, DefaultArgs b) ⇒ DefaultArgs (a → b) where
	defArgs f = defArgs $ f def
