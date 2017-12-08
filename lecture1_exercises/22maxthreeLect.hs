-- Функция получает список целых и выдает список той же длины, содержащий
-- в качестве i-го элемента максимальные значения трех элементов исходного
-- списка - i-го, (i-1)-го и (i+1)-го.
-- На краях используются два элемента.
-- Например [3, 8, 6, 5, 1] => [8, 8, 8, 6, 5].

module Maxthree where

-- ghci 
-- :load 22maxthreeLect.hs
-- test

-- implementation from a lecture
maxthree        :: [Integer] -> [Integer]
maxthree []     = []
maxthree s      = maxthree' (head s) s

maxthree'           :: Integer -> [Integer] -> [Integer]
-- note: образец - список из одного элемента может быть записан
-- как [x] (не обязательно x:[])
maxthree' m [x]  = [max m x]
maxthree' m (x:t@(y:s)) = (max (max m x) y) : maxthree' x t

test = [([3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1] == [8, 8, 8, 6, 5]),
        ([0, 1], maxthree [0, 1], maxthree [0, 1] == [1, 1]),
        ([0], maxthree [0], maxthree [0] == [0]),
        ([], maxthree [], maxthree [] == []),
        ([1..10], maxthree [1..10], maxthree [1..10] == [2..10]++[10])
       ]
