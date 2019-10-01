%e_primo(N)

e_primo(2).
e_primo(3).

e_primo(N) :-
N > 3,
N mod 2 =\= 0,
\+divisible(N, 3).

%When is divisible
divisible(N, D) :- N mod D =:= 0.

%When is not divisible
divisible(N, D) :- 
%D + 1< N,
D * D < N,
divisible(N, D+1).
