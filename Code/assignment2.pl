% Assignment 2
% Sai Krishna Kalyan

% ========= Ex 5 =========

% Question 1
% size([[1,2],[3,4],[5,6]], NbRows, NbCols).
% the length predicate returns the length of the list.
% valid predicate check if all lists have the same length.
% size predicate returns the length of rows and columns unfying with length and valid predicate.
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
% base case returns the value 1 if the 
rowI([H|_],1,H):-!.
rowI([_|T],I,X) :-
   I1 is I-1,
   rowI(T,I1,X).

% Question 3
% columnJ([[1,2],[3,4],[5,6]], 1, CJ).
% base case deals with an empty list and returns empty list.
% Head of all Lists in predicate rowI with postion will return a column. 
columnJ([],_,[]).
columnJ(X,I,[Z|K]):-
	X = [H|T],
	rowI(H,I,Z),
	columnJ(T,I,K).

% Question 4
% product([[1,2],[3,4],[5,6]], [[1,1,1],[1,1,1]], M).
% Base case returns an empty list when given an empty list.
% the predicate product is a unification of transpose predicate defined below , mult2 and product
product([],_,[]).
product(X,Y,[Z1|Z]):- 
	X = [H|T],
	transpose(Y,Z2),
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
% The predicate traceMatrix is a unification of predicates diagonal and sum_list1.
% sum_list1 is a predicate that adds a list
sum_list1([], 0).
sum_list1([H|T], Sum) :-
   sum_list1(T, Rest),
   Sum is H + Rest.

traceMatrix(X, Y):- diagonal(X,R),sum_list1(R,Y).

% Question 6
% diagonal([[1, 2, 3], [4, 5, 6], [7, 8, 9]],D).
% The base case incudes an accumulator startting from one with input X and output Y
% Another base case when the list is empty
% use rowI to get the diagonal elements of a list 
diagonal(X,Y):- diagonal(X,Y,1).
diagonal([],[],_).
diagonal(X,[R|Z],C):-
   X=[H|T],
   rowI(H,C,R),
   Count is C+1,
   diagonal(T,Z,Count).

% Question 7
% identity(3,I).
% The base case returns an empty list if the input element is 0.
% the identity predicate check for conditions X and C are not equal and calls the predicate ones and increment accumulator C2. 
% ones has arity 3 basically generates list based on condition when 
% X -> List with x elemnts
% Y -> postions of 1
% L is the list returned with 1s.
identity(0,[[]]).
identity(1,[1]).
identity(X,Y):-
	identity(X,Y,1).

identity(X,Y,C):-
	Y = [H|T],
	X \= C,
	ones(X,C,H),
	C2 is C +1,
	identity(X,T,C2).

identity(X,[Y],C):-
	ones(X,C,Y).

% ones(3,1,L).
% ones predicate has arity 3 which take input number of elements , postion of 1 and output and accumulator 1.
% Condition 1 append 0 if X and Y are not equal to C + incerment the accumulator
% Condition 2 append 1 if Y and C are equal + X and C are not the same.
% Condition 3 output element 0 if X and C are equal + Y is not equal to C.
% Condition 4 output element 1 if X and C are equal + Y and C are equal
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

% ========= Ex 6 =========

% Question 1
% listFirst([[1,2,8],[3,4],[5,6]],LF).
% base case of this predicate returns an empty list once the input is empty.
% listFirst predicate return the head of every list and ignores the rest.
listFirst([],[]).
listFirst([H1|T1],[H2|Z]):-
	H1 = [H2|_],
	listFirst(T1,Z).

% Question 2
% listFollowers([[1,2,8],[3,4],[5,6]],LF).
% The base case will return an empty list incase the input empty.
% Since we are only interested in the tail of the list we implement a predicate called listFollowers that ignores the head.
listFollowers([],[]).
listFollowers([H1|T1],[T2|Z]):-
	H1 = [_|T2],
	listFollowers(T1,Z).

% Question 3
% decompose([[1,2,8],[3,4,5],[5,6,6]], L1, L2).
% Maplist is a predcicate that takes in a function called list_head_tail.
% Predicate list_head_tail returns the head and tail of a list
% decompose predicate returns the first head of every list as L1 and Tail of every list as L2 based on the maplist. 
list_head_tail([H|T], H, T).
decompose(X, L1, L2) :-
   maplist(list_head_tail, X, L1, L2).

% Question 4
% trans([[1,2],[3,4],[5,6]], R).
% The base case makes sure that an empty list returns and empty list and terminates 
% Transpose predicate is decompose predicate. Decompose returns head and tail. Head appends to the output and tail recurses.
transpose([[]|_], []).
transpose(X,[L1|R]):-
    decompose(X,L1,L2),
    transpose(L2,R).