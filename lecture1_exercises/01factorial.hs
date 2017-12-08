module Factorial where

-- ghci 
-- :load 01factorial.hs
-- test
-- factorial 3

factorial :: Integer -> Integer
factorial n = if n == 0 then 1
                        else n * (factorial (n-1))

test = (factorial 0, factorial 5, factorial 100)
