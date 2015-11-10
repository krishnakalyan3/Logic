% replace(3,three,[1,2,3],Xs).
correspondence([],_,[]).
correspondence(L1,L2,R):-
	L1=[H1|T],
	L2=[H2|T2],
	L3=[T2|T3],
	replace(T2,T3,L1,R),
	correspondence(T,T2,).