femme(alice).
femme(victoria).
homme(albert).
homme(edward).
parents(edward, victoria, albert).
parents(alice, victoria, albert).
soeur( X, Y) :- femme( X), parents( X, Mere, Pere), parents( Y, Mere, Pere).

addition(0, X, X).
addition(s(X), Y, s(Z)) :- addition(X, Y, Z).


nombre(s(X)) :- nombre(X).
nombre(0).

multiply(0, X, 0).
multiply(s(N), P, R) :- multiply(N, P, Q), addition(P, Q, R).

fact_s(0, s(0)).
fact_s(s(0), s(0)).
fact_s(s(N), R) :- fact_s(N, Q), multiply(s(N), Q, R).

fib_t(0, 0).
fib_t(s(0), s(0)).
fib_t(s(s(X)), R) :- fib_t(X, R2),
				fib_t(s(X), R1),
				addition(R1, R2, R).

fib_a(N, R) :- fib_a(N, 0, s(0), R).

fib_a(0, U, V, U).
fib_a( s(X), U, V, R) :- addition(U, V, NV),
					fib_a(X, V, NV, R).


appartient_t(X, cons(X, L)).
appartient_t(X, cons(Y, L)):-appartient_t(X, L).

appartient0(X, [X|L]).
appartient0(X, [Y|L]):-appartient0(X, L).

concat_t(nil, M, M).
concat_t(c(A, L), M, c(A, N)) :- concat_t(L, M, N).

concat([], M, M).
concat([A|L], M, [A|N]) :- concat(L, M, N).

naiveReverse([], []).
naiveReverse([A|Q], R) :- naiveReverse(Q, P), concat(P, [A], R).

reverse(X, R) :- reverse(X, [], R).
reverse([], R, R).
reverse([X|L], A, R) :- reverse(L, [X|A], R).

sous_lis( [], _ , []).
sous_lis( [X|L1], L2, L) :- member( X, L2), !, sous_lis( L1, L2, L).
sous_lis( [X|L1], L2, [X|L]) :- sous_lis( L1, L2, L).

s10(s(s(s(s(s(s(s(s(s(s(0))))))))))).
s20(s(s(s(s(s(s(s(s(s(s(S))))))))))):-s10(S).
s25(s(s(s(s(s(S)))))) :- s20(S).

/* Programming graphs - elementary representation */
go(a).
go(b) :- go(a).
go(c) :- go(a).
go(d) :- go(b).
go(h) :- go(c).
go(f) :- go(c).
go(e) :- go(d).
go(g) :- go(e).
go(e) :- go(f).
go(b) :- go(h).
go(a) :- go(h).

/* Representing edges */
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, h).
edge(c, f).
edge(d, e).
edge(e, g).
edge(f, e).
edge(h, b).
edge(h, a).

/* Forward chaining with explanation */
go_(X,Y,[X,Y]) :- edge(X,Y).
go_(X,Y,[X|L]) :- edge(X,Z), go_(Z,Y,L).

/*  Backward chaining with explanation */
go_bk(X,Y,R) :- go_bk(X,Y, [], R).
go_bk(X,Y,C,[X,Y|C]) :- edge(X,Y).
go_bk(X,Y,C,R) :- edge(Z,Y), go_bk(X,Z,[Y|C],R).

/* Forward chaining without cycle */
go_wc(X, Y, R) :- go_wc(X, Y, [], R).
go_wc(X,Y,_,[X,Y]) :- edge(X,Y).
go_wc(X,Y,C,[X|L]) :- edge(X,Z), not(member(Z,C)), go_wc(Z,Y,[X|C],L).

/* Backward chaining without cycle */
go_bk_wc(X, Y, R) :- go_bk_wc(X, Y, [], R).
go_bk_wc(X,Y,C,[X,Y|C]) :- edge(X,Y).
go_bk_wc(X,Y,C,R) :- edge(Z,Y), not(member(Z,[X|C])), go_bk_wc(X,Z,[Y|C],R).

