module Bubble where

{- ������� �������� � ������������� ������ -}
insert          :: (Ord a) => a -> [a] -> [a]
insert elem []  = [elem]
insert elem list@(x:s) | elem < x   = elem:list
                       | otherwise  = x:(insert elem s)

{- ���������� ������ ������� ������� ������� -}
bubble          :: (Ord a) => [a] -> [a]
bubble []       = []
bubble (x:s)    = insert x (bubble s)
