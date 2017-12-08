{-
 - Returns n-th member of arithmetic progression with given start and step:
 - amember a1 d n
 -}
module Amember where

  amember :: Double -> Double -> Integer -> Double
  amember a1 d n = a1 + fromIntegral (n - 1) * d

  test = (amember 1 2 6 == 11, 
          amember 0 2 101 == 200,
          amember 10 (-3) 15 == (-32))
