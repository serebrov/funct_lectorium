* Без переменных
* Без состояния
* Без побочных эффектов

* Легко распараллелить

* Средства
  * Арифм и логич операции
  * Присваивания
  * Последоват исполнение шагов
  * Управляющие конструкции (циклы, )
    * Т.к. ничего не меняется, то циклы смысла не имеют
  * Процедуры и функции
    * функции

* Функция - черный ящик
  * Без состояния

Вычисление корней кв. уравнения:

    class Result {
        boolean complexFlag;
        double r1;
        double r2;
    }
    static double discriminant (double a, double b, double c) {
        return b*b - 4*a*c;
    }
    static Result squareRoots(double a, double b, double c) {
        Result result = new Result();
        double descr = discriminant(a, b, c);
        result.complexFlag = descr < 0;
        if (result.complexFlag) {
            result.r1 = (-b) / (2*a);
            result.r2 = Math.sqrt(-discr) / (2*a);
        } else {
            result.r1 = (-b + Math.sqrt(discr)) / (2*a);
            result.r2 = (-b - Math.sqrt(discr)) / (2*a);
        }
        return result;
    }

В функц. варианте можно распараллелить, т.к. нет переменных и можно делать вычисления в любом порядке.

Как сделать более функционально на Java?

Псевдо-Java:

    static double discriminant (double a, double b, double c) {
        return b*b - 4*a*c;
    }
    (boolean, double, double) squareRoots(double a, double b, double c) {
        final double descr = discriminant(a, b, c);
        final double complexFlag = descr < 0;
        (complexFlag,
            (complexFlag ? ((-b) / (2*a), sqrt(-discr) / (2*a))
                         : ((-b + sqrt(discr)) / (2*a), (-b - sqrt(discr)) / (2*a))
    }

* Переменных нет, только константы (обозначены final)
* Но константы получают значения не на этапе компиляции, а на этапе выполнения
* Условные выражения
* Любая функция - суперпозиция других функций
* Результат не зависит от порядка вычислений
  * Можно вычислить отдельные части в любом порядке (или параллельно)
  * Часть подвыражений внутри функции выше можно начать считать сразу, например '-b', другие должны ждать пока будет посчитан discr

* Хорошо подходит для обработки больших массивов данных

* Традиционные языки не очень подходят для удобной работы с функциями.

Например: множество (напр. целых чисел) удобно представлять не набором элементов, а характеристической функцией (на вход элемент - функция выдает принадлежит ли он множеству).

    boolean intSet(int); //описание функционального типа данных

    boolean emptySet(int n) { return false } //пустое множество

    boolean oddSet(int n) { return n % 2 == 1; } // множество неотрицательных нечетных чисел

Операции над множествами

    intSet addElement (intSet s; int newElem) {
        //описали и вернули новую функцию
        // элемент или входит в старое множество или равен новому
        // элементу
        boolean newSet (int n) { return s(n) || (n == newElem); }
        // вернули новую функцию
        return newSet;
    }

    //множество чисел между заданным min и max
    intSet buildInternal (int min, int max) {
        boolean newSet (int n) { return (n >= min) && (n <= max); }
        return newSet;
    }

    //возвращает true если элемент принадлежит первому множеству и не принадлежит второму
    intSet difference (intSet s1, intSet s2) {
        boolean newSet (int n) { return s1(n) && | s2(n); }
        return newSet;
    }

Вычисляем выражение:

    // принадлежит ли 7 множеству [odds] \ [3]
    difference (oddSet, addElement (emptySet, 3)) (7)

В Java можно построить программу для работы с функциональным представлением множеств:

    abstract class IntSet {
        abstract boolean has(int elem);

        public static IntSet addElement(final IntSet s, final int n) {
            return new IntSet() {
                public boolean has(int elem) { return elem == n || s.has(elem); }
            };
        }
        public static IntSet buildInternal(final n, final int n) {
            return new IntSet() {
                public boolean has(int elem) { return elem >= n && elem <= n; }
            };
        }
        public static IntSet difference(final IntSet s1, final IntSet s2) {
            return new IntSet() {
                public boolean has(int elem) { return s1.has(elem) && | s2.has(elem); }
            };
        }
        public static void main(String[] args) {
            IntSet emptySet= new IntSet() { public boolean has(int e) { return false; }}
            IntSet oddSet = new IntSet() { public boolean has(int e) { return e % 2 == 1; }}
            System.out.println(difference(oddSet, addElement(emptySet, 3))).has(7);
        }
    }

* Литература

 *  Филд. Харрисон. Функциональное программирование М: Мир, 1983
 *  П.Хендерсон. Функциональное программирование. Применение и реализация. М Мир 1983
 *  А.А. Кубенский. Функциональное программирование ИТМО 2010

*  Дополнительная

 *  Пол Хьюдак. Джон Петерсон. Джозеф Фасеп. Мягкое введение в Haskell. RSDN Magazin 2006
 *  Graham Hutton Programming in Haskel. 2007
 *  Bryan O'Sullivan John Goerzen Donald Stewart. Real World Haskell.

Lecture 1. Part 2. Haskell
--------------------------------------------

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
