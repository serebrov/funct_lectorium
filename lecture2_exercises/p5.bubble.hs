module Bubble where

{- вставка элемента в упорядоченный список -}
insert          :: (Ord a) => a -> [a] -> [a]
insert elem []  = [elem]
insert elem list@(x:s) | elem < x   = elem:list
                       | otherwise  = x:(insert elem s)

{- Сортировка списка методом простых вставок -}
bubble          :: (Ord a) => [a] -> [a]
bubble []       = []
bubble (x:s)    = insert x (bubble s)
