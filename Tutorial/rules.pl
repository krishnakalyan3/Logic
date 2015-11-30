% ['/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Tutorial/rules.pl'].

weather(pheonix,hot , summer).
weather(la, warm, summer).

warmer_than(C1,C2):-
	weather(C1, hot, summer),
	weather(C2, warm, summer),
	write(C1), write(' is warmer than '), write(C2), nl. 