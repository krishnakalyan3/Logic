% 	working_directory(CWD, 
%	'/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/PracticeSheets').

% Factorial Without Tail Recursion
% Basecase
fac(0,1).
fac(N,F):-
	N>0,
	N1 is N-1,
	fac(N1,F1),
	F is N*F1.
	