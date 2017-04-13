/// 1 Lists

// P01:

// P06: Find out whether a list is a palindrome
pal:{x ~ reverse x}

pal "xamax"
pal 1 2 3 2 3

// P07: Flatten a nested list structure
flatten:{$[(count x)~count raze x;:x;flatten raze x]};

/ Flatten an empty list
flatten ()
/ Flatten a nested list
flatten ((1;2;3);(1;(2;(3;4)));(1;2))
/ Flatten a nested general list
flatten ((1;2h;3j);("a";(`b;(`c;`d)));(1.23;4.56e))

// P08: Eliminate consecutive duplicates of list elements
compress:{x where differ x}

/ Compress an empty list
compress ()
/ Compress a single-element list
compress enlist `a
/ Compress a list
compress 1 1 1 1 2 2 1 2 3 3 2 2 1

// P09: Pack consecutive duplicates of list elements into sublists
pack:{(where differ x) cut x};

/ Pack an empty list
pack ()
/ Pack a single-element list
pack enlist `a
/ Pack a list
pack 1 1 1 1 2 2 1 2 3 3 2 2 1

// P10: Run-length encoding of a list
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
    :{$[1~first x;:last x;:x]} each enc }

/Encode an empty list
encodeMod ()
/ Encode a single-element list
encodeMod enlist `a
/ Encode a list
encodeMod `a`a`a`a`b`c`c`a`a`d`e`e`e`e