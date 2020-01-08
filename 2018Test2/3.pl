:- use_module(library(clpfd)).

prog2(N,M,L1,L2) :-
    length(L1,N),
    N1 is N-1, length(L2,N1),
    domain(L1,1,M),
    domain(L2,1,M),
    all_distinct(L1),
    check2(L1,L2),
    avoid_symmetry(L1),
    labeling([],L1).

check2([_],[]).

check2([A,B|R],[X|Xs]) :-
A+B #= X,
check2([B|R],Xs).

avoid_symmetry([_]).
avoid_symmetry([A, B | L2]):-
    A #=< B,
    avoid_symmetry([B | L2]).
