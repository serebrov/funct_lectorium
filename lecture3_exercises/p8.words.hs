module Wordify where
{- Так на самом деле определяется стандартная функция words -}

import Char(isSpace)

wordify     :: String -> [String]
wordify s    = case dropWhile isSpace s of
		           "" -> []
		           s' -> w : wordify s''
			          where (w,s'') = break isSpace s'
