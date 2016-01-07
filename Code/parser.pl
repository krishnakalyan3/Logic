 working_directory(_, 
	'/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').



read_command(L) :-             
    get0(C),
    read_command(_, L, C).

read_command(Y):- 
	get0(C),
	read_command(X, L,C),
	name(X, L),
	atomic_list_concat(M,' ',X),
	cmd_cal(M,Y).
	
read_command(_, [], X):-
	member(X, `.\n\t`), !.
read_command(X, [C|L], C):-
	get0(C1),
	read_command(X, L, C1).

cmd_cal([cal],calendar( M , Y )):-
	monthyear(M,Y).

cmd_cal( [cal,(M),(Y)] , calendar( M1 , Y1 ) ):-
	atom_number(M,M1),atom_number(Y,Y1),
  	integer(M1),
  	between(1,12,M1) ,
  	integer(Y1) ,
  	between(1,9999,Y1).

monthyear(M,Y) :-
    get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(month, DateTime, M),
    date_time_value(year, DateTime, Y).


