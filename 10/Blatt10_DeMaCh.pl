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

%Gibt eine Liste aller DAX Daten zurueck
get_date_list(L2) :- 
	findall(Date, dax(Date, _,_), L), 
	reverse(L, L2).

/*1.1*/

%Zeigt den DAX Verlauf auf dem Display an
print_dax() :-
	get_date_list(L),
	get_all_prices(L, APL, _, _),
	reverse(APL, APL2),
	display("DAX", APL2).
	
%Liefert drei Listen über den DAX Kurs zurueck
%AP ist eine Liste mit allen Eröffnungskursen und Schlusskursen.
%OP ist eine Liste mit allen Eröffnungskursen
%CP ist eine Liste mit allen Schlusskursen
%get_all_prices(+DAXDateList, -AllDAXPrices, -AllDAXOpeningPrices, -AllDAXClosingPrices) 	
get_all_prices([], [], [], []). 
get_all_prices(L, AP, OP, CP) :-
	head(Head, L),
	tail(L, Tail),
	dax(Head, OpeningPrice, ClosingPrice),
	OPScaled is OpeningPrice / 700,
	CPScaled is ClosingPrice / 700,
	append([CPScaled], [OPScaled], DaxPart),
	get_all_prices(Tail, AP2, OP2, CP2),
	append(AP2, DaxPart, AP),
	append(OP2, [OPScaled], OP),
	append(CP2, [CPScaled], CP).	

/*1.2*/

%Zeigt den DAX Mittelwertverlauf auf dem Display an
%print_avg_dax(+AnalyzeWindowSize)
print_avg_dax(N) :-
	get_date_list(L),
	get_avg_prices(L, N, R),
	display("AVG", R).

%Hilfspraedikat fuer die Prüfung des Analysefensters. 
%Das Analysefenster kann nicht groesser sein als die Anzahl der DAX Fakten
%get_avg_prices(+DAXDateList, +AnalyzeWindowSize, -AVGList)
get_avg_prices(L, N, R) :-
	length(L, Length),
    N =< Length,
	get_all_avgs(L, N, R).

%Ruft das Praedikat fuer die die Mittelwertsberechnung auf.
%Es wird der Mittelwert fuer den Eroeffnungskurs, sowie fuer
%den Schlusskur separat, schrittweise berechnet.
%get_all_avgs(+DAXDateList, +AnalyzeWindowSize, -AVGList)
get_all_avgs(L, N, []) :-  length(L, Length), Length < N.
get_all_avgs(L, N, R) :-
	get_sublist(L, N, Sublist),
	get_all_prices(Sublist, _, OP, CP),
	get_avg(OP, OP_AVG),
	get_avg(CP, CP_AVG),
	append([OP_AVG], [CP_AVG], AVG),
	tail(L, Tail),
	get_all_avgs(Tail, N, R2),
	append(R2, AVG, R).

%Hilfspraedikat: Berechnet den Mittelwert aller Elemente einer Liste 	
%get_avg(+List, -AVG)
get_avg(L, R) :-
	sumlist(L, Sum),
	length(L, Length),
	R is Sum / Length.

%Hilfspraedikat: Gibt die Subliste der ersten N Elemente einer Liste zurueck
%get_sublist(+List, +NumberOfElements, -Sublist)
get_sublist(L, N, S) :- 
	append(S, _, L),
	length(S, N).
	
/*1.3*/

%Zeigt den Mittelwert fuer zwei verschieden große Analysefenster an
%print_two_avg_dax(+AnalyzeWindowSize1, +AnalyzeWindowSize2)
print_two_avg_dax(N1, N2) :-
	get_date_list(L),
	get_avg_prices(L, N1, R),
	get_avg_prices(L, N2, R2),
	displayTwo("AVG DAX comparison", R, R2).

/*1.4*/

%TODO

/*1.5*/
	
make_forecast(Date1, Date2, Forecast, AP2) :-
	Date1 @< Date2,
	get_date_list(L),
	nth0(Index1, L, Date1),
	nth0(Index2, L, Date2),
	Diff is (Index2 + 1) - Index1,
	trim_list(L, Index1, TList),
	get_sublist(TList, Diff, Sublist),
	get_all_prices(Sublist, AP, _, _),
	reverse(AP, AP2).
	%1 Erstelle Liste, aller Daten zwischen D1 und D2 #DONE
	%2 Erstelle Prognose #TODO
	
trim_list(L, N, S) :-      
	append(P, S, L),
	length(P, N).

	
	
