% Ex 1
%second([a,b,c,d],X).
% H2 is the second element which is in the output of this function 
second([H1,H2|T],[H2]).

% Ex 2
% removeLast([1,5,8,2], R).
% Appends the output with [_] anonymous element
% removing  the last element
removeLast1(L, X) :-													
    append(X, [_], L).
% Edge Case that exectes when single element to give an empty list
% Recursively removes the first element of the list and put it on the head of the output
removeLast2([_], []).
removeLast2(L, X) :-
	L = [H|Y],
	X = [H|Z],
   	removeLast2(Y, Z).

% Ex 3
% replace([1, 5, 8, 1, 4, 3], 1, 12, L1).
% Edge case exectes when there is an empty list to be replced. It gives back an empty list.
% replace function checks to see if the first element is not equal to the second argument in the predicate
% It recursively check this condition and if otherwise result that is the third argument in the predicate
% is added to the head of the output.  
replace([],_,_,[]).
replace([H|T],X,Y,[H|R]):-
	H\=X,
	replace(T,X,Y,R).
replace([X|T],X,Y,[Y|R]):-
	replace(T,X,Y,R).

% Ex 4
% correspondence([3, 8, 1, 1], [[1, one],[2, two],[3, three]], R).
% Edge case that executes when the list is supposed to replaced by and empty list. This will return an empty list.
% the correspondence predicate calls the replace predicate with argument as the list1 and the first two arguments 
% as the remaining arguments to output to the result of the predicate will give us the replaced list.
correspondence(L,[],L).
correspondence([L1|T1],[L2|T2],R):-
    L2=[H,T],
    replace([L1|T1],H,T,Z),
    correspondence(Z,T2,R).

% Ex 5
% decompose([1,2,4,-1,2],X,Y).
% Edge case executes whenever we have an empty list to return an empty list. 
% The second decompose predicate check if the head of the list is positive. If its positive it adds it to the head of first output, in a recusrsive fashion.
% The third decompose predicate checks for zero or less and if the condition satisfys it adds to the output to the head of second output.
decompose([],[],[]).
decompose([H|T], [H|LPos], LNeg):-
	H > 0,
	decompose(T,LPos,LNeg).
decompose([H|T], LPos, [H|LNeg]):-
	H =< 0,
	decompose(T,LPos,LNeg).

% Ex 6
% compact([a,a,a,b,b,c,a,a,a,a],L2).
% enumerate: predicate simply maps [a,b,c] to [[a,1],[b,1],[c,1]]
% edge cases if the list is empty return empty list
% collapse return an empty list if empty and if single element return single element.
% elements are added by the collapse predicate.
% if elements are not equal create a seperate list.
% compress preicate is a unification of the enumerate predicate and the collapse predicate.
compress(X,R) :-
    enumerate(X,Y),
    collapse(Y,R).
enumerate([],[]).
enumerate([H|T],[[H,1]|R]) :- enumerate(T,R).
collapse([],[]).
collapse([X],[X]).
collapse([[X,N1],[X,N2]|T],R) :- 
	N is N1 + N2, collapse([[X,N]|T],R).
collapse([[X,N1],[Y,N2]|T],[[X,N1]|R]) :- 
	X \= Y, collapse([[Y,N2]|T],R).           

% Ex 7	
% decompress([[a,4],[b,4]],Y).
% decompress predicate calls a map function that takes in repeat function, input L1 and output Z.
% repeat function is creates variables based on the lenght of input list which are replaced by the input element.
repeat([X, N], L) :-
    length(L, N),
    maplist(=(X), L).
decompress(L1, OP) :-
    maplist(repeat, L1, Z),
    flatten(Z,OP).