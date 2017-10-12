\begin{code}
main :: IO ()
main = undefined
\end{code}

Exercise 1.

Identify redexes:

Identify:   1 + (2*3)
Innermost:  (2*3)
Outermost:  1 + (2*3)

Identify:   (1+2) * (2+3)
Step:   =   3 * (2+3)
        =   3 * 5
        =   15
Innermost:  (1+2), (2+3)
Outermost:  (1+2) * (2+3)

Identify:   fst (1+2, 2+3)
Innermost:  (1+2), (2+3)
Outermost:  fst

Identify:   (\x -> 1 + x) (2*3)
Innermost:  (2*3)
Outermost:  (\x -> 1 + x) (2*3) OR 1 + (2*3)
Since:      (\x -> 1 + x)       <--      Not reducible without knowledge of x

--------------------------------------------------------------------------------

Exercise 2.

Outermost vs Innermost evaluation for fst

Innermost
fst ((1+2), (2+3))
  = fst (3, (2+3))
  = fsst (3, 5)
  = 3

Outermost
fst ((1+2), (2+3))
  = (1+2)
  = 3

--------------------------------------------------------------------------------

Exercise 3.

Reduce cube (cube 3)
Innermost
cube (cube 3)
  = cube ((\x -> x * x * x) 3)
  = cube (3 * 3 * 3)
  = cube (9 * 3)
  = cube (27)
  = (\x <- x * x * x) 27
  = 27 * 27 * 27
  = 729 * 27
  = 19683

Outermost
cube (cube 3)
  = (\x -> x * x * x) (cube 3)
  = (cube 3) * (cube 3) * (cube 3)
  = ((\x -> x * x * x) 3) * (cube 3) * (cube 3)
  = (3 * 3 * 3) * (cube 3) * (cube 3)
  = (3 * 3 * 3) * ((\x -> x * x * x) 3) * (cube 3)
  = (3 * 3 * 3) * (3 * 3 * 3) * (cube 3)
  = (9 * 3) * (3 * 3 * 3) * (cube 3)
  = (27) * (3 * 3 * 3) * (cube 3)
  = (27) * (9 * 3) * (cube 3)
  = (27) * (27) * (cube 3)
  = 729 * (cube 3)
  = 729 * ((\x -> x * x * x) 3)
  = 729 * (3 * 3 * 3)
  = 729 * (9 * 3)
  = 729 * (27)
  = 19683

Outermost with sharing
cube (cube 3)
  = (\x -> x * x * x) (cube 3)
  = let x = cube 3      in x * x * x
  = let x = 3 * 3 * 3   in x * x * x
  = let x = 9 * 3       in x * x * x
  = let x = 27          in x * x * x
  = 27 * 27 * 27
  = 729 * 27
  = 19683

--------------------------------------------------------------------------------

Excercise 4.

Definition of map
map f [] = []
map f (x:xs) = f x : map f xs


Evaluation of map (Outermost with sharing)
map (2*) (map (1+) [1,2,3])
  = map (2*) ((1 + 1 : map (1+) [2, 3])
  = (2*(1+1)) : map (2*) (map (1+) [2, 3])
  = (2*2) : map (2*) (map (1+) [2 ,3])
  = 4 : map (2*) (map (1+) [2, 3])

--------------------------------------------------------------------------------

Strict map implementation
--\begin{code}
mapStrict :: (a -> b) -> [a] -> [b]
mapStrict f (x:xs) =
  let v = f $! x
  rest = mapStrict f xs
  in v `seq` rest `seq` v:rest
--\end{code}

--------------------------------------------------------------------------------

-- Iterate
Iterate (+1) 0 --> 0+1: 1+1: 2+1: 3+2: []
Iterate (*2) 1 --> 2*1: 2*2: 4*2: []

\begin{code}
-- Natural numbers
nats :: [Int]
nats = iterate f 0
  where f = (+1)

-- Even numbers
evens :: [Int]
evens = iterate f 0
  where
    f = (+2)

-- Two-powers
twopows :: [Int]
twopows = iterate f 1
  where
    f = (*2)

-- Factorials
factorials :: [(Int, Int)]
factorials = iterate f (0, 1)
  where
    f (a, b) = ((a+1), (a+1)*b)

-- Fibs
fibs :: [(Int, Int)]
fibs = iterate f (0, 1)
  where
    f (a, b) = (b, a+b)
\end{code}

--------------------------------------------------------------------------------

-- mapM_ print $ take n (diags pairs)

-- Infinite lists

\begin{code}
pairs :: [[(Int, Int)]]
pairs = [ [ (x, y) | y <- [1..] ] | x <- [1..] ]

-- taketake
taketake :: Int -> [[a]] -> [[a]]
taketake n l = take n [take n x | x <- l]
--taketake n l = take n . map (take n)

-- diagonals(
diags :: [[a]] -> [[a]]
diags xs = map (diags' xs) [0..]
  where
    diags' [] n   = []
    diags' (y:ys) n
                | n >= 0 = y !! n : diags' ys (n-1)
                | otherwise = []

--------------------------------------

-- Full binary trees
data FTree a = Nil | Cons a (FTree (a, a)) deriving Show

-- Constructors level0-2
level0, level1, level2 :: FTree Int
level0 = Nil
level1 = Cons 1 Nil
level2 = Cons 1 (Cons (2,3) Nil)
--level3 = Cons 1 (Cons (2,3) (Cons ((4,5), (6,7) Nil)))

-- levels (take)
levels :: Int -> FTree a -> FTree a
levels 0 _          = Nil
levels _ Nil        = Nil
levels n (Cons v c) = Cons v (levels (n-1) c)

-- Split
-- Split: (a, a) -> (FTree a, FTree a)
split :: FTree (a, a) -> (FTree a, FTree a)
split Nil              = (Nil, Nil)
split (Cons (a, b) c)  = let (l, r) = split c
                         in (Cons a l, Cons b r)

-- Left
left :: FTree a -> Maybe (FTree a)
left Nil = Nothing
left (Cons c _) = Just $ fst $ split c

-- Right
right :: FTree a -> Maybe (FTree a)
right Nil = Nothing
right (Cons _ c) = Just $ snd $ split c

-- Join
join :: (FTree a, FTree a) -> FTree (a, a)
join (Nil, t2) = Nil
join (t1, Nil) = Nil
join ((Cons a, l), (Cons b r)) = Cons (a, b) (join (l, r))

-- GenTree
genTree :: Integer -> FTree Integer
genTree n = Cons n $ join (genTree)
\end{code}
