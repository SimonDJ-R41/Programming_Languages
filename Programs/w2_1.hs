import Data.List -- Mostly for sorting
main :: IO ()
main = undefined

-- RECAP: TYPES AND TYPECLASSES --
-- Why write function types explicitly?

-- Suggest the types of following functions:

timesTwo :: Num a => a -> a
timesTwo n = n * 2

half :: Integral a => a -> a
half n = n `div` 2

thrice :: (t -> t) -> t -> t
thrice f x = f $ f $ f x
-- thrice f x = f (f (f x))

-- Some list functions from friday & list comprehension alts. (and zip)
dropZeros :: [Int] -> [Int]
dropZeros []       = []               -- Always do this when working on lists
dropZeros (0 : xs) = dropZeros xs
dropZeros (x : xs) = x : dropZeros xs

dropZeros' :: [Int] -> [Int]
dropZeros' l = [x | x <- l, x /= 0]

--

flatten :: [[a]] -> [a]
flatten []              = []
flatten ([] : xs)       = flatten xs
flatten ((x : xs) : ys) = x : flatten (xs:ys) -- xs->[a] ys->[[a]]

flatten' :: [[a]] -> [a]
flatten' l = [x | y <- l
                , x <- y]

--

twiceAll :: [a] -> [a]
twiceAll []      = []
twiceAll (x : xs) = x : x : twiceAll xs

twiceAll' :: [a] -> [a]
twiceAll' l = [x | x <- l
                 , _ <- [0,1]]

--

alternate :: [Int] -> [Int]
alternate [] = []
alternate (x : xs) = x : alternate' xs
  where
    alternate' [] = []
    alternate' (y : ys) = (-y) : alternate ys

alter :: [Int] -> [Int]
alter l = [f (x, y) | (x, y) <- zip l [0..length l]]
  where
    f (a, b) | even b    = a
             | otherwise = -a

--

replicateAll :: Int -> [a] -> [a]
replicateAll _ [] = []
replicateAll 0 _  = []
replicateAll n xs = replicateAll' n xs
  where
    replicateAll' :: Int -> [a] -> [a]
    replicateAll' _ [] = []
    replicateAll' 0 (_ : ys) = replicateAll' n ys
    replicateAll' k (y : ys) = y : replicateAll' (k-1) (y : ys)

replAll :: Int -> [a] -> [a]
replAll n l = [x | x <- l, _ <- [1..n]]

--

cumulativeSum :: [Int] -> [Int]
cumulativeSum [] = []
cumulativeSum (x : xs) = x : cumulativeSum' x xs
  where
    cumulativeSum' :: Int -> [Int] -> [Int]
    cumulativeSum' _ [] = []
    cumulativeSum' prevSum (y : ys) = prevSum + y : cumulativeSum' (y + prevSum) ys

cumuSum :: [Int] -> [Int]
cumuSum l = [sum $ take n l | (_, n) <- zip l [1..length l]]


-- Exercises for this week

-- Construct list of a's with length n
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n-1) x


-- Enumerate elements of list
zipIdx :: [a] -> [(a, Int)]
zipIdx [] = []
zipIdx list = zipIdx' 0 list
  where
    zipIdx' _ []          = []
    zipIdx' n (x:xs)      = (x, n) : zipIdx' (n+1) xs


-- Replace element at index
setIdx :: [a] -> Int -> a -> [a]
setIdx [] _ _ = []
setIdx (_:xs) 0 e = e : xs
setIdx (x:xs) n e = x : setIdx xs (n-1) e


-- Modify element at index
modIdx :: [a] -> Int -> (a -> a) -> [a]
modIdx = undefined


-- Eliminate duplicates
nubEq :: Eq a => [a] -> [a]
nubEq []     = []
nubEq (x:xs) = x : nubEq [y | y <- xs, x /= y]


nubOrd :: Ord a => [a] -> [a]
nubOrd [] = []
nubOrd list = nubOrd' (sort list)
  where
    nubOrd' []        = []
    nubOrd' [x]       = [x]
    nubOrd' (x:y:xs)
      | x == y        = nubOrd' (y:xs)
      | otherwise     = x : nubOrd' (y:xs)

-- Count occurences of element in list
-- Example: List[1,2,3,4,1] --> [(1,2), (2,1), (3,1), (4,1)]
elemCountsEq :: Eq a => [a] -> [(a, Int)]
elemCountsEq [] = []
elemCountsEq l@(x:_) = (x, length getEq) : elemCountsEq getNEq
  where
    getEq = [y | y <- l, y == x]
    getNEq = [y | y <- l, y /= x]

elemCountsOrd :: Ord a => [a] -> [(a, Int)]
elemCountsOrd []      = []
elemCountsOrd list    = elemCountsOrd' (first, 1) rest
  where
    (first:rest)                       = sort list
    elemCountsOrd' (e, occ) []         = [(e, occ)]
    elemCountsOrd' (e, occ) (x:xs)
                           | e == x    = elemCountsOrd' (e, occ+1) xs
                           | otherwise = (e, occ) : elemCountsOrd' (x, 1) xs

-- Replicate Int a
fromElemCounts :: [(a, Int)] -> [a]
fromElemCounts []             = []
fromElemCounts ((x, n) : xs)  = replicate n x ++ fromElemCounts xs

-- Probability distributions
type Dist a = [(a, Double)]

--Heads -> 0.5
--Tails -> 0.5

-- Each element has same probability
uniformly :: [a] -> Dist a
uniformly [] = []
uniformly l = zip l [1/(length l)..]

-- Probability based on occurences of each element
uniformlyEq :: Eq a => [a] -> Dist a
uniformlyEq = undefined

uniformlyOrd :: Ord a => [a] -> Dist a
uniformlyOrd = undefined


-- Join Distributions
joinDists :: Dist a -> Dist b -> Dist (a, b)
joinDists = undefined


flattenDist :: Dist (Dist a) -> Dist a
flattenDist = undefined
