/*optimal_skating_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs)*/

optimal_skating_pairs(MenHeights, WomenHeights, Delta, Pairs) :-

doPairs(1, MenHeights, WomenHeights, Pairs, Delta),
getGirlsOut(Pairs, GirlsOut),

all_distinct(GirlsOut),

length(GirlsOut, N),

labeling([maximize(N)], GirlsOut).







getGirlsOut([], []).

getGirlsOut([_-IndexWomen | Tail], [IndexWomen | TailIndexWomen]) :-
    getGirlsOut(Tail, TailIndexWomen).


doPairs(_, [], _, [], _).

doPairs(Counter, [HightMen | TailMen], WomenHeights, [IndexMen-IndexWomen | Tail], Delta) :-
IndexMen = Counter,
element(IndexWomen, WomenHeights, HightWomen),

HightMen #>= HightWomen #/\ (HightMen - HightWomen #< Delta),

NewCounter is Counter + 1,

doPairs(NewCounter, TailMen, WomenHeights, Tail, Delta).

doPairs(Counter, [_ | TailMen], WomenHeights, Pairs, Delta) :-
    NewCounter is Counter + 1,

    doPairs(NewCounter, TailMen, WomenHeights, Pairs, Delta).