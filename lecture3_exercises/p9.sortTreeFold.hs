module TreeSortFold where

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

{- ������� �������� � ������������� ������ ������ -}
insert e Empty                    =  Node Empty e Empty
insert e (Node t1 n t2) | e < n   =  Node (insert e t1) n t2
                        | e >= n  =  Node t1 n (insert e t2)
                        
{- ����� (�������) ������ ������ ������ -}
foldTree  ::  (a -> b -> b) -> b -> Tree a -> b
foldTree _ seed Empty           =  seed
foldTree f seed (Node t1 n t2)  =  foldTree f (f n (foldTree f seed t2)) t1

{- ���������� ������ �� ������ -}
build    =  foldr insert Empty

{- ����������� ������������� ������ � ������� ������� -}
flatten  =  foldTree (:) []

test = sort [2, 4, 7, 5, 1, 3, 8, 6, 9]
