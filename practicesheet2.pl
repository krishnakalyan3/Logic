%Lists and difference tests : unification and identity

% Ex 2
% elem(X,[a,b,a,c]).
% predicate to if an element is present in the List
% first predicate checks if the element  matches the head of the list.
% second predicate just recursively iterates the list.
elem(X, [X | _ ]).
elem(X, [ _ | L]) :- elem(X,L).

% elem2(X,[a,b,c,d]).
% first predicate check if the element is the head of the list.
% second predicate means that X and Y cannot be unified.
% = that succeeds when the two terms are unified.
% returns a
elem2(X, [X | _ ]).
elem2(X, [Y | L]) :- X\=Y, elem2(X,L).

% elem3(X,[a,b,a,c]).
% \== means the two terms are not identical. Here also no unification takes place even if this succeeds.
elem3(X, [X | _ ]).
elem3(X, [Y | L]) :- X\==Y, elem3(X,L).

% Define a query that provides different results for elem and elem3.
%?- elem(a,[a,b,a,c]).
%true ;
%true ;
%false.
%?- elem3(c,[a,b,a,c]).
%true ;
%false.

% Ex 3
% Define a predicate concat/3 that concatenates two lists.
% The base case simply says that appending the empty list to any list whatsoever yields that same list, which is obviously true.
% http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse24
concat([],X,X).
concat(X,Y,[H1|Z]):-
	X = [H1|T1],
	concat(T1,Y,Z).

% Define a predicate remove/3 that removes an element from a list : for instance remove([a,b,a,c], a, L)
remove([],_,[]).
remove(X,Y,Z):-
	X = [Y|T1],
	remove(T1,Y,Z).
remove(X,Y,[H1|Z]):-
	X = [H1|T1],
	Y \= H1,
	remove(T1,Y,Z).




