% ['/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Tutorial/PracticeSheet2.pl'].
% working_directory(_ )
elem(X, [X | _ ]).
elem(X , [Y| L]):- elem(X,L).

elem2(X, [X | _ ]).
elem2(X , [Y| L]):- X\=Y , elem2(X,L).

elem3(X, [X | _ ]).
elem3(X , [Y| L]):- X\==Y , elem3(X,L).

concat([], X, X).
concat( X , Y , Z) :-
	X = [V | T],
	concat(T, Y , Z1),
	Z = [V | Z1].

remove([],Y,[]).
remove(X, Y Z) :-		% remove([a,b,c],a,Z)
	X = [E | L3],		% E = [a] , L3 = [b,c]
	V = E 				% V = [a]
	remove(L3, V, L4),	% remove([b,c], a, L4)
	L2 = L4.			% L2 = 

remove(L,V, L4):-
	L = [E | L3],
	V \= E,
	remove(L3, V, L4),
	L2 = [E | L4].

revert([X],[X]).
revert(X,Y):-
	X = [V | T],
	revert(T,Z),
	append(Z , [V], Y).