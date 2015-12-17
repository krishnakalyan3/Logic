working_directory(_, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').

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


list_head_tail([H|T], H, T).
decompose(X, L1, L2) :-
   maplist(list_head_tail, X, L1, L2).

% Question 4
% trans([[1,2],[3,4],[5,6]], R).
trans([[]|_], []).
trans(X,[L1|R]):-
    decompose(X,L1,L2),
    trans(L2,R).