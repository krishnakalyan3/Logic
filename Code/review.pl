working_directory(CWD, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/code').
% working_directory(CWD, CWD).

second([_,H2|_],H2).

removeLast1(X,T):-
	append(T,[_],X).

removeLast2([_],[]).
removeLast2(X,[H|Y]):-
	X =[H|T],
	removeLast1(T,Y).

replace([],_,_,[]).
replace(X,Y,Z,[H|M]):-
	X = [H|T],
	H \= Y,
	replace(T,Y,Z,M).
replace(X,Y,Z,[Z|M]):-
	X =[H|T],
	H == Y,
	replace(T,Y,Z,M).

correspondence(L,[],L).
correspondence([L1|T1],[L2|T2],R):-
    L2=[H,T],
    replace([L1|T1],H,T,Z),
    correspondence(Z,T2,R).

member2(X, [Y|Ys]) :-
    X = Y ; member2(X, Ys).

concat1([],M,M).
concat1(X,Y,[H|Z]):-
	X = [H|T],
	concat1(T,Y,Z).




