module Factorial where

-- Вычисление факториала.
-- Аргумент: число, факториал которого следует вычислить.
-- Результат: Вычисленное значение факториала.
factorial  :: Integer -> Integer
factorial n = factorial' n 1               -- (factorial' n f) == (f * n!)

-- Вспомогательная функция для вычисления факториала.
-- По заданным аргументам n и f вычисляет значение (f * n!).
factorial' :: Integer -> Integer -> Integer
factorial' n f | n == 0  =  f
               | n > 0   =  factorial' (n-1) (n*f)
               
test = (factorial 0, factorial 5, factorial 100)