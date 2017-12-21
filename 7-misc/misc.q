// 90 Eight queens problem
perms1:{[N;l] $[N=1;l;raze .z.s[N-1;l]{x,/:y except x}\:l]}
perms:{[l] perms1[count l; l]}
perms til 4

// 91 Knight's tour

// 92 Von Koch's conjecture

// 93 An arithmetic puzzle

// 94 Generate K-regular simple graphs with N nodes

// 95 English number words

// 96 Syntax checker

// 97 Sudoku

t:"200370009009200007001004002050000800008000900006000040900100500800007600400089001"
value each (((9* til "j"$(count t) %9) _ t))

/ translation to q
P,:3 sv floor(P:9 vs til 81)%3
P
S:{first(enlist x)(raze@{@[x;y;:;] each where 21=x[where (or) over P[;y]=P]?til 10}')/where not x}

/ some Sudoku puzzles
puz:(value each "200370009","009200007","001004002","050000800","008000900","006000040","900100500","800007600","400089001";
     value each "070000003","100200800","050087000","009001000","200604001","000700400","000310090","004005008","700000050")

solve:{-1"puzzle";show 9 9#y;-1"solution";show 9 9#x[y];S[y]~x y}
solve[S;] each puz
solve[S;] puz 0
solve[S;] puz 1

/R:flip{(group x)x}each R,enlist 3 sv(R:asc scan 81#til 9) div 3
/R
/F:{$[81=i:x?0; enlist x; raze R each i@[x;;:;]' where 27=x[raze R i]?til 10]}
/all solve[F;] each puz

// 98 Nonograms

// 99 Crossword puzzle 
