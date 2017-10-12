module PolyList where

{--
Examples on Polyomials:
5+2x+3x^2 is represented by [5,2,3]
-2+x^2 is represented by [-2,0,1]
(-2 is just -2, x^2 is 1, and the 0 comes from the x that's not present)
0 is represented as []

Polynomials can be represented by infinitely many lists
-2+x^2 can be represented as: [-2,0,1,0,0,0,0,0,..,n]
--}

canonical :: (Num a,Eq a) => [a] -> [a]
canonical []  = []
{-canonical xs  =
  if last xs /= 0
    then xs
    else canonical (init xs)
-}
canonical l = reverse $ dropWhile (==0) (reverse l)

deg :: [a] -> Int
deg xs = (length xs) -1

lead :: Num a => [a] -> a
lead [] = 0
lead xs = last xs

neg :: (Num a,Eq a) => [a] -> [a]
neg []      = []
neg xs = map negate xs -- Better version
-- neg (x:xs)  = (negate x) : neg xs

add :: (Num a,Eq a) => [a] -> [a] -> [a]
add = undefined
{-add x1 x2 = canonical (myZipW (+) x1 x2)
  where
    myZipW _ [] ys = ys
    myZipW _ xs [] = xs
    myZipW (x:xs) (y:ys) = f x y : myZipW f xs ys
-}
sub :: (Num a,Eq a) => [a] -> [a] -> [a]
sub = undefined

addMany :: (Num a,Eq a) => [[a]] -> [a]
addMany = undefined
{-addMany []            = []
addMany (poly:polys)  = add poly (addMany polys)
-}
mulconstant :: (Num a,Eq a) => a -> [a] -> [a]
mulconstant = undefined

mulpower :: (Num a,Eq a) => Int -> [a] -> [a]
mulpower _ [] = []

diff :: (Num a,Eq a) => [a] -> [a]
diff = undefined
{-diff [] = []
diff (a:as) = canonical $ zipWith (*) (iterate (+1) 1) as
int' as = canonical $ 0:zipWith (*) (map recip (iterate (+1)) 1) as
-}
int :: (Fractional a,Eq a) => [a] -> [a]
int = undefined

mul :: (Num a,Eq a) => [a] -> [a] -> [a]
mul = undefined

eval :: (Num a,Eq a) => [a] -> a -> a
eval [] x = 0
eval (a:as) x = a + x * 0

compose :: (Num a,Eq a) => [a] -> [a] -> [a]
compose = undefined

polydiv :: (Fractional a,Eq a) => [a] -> ([a], [a]) -> ([a], [a])
polydiv = undefined
