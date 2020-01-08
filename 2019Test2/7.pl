/*prat(+Prateleiras, +Objetos, -Vars)*/
:- use_module(library(clpfd)).

prat(Prateleiras, Objetos, Vars) :-
length(Objetos, Len),
length(Vars, Len),


append(Prateleiras, FlattenPrat),
length(FlattenPrat, LenPrat),
domain(Vars, 1, LenPrat),


createTasks(Objetos, Vars, Tasks),
createMachines(1, FlattenPrat, Machines),

nth1(1, Prateleiras, OneLevel),
length(OneLevel, DivsPerRow),
LastDiv is LenPrat - DivsPerRow + 1,
setWeight(1, LastDiv, DivsPerRow, Objetos, Vars),

cumulatives(Tasks, Machines, [bound(upper)]), 


labeling([], Vars).



/*=================================================*/
createTasks([], _, []).

createTasks([_-Volumn | TailVolumn], [Vars | TailV], [Tasks | TailTasks]) :-
    Tasks = task(0, Volumn, Volumn, Volumn, Vars),
    createTasks(TailVolumn, TailV, TailTasks).

createMachines(_, [], []).

createMachines(Counter, [Prat | Tail], [Machine | TailMachines]) :-
    Machine = machine(Counter, Prat),

    NewCounter is Counter + 1,
    createMachines(NewCounter, Tail, TailMachines).


/*=================================================*/
setWeight(TotalDivs, TotalDivs, _, _, _).

setWeight(NDiv, TotalDivs, DivsPerRow, Objetos, Vars) :-

    DivBelow is NDiv + DivsPerRow,

    weightOfElements(Vars, Objetos, NDiv, CurrWeight),
    weightOfElements(Vars, Objetos, DivBelow, BelowWeight),

    CurrWeight #=< BelowWeight,

    NewNDiv is NDiv + 1,

    setWeight(NewNDiv, TotalDivs, DivsPerRow, Objetos, Vars).

    
/*=================================================*/

weightOfElements([], _, _, 0).

weightOfElements([Vars | TailV], [Weight-_ | Tail], NDiv, CurrWeight) :-
    (Vars #= NDiv) #<=> Between,
    weightOfElements(TailV, Tail, NDiv, NextWeight),
    
    CurrWeight #= Between * Weight + NextWeight.