Homework
--------------------------------------------
### [0:06:30] Локальные определения

root' eps a b | b - a < eps = b
              | fn > 0      = root' eps m b
              | otherwise   = root' eps a m
      where m = (a + b) / 2
            fn = f n

В where - локальные определения, которые используются в описании функции.

### Максимальное из трех.

Функция получает список целых и выдает список той же длины, содержащий
в качестве i-го элемента максимальные значения трех элементов исходного
списка - i-го, (i-1)-го и (i+1)-го.
На краях используются два элемента.
Например [3, 8, 6, 5, 1] => [8, 8, 8, 6, 5].

Исходная реализация:

    maxthree   :: [Integer] -> [Integer]
    maxthree'  :: [Integer] -> [Integer]

    maxthree' []              = []
    maxthree' (e:[])          = [e]
    maxthree' (e1:e2:[])      = [maximum [e1,e2]]
    maxthree' (e1:e2:e3:ls)   = [maximum [e1,e2,e3]] ++ maxthree' (e2:e3:ls)

    maxthree ls@(e1:e2:s)     = [maximum [e1,e2]] ++ maxthree' ls
    maxthree ls               = maxthree' ls
    -- тут можно было использовать первый элемент списка в качестве дополнительного
    {-maxthree ls               = maxthree' ((-10000):ls)-}

Implementation from a lecture:

    maxthree        :: [Integer] -> [Integer]
    maxthree []     = []
    maxthree s      = maxthree' (head s) s

    maxthree'           :: Integer -> [Integer] -> [Integer]
    -- note: образец - список из одного элемента может быть записан
    -- как [x] (не обязательно x:[])
    maxthree' m [x]  = [max m x]
    maxthree' m (x:t@(y:s)) = (max (max m x) y) : maxthree' x t

Образец - список из одного элемента может быть записан как [x] (и не обязательно x:[]).

Реализация через map:

    maxthree        :: [Integer] -> [Integer]
    maxthree s      = map (\[x,y,z]-> max3 x y x)
                          (zip3 s (head s : s) (tail s ++ [last s]))

Функция, убирающая из списка строк каждую вторую и в оставшихся строках убирает каждый второй символ:

    removeEven        :: [String] -> [String]

    removeEven s = map remEven (remEven s)
    -- removeEven = (map remEven) . remEven
            where remEven :: [a] -> [a]
                  remEven (x:y:rest) = x : remEven rest
                  remEven s = s -- этот образец сработает только если
                                -- в списке один элемент или список пустой

[0:33:40] Еще один пример функции высшего порядка
--------------------------------------------

    source = [1, 2, 5, 7, 11]
    func = (+)      seed = 0

Есть исходный массив, функция и начальное значение.
Сворачиваем массив последовательно применяя функцию.

    11 + 0
    7  + 11 + 0
    5  + 7  + 11 + 0

Операция называется сверткой или редуцированием.

    func = (:)      seed = []

При такой функции и исходном значении мы получим копию списка:

    1 : 2 : 5 : 7 : 11 : [] = [1, 2, 5, 7, 11]

Стандартная функция foldr

    foldr   :: (a -> b -> b) -> b -> [a] -> b
    foldr func seed []      = seed
    foldr func seed (x:ls)  = func x (foldr func seed ls)

Суммирование, для использования операции + нужно заключить ее в скобки:

    foldr (+) 0 [1,2,5,7,11]
    26 : Integer

Функции foldr и map являются очень сильным средством программирования.
Факториал:

    factorial       :: Integer -> Integer
    factorial n     = foldr (*) 1 [1..n]

Пример с map и foldr - поиск элемента (есть такая стандартная elem):

    search      :: (Eq a) => a -> [a] -> Bool
    search e ls = foldr (||) False (map (\x -> x == e) ls)

Сначала с помощью map сравниваем каждый элемент списка с заданным значением.
Получаем список из бинарных значений, нужно проверить на наличие хотя бы
одного True.
Делаем это c помощью foldr (||) list.

    search 5 [1, 2, ,5 ,7, 11]
    foldr (||) False (map (\x -> x ==5) [1,2,5,7,11])
    foldr (||) False [False,False,True,False,False]

Lection 3. Part 2.
--------------------------------------------
### Еще несколько полезных функций высшего порядка.

    -- "левая свертка"
    foldl               :: (b -> a -> b) -> b -> [a] -> b
    foldl _ seed []     = seed
    foldl f seed (x:ls) = foldl f (f seed x) ls

    reverse             :: [a] -> [a]
    reverse list        = foldl app [] list
                          where app l x = x:l

    flip                :: (a -> b -> c) -> (b -> a -> c)
    flip f              = f' where f' x y = f y x

    reverse             :: [a] -> [a]
    reverse list        = foldl (flip (:)) [] list

    comp                :: (b -> c) -> (a -> b) -> (a -> c)
    comp f g            = fg where fg x = f (g x)
