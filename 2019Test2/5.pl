
/*
K = People
N = presents
For K = 2 and N = 2,
pres(N, K, Vars).
Vars = [2, 1].
Then binary matrix will be:
Binary_Matrix = [
    [0, 1], % person 1
    [1, 0]  % person 2
]
*/
:- use_module(library(lists)).
:- use_module(library(clpfd)).

pres(N, K, Vars, Bin):-
    length(Vars, N),
    domain(Vars, 1, K),
    %
    indices(1, Vars),
    constroi_binarias(1, K, Vars, Bin),
    %
    labeling([], Vars).
    
indices(I, [V | Vs]):-
    V mod 2 #\= I mod 2,
    I1 is I + 1,
    indices(I1, Vs).
indices(_, []).

constroi_binarias(I, K, Vars, [LBin | LBins]) :-
I =< K, !,
constroi_bins(I, Vars, LBin),
I1 is I + 1,
constroi_binarias(I1, K, Vars, LBins).

constroi_binarias(_, _, _, []).


/* RESPOSTA */
constroi_bins(_, [], []).

constroi_bins(I, [Vars | Tail], [LBin | LBinTail]) :-
    I #= Vars #<=> LBin,
    constroi_bins(I, Tail, LBinTail).
