This document will contain elements from the book:
Learn You a Haskell for Great Good!.

Functions are rather simple:

\begin{code}
doubleSmallNumber x = if x > 100
  then x
  else x*2
\end{code}

\begin{code}
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1
\end{code}

The " ' " character is valid to denote function names.

\begin{code}
lostNumbers = [4,8,15,16,23,42]
\end{code}

To create functions within GHCI, simply add " let " infront of the function.

\begin{code}
a = [1,2,3,4]
b = [9,10,11,12]
\end{code}

To add the list together, use " ++ ".

Lists have many uses, but there's complications when working with large lists.
Example: A list with a millionth entry, will take a while to go through to add an element.
You can however add an element to the first index with " : ".

\begin{code}
c = 5:[1,2,3,4,5]
\end{code}

[1,2,3] is actually just syntactic sugar for 1:2:3:[]. [] is an empty list.
If we prepend 3 to it, it becomes [3]. If we prepend 2 to that, it becomes [2,3], and so on.

If you however want a specific element out of its index location, you can use " !! ".

\begin{code}
d = [9.4,33.2,96.2,11.2,23.25] !! 1
\end{code}

This will take the element at the index location 1 out of the list and return it.
Basic, but important functions for working on lists:

head: takes a list and returns its head. The head of a list is basically its first element.
\begin{code}
h = head [5,4,3,2,1]
\end{code}

tail: takes a list and returns its tail. In other words, it chops off a list's head.
\begin{code}
t = tail [5,4,3,2,1]
\end{code}

last: takes a list and returns its last element.
\begin{code}
l = last [5,4,3,2,1]
\end{code}

init: takes a list and returns everything except its last element.
\begin{code}
i = init [5,4,3,2,1]
\end{code}

length: takes a list and returns its length, obviously.
\begin{code}
l' = length [5,4,3,2,1]
\end{code}

null: checks if a list is empty. If it is, it returns True, otherwise it returns False.
Use this function instead of xs == [] (if you have a list called xs)
\begin{code}
n = null [1,2,3]
n' = null []
\end{code}

reverse: reverses a list.
\begin{code}
r = reverse [5,4,3,2,1]
\end{code}

take: takes number and a list. It extracts that many elements from the beginning of the list.
Watch: See how if we try to take more elements than there are in the list, it just returns the list.
If we try to take 0 elements, we get an empty list.
\begin{code}
t' = take 3 [5,4,3,2,1]
t'' = take 1 [3,9,3]
t''' = take 5 [1,2]
t'''' = take 0 [6,6,6]
\end{code}

drop: works in a similar way, only it drops the number of elements from the beginning of a list.
\begin{code}
d' = drop 3 [8,4,2,1,5,6]
d'' = drop 0 [1,2,3,4]
d''' = drop 100 [1,2,3,4]
\end{code}

maximum: takes a list of stuff that can be put in some kind of order and returns the biggest element.
\begin{code}
m = maximum [1,2,3,4,5,66,3,1,24,6]
\end{code}

minimum:returns the smallest.
\begin{code}
m' = minimum [1,2,3,4,5,66,3,1,24,6]
\end{code}

sum: takes a list of numbers and returns their sum.
\begin{code}
s = sum [1,2,3,4,5,66,3,1,24,6]
\end{code}

product: takes a list of numbers and returns their product.
\begin{code}
p = product [6,2,1,2]
p' = product [1,2,5,6,7,9,2,0]
\end{code}

elem: takes a thing and a list of things and tells us if that thing is an element of the list.
It's usually called as an infix function because it's easier to read that way.
\begin{code}
e = elem 4 [1,2,3,4]
e' = elem 42 [1,2,3,4]
\end{code}

--------------------------------------------------------------------------------

If need be, you can auto-complete a set length of a list:

\begin{code}
texList = [1..2]
\end{code}

This will generate a list with the elements ranging from 1 to 20.
Can also be generated in numerous ways:

\begin{code}
texList' = [2,4..20]
\end{code}

This will generate a list with the elements ranging from 2 to 20, with a jump each 2nd element.

You can also use ranges to make infinite lists by just not specifying an upper limit.
Later we'll go into more detail on infinite lists.
For now, let's examine how you would get the first 24 multiples of 13.
Sure, you could do [13,26..24*13]. But there's a better way: take 24 [13,26..].
Because Haskell is lazy, it won't try to evaluate the infinite list immediately,
because it would never finish.
It'll wait to see what you want to get out of that infinite lists.
And here it sees you just want the first 24 elements and it gladly obliges.

\begin{code}
texList'' = take 24 [13,26..]
\end{code}
