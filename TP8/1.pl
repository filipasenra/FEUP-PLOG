:-use_module(library(clpfd)).

magic(Vars):-
 Vars=[A1,A2,A3,A4,A5,A6,A7,A8,A9],

 domain(Vars,1,9),

 %Soma is (9+1)*3//2, % Aumenta a Eficiência

 all_distinct(Vars),
 A1+A2+A3 #= Soma,

 A4+A5+A6 #= Soma,

 A7+A8+A9 #= Soma,

 A1+A4+A7 #= Soma,

 A2+A5+A8 #= Soma,

 A3+A6+A9 #= Soma,

 A1+A5+A9 #= Soma,
 
 A3+A5+A7 #= Soma,

 % A1 #< A2, A1 #< A3, A1 #< A4, A2 #< A4, % Eliminar simetrias
 
 labeling([],Vars).


magic4(Vars):-
 Vars=[A1,A2,A3,A4,
 A5,A6,A7,A8,
 A9, A10, A11, A12,
 A13, A14, A15, A16],

 domain(Vars,1,16),

 %Soma is (16+1)*4//2, % Aumenta a Eficiência => (N*(N^2+1) / 2)

 all_distinct(Vars),

 A1+A2+A3+A4 #= Soma,
 A5+A6+A7+A8 #= Soma,
 A9+A10+A11+A12 #= Soma,
 A13+A14+A15+A16 #= Soma,

 A1+A5+A9+A13 #= Soma,
 A2+A6+A10+A14 #= Soma,
 A3+A7+A11+A15 #= Soma,
 A4+A8+A12+A16 #= Soma,

 A1+A6+A11+A16 #= Soma,
 A4+A7+A10+A13 #= Soma,
 
 labeling([],Vars).