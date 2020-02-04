:-use_module(library(clpfd)).

seatdown(L, N, Seats1, Seats2):-
    length(L, NPersons),
	length(Seats1, NPersons), length(Seats2, NPersons), 
	domain(Seats1, 1, NPersons), domain(Seats2, 1, NPersons),
	%
	all_distinct(Seats1), all_distinct(Seats2),
    checkAllPairs(N, Seats1, Seats2),

    %
	append(Seats1, Seats2, Seats),
	labeling([], Seats),
	%
	show_seats(L, N, Seats1), nl, 
	show_seats(L, N, Seats2), nl.




checkAllPairs(N,Seats1, Seats2):-
	length(Row, N), append(Row, SeatsSufix, Seats1),
	!,
    write('passou'), nl,
    checkPairAgainstAllRows(N, Row, Seats2),
	checkAllPairs(N, SeatsSufix, Seats2).
    
checkAllPairs(N, Seats1, Seats2):- 
    checkPairAgainstAllRows(N, Seats1, Seats2).


checkPairAgainstAllRows(N,Seats1, Seats2):-
	length(Row, N), append(Row, SeatsSufix, Seats2),
	!,
    write(Seats1), nl,
    write(Row), nl,
    compare(Seats1, Row),
	checkPairAgainstAllRows(N, Seats1, SeatsSufix).
    
checkPairAgainstAllRows(_, Seats1, Seats2) :-
    compare(Seats1, Seats2).
    
compareAll([], _).

compareAll([H1|Tail], H2) :-
compare(H1, H2),
compareAll(Tail, H2).

/* Not working correctly */
compare(_, _, []).
compare(Result, H1, [H2|Tail]) :- 
    H1 #\= H2 #<=> Result2,
    Result2 #< Result, 

    !, compare(Result2, H1, Tail).


% teacher predicate for printing to the screen
show_seats(Ppl,N,Seats):-
	length(Row, N), append(Row, SeatsSufix, Seats),
	!,
	write_people(Ppl, Row),
	show_seats(Ppl, N, SeatsSufix).
show_seats(Ppl, _, Seats):-write_people(Ppl, Seats).

write_people(Ppl, List):-
	get_ppl(Ppl, List, ListPpl), write(ListPpl), nl.
	
get_ppl(_, [], []).
get_ppl(L, [X|Xs], [P|Ps]):-
	nth1(X,L,P),
	get_ppl(L,Xs,Ps).