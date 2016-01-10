working_directory(_, 
	'/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Prolog_Code/Code').

% Conditional Checks
% We check the follwing
read_command(L1):-             
    get0(C),
    read_command(_, L, C),name(X, L),atomic_list_concat([M1|T1],' ',X),last([M1|T1],Z1),name(Z1,[H1,H2|T]),
    (
    [H1,H2] == [62,62]
    	-> list_butlast([M1|T1],OP1),default_sol(OP1,L2),name(L3,T),L1 = append(L2,L3);
    [H1] == [62] 
    	-> list_butlast([M1|T1],OP1),default_sol(OP1,L2),name(L3,[H2|T]),L1 = send(L2,L3);
    default_sol([M1|T1],LO),
    LO = L1
    ).

list_butlast([X|Xs],Ys) :-                % use auxiliary predicate ...
   list_butlast_prev(Xs,Ys,X).            % ... which lags behind by one item
list_butlast_prev([],[],_).
list_butlast_prev([X1|Xs],[X0|Ys],X0) :-  
   list_butlast_prev(Xs,Ys,X1).           % lag behind by one

default_sol(X,Y):-
	cmd_cal(X,Y).
default_sol(X,Y):-
	cmd_cat(X,Y).
default_sol(X,Y):-
	cmd_cp(X,Y).
default_sol(X,Y):-
	cmd_grep(X,Y).
default_sol(X,Y):-
	sub_element_cat(X,Y1),flatten(Y1,Y).

read_command(_, [], X):-
	member(X, `.\n\t`), !.
read_command(X, [C|L], C):-
	get0(C1),
	read_command(X, L, C1).

% ======================================= %

% cmd_cal([cal],Y).
cmd_cal([cal],calendar( M , Y )):-
	default_cal(M,Y).
	

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

default_cal(M,Y):-
	get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(month, DateTime, M),
    date_time_value(year, DateTime, Y).

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

% ======================================= %

read_dcg(R):-
	get0(Input),
	read_dcg(C,Input),
	phrase(default(M),C),
	R =..M.

read_dcg([],Input):-
	member(Input,`\n\t`),
	!.
read_dcg([In|L],In):-
	get0(In2),
	read_dcg(L,In2).

% atom_codes('cat -nb file1 file2',Y),phrase(default(X),Y).
% phrase(default(X),[99,97,108]).
default([calendar|Args]) --> `cal`, cal(Args),! .
default([concatenate|Args]) --> `cat`, cat(Args), !.
default([copy|Args]) --> `cp`, cp(Args), !.
default([search_expr|Args]) --> `grep`, grep(Args), !.
% ======================================= %
% atom_codes('',X), phrase(cal(Y),X). 


cal([M,Y]) --> ` `, integer(M),{between(1,12,M)}, ` `,integer(Y),{between(1,9999,Y)}.

% atom_codes(' 1',X), phrase(cal(Y),X).
cal([Y]) --> ` `, integer(Y),
	{between(1,9999,Y)}.

cal([M,Y]) --> [],{default_cal(M,Y)}.

integer(I) --> digit(D0), digits(D),
	{number_codes(I,[D0|D])}.
digits([D|L]) --> digit(D), !, digits(L).
digits([]) --> [].
digit(D) --> [D],
	{code_type(D,digit)}.

% ======================================= %

% atom_codes('file1',X), phrase(cat(Y),X). 
cat([C,Y]) --> ` -`,cat_args(C),files(Y).
cat([[],Y]) --> files(Y).
cat_args([X|Y]) --> options(X),cat_args(Y).
cat_args([X]) --> options(X).
options(n) --> `n`.
options(b) --> `b`.
options(s) --> `s`.
options(u) --> `u`.
options(v) --> `v`.
options(e) --> `e`.
options(t) --> `t`.

% atom_codes(' file1 file2 file3',Y),phrase(files(M),Y).
% After space file is a word follwed recursively.
% AC contains the name of the file.
files([AC|FL]) --> ` `, file(F), files(FL),
	{not(F =[]),
	atom_codes(AC,F)}, !.

% Base case when i have a single file
files([AC]) --> ` `, file(F),
	{not(F=[]),
	atom_codes(AC,F)}.

% Check for negation
file([F|L]) --> [F], file(L),
	{not(member(F,` ->`))}, !.
file([]) --> [].
% ======================================= %

% atom_codes(' file1 file2 target',Y),phrase(cp(M,N),Y).
% atom_codes(' -R -f -p file1 file2 target',Y),phrase(cp(M,N,Q),Y).
cp([C,X,Y]) --> cp_args(C),cp_file(X,Y).
cp([X,Y]) --> cp_file(X,Y).

% atom_codes(' -R -f -i',Y),phrase(cp_args(M),Y).
cp_args([X|Y]) --> cp_options(X),cp_args(Y).
cp_args([X]) --> cp_options(X).
cp_options(r) --> ` -r`;` -R`.
cp_options(f) --> ` -f`.
cp_options(i) --> ` -i`.
cp_options(p) --> ` -p`.

% atom_codes(' file1 file2 target',Y),phrase(cp_file(M,N),Y).
% Case when we have more than multiple files and a target
cp_file([AC|FL],Y) --> ` `,file(F),cp_file(FL,Y),
	{not(F=[]),
	atom_codes(AC,F)}.

% Base case to get the file and target as agruments
cp_file([AC],AD) --> ` `,file(F),` `,file(Y),
	{not(F=[]),
	atom_codes(AC,F)},
	{not(Y=[]),
	atom_codes(AD,Y)}.

% ======================================= %
grep([[],[],[],X]) --> files(X).


