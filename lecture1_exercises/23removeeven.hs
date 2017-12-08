-- Функция получает список строк, удаляет каждую вторую строку и 
-- в оставшихся строках - каждый второй символ
-- Например ["one", "two", "three", "four", "five"] => ["oe", "tre", "fv"].

module RemoveEven where

-- ghci 
-- :load 23removeeven.hs
-- test

-- implementation from a lecture via map
removeEven        :: [String] -> [String]
remEven        :: [a] -> [a]

remEven (o:e:s) = o : remEven s
remEven s = s

removeEven s = map remEven (remEven s)

test = [
    (removeEven ["one", "two", "three", "four", "five"] == ["oe", "tre", "fv"]),
    (removeEven ["one"] == ["oe"]),
    (removeEven [] == [])
        ]
