module TreeSortFold where

{- Определение двоичного дерева -}
data Tree a = Empty |
              Node (Tree a) a (Tree a)
              
sort    :: (Ord a) => [a] -> [a]
build   :: (Ord a) => [a] -> Tree a
insert  :: (Ord a) => a -> Tree a -> Tree a
flatten :: Tree a -> [a]

{- Сортировка заключается в том, что сначала строится
   упорядоченное двоичное дерево поиска, а потом оно
   проходится слева направо с построением списка (разглаживается) -}
sort ls       =  flatten (build ls)

{- Вставка элемента в упорядоченное дерево поиска -}
insert e Empty                    =  Node Empty e Empty
insert e (Node t1 n t2) | e < n   =  Node (insert e t1) n t2
                        | e >= n  =  Node t1 n (insert e t2)
                        
{- Обход (свертка) дерева справа налево -}
foldTree  ::  (a -> b -> b) -> b -> Tree a -> b
foldTree _ seed Empty           =  seed
foldTree f seed (Node t1 n t2)  =  foldTree f (f n (foldTree f seed t2)) t1

{- Построение дерева из списка -}
build    =  foldr insert Empty

{- Эффективное разглаживание дерева с помощью свертки -}
flatten  =  foldTree (:) []

test = sort [2, 4, 7, 5, 1, 3, 8, 6, 9]
