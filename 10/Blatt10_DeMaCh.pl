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

%1.1
print_all_courses() :-
	get_date_list(L),
	get_all_courses(L, CList),
	display("DAX", CList).
	
get_all_courses([], []). 
get_all_courses(L, CList) :-
	head(Head, L),
	tail(L, Tail),
	dax(Head, EKurs, SKurs),
	append([EKurs / 700], [SKurs / 700], DaxPart),
	get_all_courses(Tail, NewList),
	append(NewList, DaxPart, CList).	

%1.2
print_all_avg_courses(N) :-
	get_avg_courses(N, R),
	display("AVG", R).

get_avg_courses(N, R) :-
	get_date_list(L),
	length(L, Length),
    N =< Length,
	get_all_avgs(L, N, R).
	
get_all_avgs(L, N, []) :-  length(L, Length), Length < N.
get_all_avgs(L, N, R) :-
	sublist(L, N, Sublist),
	get_all_courses(Sublist, M),
	get_AVG(M, AVG),
	tail(L, Tail),
	get_all_avgs(Tail, N, R2),
	append(R2, [AVG], R).
	
get_AVG(L, R) :-
	sumlist(L, Sum),
	length(L, Length),
	R is Sum / Length.

sublist(L,N,P) :- 
	append(P,_,L),
	length(P,N).
	
trim(L,N,S) :-      
	append(P,S,L),
	length(P,N).
