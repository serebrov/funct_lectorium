{-
 Список простых чисел, полученный методом "решета Эратосфена".
 Работа ведется с помощью функционального представления множеств.
 -}
 
-- Тип множества целых
type IntSet = Integer -> Bool

-- Пустое множество
empty :: IntSet
empty n = False

-- Объединение множеств
disjunct :: IntSet -> IntSet -> IntSet
disjunct s1 s2 n = s1 n || s2 n

-- Генерация множества из списка
fromList :: [Integer] -> IntSet
fromList list n = n `elem` list

-- "Просеивание" множества
-- Из множества убираются все числа, кратные заданному, кроме самого этого числа.
removeMultiples :: Integer -> IntSet -> IntSet
removeMultiples n s m = (n == m || m `mod` n /= 0) && s m

-- Преобразование множества в список для вывода
fromSet :: IntSet -> [Integer] -> [Integer]
fromSet = filter

-- Множество всех простых чисел, не превосходящих заданного числа.
primes :: Integer -> IntSet
primes n = disjunct (==2) (foldr removeMultiples (fromList [3,5..n]) [3,5..n])

-- Список всех простых чисел, не превосходящих заданного числа.
primesList :: Integer -> [Integer]
primesList n = fromSet (primes n) [2..n]

test = primesList 1000