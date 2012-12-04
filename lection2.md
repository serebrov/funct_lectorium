Haskell
--------------

* [www.lambda.org](www.lambda.org)
* 1960 - LISP - первый функциональный язык программирования
* 1978 - Jonh Backus. FP - система комбинаторного программирования.
конец 1970=х - ML - meta-language
* 1985-1986 David Turner. Miranda - функциональный язык с ленивыми вычислеиями
* 1990 Erricson Erlang - коммерческий функциональный язык
* 1988 Paul hudak Haskell - first version
* 1999 Haskell'98
* [haskell.org](haskell.org)

* Типы данных и базовые конструкции
* Элементарные типы данных
* Строго типизированный.
 * Integer, Int - целые значения (длинное и короткое)
 * Float, Double - вещественные
 * Char - символьные значения
 * Bool - True, False
* Идентификаторы: fact, fAct, fact_1, fact''
* Знаки операций:  +, -, *, <, ==

Идентификаторы - для обозначения костант:

    school :: Integer (можно не указывать - будет определено из контекста)
    school = 239

    piHalf :: Double
    piHalf = 3.14 / 2

Кортежи:

    pair :: (Double, Double)
    pair = (2.7, 3.14)

    attrs :: (Char, (Int, Int, Int), Bool)
    attrs :: ('M', (17, 4, 1955), True)

Функции:

    sin :: Double -> Double -- аргумент и результат Double
    plusInt :: Int -> Int -> Int -- два аргумента типа Int, результат Int
    divMod :: (Int, Int) -> (Int, Int) -- аргумент и результат - кортежи

Выражения из констант применением операций и функций:

    result = sin (3.14 / 4) - 2/5
    c10 = 3 + plusInt 3 4
    pair = divMod (1458, plusInt 176 192)


[1:23:51]
Аргументы передаются через пробел, скобки присутствуют только в случае передачи кортежа:

    plusInt 3 4                     -- два аргумента
    divMod (1458, plusInt 176 192)  -- один аргумент-кортеж

Операции и функци отличаются только формой записи. Следующие выражения эквивалентны:

    3 + 8                      <>           (+) 3 8
    27 `div` 4                 <>           div 27 4
    7 `plusInt` 11             <>           plusInt 7 11

Т.е. функцию с двумя операндами можно записать и в префиксной форме и в инфексной.

Определение функций с помощью уравнений:

    plusInt :: Int -> Int -> Int
    plusInt a b = a + b

    divMod :: (Int, Int) -> (Int, Int)
    divMod (a, b) = (a `div` b, a `mod` b)

Условные выражения и рекурсивные обращения:

    factorial :: Integer -> Integer
    factorial n = if n == 0 then 1
                            else n * (factorial (n-1))

    sum :: Integer -> Integer
    sum n = n + if n == 0 then 0 else sum (n-1)

[1:35:53]
Несколько уравнений для одной функции:

    factorial1 :: Integer -> Integer
    factorial1 n | n == 0 = 1
                 | n > 0  = n * (factorial1 (n-1))

[1:38:40]
Описание в виде нескольких функций:

    factorial2 :: Integer -> Integer
    factorial2 0   = 1
    factorial2 n   = n * (factorial2 (n-1))

Можно использовать константы в виде образца в описании функции.
Порядок описания функций важен.


Подготовка и запуск
-------------------

Краткий синтаксис - все предложения друг под другом
Полный - можно делать отступы как угодно, но нужно ставить точки с запятой, скобки и т.д.

[1:48:55]
При добавлении отступа компилятор считает следующую строку продолжением:

    factorial1 :: Integer -> Integer     -- ошибка
       factorial1 n | n == 0 = 1
                    | n > 0  = n * (factorial1 (n-1))


      factorial1 :: Integer -> Integer     -- ошибка
    factorial1 n | n == 0 = 1
                | n > 0  = n * (factorial1 (n-1))


    factorial1 :: Integer -> Integer     -- OK
    factorial1 n | n == 0 = 1 | n > 0  = n * (factorial1 (n-1))

[2:01:32]

    factorial - 3 -- это отнять 3 от factorial
    factorial (-3) -- факториал от -3

Примеры определений арифм. функций:

    --наибольший общий делитель
    gcd             :: Integer -> Integer -> Integer
    gcd m n | m < n = gcd n m
            | n < 0 = error "gcd: wrong argument"
    gcd m 0         = m
    gcd m n         = gcd n (m `mod` n)

Функция error - специальная, может быть подставлена в любое место (т.е. как-бы возвращает любой результат).
Фактически прекращает выполнение программы.


    -- Проверка заданного натурального числа на простоту
    prime            :: Integer -> Bool
    prime'           :: Integer -> Integer -> Bool
    prime p    | p <= 0         = error "prime: Non-positive argument"
                | otherwise      = prime' 2 p
    prime' d p | d * d > p      = True
                | p `mod` d == 0 = False
                | otherwise      = prime' (d+1) p

[2:10:15]
Преобразования типов:

    2 + 5 - сложение целых, результат целое
    2.5 + 3.5 - сложение вещественных, результат вещественное
    2 + 3.5 - сложение вещественных (преобразование)
    n + 3.5 where n = 2 - сложение вещественных (преобразование)
    n + 3.5 where { n :: Int; n = 2 } - ошибка (целое + вещественное)
    fromIntegral n + 3.5 where { n :: Int; n = 2 } - явное преобразование целого в вещественное

    a + b where { a :: Int; a = 2; b :: Integer; b = 12 } - ошибка, разные типы (Int / Integer)

    a + fromIntegral b where { a :: Int; a = 2; b :: Integer; b = 12} - сложение короких целых (явное преобразование)


Некоторые функции пребразования типов:

    fromIntegral, fromRational, fromEnum,
    truncate, round, ceiling, floor
