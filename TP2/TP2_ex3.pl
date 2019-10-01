exec(X,Y) :- p(X,Y).
exec(X,X) :- t(X).
p(X,Y) :- w(X), r(Y).
p(X,Y) :- t(X), r(Y).
w(a).
w(b).
r(c).
r(d).
t(e). 