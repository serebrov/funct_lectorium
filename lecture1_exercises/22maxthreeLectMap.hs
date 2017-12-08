-- Функция получает список целых и выдает список той же длины, содержащий
-- в качестве i-го элемента максимальные значения трех элементов исходного
-- списка - i-го, (i-1)-го и (i+1)-го.
-- На краях используются два элемента.
-- Например [3, 8, 6, 5, 1] => [8, 8, 8, 6, 5].

module Maxthree where

-- ghci 
-- :load 22maxthreeLectMap.hs
-- test

-- implementation from a lecture via map
maxthree        :: [Integer] -> [Integer]
        -- zip3 will make a list of three-values [(3,3,8),(3,8,6)...]
        -- and map will select max in each tree and make a flat list
maxthree s      = map (\(x,y,z)-> max3 x y z)
                        (zip3 s (head s : s) (tail s ++ [last s]))
                where max3 x y z = max x (max y z)

test = [([3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1], maxthree [3, 8, 6, 5, 1] == [8, 8, 8, 6, 5]),
        ([0, 1], maxthree [0, 1], maxthree [0, 1] == [1, 1]),
        ([0], maxthree [0], maxthree [0] == [0]),
        ([], maxthree [], maxthree [] == []),
        ([1..10], maxthree [1..10], maxthree [1..10] == [2..10]++[10])
       ]
