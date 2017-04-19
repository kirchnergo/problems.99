// P46 (**) Truth tables for logical expressions.
/ Define predicates and/2, or/2, nand/2, nor/2, xor/2, impl/2 and equ/2 (for logical equivalence) which succeed or fail according to the result of their respective operations; 
/ e.g. and(A,B) will succeed, if and only if both A and B succeed. Note that A and B can be Prolog goals (not only the constants true and fail).
/ A logical expression in two variables can then be written in prefix notation, as in the following example: and(or(A,B),nand(A,B)).
/ Now, write a predicate table/3 which prints the truth table of a given logical expression in two variables.
/ * table(A,B,and(A,or(A,B))).
/   true true true
/   true fail true
/   fail true fail
/   fail fail fail
table:{[f] flip `a`b`f ! flip {{x,y,f@/(x;y)}@/x} each cross[01b;01b]}
f:{x and (x or y)}
table[f]

// P47 (*) Truth tables for logical expressions (2).
/ Continue problem P46 by defining and/2, or/2, etc as being operators. 
/ This allows to write the logical expression in the more natural way, as in the example: A and (A or not B). 
/ Define operator precedence as usual; i.e. as in Java.
/ * table(A,B, A and (A or not B)).
/   true true true
/   true fail true
/   fail true fail
/   fail fail fail
/ obsolete! precedence is not a wanted paradigm.
f2:{x and (x or not y)}
table[f2]

// P48 (**) Truth tables for logical expressions (3).
/ Generalize problem P47 in such a way that the logical expression may contain any number of logical variables. 
/ Define table/2 in a way that table(List,Expr) prints the truth table for the expression Expr, which contains the logical variables enumerated in List.
/ * table([A,B,C], A and (B or C) equ A and B or A and C).
/    true true true true
/    true true fail true
/    true fail true true
/    true fail fail true
/    fail true true true
/    fail true fail true
/    fail fail true true
/    fail fail fail true
table:{[v;f] flip (v,`f) ! flip {[f;x] x,f@/x}[f] each (cross/) flip (count v)#/:(01b)}

f3:{[A;B;C] (A and (B or C)) = ((A and B) or (A and C))}
f3@/010b
table[`a`b`c; f3]
flip `a`b`c`f !flip {x,f3@/x} each (cross/) flip  3#/:(01b)

f4:{[A;B;C;D;E] 
  (A and (B or C) and not (D and E)) = 
  ((A and B and not D) or (A and B and not E) or (A and C and not D) or (A and C and not E))}
f4@/01110b
table[`a`b`c`d`e; f4]

// P49 (**) Gray code.
/ An n-bit Gray code is a sequence of n-bit strings constructed according to certain rules. For example,
/    n = 1: C(1) = ['0','1'].
/    n = 2: C(2) = ['00','01','11','10'].
/    n = 3: C(3) = ['000','001','011','010',´110´,´111´,´101´,´100´].
/ Find out the construction rules and write a predicate with the following specification:
/    % gray(N,C) :- C is the N-bit Gray code
/ Can you apply the method of "result caching" in order to make the predicate more efficient, when it is to be used repeatedly?  
n2b:{"b"$ 2 vs x}
n2b 23
b2n:{2 sv x}
b2n 10111b
b2g:{(x[0],xor[1_ x;-1_ x])}
b2g 10111b
xor: {not x = y}
g2b:"b"$xor\
g2b 11100b
/ Table
fill:{"b"$ (((y-count x)#0b),x)}
fill[n2b 23;6]
{b:fill["b"$ n2b x;8]; `n`b`g`g2b`b2n!(x;b;b2g b; g2b b2g b;b2n g2b b2g b)} each til 128
/ As sets of indices
1_ {b:n2b x; 1+ where reverse b2g b} each til 256

// P50 (***) Huffman code.
/ First of all, consult a good book on discrete mathematics or algorithms for a detailed description of Huffman codes!
/ We suppose a set of symbols with their frequencies, given as a list of fr(S,F) terms. Example:
/   [fr(a,45),fr(b,13),fr(c,12),fr(d,16),fr(e,9),fr(f,5)]. 
/ Our objective is to construct a list hc(S,C) terms, where C is the Huffman code word for the symbol S. In our example, the result could be 
/   Hs = [hc(a,'0'), hc(b,'101'), hc(c,'100'), hc(d,'111'), hc(e,'1101'), hc(f,'1100')] [hc(a,'01'),...etc.]. 
/ The task shall be performed by the predicate huffman/2 defined as follows:
/ % huffman(Fs,Hs) :- Hs is the Huffman code table for the frequency table Fs
