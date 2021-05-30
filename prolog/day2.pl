% factorial

% base case
factorial(1, 1).

% recursive case, with positive N check to prevent ; or a from overflowing
factorial(Result, N) :- N > 0, K is N - 1, factorial(Subresult, K), Result is Subresult * N.

% fibonacci

% base cases
fib(1, 0).
fib(1, 1).

% recursive case, with non-base case check to prevent ; or a from overflowing
fib(Result, N) :- N > 1, N1 is N-1, N2 is N-2, fib(Last, N1), fib(LastLast, N2), Result is Last + LastLast.

% list reversal

% base case
myReverse([], []).

% recursive call
myReverse(Result, [Head|Tail]) :- myReverse(Subresult, Tail), Result is [Tail, Head].

% smallest element in list

smallest(N, [N]).
smallest(Result, [Head|Tail]) :- smallest(Subresult, Tail), Subresult < Head, Result is Subresult.
smallest(Result, [Head|Tail]) :- smallest(Subresult, Tail), Subresult >= Head, Result is Head.