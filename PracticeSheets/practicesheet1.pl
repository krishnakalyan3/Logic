% Eg1
conscientious(pascal).
conscientious(zoe).
study(X):-serious(X).
homework(X):-conscientious(X).
serious(X):-homework(X).
passexam(X):-study(X).

% passexam(X).

% Eg2
father(prabhakar,shobhana).
father(subramanium,venkat).
father(venkat,krishna).
father(venkat,madhuri).
mother(shobhana,krishna).
mother(shobhana,madhuri).

% parent(X,krishna).
parent(X,Y):-father(X,Y).
parent(X,Y):-mother(X,Y).

% parent(X,Y,krishna).
parent(X,Y,Z):-father(X,Z),mother(Y,Z).

% grandfather(X,krishna).
grandfather(X,Y):-parent(X,Z),parent(Z,Y).

% brotherOrSister(X,madhuri).
brotherOrSister(X,Y):- father(Z,X),father(Z,Y),X\=Y.

% ancestor(A,krishna). any one above me is my ancestor
% person A is person C's ancestor if person A is a parent of an ancestor of C
ancestor(A, B) :- parent(A, B).
ancestor(A, B) :- parent(A, X), ancestor(X, B).

%Eg3
%circuit(A,B,C)
and(1,1,1).
and(1,0,0).
and(0,1,0).
and(0,0,0).

or(1,1,1).
or(1,0,1).
or(0,1,1).
or(0,0,0).

not(1,0).
not(0,1).

nand(A,B,C):-
	and(A,B,Z),not(Z,C).
	
xor(A,B,C):-
	nand(A,B,Z),or(A,B,M),and(M,Z,C).

circuit(X,Y,Z):-
	nand(X,Y,O1),not(X,O2),xor(O1,O2,O3),not(O3,Z).

% Eg4
% http://ssdi.di.fct.unl.pt/flcp/foundations/0910/files/class_02.pdf

% int(s(0))
int(0).
int(s(M)) :- int(M).

% addition(s(s(0)), U, s(s(s(s(s(0)))))).
addition(0, X, X).
addition(s(X), Y, s(Z)) :- addition(X, Y, Z).


% mult(s(0),s(s(0)),Y).
mult(0,Y,0).
mult(s(X),Y,Z):-
	mult(X,Y,OP1),
	addition(OP1,Y,Z).

% factorial
factorial(0, 1).
factorial(N, NFact) :-
    N > 0,
    Nminus1 is N - 1,
    factorial(Nminus1, Nminus1Fact),
    NFact is Nminus1Fact * N.