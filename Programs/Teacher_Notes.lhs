Notes.
\begin{code}
data Nat = Z | S Nat deriving (Eq,Show,Ord)
add :: Nat -> Nat -> Nat
add n Z = n
add n (S m) = add (S n) m
\end{code}

\begin{code}
add' n Z = n
add' n (S m) = S (add n m)
\end{code}

Insertion:

\begin{code}
insert x [] = [x]
insert x (y:ys)
  | y >= x    = x:y:ys
  | otherwise = y:insert x ys
\end{code}

Tree:
\begin{code}
data Tree a = Nil | Node a (Tree a) (Tree a)
insert' :: Ord a => a -> Tree a -> Tree a
insert' x (Nil) = Node x Nil Nil
insert' x (Node y l r)
                  | x < y = Node y (insert' x l) r
                  | x == y = Node y l r
                  | x > y = Node y l (insert' x r)
\end{code}

Exists:
\begin{code}
{-exists :: Ord a => a -> Tree a -> Tree a
exists x Nil = False
exists x (Node y l r)
                      | x < y = exists x l
                      | x == y = True
                      | x > y = exists x r
                      -}
\end{code}

Breath-first Flatten:
\begin{code}
bfflatten' :: [Tree a] -> [a]
bfflaten' [] = []
bfflatten' ts = [x | Node x _ _ <- ts] ++ bfflatten' [t | Node _ l r <- ts, t <- [l,r]]
\end{code}
