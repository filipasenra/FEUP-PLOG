:- use_module(library(clpfd)).

objeto(piano, 3, 30).
objeto(cadeira, 1, 10).
objeto(cama, 3, 15).
objeto(mesa, 2, 15).

homens(4).

tempo_max(60).

/* ================================================== */


furniture :-
homens(NMen),
tempo_max(MaxTime),

findall(Object-Man-Time, objeto(Object, Man, Time), Objects),

length(Objects, LenObj),
length(EndTimes, LenObj),
length(StartTimes, LenObj),

createTasks(Objects, StartTimes, EndTimes, Tasks),

domain(StartTimes, 0, MaxTime),

maximum(End, EndTimes),
End #=< MaxTime,

cumulative(Tasks, [limit(NMen)]),

labeling([minimize(End)], StartTimes),
write('Total Time: '), write(End), nl,
writeResult(Objects, StartTimes, EndTimes).



/* ================================================== */


writeResult([], _, _).

writeResult([Object-_-_ | TailObj], [StartTime | TailStart], 
[EndTime | TailEnd]) :-
write(Object), write(: ), write(StartTime), write(-), write(EndTime), nl,
writeResult(TailObj, TailStart, TailEnd).

/* ================================================== */

createTasks([], _, _, []).

createTasks([Object-Man-Time | TailObj], [StartTime | TailStart], 
[EndTime | TailEnd], [Task | Tail]) :-

Task = task(StartTime, Time, EndTime, Man, Object),

createTasks(TailObj, TailStart, TailEnd, Tail).

