wizard(harry).
wizard(ron).
wizard(hermione).

wizard(harry) :- !.
wizard(ron).
wizard(hermione).

wizard(harry).
wizard(ron) :- !.
wizard(hermione).

wizard(harry).
wizard(ron).
wizard(hermione) :- !.