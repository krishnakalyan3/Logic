% Assignment 2
% Sai Krishna Kalyan

% working_directory(CWD, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').

% Ex 5.
% Question 1
% size([[1,2],[3,4],[5,6]], NbRows, NbCols).
len1(A,X):-
	len1(A,0,X).
len1([],L,L).
len1([_|T],A,L):-
	T1 is A +1,
	len1(T,T1,L).

valid([],_).
valid([H|T],Z):-
	len1(H,Z),
	valid(T,Z).

size([H|T],Y,Z):-
	len1([H|T],Y),
	valid([H|T],Z).

% Question 2
% rowI([[1,2],[3,4],[5,6]], 2, RI).
rowI([H|_],1,H):-!.
rowI([_|T],I,X) :-
   I1 is I-1,
   rowI(T,I1,X).

% Question 3
% columnJ([[1,2],[3,4],[5,6]], 1, CJ).
columnJ([],_,[]).
columnJ(X,I,[Z|K]):-
	X = [H|T],
	rowI(H,I,Z),
	columnJ(T,I,K).

% Question 4
% product([[1,2],[3,4],[5,6]], [[1,1,1],[1,1,1]], M).
%product([],_,[]).
%product(X,Y,Z):-

% Question 5
% traceMatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]],R).
sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.

traceMatrix([],0).
traceMatrix(X,[K|Z]):-
	X = [H|T],
	len1(A,X),
	rowI(H,M,K),
	traceMatrix(T,Z).

% Ex 6. 
% Question 1
% listFirst([[1,2,8],[3,4],[5,6]],LF).
listFirst([],[]).
listFirst([H1|T1],[H2|Z]):-
	H1 = [H2|_],
	listFirst(T1,Z).

% Question 2
% listFollowers([[1,2,8],[3,4],[5,6]],LF).
listFollowers([],[]).
listFollowers([H1|T1],[T2|Z]):-
	H1 = [_|T2],
	listFollowers(T1,Z).

% Question 3
% decompose([[1,2,8],[3,4,5],[5,6,6]], L1, L2).
list_head_tail([H|T], H, T).
decompose(X, L1, L2) :-
   maplist(list_head_tail, X, L1, L2).

% Question 4
% trans([[1,2],[3,4],[5,6]], R).
trans([[]|_], []).
trans(X,[L1|R]):-
    decompose(X,L1,L2),
    trans(L2,R).