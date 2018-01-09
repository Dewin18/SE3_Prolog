/* SE3 LP - Aufgabenblatt 10

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 09.01.2018
*/

%:- consult('dax2016.pl').
:- consult('dax2017.pl').
:- consult('display_pi.pl').

%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

get_date_list(L2) :- 
	findall(Date, dax(Date, _,_), L), 
	reverse(L, L2).

print_all_courses(CList) :-
	get_date_list(L),
	get_all_courses(L, [], CList).
	%display("DAX", Clist).
	
get_all_courses(L,[], _) :- 
	length(L, Length),
	Length =< 0.
	
get_all_courses(L, EList, Clist) :-
	length(L, Length),
	Length > 0,
	head(Head, L),
	tail(L, Tail),
	dax(Head, EKurs, SKurs),
	append([EKurs], [SKurs], DaxPart),
	append(EList, DaxPart, Newlist),
	Clist = NewList,
	get_all_courses(Tail, NewList, _).
	
	