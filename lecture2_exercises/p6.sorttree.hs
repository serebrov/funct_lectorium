module TreeSort where

{- ќпределение двоичного дерева -}
data Tree a = Empty |
              Node (Tree a) a (Tree a)
              
sort    :: (Ord a) => [a] -> [a]
build   :: (Ord a) => [a] -> Tree a
insert  :: (Ord a) => a -> Tree a -> Tree a
flatten :: Tree a -> [a]

{- —ортировка заключаетс€ в том, что сначала строитс€
   упор€доченное двоичное дерево поиска, а потом оно
   проходитс€ слева направо с построением списка (разглаживаетс€) -}
sort ls       =  flatten (build ls)

{- ѕостроение дерева из списка -}
build []      =  Empty
build (e:ls)  =  insert e (build ls)

{- ¬ставка элемента в упор€доченное дерево поиска -}
insert e Empty                    =  Node Empty e Empty
insert e (Node t1 n t2) | e < n   =  Node (insert e t1) n t2
                        | e >= n  =  Node t1 n (insert e t2)
                        
{- "–азглаживание" дерева -}
flatten Empty = []
flatten (Node t1 n t2) = (flatten t1) ++ (n : (flatten t2))
