%fibonacci(N, valor).

fibonacci(0, 1).
fibonacci(1, 1).

fibonacci(N, Valor) :-
N > 1,
N1 is N-1, fibonacci(N1, Y1),
N2 is N-2, fibonacci(N2, Y2),
Valor is Y2 + Y1.
