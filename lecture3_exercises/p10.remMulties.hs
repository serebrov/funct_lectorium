{-
 ������ ������� �����, ���������� ������� "������ ����������".
 ������ ������� � ������� ��������������� ������������� ��������.
 -}
 
-- ��� ��������� �����
type IntSet = Integer -> Bool

-- ������ ���������
empty :: IntSet
empty n = False

-- ����������� ��������
disjunct :: IntSet -> IntSet -> IntSet
disjunct s1 s2 n = s1 n || s2 n

-- ��������� ��������� �� ������
fromList :: [Integer] -> IntSet
fromList list n = n `elem` list

-- "�����������" ���������
-- �� ��������� ��������� ��� �����, ������� ���������, ����� ������ ����� �����.
removeMultiples :: Integer -> IntSet -> IntSet
removeMultiples n s m = (n == m || m `mod` n /= 0) && s m

-- �������������� ��������� � ������ ��� ������
fromSet :: IntSet -> [Integer] -> [Integer]
fromSet = filter

-- ��������� ���� ������� �����, �� ������������� ��������� �����.
primes :: Integer -> IntSet
primes n = disjunct (==2) (foldr removeMultiples (fromList [3,5..n]) [3,5..n])

-- ������ ���� ������� �����, �� ������������� ��������� �����.
primesList :: Integer -> [Integer]
primesList n = fromSet (primes n) [2..n]

test = primesList 1000