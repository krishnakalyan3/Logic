% working_directory(CWD, '/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code')

elem(X, [X | ]).
elem(X, [Y | L]) :- elem(X,L).

￼
elem2(X, [X | ]).
elem2(X, [Y | L]) :- X\=Y, elem2(X,L).

elem3(X, [X | ￼ ]).
elem3(X, [Y | L]) :- X\==Y, elem3(X,L).