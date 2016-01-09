command2(C):-
	get0(Input),
	command2(C1,Input),
	atom_codes(C2,C1), % gets the atom of the ascii codes read
	normalize_space(codes(C3),C2), % trims the spaces of the phrase
									%and returns the ascii codes
	phrase(g_command(C),C3).
command2([],Input):-
	member(Input,`\n\t`),
	!.
command2([In|L],In):-
	get0(In2),
	command2(L,In2).


arg_calendar([Month,Year]) --> arg_month(Month), arg_year(Year), !.
% Year
arg_calendar([Month,Year]) --> arg_year(Year), !,
	{current_date(Month,_)}.
% (no arguments)
arg_calendar([Month,Year]) --> [],
	{current_date(Month,Year)}.

%% other calendar clauses
% checks that it starts with a space and it is an integer inside
%the range
arg_month(Month) --> ` `, integer(Month),
	{between(1,12,Month)}.
% checks that it starts with a space and it is an integer inside
%the range
arg_year(Year) --> ` `, integer(Year),
	{between(1,9999,Year)}.