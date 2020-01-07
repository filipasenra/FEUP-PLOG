/*sweet_recipes(+MaxTime,+NEggs,+RecipeTimes,+RecipeEggs,-Cookings,-Eggs)*/

sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-

length(Cookings, 3),

/*Domain of Cookings*/
length(RecipeTimes, Len), 
domain(Cookings, 1, Len),

/*Cookings Must be Distinct*/
all_distinct(Cookings),

/* Get a List with the RecipeTimes Choosen and restrict the sum of them to be less than the time given*/
getListWithX(RecipeTimes, Cookings, TimePerRecipe),
sum(TimePerRecipe, #=<, MaxTime),


/* Get a List with the Eggs Per Recipe Choosen and restrict the sum of them to be less than the eggs given*/
getListWithX(RecipeEggs, Cookings, NEggsPerRecipe),
sum(NEggsPerRecipe, #=, Eggs),
Eggs #=< NEggs,

labeling([maximize(Eggs)], Cookings).

/*===============================*/

getListWithX(_, [], []).

getListWithX(RecipeX, [Cookings | Tail], [NewList | TailNewList]) :-
element(Cookings, RecipeX, NewList),
getListWithX(RecipeX, Tail, TailNewList).





