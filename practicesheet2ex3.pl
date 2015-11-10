% working_directory(CWD, '/Users/saulgarcia/Dropbox/Maestria/DMKM/Courses/SEM1/Logic')

%Exercise 3 – Rewriting
%In this exercise, you are asked to rewrite the built-in predicates append/3, delete/3 and reverse/3.
%You are asked not to use them here, and to implement independent solutions.
%1. Define a predicate concat/3 that concatenates two lists.
%2. Define a predicate remove/3 that removes an element from a list : for instance remove([a,b,a,c], a, L). must unify L with the list [b,c].
%3. Define a predicate myReverse(L1, L2) which is satisfied if the list L2 is the reverse list of L1. 
%For instance myReverse([a,b,c,d],L2). must lead to the single unification L2 = [d, c, b, a]. Use the predicate append/3 that makes it possible, among other, to concatenate two lists in a third one.

%concat([],X,X).
%concat(X,Y,Z) :-
%	X = [V|T],
%	concat(T,Y,Z1),
%	Z = [V | Z1].


concat([],X,X).
concat([V|T],Y,[V | Z1]) :-
	concat(T,Y,Z1).
	
	
remove([], _, []).	
remove(L,V,L2) :- 
	L = [E | L3],
	V = E,
	remove(L3 , V, L4),
	L2 = L4.

remove(L ,V ,L2) :- 
	L = [E| L3],
	V \= E,
	remove(L3,V,L4),
	L2= [E | L4].
	

revert([X],[X])
revert(X,Y) :-
	X= [V|T],
	revert(T,Z),
	append(Y,[V], Z).
	

	