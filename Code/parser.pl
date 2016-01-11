% Sai Krishna Kalyan : Prolog Assignment 3

% Reading the characters and based on '>' or '>>' return the output required else return the ascii code
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


% Predicate to remove the last element in the List
list_butlast([X|Xs],Ys) :-                
   list_butlast_prev(Xs,Ys,X).            
list_butlast_prev([],[],_).
list_butlast_prev([X1|Xs],[X0|Ys],X0) :-  
   list_butlast_prev(Xs,Ys,X1).           

% based on input List Conditional Decions are made
default_sol(X,Y):-
	cmd_cal(X,Y),!.
default_sol(X,Y):-
	cmd_cat(X,Y),!.
default_sol(X,Y):-
	cmd_cp(X,Y),!.
default_sol([_|T],Y):-
	cmd_grep(T,Y),!.
default_sol(X,Y):-
	sub_element_cat(X,Y1),flatten(Y1,Y),!.

read_command(_, [], X):-
	member(X, `.\n\t`), !.
read_command(X, [C|L], C):-
	get0(C1),
	read_command(X, L, C1).
% ======================================= %

% Wrapper Predicate to return the default Month and Year
cmd_cal([cal],calendar( M , Y )):-
	default_cal(M,Y).
	
% Cal predicate retuns user supplied Date after checking the range
cmd_cal( [cal,(M),(Y)] , calendar( M1 , Y1 ) ):-
	atom_number(M,M1),atom_number(Y,Y1),
  	integer(M1),
  	between(1,12,M1) ,
  	integer(Y1) ,
  	between(1,9999,Y1).

% Predicate returns the Year after checking the range
cmd_cal( [cal,(Y)] , calendar( Y1 ) ):-
   atom_number(Y,Y1),
   integer(Y1),
   between(1,9999,Y1).

% Predicate to return the default date
default_cal(M,Y):-
	get_time(Stamp),
    stamp_date_time(Stamp, DateTime, local),
    date_time_value(month, DateTime, M),
    date_time_value(year, DateTime, Y).
% ======================================= %

% Cat predicate to return the output in the required format
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

% Cmd predicate get the output in the required format.
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

% Grep predicate gets the output in the require format. It expects input with arity 5
% cmd_grep(['-bcihlnvsy','-e',expe,file1,file2],Y).
cmd_grep(X,A):-cmd_grep(X, A1, Z, M, F),A=search_exp(A1,Z,M,F).

% Predicate to check if if '-e' is porvied 
cmd_grep(['-e'|T],R1,['e'],R3,R):-
    !,
    cmd_grep(T,R1,_,R3,R).

% Predicate to check if the argument is compliant
cmd_grep([H|T],T2,R2,R3,R):-
    atom_chars(H,['-'|T1]),
    !,
    ismember(T1,T2),
    cmd_grep(T,_,R2,R3,R).

% Predicate to make sure that there is more than
cmd_grep([H|T],[],[],H,T):-
    not(T = []),!.

% List of arguments that need to beck checked for this predicate
ismember([],[]).
ismember([H|T],[H|R]):-
    member(H,[b,c,i,h,l,n,v,s,y]),
    ismember(T,R).
% ======================================= %

% Reading the characters and based on '>' or '>>' return the output required else return the ascii code
read_dcg(R):-
	get0(Z),
	read_dcg(C,Z),
	phrase(send_append(M),C),
	R =..M.

read_dcg([],Z):-
	member(Z,`\n\t`),
	!.
read_dcg([I|L],I):-
	get0(I2),
	read_dcg(L,I2).

% Decied if its a send or append or use defaults
% atom_codes('abc',Y),phrase(send_append(X),Y).
send_append([append,R,Y1]) --> default(X) ,` >>`,file(Y),{atom_codes(Y1,Y)},{R=..X}.
send_append([send,R,Y1]) --> default(X) ,` >`,file(Y),{atom_codes(Y1,Y)},{R =..X}.
send_append(X) --> default(X).

% based on head of the list decide on the type of operation to preform
% atom_codes('cat -nb file1 file2',Y),phrase(default(X),Y).
default([calendar|A]) --> `cal`, cal(A),! .
default([concatenate|A]) --> `cat`, cat(A), !.
default([copy|A]) --> `cp`, cp(A), !.
default([search_expr|A]) --> `grep`, grep(A), !.
% ======================================= %

% Check for the correct range for the month and year if both inputs are provided
% atom_codes('',X), phrase(cal(Y),X). 
cal([M,Y]) --> ` `, integer(M),{between(1,12,M)}, ` `,integer(Y),{between(1,9999,Y)}.

% Only if the year is provided return year after checking its range
% atom_codes(' 1',X), phrase(cal(Y),X).
cal([Y]) --> ` `, integer(Y),
	{between(1,9999,Y)}.

% Return the default year if no input is provided
cal([M,Y]) --> [],{default_cal(M,Y)}.

% Integer and Digit check
integer(I) --> digit(D0), digits(D),
	{number_codes(I,[D0|D])}.
digits([D|L]) --> digit(D), !, digits(L).
digits([]) --> [].
digit(D) --> [D],
	{code_type(D,digit)}.
% ======================================= %

% concatinate dcg checks for 
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


% After space file is a word follwed recursively.
% AC contains the name of the file.
% atom_codes(' file1 file2 file3',Y),phrase(files(M),Y).
files([AC|FL]) --> ` `, file(F), files(FL),
	{not(F =[]),
	atom_codes(AC,F)}, !.

% Base case single file
files([AC]) --> ` `, file(F),
	{not(F=[]),
	atom_codes(AC,F)}.

% Check for negation
file([F|L]) --> [F], file(L),
	{not(member(F,` ->`))}, !.
file([]) --> [].
% ======================================= %

% Copy DCG  checks for the arguments and files supplied
% atom_codes(' -R -f -p file1 file2 target',Y),phrase(cp(M,N,Q),Y).
cp([C,X,Y]) --> cp_args(C),cp_file(X,Y).
cp([X,Y]) --> cp_file(X,Y).

% optional dcg list to check for  -R -f -i
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

% Grep predicate checks for all conidtions and options + arguments
grep([A,Z,Y,X]) --> ` -`,grep_options1(A),grep_options2(Z), expr(Y),files(X).

% Check only for expression -e and files
% atom_codes(' -e expr file1 file2 file3',Y),phrase(grep(M),Y).
grep([[],Z,Y,X]) --> grep_options2(Z), expr(Y),files(X).

% This predicate checks for expression and the files
% atom_codes(' expr file1 file2 file3',Y),phrase(grep(M),Y).
grep([[],[],Y,X]) --> expr(Y),files(X).
expr(Y) --> ` `,file(Y1),{atom_codes(Y,Y1)}.

% option to check -e
grep_options2(e) --> ` -e`.

% Options to check -bcihlnvsy
grep_options1([X|Y]) --> options1(X),grep_options1(Y).
grep_options1([X]) --> options1(X).
options1(b) --> `b`.
options1(c) --> `c`.
options1(i) --> `i`.
options1(h) --> `h`.
options1(l) --> `l`.
options1(n) --> `n`.
options1(v) --> `v`.
options1(s) --> `s`.
options1(y) --> `y`.