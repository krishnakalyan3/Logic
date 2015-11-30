% ['/Users/krishna/Dropbox/DMKM/Course/Logic and Knowledge Representation/Tutorial/rules_temp.pl'].

avg_temp(phx, 100).
avg_temp(sf, 68).

avg_temp_cels(location, C_Temp):-
	avg_temp(location, F_Temp),
	C_Temp is (F_Temp - 32) * 5/9.

