/*gym_pairs(+MenHeights,+WomenHeights,+Delta,-Pairs)*/

gym_pairs(MenHeights, WomenHeights, Delta, Pairs) :-
length(MenHeights, LenMen),

length(IndexWomen, LenMen),

doPairs(1, MenHeights, WomenHeights, IndexWomen, Delta),
all_distinct(IndexWomen),

labeling([], IndexWomen),

getCorrectOutput(1, IndexWomen, Pairs).




getCorrectOutput(_, [], []).

getCorrectOutput(Counter, [IndexWomen | TailIndexMan], [Pair | Tail]) :-
    Pair = Counter-IndexWomen,
    NewCounter is Counter + 1,
    getCorrectOutput(NewCounter, TailIndexMan, Tail).


doPairs(_, _, _, [], _).

doPairs(Counter, MenHeights, WomenHeights, [IndexWomen | Tail], Delta) :-
element(IndexWomen, WomenHeights, HightWomen),
element(Counter, MenHeights, HightMen),


HightMen #>= HightWomen #/\ (HightMen - HightWomen #=< Delta),

NewCounter is Counter + 1,

doPairs(NewCounter, MenHeights, WomenHeights, Tail, Delta).

