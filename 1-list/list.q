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

// P21: Insert an element at a given position into a list
/ * (insert-at 'alfa '(a b c d) 2)
/   (A ALFA B C D)
insertAt:{f:(0;z-1)_y; raze (first f),x,(last f)}
insertAt[`ALFA;`a`b`c`d`e`f`g`h;2]
insertAt[10;`a`b`c`d`e`f`g`h;6]

// P22: Create a list containing all integers within a given range
/ If first argument is smaller than second, produce a list in decreasing order.
/ * (range 4 9)
/   (4 5 6 7 8 9)
range:{$[x>y; reverse y+til x-y-1; x+til y-x-1]}
range[20;35]
range[35;20]

// P23: Extract a given number of randomly selected elements from a list
/ The selected items shall be returned in a list.
/ * (rnd-select '(a b c d e f g h) 3)
/   (E D A)
/ Non-unique elemenst
rndSelect:{y?x}
rndSelect[til 20;30]
rndSelect[`ekf`jef`col`faa`epl;8]
/ Unique elemenst
rndSelectU:{(neg y)?x}
rndSelectU[til 20;10]
rndSelectU[`ekf`jef`col`faa`epl;3]

// P24: Lotto: Draw N different random numbers from the set 1..M
/ The selected numbers shall be returned in a list.
/ * (lotto-select 6 49)
/   (23 1 17 33 21 37)
lottoSelect:{(neg x)?1+til y}
lottoSelect[5;20]
lottoSelect[6;49]

// P25: Generate a random permutation of the elements of a list
/ * (rnd-permu '(a b c d e f))
/   (B A D C E F)
rndPermu:{(neg count x)?x}
rndPermu[`a`b`c`d`e`f]
rndPermu[til 20]

// P26: Generate the combinations of K distinct objects chosen from the N elements of a list
/ In how many ways can a committee of 3 be chosen from a group of 12 people? 
/ We all know that there are C(12,3) = 220 possibilities (C(N,K) denotes the well-known binomial coefficients). 
/ For pure mathematicians, this result may be great. But we want to really generate all the possibilities in a list.
/ * (combination 3 '(a b c d e f))
/   ((A B C) (A B D) (A B E) ... )
comb0:{[n;k] if[n~k;:enlist til k]; $[1~k;:enlist each til n; :comb0[n-1;k],comb0[n-1;k-1],\:enlist n-1]}
comb:{x@comb0[count x; y]}
comb0[6;5]
comb[`a`b`c`d`e`f;5]
\ts do[1000; comb[`a`b`c`d`e`f;5]]
comb2["kdb+";2]
comb["kdb+";2]
\ts do[10; comb[til 20;10]]

// P27: Group the elements of a set into disjoint subsets
/ In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? 
/ Write a function that generates all the possibilities and returns them in a list.
/ * (group3 '(aldo beat carla david evi flip gary hugo ida))
/   ( ( (ALDO BEAT) (CARLA DAVID EVI) (FLIP GARY HUGO IDA) )
/   ... )
/ Generalize the above predicate in a way that we can specify a list of group sizes and the predicate will return a list of groups.
/ * (group '(aldo beat carla david evi flip gary hugo ida) '(2 2 5))
/   ( ( (ALDO BEAT) (CARLA DAVID) (EVI FLIP GARY HUGO IDA) )
/   ... )
/ Note that we do not want permutations of the group members; 
/ i.e. ((ALDO BEAT) …) is the same solution as ((BEAT ALDO) …). 
/ However, we make a difference between ((ALDO BEAT) (CARLA DAVID) …) and ((CARLA DAVID) (ALDO BEAT) …).
/ You may find more about this combinatorial problem in a good book on discrete mathematics under the term “multinomial coefficients“.

/ using comb0 function to generate combinations of K distinct objects chosen from N elements of a list. 
/ First the special case – 3 disjoint subgroups of 2, 3 and 4 elements:
group3:{[list]
  if[9<>count list;'"length";];
  tmp:list except/:s2:list comb0[count list;2];
  :raze (enlist each s2),/:'(enlist @/:'s3),''enlist@/:'tmp except/:'s3:tmp@\:comb0[count tmp[0];3]}
group3 `a`b`c`d`e`f`g`h`i
count group3 `a`b`c`d`e`f`g`h`i
count distinct group3 `a`b`c`d`e`f`g`h`i
/ Now the generalized version which is using recursion. 
/ groups - generates all the groups
/ subsets is a wrapper that adds one-time basic validation of parameters
groups:{[list;lengths]
  c:list comb0[count list;first lengths];
  if[2=count lengths;
    :flip ((),c;list except/:c);
    ];
  :raze (enlist each c),/:'.z.s ./:(enlist each list except/:c),\:enlist 1_lengths}
subsets:{[list;lengths]
  if[any not 0<lengths;'"type"];
  if[(c:count list)<>sum lengths;'"length"];
  if[all c=lengths;:list];
  :groups[list;lengths]}
subsets[`a`b`c`d`e`f`g`h`i;2 3 4]
count subsets[`a`b`c`d`e`f`g`h`i;2 3 4]
count distinct subsets[`a`b`c`d`e`f`g`h`i;2 3 4]
subsets[`a`b`c`d`e`f`g`h`i;2 2 5]
count subsets[`a`b`c`d`e`f`g`h`i;2 2 5]

//  P28: Sorting a list of lists according to length of sublists
/ We suppose that a list contains elements that are lists themselves. 
/ The objective is to sort the elements of this list according to their length. 
/ E.g. short lists first, longer lists later, or vice versa.
/ * (lsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
/   ((O) (D E) (D E) (M N) (A B C) (F G H) (I J K L))
/ Again, we suppose that a list contains elements that are lists themselves. 
/ But this time the objective is to sort the elements of this list according to their length frequency; 
/ i.e., in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.
/ * (lfsort '((a b c) (d e) (f g h) (d e) (i j k l) (m n) (o)))
/   ((i j k l) (o) (a b c) (f g h) (d e) (d e) (m n))
/ Note that in the above example, the first two lists in the result have length 4 and 1, both lengths appear just once. 
/ The third and forth list have length 3 which appears twice (there are two list of this length). 
/ And finally, the last three lists have length 2. This is the most frequent length.
lsort:{x@iasc count each x}
lsort (`a`b`c;`d`e;`f`g`h;`d`e;`i`j`k`l;`m`n;`o)
lfsort:{x raze a iasc count each a:group count each x};
lfsort (`a`b`c;`d`e;`f`g`h;`d`e;`i`j`k`l;`m`n;`o)
\ts do[100000; lfsort (`a`b`c;`d`e;`f`g`h;`d`e;`i`j`k`l;`m`n;`o)]
