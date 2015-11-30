list_sym_len([H|Rest], [H, Len]) :- 
	length([H|Rest], Len).

size_sub(A,Ls):-
    maplist(list_sym_len,A,Ls).

compress([],[])
compress([H1,H2|T1],R):-
	H1\=H2,
	compress([[H1,H2]|T1],T2).


compress1(L, C) :-
    compress1(L, 1, C).


compress([], _, []). 
compress([H], Count, [[H,Count]]).
compress([H, H|T], Count, TC) :-
	compress(T,Count,TC).
	C is R +1.

compress([H1, H2|T], Count, [[H1,Count]|TC]) :-
    dif(H1, H2),
    compress(T,Count,TC).