% ============ex5.1==============
% Size of matrix
% size([[1,2],[3,4],[5,6]], NbRows, NbCols).

size([], 0, 0).
size([[H1|T1]|T2], NbRows, NbCols):-
	length([[H1|T1]|T2], NbRows),
	length([H1|T1], NbCols),
	check([[H1|T1]|T2], NbCols).

%checking if each row has same number of elements
check([], _).
check([H|T], Col1):-
	length(H, Col1),
        check(T, Col1).

% ============ex5.2==============
% rowI([[1,2],[3,4],[5,6]], 2, RI).
% get I-th row
% using built in predicate
rowI([H|T], I, RI):-
	nth1(I, [H|T], RI).

% ============ex5.3==============
% get I-th column
% columnJ([[1,2],[3,4],[5,6]], 1, CJ).
% get I-th element for each list in list
columnJ([],_,[]).
columnJ([H|T], I, [Temp|Temp2]):-
	nth1(I, H, Temp),
	columnJ(T, I, Temp2).

% ============ex5.4==============
% matrix product
% product([[1,2],[3,4],[5,6]], [[1,1,1],[1,1,1]], M).
% mult gives out the list of paired multiplication
% of two lists (1st element*1st element, etc.)
mult(M, N, Counter, [Mult|T]):-
	length(M, Len),
	Counter<Len,
	nth1(Counter, M, First),
	nth1(Counter, N, Second),
	Mult is First*Second,
	NewCounter is Counter+1,
	mult(M, N, NewCounter, T).
mult(M, N, Counter, [Mult]):-
	length(M, Len),
	Counter=Len,
	nth1(Counter, M, First),
	nth1(Counter, N, Second),
	Mult is First*Second.
% sumMult gives out the sum of mult
sumMult(M, N, Total):-
	mult(M, N, 1, List),
	list_sum(List, Total).

% product has 4 cases, and doesn't work properly...
% it gives out list instead of list of lists and
% i am too lost to try to fix this
%
% product([[1,2],[3,4],[5,6]], [[1,1,1],[1,1,1]], 1, 1, M).
%
product(M, [N1|N], Count1, Count2, [Total|T]):-
	length(M, Nbr), %Number of rows of the product matrix
	length(N1, Nbc), %Number of columns
	Count1<Nbr,
	Count2<Nbc,
	rowI(M, Count1, Row),
	columnJ([N1|N], Count2, Col),
	sumMult(Row, Col, Total),
	NewCount2 is Count2+1,
	product(M, [N1|N], Count1, NewCount2, T).


product(M, [N1|N], Count1, Count2, [Total|T]):-
	length(M, Nbr),
	length(N1, Nbc),
	Count1<Nbr,
	Count2=Nbc,
	rowI(M, Count1, Row),
	columnJ([N1|N], Count2, Col),
	sumMult(Row, Col, Total),
	NewCount1 is Count1+1,
	NewCount2 is 1,
	product(M, [N1|N], NewCount1, NewCount2, T).

product(M, [N1|N], Count1, Count2, [Total|T]):-
	length(M, Nbr),
	length(N1, Nbc),
	Count1=Nbr,
	Count2<Nbc,
	rowI(M, Count1, Row),
	columnJ([N1|N], Count2, Col),
	sumMult(Row, Col, Total),
	NewCount2 is Count2+1,
	product(M, [N1|N], Count1, NewCount2, T).

product(M, [N1|N], Count1, Count2, [Total]):-
	length(M, Nbr),
	length(N1, Nbc),
	Count1=Nbr,
	Count2=Nbc,
	rowI(M, Count1, Row),
	columnJ([N1|N], Count2, Col),
	sumMult(Row, Col, Total).

product(M, N, Res):-
	product(M, N, 1, 1, Res).


% ============ex5.5==============
% traceMatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]],R).
% defining list summation predicate
list_sum([Item], Item).
list_sum([Item1,Item2 | Tail], Total) :-
    Temp is Item1+Item2,
    list_sum([Temp|Tail], Total).

% after that just summing up the elements of the diagonal
traceMatrix(M,T):-
	diagonal(M, Dia),
	list_sum(Dia,T).



% ============ex5.6==============
% diagonal([[1, 2, 3], [4, 5, 6], [7, 8, 9]],D).
% checking if matrix is diagonal
% writing down its diagonal

diagonal([H|T], Dia):-
	size([H|T], R, C),
	R == C,
	count1([H|T], Dia, R, 1).

% if counter = number of rows, calculate last time and exit

count1([H|_], [Temp], R, Counter):-
	Counter==R,
	nth1(Counter, H, Temp).

% increase counter in every row until max row number
% get element using counter as index

count1([H|T], [Temp|Dia], R, Counter):-
	Counter\=R,
	nth1(Counter, H, Temp),
	NextCounter is Counter+1,
	count1(T, Dia, R, NextCounter).


% ============ex5.7==============

% identity matrix
% identity(3,I)
% This is a very weird way of doing this, but it works :D


% I first generate a row of zeroes.
zeroes(0, []).
zeroes(N, [0|Rest]) :-
	succ(N0, N),
	zeroes(N0, Rest).

%then define a predicate of replacing element in a list by index

replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):-
	I > -1,
	NI is I-1,
	replace(T, NI, X, R),
	!.
replace(L, _, _, L).

% and now replace all the elements on the main diagonal by 1
% for some reason, i couldn't make it work in it's simplest
% form, so i had to add the specific case for 1st iteration
% (it didn't recognise (count-1) in replace predicate).
% But it works fine.
%
identity(1, [[1]]).
identity(N, Res):-
	identity(N, 1, Res).


identity(N, Count, [Resrow|R]):-
	Count=1,
	zeroes(N, Row),
	replace(Row, 0, 1, Resrow),
	NewCount is Count+1,
	identity(N, NewCount, R).

identity(N, Count, [Resrow|R]):-
	Count<N,
	zeroes(N, Row),
	replace(Row, Count-1, 1, Resrow),
	NewCount is Count+1,
	identity(N, NewCount, R).


identity(N, Count, [Resrow]):-
	Count==N,
	zeroes(N, Row),
	replace(Row, (Count-1), 1, Resrow).



% ============ex6.1==============

% listFirst([[1,2,8],[3,4],[5,6]],LF).
% collecting all first elements in lists inside a list
listFirst([],[]).
listFirst([H|T], [Temp|Temp2]):-
	nth1(1, H, Temp),
	listFirst(T, Temp2).

% ============ex6.2==============
% listFollowers([[1,2,8],[3,4],[5,6]],LF).
% additional predicate removehead - returns everything except head of
% list

removehead([_|Tail], Tail).
listFollowers([H|T], [LF1|LF2]):-
	removehead(H, LF1),
	listFollowers(T, LF2).
listFollowers([], []).


% ============ex6.3==============
%
% I know this is not supposed to be done like this :(
decompose(M, L1, L2):-
	listFirst(M, L1),
	listFollowers(M, L2).


% ============ex6.4==============
% transpose1([[1,2],[3,4],[5,6]], R).

transpose1([H|T1],T):-
	length(H, C),
	cycle([H|T1], C, 1, T).

% M - input matrix
% C - number of rows
% while counter < number of rows
% take a column of index=counter and put it into a new matrix
cycle(M, C, Counter, [Temp|Temp2]):-
	Counter<C,
	columnJ(M, Counter, Temp),
	NewCounter is Counter+1,
	cycle(M, C, NewCounter, Temp2).

% calculate the last time
cycle(M, C, Counter, [Temp]):-
	Counter=C,
	columnJ(M, Counter, Temp).



