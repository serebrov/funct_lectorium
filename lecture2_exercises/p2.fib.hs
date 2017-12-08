module Fib where

-- ���������� ����� ���������, ��������� ���������� �������.
-- ��������: ���������� ����� ����� ���������.
-- ���������: ������ ��������� � �������� �������
fib        :: Integer -> Integer
fib 1      =  1
fib 2      =  1
fib n      =  fib (n-1) + fib (n-2)

test = (fib 1, fib 10, fib 30)