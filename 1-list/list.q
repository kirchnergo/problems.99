/// 1 Lists

// P01: Find the last box of a list
/ *(my-last '(a b c d))
/  (d)
last `a`b`c`d

// P02: Find the last but one box of a list
/ *(my-but-last '(a b c d))
/  (c)
first -2#`a`b`c`d

// P03: Find the kth element of a list
/  The first element in the list is number 1.
/ *(element-at '(a b c d e) 3)
/  c
nth:{x[y-1]}
nth[`a`b`c`d`e;3]

// P04: Find the number of elements of a list
count `a`b`c`d`e

// P05: Reverse a list
reverse `a`b`c`d`e

// P06: Find out whether a list is a palindrome
/ A palindrome can be read forward or backward; e.g. (x a m a x).
pal:{x ~ reverse x}
pal "xamax"
pal 1 2 3 2 3

// P07: Flatten a nested list structure
/ Transform a list, possibly holding lists as elements into a ‘flat’ list by replacing each list with its elements (recursively).
/ *(my-flatten '(a (b (c d) e)))
/  (A B C D E)
flatten:{$[(count x)~count raze x;:x;flatten raze x]};
/ Flatten an empty list
flatten ()
/ Flatten a nested list
flatten ((1;2;3);(1;(2;(3;4)));(1;2))
/ Flatten a nested general list
flatten ((1;2h;3j);("a";(`b;(`c;`d)));(1.23;4.56e))

// P08: Eliminate consecutive duplicates of list elements
/ If a list contains repeated elements they should be replaced with a single copy of the element. The order of the elements should not be changed.
/ *(compress '(a a a a b c c a a d e e e e))
/  (A B C A D E)
compress:{x where differ x}
/ Compress an empty list
compress ()
/ Compress a single-element list
compress enlist `a
/ Compress a list
compress 1 1 1 1 2 2 1 2 3 3 2 2 1

// P09: Pack consecutive duplicates of list elements into sublists
/ If a list contains repeated elements they should be placed in separate sublists.
/ *(pack '(a a a a b c c a a d e e e e))
/  ((A A A A) (B) (C C) (A A) (D) (E E E E))
pack:{(where differ x) cut x};
/ Pack an empty list
pack ()
/ Pack a single-element list
pack enlist `a
/ Pack a list
pack 1 1 1 1 2 2 1 2 3 3 2 2 1

// P10: Run-length encoding of a list
/ *(encode '(a a a a b c c a a d e e e e))
/  ((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))
encode:{c:where differ x; (deltas 1_c,count x) ,' x c};
/ Encode an empty list
encode ()
/ Encode a single-element list
encode enlist `a
/ Encode a list
encode `a`a`a`a`b`c`c`a`a`d`e`e`e`e

// P11: Modified run-length encoding
/ Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.
/ Example
/ *(encode-modified'(a a a a b c c a a d e e e e))
/  ((4 A) B (2 C) (2 A) D (4 E))
encodeMod:{
    c:where differ x;
    enc:(deltas 1_c,count x) ,' x c;
    {$[1~first x;last x;x]} each enc }

/Encode an empty list
encodeMod ()
/ Encode a single-element list
encodeMod enlist `a
/ Encode a list
encodeMod `a`a`a`a`b`c`c`a`a`d`e`e`e`e

// P12: Decode a run-length encoded list
/ Given a run-length code list generated as specified in problem P11. Construct its uncompressed version.
decode:{raze {$[1~count x; x; (first x)#last x]} each x}
/ Decode an empty list
decode ()
/ Decode a single-element list
decode enlist `a
/ Decode a list encoded with encode-modified function
l:`a`a`a`a`b`c`c`a`a`d`e`e`e`e
l ~ decode encodeMod l
/ Decode a list encoded with encode function
l ~ decode encode l

// P13: Run-length encoding of a list (direct solution)
/ obsolete

// P14: Duplicate the elements of a list
/ * (dupli '(a b c c d))
/   (A A B B C C C C D D)
dupli:{:raze 2#/:x}
/ Duplicate a single element
dupli `a
`a`a
/ Duplicate a list
dupli `a`b`c`c`d
dupli each `a`b`c`c`d
dupli (enlist "cat"; enlist "dog")

// P15: Replicate the elements of a list a given number of times
/ * (repli '(a b c) 3)
/   (A A A B B B C C C)
repli:{:raze x#/:y}
/ Replicate a single element
repli[3] `a
/ Replicate a list
repli[3] `a`b`c
repli[3] each `a`b`c
repli[3] (enlist "cat";enlist "dog")

// P16: Drop every N’th element from a list
/ * (drop '(a b c d e f g h i k) 3)
/   (A B D E G H K)
drop:{y where (count y)#((x-1)#1b),0b}
/ Drop an element from an empty list
drop[5] ()
/ Drop an element from a list
drop[3] enlist `a
drop[3] `a`b`c`d`e`f`g`h`i`j
drop[2] "abcdefghij"

// P17: Split a list into two parts; the length of the first part is given
/ * (split '(a b c d e f g h i k) 3)
/   ( (A B C) (D E F G H I K))
split:{(0;y)_x}
0 3_`a`b`c`d`e`f`g`h`i`k
split[`a`b`c`d`e`f`g`h`i`k;3]
split[til 20;7]

// P18: Extract a slice from a list
/ Given two indices, I and K, the slice is the list containing the elements between the I’th and K’th element of the original list (both limits included). Start counting the elements with 1.
/ * (slice '(a b c d e f g h i k) 3 7)
/   (C D E F G)
slice:{(y-1)_(z - count x)_x}
first (2 7_`a`b`c`d`e`f`g`h`i`k)
slice[`a`b`c`d`e`f`g`h`i`k;3;7]
l:til 100000
slice[l;3;7]
\t do[100000;slice[l;3;7]]

// P19: Rotate a list N places to the left
/ * (rotate '(a b c d e f g h) 3)
/   (D E F G H A B C)
/ * (rotate '(a b c d e f g h) -2)
/   (G H A B C D E F)
3 rotate `a`b`c`d`e`f`g`h
-2 rotate `a`b`c`d`e`f`g`h

//  P20: Remove the K’th element from a list
/ * (remove-at '(a b c d) 2)
/   (A C D)
`a`b`c`d _ 1
