% Assignment 2
% Sai Krishna Kalyan

% working_directory(CWD, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').

% Ex 5.
% size([[1,2],[3,4],[5,6]], NbRows, NbCols).

chklength([],0).
chklength([H|T],M):-
	length([H|T],M).

chkrowl([],0).
chkrowl([H|T],[M|Z]):-
	length(H,Z),
	chkrowl(T,Z).

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
	H1 = [H2|T2],
	listFollowers(T1,Z).

% Question 3
% decompose([[1,2,8],[3,4],[5,6]], L1, L2).
% Inefficient Implementation
decompose(A,L1,L2):-
	listFollowers(A,L2),listFirst(A,L1).

% decompose1([[1,2,8],[3,4],[5,6]], L1, L2).

decompose1([H|T],A):-
	H = [H1|_],
	decompose1(T,B,C).
	


flat([H|T],R) :- is_list(H), flat(T,T1), append(H,T1,R).

% Question 4
% transpose1([[1,2],[3,4],[5,6]], R).
transpose1([[X],[Y],[Z]],[[X,Y,Z]]).
transpose1([H|T],[L1|R]):-	
	decompose([H|T],L1,L2),
	transpose1(L2,R).
