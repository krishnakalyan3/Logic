/*
r(a,b).
r(c,d).
r(X,Z):- 
	r(X,Y),r(Y,Z).
r(X, Y):- 
	r(Y, X).
*/

r(a,b).
q(X,X).
q(X,X):-
	r(X,Y),q(Y,Z).
