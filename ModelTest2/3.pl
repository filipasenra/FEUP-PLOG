:- use_module(library(clpfd)).

p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    %
    list_to_fdset(L1, FD_Set),
    makeDomain(FD_Set, L2),
    all_distinct(L2),
    test(L2),
    %
    labeling([],L2).

makeDomain(_, []).

makeDomain(FD_Set, [Head | Tail]) :-
Head in_set FD_Set,
makeDomain(FD_Set, Tail).

test([_,_]).
test([X1,X2,X3|Xs]) :-
    ((X1 #< X2 #/\ X2 #> X3) #\/ (X1 #> X2 #/\ X2 #< X3)),
    test([X2,X3|Xs]).