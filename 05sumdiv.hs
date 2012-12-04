{-
 - Find sum of divs for given positive number
 - including 1, but excluding given number
 - Example: sumdiv 36 => 1+2+3+4+6+9+12+18 = 55
 -
 -}

 {- my solution -}
 sumdiv :: Integer -> Integer
 sumdiv n | n < 1       = error "sumdiv: wrong argument"
          | n == 1      = 0
          | otherwise   = 1 + sumdiv' 2 n

 sumdiv' :: Integer -> Integer -> Integer
 sumdiv' d n 
    | fromIntegral d <= n `div` 2 = if n `mod` d == 0 then d + (sumdiv' (d+1) n)
                                                      else sumdiv' (d+1) n
    | otherwise                   = 0

 test  = (sumdiv 1 == 0, sumdiv 36 == 55)


 {- lection solution 04:01 -}
 sumdivL :: Integer -> Integer
 sumdivL 1 = 0
 sumdivL n = 1 + sumdivL' n 2

 sumdivL' :: Integer -> Integer -> Integer
 sumdivL' n low 
     | 2 * low > n = 0
     | otherwise   = sumdivL' n (low+1) + if n `mod` low == 0 then low else 0

 testL  = (sumdivL 1 == 0, sumdivL 36 == 55)
