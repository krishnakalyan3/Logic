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