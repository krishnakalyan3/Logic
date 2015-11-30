% working_directory(CWD, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code').
% working_directory(CWD, CWD).

% To check if an element is a memeber of the list
% Logic for the first element in head
member(X,[X|Y]).
% logic for the tail
member(X,[Y|R]) :- member(X,R).

elem2(X,[X|Y]).
elem2(X, [Y | L]) :- X\=Y, elem2(X,L). 

second(X,[_,X|_]).

first([_|X],X).
removeLast([],[]).
removeLast(L,R):-
	L = [X|Xs].
	removeLast(Xs,R).

removeLast11(L,R):-
	L = [X|Xs],
	removeLast(Xs,T),
	append( T , [Xs], R).

remove(X,Y):-
	removeLast(X,Y),first(X,Y).





findlen([],X):-
        X=0.

findlen([X|Tail],Count):-
        findlen(Tail,Prev),
        Count = Prev + 1.

len(X):-
        findlen(X,Count),
        write(Count).

element_at(X,[X|_],1).
element_at(X,[_|L],K) :- element_at(X,L,K1), K is K1 + 1.