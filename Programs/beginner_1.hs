{-
1 - shift
====

Make a function which shifts a list n positions.

Examples:
    shift 1    [1,2,3,4] == [4,1,2,3]
    shift (-1) [1,2,3,4] == [2,3,4,1]

-}

shift :: Int -> [a] -> [a]
--shift n xs = undefined
shift 0 xs = xs
shift _ [] = []
shift n xs = snd (splitAt' n xs) ++ fst (splitAt' n xs) where
  splitAt' n xs = splitAt (n `mod` (length xs)) xs

{-
2 - inject
====

Make a function which injects an element at a specific position of a list

Examples:
    inject 0 'x' "abc" == "xabc"
    inject 1 'x' "abc" == "axbc"
    inject 2 'x' "abc" == "abxc"
-}

inject :: Int -> a -> [a] -> [a]
--inject i x xs = undefined
inject _ a [] = [a]
inject i a xs = fst split' ++ a : snd split' where
  split' = splitAt i xs

{-
2 - innerProd
====

Make a function which for two lists computes the inner product of the lists, i.e.

  innerProd [x1,x2,x3] [y1,y2,y3] == x1*y1 + x2*y2 + x3*y3

-}
innerProd :: (Num a) => [a] -> [a] -> a
innerProd xs ys = foldr (\t s -> s + (fst t) * (snd t)) 0 (zip xs ys)

{-
3 - outerProd
====

Make a function which for two lists computes the outer product of the lists, i.e.

  outerProd [x1,x2,x3] [y1,y2,y3,y4] == [[x1*y1, x1*y2, x1*y3, x1*y4],
                                         [x2*y1, x2*y2, x2*y3, x2*y4],
                                         [x3*y1, x3*y2, x3*y3, x3*y4]]
-}

outerProd :: (Num a) => [a] -> [a] -> [[a]]
outerProd xs ys = [[x * y | y <- ys] | x <- xs]

{-
4 - chop
====

Make a function which chops a list into lists of equal length, except for the last list i.e.

  chop 3 [1,2,3,4,5,6,7,8,9,10] == [[1,2,3], [4,5,6], [7,8,9], [10]]


-}
chop :: Int -> [a] -> [[a]]
chop _ [] = []
chop n xs = take n xs : chop n (drop n xs)

{-
5 - sumLists
====

Make a function which sums a list of lists i.e.

  sumLists [[1,2,3], [4,5,6], [7,8,9], [10]] == [1+4+7+10, 2+5+8, 3+6+9]

-}
sumLists :: (Num a) =>  [[a]] -> [a]
sumLists xxs = undefined



{-
6 - digits
====

Make a function which returns the digits of a number in reverse order, i.e.

Example:

  digits 1337 == [7,3,3,1]

-}
digits :: (Integral a) => a -> [a]
digits n = undefined



{-
7 - insertDecr
====

Make a function which inserts an element in the correct position of a decreasing list

Example:
    insertDecr 5 [8,6,3] == [8,6,5,3]
-}
insertDecr :: (Ord a) => a -> [a] -> [a]
insertDecr x xs = undefined

{-
8 - sortedDecr
====

Makes a function which detects if a list is sorted in decreasing order
-}
sortedDecr :: (Ord a) => [a] -> Bool
sortedDecr xs = undefined
