module TestConvert where

  n1 = 2 + 5
  n2 = 2.5 + 3.5
  n3 = 2 + 3.5
  n4 = n + 3.5 where n = 2
  {-n5 = n + 3.5 where { n :: Int; n = 2 }-}
  n6 = fromIntegral n + 3.5 where { n :: Int; n = 2 }
  {-n7 = a + b where { a :: Int; a = 2; b :: Integer; b = 12 }-}
  n8 = a + fromIntegral b where { a :: Int; a = 2; b :: Integer; b = 12}

