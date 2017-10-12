This document contain the tasks for the course DM552.
Simon D. Jørgensen

Boolean functions
The concept of truth tables for a boolean function is well-known. Below, we
see the truth table of ∧ (AND).

andImpl :: Bool → Bool → Bool
andImpl False False = False
andImpl False True = False
andImpl True False = False
andImpl True True = True

We can shorten it using wildcards:

andImpl :: Bool → Bool → Bool
andImpl True True = True
andImpl = False

or

andImpl :: Bool → Bool → Bool
andImpl True a = a
andImpl _ _ = False

Task 1: Implement ¬ (NOT), ∨ (OR), ⊕ (XOR) and NAND using pattern
matching and wildcards:

\begin{code}
notImpl :: Bool -> Bool
orImpl :: Bool -> Bool -> Bool
xorImpl :: Bool -> Bool -> Bool
nandImpl :: Bool -> Bool -> Bool

notImpl True = False
notImpl _ = True

orImpl False False = False
orImpl _ _ = True

xorImpl True True = False
xorImpl False False = False
xorImpl _ _ = True

nandImpl True True = False
nandImpl _ _ = True
\end{code}

Task 2 - A few simple functions:
1. Define a function eeny that returns the string "eeny" for even inputs
– and "meeny" for odd inputs.

\begin{code}
eeny :: Integer -> String
eeny x =
  if mod x 2 == 0
    then "eeny"
    else "meeny"
\end{code}

2. Define a function fizzbuzz that returns "Fizz" for numbers divisible
by 3, "Buzz" for numbers divisible by 5, and "FizzBuzz" for numbers
divisible by both. For other numbers it returns the empty string.

\begin{code}
fizzbuzz :: Integer -> String
fizzbuzz x | mod x 3 == 0 && mod x 5 == 0 = "FizzBuzz"
           | mod x 3 == 0 = "Fizz"
           | mod x 5 == 0 = "Buzz"
           | otherwise = "Not divisable by either 3 or 5."
\end{code}

Task 3 - Recursive functions on integers:

The mathematial function:
gcd(a,b) =
a,                b = 0
OR
gcd(b, a mod b),  b > 0

Can be implemented in Haskell by:
gcd :: Integer → Integer → Integer
gcd a 0 = a
gcd a b = gcd b (a ‘mod‘ b)

1. The sum of all numbers up to n can be defined using recursion:
S(n) =
0,          n = 0
n + S(n-1), n > 0

Implement a function sumTo :: Integer → Integer in Haskell, which
implements this definition.

\begin{code}
sumTo :: Integer -> Integer
sumTo 0 = 0
sumTo n = if n > 0
  then n + sumTo (n-1)
  else error "sumTo only accepts positive integers!"
\end{code}

This function will, if requirements are met, recursively add the input to itself, after reducing by 1.
Example, 5 -> 5 + 4 + 3 + 2 + 1 = 15
When 0 hits, the recursion will stop.

2. Binomial coefficients can be defined using recursion:

B(n, k) =
B(n-1, k) + B(n-1k-1),   1 <= k <= n - 1
1,                       k = 0 && k = n
0,                       k < 0 && k > n

Implement a function binomial :: Integer → Integer → Integer in
Haskell, which implements this definition.

\begin{code}
binomial :: Integer -> Integer -> Integer
binomial _ 0 = 1
binomial n k  | k == n                = 1
              | k < 0                 = 0
              | k > n                 = 0
              | 1 <= k && n - 1 <= k  = binomial(n-1) k + binomial (n-1) (k-1)
\end{code}

3. Use recursion to define a function power ::Integer → Integer → Integer.
power n k should compute n**k.



4. Use recursion to define a function ilog2 :: Integer → Integer. ilog2 n
should be the number of times you can halve the integer n (rounding
down) before you get 1.
