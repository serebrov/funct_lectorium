module TreeSort where

{- ����������� ��������� ������ -}
data Tree a = Empty |
              Node (Tree a) a (Tree a)
              
sort    :: (Ord a) => [a] -> [a]
build   :: (Ord a) => [a] -> Tree a
insert  :: (Ord a) => a -> Tree a -> Tree a
flatten :: Tree a -> [a]

{- ���������� ����������� � ���, ��� ������� ��������
   ������������� �������� ������ ������, � ����� ���
   ���������� ����� ������� � ����������� ������ (��������������) -}
sort ls       =  flatten (build ls)

{- ���������� ������ �� ������ -}
build []      =  Empty
build (e:ls)  =  insert e (build ls)

{- ������� �������� � ������������� ������ ������ -}
insert e Empty                    =  Node Empty e Empty
insert e (Node t1 n t2) | e < n   =  Node (insert e t1) n t2
                        | e >= n  =  Node t1 n (insert e t2)
                        
{- "�������������" ������ -}
flatten Empty = []
flatten (Node t1 n t2) = (flatten t1) ++ (n : (flatten t2))
