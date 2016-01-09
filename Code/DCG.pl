% read_dcg(C)
read_dcg(C):-
	get0(Input),
	read_dcg(C1,Input),
	writeln(C1).

read_dcg([],Input):-
	member(Input,`\n\t`),
	!.
read_dcg([In|L],In):-
	get0(In2),
	read_dcg(L,In2).


dgc_cal([Month,Year]) --> arg_month(Month), arg_year(Year), !.
dgc_cal([Month,Year]) --> arg_year(Year), !,
	{current_date(Month,_)}.
dgc_cal([Month,Year]) --> [],
	{current_date(Month,Year)}.

arg_month(Month) --> ` `, integer(Month),
	{between(1,12,Month)}.
arg_year(Year) --> ` `,integer(Year),
	{between(1,9999,Year)}.