onecount(X,Y):-
	rowI(M,)
	Z is X - 1,
	onecount(T,Z),

traceMatrix(X,Z):-
	traceMatrix1(X,0,Z).

traceMatrix1([],[_],[]).
traceMatrix1(X,NewCount,[K|Z]):-
    X = [H|T],
    rowI(H,Count,K),
    NewCount is Count +1,
    traceMatrix1(T,NewCount,Z).



% Ex 5.
% size([[1,2],[3,4],[5,6]], NbRows, NbCols).

chklength([],0).
chklength([H|T],M):-
	length([H|T],M).

chkrowl([],0).
chkrowl([H|T],[M|Z]):-
	length(H,Z),
	chkrowl(T,Z).

% Inefficient Implementation
decompose(A,L1,L2):-
	listFollowers(A,L2),listFirst(A,L1).

decompose2([[H|T]|T0], [H|L1], [T|L2]) :- decompose(T0, L1, L2).
decompose2([], [], []).


% http://stackoverflow.com/questions/4280986/how-to-transpose-a-matrix-in-prolog
trans(M, [P|T]):- first(M, P, A), trans(A, T).
trans(Empty, []):- empty(Empty).

empty([[]|T]):- empty(T).
empty([[]]).

first([[P|A]|R], [P|Ps], [A|As]):- first(R, Ps, As).
first([], [], []).


len([],0).
len([_|T],L):-
	len(T,N),
	L is N+1.

traceMatrix([],0).
traceMatrix(M,Z):-
	len1(M,Z1),
	M = [H|T],
	traceMatrix(T,)


traceMatrix(X,Y):-
	len1(X,Z),traceMatrix1(X,Z,Y).

traceMatrix1([],Count,[]).
traceMatrix1(X,0,[K|Z]):-
	X = [H|T],
	NewCount is Count - 1,
	rowI(H,NewCount,K),
	traceMatrix1(T,Z).


identity(0,[[]]).
identity(1,[[1]]).
identity(X, R):- identity(X,R,1).
identity(X, [H|T],C):-
    X\=C,
    !,
    ones(X,C,H),
    C2 is C + 1,
    identity(X, T ,C2).
identity(X, [H],C):-
    ones(X,C,H).