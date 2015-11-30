likes(dan,sally).
likes(sally,dan).
likes(josh,brit).

dating(X,Y):-
likes(X,Y),
likes(Y,X).

friendship(X,Y):-
likes(X,Y);
likes(Y,X).

