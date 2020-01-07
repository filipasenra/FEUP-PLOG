/*Ss = [S1,S2,S3,S4,S5,S6,S7],
Es = [E1,E2,E3,E4,E5,E6,E7],
Tasks = [
task(S1, 16, E1, 2, 1),
task(S2, 6, E2, 9, 2),
task(S3, 13, E3, 3, 1),
task(S4, 7, E4, 7, 2),
task(S5, 5, E5, 10, 1),
task(S6, 18, E6, 1, 2),
task(S7, 4, E7, 11, 1)
],
Machines = [machine(1,12), machine(2,10)],

corta(+Pranchas,+Prateleiras,-PranchasSelecionadas)*/

corta(Pranchas, Prateleiras, PranchasSelecionadas) :-
length(Prateleiras, Len),
length(PranchasSelecionadas, Len),

length(Pranchas, LenPranchas),
domain(PranchasSelecionadas, 1, LenPranchas),


createTasks(PranchasSelecionadas, Prateleiras, Tasks),
createMachines(0, Pranchas, Machines),

cumulatives(Tasks, Machines, [bound(upper)]),

labeling([], PranchasSelecionadas).


createMachines(_, [], []).

createMachines(Counter, [Prancha | Tail], [Machine | TailMach]) :-
NewCounter is Counter + 1,
Machine = machine(NewCounter, Prancha),
createMachines(NewCounter, Tail, TailMach).


createTasks([], [], []).

createTasks([PranchasSelect | TailSelect], [Prateleira | Tail], [Tasks | TailTasks]) :-
Tasks = task(0, Prateleira, Prateleira, Prateleira, PranchasSelect),
createTasks(TailSelect, Tail, TailTasks).