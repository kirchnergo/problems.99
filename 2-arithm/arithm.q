// P31: Determine whether a given integer number is prime
/* (is-prime 7)
/  T
isPrime:{if[x = 1; :0b]; if[x = 2; :1b]; $[0=x mod 2; :0b ; min 0 <> x mod 2 + til floor sqrt x]}
/ Examples
isPrime 1
isPrime 7
isPrime 2^33 - 1
\t where isPrime each til 100000

// P32: Determine the greatest common divisor of two positive integer numbers
/ Use Euclidean algorithm.
/ * (gcd 36 63)
/   9
gcd:{[x;y] $[0~y; :x; .z.s[y;x mod y]] }
gcd[36;63]
gcd[123456789;987654321]
\t do[100000;gcd[123456789;987654321]]

