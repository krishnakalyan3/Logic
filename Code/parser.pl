working_directory(_, 
	'/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').

% Conditional Checks
% We check the follwing
read_command(L1):-             
    get0(C),
    read_command(_, L, C),name(X, L),atomic_list_concat([M1|T1],' ',X),
    ([M1] == [cal]
  		->cmd_cal([M1|T1],L1);
  	[M1] == [cat]
  		->cmd_cat([M1|T1],L1);
  	[M1] == [cp]
  		->cmd_cp([M1|T1],L1);
  	[M1] == [grep]
  		->cmd_grep([M1|T1],L1);
    L = L1
    ).

read_command(_, [], X):-
	member(X, `.\n\t`), !.
read_command(X, [C|L], C):-
	get0(C1),
	read_command(X, L, C1).


% ======================================= %

% cmd_cal([cal],Y).
cmd_cal([cal],calendar( M , Y )):-
	get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(month, DateTime, M),
    date_time_value(year, DateTime, Y).

cmd_cal( [cal,(M),(Y)] , calendar( M1 , Y1 ) ):-
	atom_number(M,M1),atom_number(Y,Y1),
  	integer(M1),
  	between(1,12,M1) ,
  	integer(Y1) ,
  	between(1,9999,Y1).

cmd_cal( [cal,(Y)] , calendar( Y1 ) ):-
   atom_number(Y,Y1),
   integer(Y1),
   between(1,9999,Y1).

% ======================================= %

% cmd_cat([cat,'-nbsuvet',file1,file2],Y).
cmd_cat([cat|T],Z):-
	divide_dashed(T,Z1,Z2),sub_element_cat(Z1,Z3),flatten(Z3,[_|T1]),sub_member_cat(T1,Z4),name(Z5,Z4),
	Z = concatenate(Z5,Z2).

% Converts -nbsuvet to ASCII 
sub_element_cat([],[]).
sub_element_cat(X,[Z|Y]):-
	X = [H|T],
	atom_codes(H,Z),
	sub_element_cat(T,Y).

% Check if the ASCII Code matches [110,98,115,117,118,101,116]
sub_member_cat([],[]).
sub_member_cat(X,[H|Y]):-
	X = [H|T],
	member(H,[110,98,115,117,118,101,116]),
	sub_member_cat(T,Y).

% ======================================= %

% cp [-r|-R] [-f] [-i] [-p] file1 [file2 …] target
% cmd_cp([cp,'-r','-i','-p',file1,target],Z).
cmd_cp([cp|T],Z):-
	last(T,Z1),divide_dashed(T,Z2,Z3),append(WithoutLast, [_], Z3),len(WithoutLast) \= 1,sub_element(Z2,Y),
	WithoutLast \= [],
	Z = copy(Y,WithoutLast, Z1).

% This code allows us to strip the '-' symbol from an atom
sub_element([],[]).
sub_element(X,[S|Y]):-
	X = [H|T],
	sub_atom(H, 1, 1, _, S),
	member(S,[r,f,i,p,'R']),
	sub_element(T,Y).

% spits the list if it has dashes
divide_dashed(L, D, P) :-
    partition(dashed, L, D, P).
dashed(S) :- atom_concat(-,_,S).

% ======================================= %

% cmd_grep([grep,'-bcihlnvsy','-e',expe,file1,file2],Y).
% cmd_grep([grep,'-bcihlnvsy',file1,file2],Y). 
cmd_grep([grep|T],Z):-
	divide_dashed(T,[Z1H|Z1T],[Z2|Z3]),length([Z1H|Z1T],Y),Y == 2,sub_element_cat([Z1H],[Z4]),removehead(Z4,Z5),
	sub_member_grep(Z5,Z6),name(Z7,Z6),
	Z = search_expr(Z7,Z1T,Z2,Z3).

cmd_grep([grep|T],Z):-
	divide_dashed(T,[Z1H|Z1T],[Z2|Z3]),length([Z1H|Z1T],Y),Y == 1,sub_element_cat([Z1H|Z1T],[Z4]),
	removehead(Z4,Z5),sub_member_grep(Z5,Z6),name(Z7,Z6),
	Z = search_expr(Z7,[],[],[Z2|Z3] ).


removehead([_|Tail], Tail).

sub_member_grep([],[]).
sub_member_grep(X,[H|Y]):-
	X = [H|T],
	member(H,[98,99,105,104,108,110,118,115,121]),
	sub_member_grep(T,Y).



