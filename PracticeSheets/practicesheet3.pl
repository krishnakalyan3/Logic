% 	working_directory(CWD, 
%	'/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/PracticeSheets').

% Factorial Without Tail Recursion

% Basecase
fact1(0,Result) :-
    Result is 1.
fact1(N,Result) :-
    N > 0,
    N1 is N-1,
    fact1(N1,Result1),
    Result is Result1*N.

fact2(0,1).
fact2(X,Y):-
	X > 0,
	X1 is X -1,
	fact2(X1,Y1),
	Y is Y1 * X.

% 1st statement is for encapulation
% 2nd predaictae cuts the tree and starts backtracking once the predicate conditions are staisfied
fact3(N, R) :- fact3(N, 1, R).
fact3(0, R, R) :- !.
fact3(N, Acc, R) :-
    NewN is N - 1,
    NewAcc is Acc * N,
    fact3(NewN, NewAcc, R).