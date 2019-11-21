%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').


%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).

%Question 1

madeItThrough(Participant) :-
performance(Participant, List),
loopmadeItThrough(List).

loopmadeItThrough([]) :- false.

loopmadeItThrough([Head | _]) :-
Head == 120.

loopmadeItThrough([_ | Tail]) :-
!,
loopmadeItThrough(Tail).

%Question 2
%juriTimes(+Participants, +JuriMember, -Times, -Total).

juriTimes(ListParticipants, JuriMember, Times, Total) :-
loopJuriTimes(ListParticipants, JuriMember, [], Times, Total).


sum([], OldTotal, OldTotal).

sum([Head | Tail], OldTotal, Total) :-
NewTotal is OldTotal + Head,
sum(Tail, NewTotal, Total).

loopJuriTimes([], _, OldTimes, OldTimes, Total) :-
sum(OldTimes, 0, Total).

loopJuriTimes([Head | Tail], JuriMember, OldTimes, Times, Total) :-
performance(Head, TimeList),
findTimeJuri(TimeList, JuriMember, TimeJuri),
append(OldTimes, [TimeJuri], NewTimes),
juriTimes(Tail, JuriMember, NewTimes, Times, Total).


findTimeJuri([Head | _], N, Head) :-
N == 1.

findTimeJuri([_ | Tail], N, Time) :-
N \== 1,
N1 is N - 1,
findTimeJuri(Tail, N1, Time). 


%Question 3
patientJuri(JuriMember) :-
getParticipants([], ListOfParticipants),
noPushButtonJuri(ListOfParticipants, JuriMember, 0, N),
N >= 2.

noPushButtonJuri([], _, OldN, OldN).

noPushButtonJuri([Participant | Tail], JuriMember, OldN, N) :-
performance(Participant, TimeList),
findTimeJuri(TimeList, JuriMember, TimeJuri),
((TimeJuri == 120,
N1 is OldN + 1);
N1 is OldN),
noPushButtonJuri(Tail, JuriMember, N1, N).

getParticipants(OldList, ListOfParticipants) :-
performance(ID, _),
\+member(ID, OldList), !, 
append(OldList, [ID], NewListOfIDs),
getParticipants(NewListOfIDs, ListOfParticipants).

getParticipants(OldList, OldList).

%Question 4
%bestParticipant(+P1, +P2, -P)

bestParticipant(P1, P2, P) :-
performance(P1, ListP1),
sum(ListP1, 0, SumP1),
performance(P2, ListP2),
sum(ListP2, 0, SumP2),
((SumP2 > SumP1, P is P2);
(SumP1 > SumP2, P is P1)).

%Question 5
allPerfs :-
getParticipants([], ListOfParticipants),
loopAllPerfs(ListOfParticipants).


loopAllPerfs([]).

loopAllPerfs([ID | Tail]) :-
write(ID), write(':'),
participant(ID, _, TypePerfomance),
write(TypePerfomance), write(':'),
performance(ID, ListTime),
write(ListTime), write('\n'),
loopAllPerfs(Tail).

%Question 6
noButtonParticipants([]).

noButtonParticipants([120 | Tail]) :-
noButtonParticipants(Tail).

noButtonParticipants(_) :- fail.

nSuccessfulParticipants(T):-
findall(ID, (performance(ID, ListTimes), noButtonParticipants(ListTimes)), ListIDs),
length(ListIDs, LenListIDs),
T is LenListIDs.


%Question 7

juriFans(JuriFansList) :-
findall(ID-NewList, (performance(ID, ListTime), getListJuri(ListTime, 0, [], NewList)), JuriFansList).

getListJuri([], _, OldList, OldList).

getListJuri([ListSeconds | Tail], N, OldList, NewList):-
ListSeconds == 120,
N1 is N + 1,
append(OldList, [N1], List),
!,
getListJuri(Tail, N1, List, NewList).

getListJuri([_ | Tail], N, OldList, NewList):-
N1 is N + 1,
!,
getListJuri(Tail, N1, OldList, NewList).

%Question 8

:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

nextPhase(N,P) :-
setof(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), ListEligible),
reverse(ListEligible, NewListEligible),
length(NewListEligible, LenList),
LenList >= N,
findall(E, (nth1(Index, NewListEligible, E), Index =< N), P).

%Question 9
/*O predicado apresentado retorna no Terceiro Argumento o Nome das Atuações feitas por individuos com idade igual ou inferior ao primeiro argumento do predicado predX.

O cut é verde, pois influencia apenas a eficiência do programa (corta árvores de exploração), não tendo qualquer influência no resultado do programa.*/

%Question 10
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).

%11
langford(N, L) :-
    LenList is 2*N,
    length(L, LenList),
    langford_helper(N, L).

langford_helper(0, _) :- !.

langford_helper(N, L) :-
    impoe(N, L),
    N1 is N - 1,
    langford_helper(N1, L).