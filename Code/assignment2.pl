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

% elm([[1,2],[3,4],[5,6]], 1,1, Z).
elm(A,X,Y,Z):-
	rowI(A,X,K),columnJ(K,Y,Z).

% Question 4
% product([[1,2],[3,4],[5,6]], [[1,1,1],[1,1,1]], M).
product([],_,[]).
product(X,Y,[Z1|Z]):- 
	X = [H|T],
	trans(Y,Z2),
	mult2(H,Z2,Z1),
	product(T,Y,Z).

mult2(X,Y,Z):-
	mult1(X,Y,Z1),
	multixlist(Z1,Y,Z).


mult1(X,Y,M):-
	length(Y,Z),
	repl(X,Z,M).

% multixlist([[1,1],[1,1]],[[1,1],[2,2]],Z).
multixlist(X,Y,Z2):-
	maplist(scalar,X,Y,Z2).

% multiplying 2 lists
% scalar([1,2,3],[1,1,1],Z).
scalar(X,Y,Z):-
	maplist(mult,X,Y,Z1),
	sumlist(Z1,Z).

% Adding all elements in the list
% sumlist([1,2,3,4],X).
sumlist([],0).
sumlist(X,Z):-
	X =[H|T], 
	sumlist(T,Z1),
	Z is Z1 + H. 

% multipying elements
% mult(4,3,Z).
mult(X,Y,Z):- Z is X *Y.

% repeating list
% repl([1,2,3],3,Z).
repl(X, N, L) :-
    length(L, N),
    maplist(=(X), L).

% Question 5
% traceMatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]],R).
sum_list1([], 0).
sum_list1([H|T], Sum) :-
   sum_list1(T, Rest),
   Sum is H + Rest.

traceMatrix(X, Y):- diagonal(X,R,1),sum_list1(R,Y).

% Question 6
% diagonal([[1, 2, 3], [4, 5, 6], [7, 8, 9]],D).
diagonal(X,Y):- diagonal(X,Y,1).
diagonal([],[],_).
diagonal(X,[R|Z],C):-
   X=[H|T],
   rowI(H,C,R),
   Count is C+1,
   diagonal(T,Z,Count).

% Question 7
% identity(3,I).
% ones has arity 3 basically generates list
% X -> List i want x elemnts
% Y -> postions of 1
% L is the list returned with 1s.
% ones(3,1,L).
identity(0,[[]]).
identity(1,[1]).
identity(X,Y):-
	identity(X,Y,1).

identity(X,Y,C):-
	Y = [H|T],
	X \= C,
	!,
	ones(X,C,H),
	C2 is C +1,
	identity(X,T,C2).

identity(X,[Y],C):-
	ones(X,C,Y).

ones(X,Y,Z) :- ones(X,Y,Z,1).
ones(X,Y,Z,C):-
	Z = [0|K],
	X \= C,
	Y \= C,
	C2 is C + 1,
	ones(X,Y,K,C2).

ones(X,Y,Z,C):-
	Z = [1|K],
	X \= C,
	Y = C,
	C2 is C + 1,
	ones(X,Y,K,C2).

ones(X,Y,Z,C):-
	Z = [0],
	X = C,
	Y \= C.

ones(X,Y,Z,C):-
	Z = [1],
	X = C,
	Y = C.




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
transpose([[]|_], []).
transpose(X,[L1|R]):-
    decompose(X,L1,L2),
    transpose(L2,R).
