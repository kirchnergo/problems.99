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
