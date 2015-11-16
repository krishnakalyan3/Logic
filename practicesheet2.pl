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

% Definite Clause Grammars 
reverse1([])     --> [].
reverse1([L|Ls]) --> reverse(Ls), [L].

% TODO : Reverse
% http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse25
% Simple Reverse
reverse2([],[]). 
   reverse2([H|T],R):-  reverse2(T,RevT),  
   append(RevT,[H],R).

% Reverse with accumulator
reverse3([],Z,Z).
reverse3([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

% List Filter
deleteSome(X, [], X).
deleteSome(X, [Y|Ys], Z) :-
    deleteOne(Y, X, T),
    deleteSome(T, Ys, Z).

% palindrome
pal([]).
pal([_]).
pal(X) :-
	X = [H|T],
	append(L1,[H],R), pal(L1).

        
% Nested List I
% Write a predicate longestList/2 such that longestList(L1,L2) is satisfied if L2 is the longest
% nested list from the list of lists L1.


% This one is wrong as it just returns the longest number
% long([[1],[1,2],[1,2,3],[1,2,3,4]],LI).
length2([],0).
length2(A,X):-
	A = [_|L],
	length2(L,Y),
	X is Y + 1.

ll([],X,X).
ll([H|L],X,M):-
	length2(H,S1),
	length2(M,S2),
	S1>S2,!,
	ll(L,X,H).	

ll([H|L],X,M):-
	ll(L,X,M).

long(L, M) :-
	ll(L,M,[]).







