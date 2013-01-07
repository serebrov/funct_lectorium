-- Функция получает список целых и выдает список той же длины, содержащий
-- в качестве i-го элемента максимальные значения трех элементов исходного
-- списка - i-го, (i-1)-го и (i+1)-го.
-- На краях используются два элемента.
-- Например [3, 8, 6, 5, 1] => [8, 8, 8, 6, 5].

module Maxthree where

-- ghci 
-- :load 22maxthree.hs
-- test

maxthree   :: [Integer] -> [Integer]
maxthree'  :: [Integer] -> [Integer]

maxthree' []              = []
maxthree' (e:[])          = [e]
maxthree' (e1:e2:[])      = [maximum [e1,e2]]
maxthree' (e1:e2:e3:ls)   = [maximum [e1,e2,e3]] ++ maxthree' (e2:e3:ls)

maxthree ls@(e1:e2:s)     = [maximum [e1,e2]] ++ maxthree' ls
maxthree ls               = maxthree' ls
{-maxthree ls               = maxthree' ((-10000):ls)-}

test = [([3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1] == [8, 8, 8, 6, 5]),
        ([0, 1], maxthree [0, 1], maxthree [0, 1] == [1, 1]),
        ([0], maxthree [0], maxthree [0] == [0]),
        ([], maxthree [], maxthree [] == []),
        ([1..10], maxthree [1..10], maxthree [1..10] == [2..10]++[10])
       ]
