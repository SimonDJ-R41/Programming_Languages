\begin{code}
main :: IO ()
main = undefined
\end{code}

-- 1: Under which conditions does [x | x <- xs,y <- ys] == [x | y <- ys,x <- xs] hold?

xs = []
xs = [x,x..]
ys = []
|xs| = 1 [1..|ys|]


-- 2: define functions
\begin{code}
data Tree a = Nil | Node a (Tree a) (Tree a) deriving Show

repeatT :: a -> Tree a
repeatT x = Node x (repeatT x) (repeatT x)

takeT :: Int -> Tree a -> Tree a
takeT n _ | n <= 0    = Nil
takeT _ Nil           = Nil
takeT n (Node x l r)  = Node x (takeT (n-1) l) (takeT (n-1) r)

replicateT :: Int -> a -> Tree a
replicateT n = takeT n . repeatT
\end{code}

-- 3 - Traversal
\begin{code}
data Direction = L | R deriving Show

elementAt :: [Direction] -> Tree a -> Maybe a
elementAt _ Nil               = Nothing
elementAt [] Nil              = Just x
elementAt (L:xs) (Node _ l _) = elementAt xs l
elementAt (R:xs) (Node _ _ r) = elementAt xs r

modifyAt :: (a -> a) -> [Direction] -> Tree a -> Tree a
modifyAt _ _ Nil = Nil
modifyAt f [] (Node x l r)      = Node (f x) l r
modifyAt f (L:xs) (Node x l r)  = Node x (modifyAt f xs l) r
modifyAt f (R:xs) (Node x l r)  = Node x l (modifyAt f xs r)
\end{code}

-- 4 - toTree
\begin{code}
toTree :: [a] -> Tree a
toTree l = toTree' 0
  where
    toTree' n | n >= length l = Nil
              | otherwise     = Node (l !! n) (toTree' (2*n+1)) (toTree' (2*n+2))

toTreeL :: [a] -> Tree a
toTreeL []  = Nil
toTreeL l   = toTree' (level 0 l)
  where
    level :: Int -> [a] -> [[a]]
    level _ [] = []
    level n xs = take (n+1) xs : level (2*n+1) (drop (n+1) xs)

    left :: Int -> [[a]] -> [[a]]
    left _ []     = []
    left n (x:xs) = take (2^n `div` 2) x : left (n+1) xs

    right :: Int -> [[a]] -> [[a]]
    right _ []     = []
    right n (x:xs) = drop (2^n `div` 2) x : right (n+1) xs

    toTree' :: [[a]] -> Tree a
    toTree' ([x]:xs) = Node
      x
      (toTree' (left 1 xs))
      (toTree' (right 1 xs))
\end{code}


-- 5 - Interpreted language
\begin{code}
data Expression =
  Var String -- Variable
  | Val Int  -- Integer literal
  | Op Expression Bop Expression -- Operation

data Bop
  = Plus
  | Minus
  | Times
  | Divide
  | Gt | Ge | Lt | Le | Eql
  deriving (Show, Eq)

type State = String -> Maybe Int
\end{code}

-- Things to note: If Exp is Var, consult database(State) for its value.
-- Binary operators can only be used on two Ints (Right)
\begin{code}
{-
evalE :: State -> Expression -> Either String Int
evalE st (Var s) =
  case st s of
    Nothing -> Left ("Variable is not defined: " ++ shows s)
    Just state -> Right state
evalE _ (Val i)             = Right i
evalE st (Op exp1 op exp2)  =
  let
  res1 = evalE st exp1
  res2 = evalE st exp2
  in case (res1, res2) of
    (Right v1, Right v2)  -> Right (eval op v1 v2)
    (Left e1 _)           -> Left e1
    (_, Left e2)          -> Left e2
  where
    eval :: Bop -> Int -> Int -> Int
  -}
\end{code}




-- Example states:
\begin{code}
myState :: State
myState x = lookup x [
  ("Klaus Meer", error "Counted to infinity twice"),
  ("BoomBox", 5*10^6)]


anotherState :: State
anotherState "Bjarne Toft" = Just 42
anotherState "test" = Just 1
anotherState _      = Nothing
\end{code}
