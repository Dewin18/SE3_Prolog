/* SE3 LP - Aufgabenblatt 10

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 15.01.2018
*/

%:- consult('dax2016.pl').
:- consult('dax2017.pl').
:- consult('display_pi.pl').

%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

%Gibt eine Liste aller DAX Daten zurueck
get_date_list(L) :- 
	findall(Date, dax(Date, _,_), L).

/*1.1*/

%Zeigt den DAX Verlauf auf dem Display an
print_dax() :-
	get_date_list(L),
	get_all_prices(L, 700, AP, _, _),
	display("DAX", AP).
	
%Beispieleingabe	
%:- print_dax().	
	
%Liefert drei Listen über den DAX Kurs zurueck
%Fuer eine bessere Visualisierung auf dem Display wird jeder Wert durch den Scale geteilt.
%AP ist eine Liste mit allen Eröffnungskursen und Schlusskursen.
%OP ist eine Liste mit allen Eröffnungskursen
%CP ist eine Liste mit allen Schlusskursen
%get_all_prices(+DAXDateList, +ScaleFactor, -AllDAXPrices, -AllDAXOpeningPrices, -AllDAXClosingPrices) 	
get_all_prices([], _, [], [], []). 
get_all_prices(L, Scale, AP, OP, CP) :-
	head(Head, L),
	tail(L, Tail),
	dax(Head, OpeningPrice, ClosingPrice),
	OPScaled is OpeningPrice / Scale,
	CPScaled is ClosingPrice / Scale,
	append([OPScaled], [CPScaled], DaxPart),
	get_all_prices(Tail, Scale, AP2, OP2, CP2),
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
	
%Beispieleingabe
%:- print_avg_dax(3).	

%Hilfspraedikat fuer die Pruefung des Analysefensters. 
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
	get_all_prices(Sublist, 700, _, OP, CP),
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

%Beispieleingabe
%:- print_two_avg_dax(1, 5).	
	
/*1.4*/

%TODO

/*1.5*/

%Beispieleingabe

%:- make_forecast('02.01.2017', '04.01.2017', LetzterWert, Prognose, Nachricht).
%LetzterWert = 11584,
%Prognose = 11649.6,
%Nachricht = "Anstieg erwartet" 

%:- make_forecast('02.01.2017', '22.02.2017', LetzterWert, Prognose, Nachricht).
%LetzterWert = 11998,
%Prognose = 11793.272631578948,
%Nachricht = "Stagnation erwartet" ;	
	
%Das Praedikat gibt die Auskunft darueber, ob der DAX kurs evtl. steigen oder stagnieren wird. 
%Die Berechnung erfolgt nach der Formel http://westclintech.com/SQL-Server-Statistics-Functions/SQL-Server-TREND-function
%make_forecast(+Date1, +Date2, -LastValue, -ForecastValue, -Message)
make_forecast(Date1, Date2, LastElement, Forecast, Message) :-
	Date1 @< Date2,
	get_date_list(L),
	nth0(Index1, L, Date1),
	nth0(Index2, L, Date2),
	Diff is (Index1 + 1) - Index2,
	trim_list(L, Index2, TList),
	get_sublist(TList, Diff, Sublist),
	get_all_prices(Sublist, 1, AP, _, _),
	length(AP, Length),
	LastIndex is Length - 1,
	nth0(LastIndex, AP, LastElement),
	compute_trend(AP, Forecast),
	print_mess(LastElement, Forecast, Message).

%Hilfspraedikat: Entfernt die ersten N elemente einer Liste
%trim_list(+List, +NumberOfElements, -TrimedList)	
trim_list(L, N, S) :-      
	append(P, S, L),
	length(P, N).	

%Berechnung aller Zwischenergebnisse fuer die Trendformel	
compute_trend(AP, Forecast) :-
	length(AP, Length),
	yQ(AP, Length, YQ),
	tQ(Length, TQ),
	tyt(AP, Length, TYT),
	T = Length,
	t_sqare(AP, Length, TSquare),
	TQSquare is TQ * TQ,
	b(TYT, T,  YQ, TQ, TSquare, TQSquare, B),
	a(YQ, B, TQ, A),
	mQ(A, B, Length + 1, Forecast).	
	
yQ(AP, Length, YQ) :-
	sumlist(AP, Sum),
	YQ is Sum / Length.
	
tQ(Length, TQ) :-
	TQ is ((Length + 1) / 2).

tyt(AP, Length, TYT) :-
	compute_tyt(AP, Length, 0, TYTList),
	sumlist(TYTList, TYT).
	
compute_tyt(_, Length, Counter, []) :- Counter >= Length.	
compute_tyt(AP, Length, Counter, TYTList) :-
	Counter < Length,
	NewCounter is Counter + 1,
	nth0(Counter, AP, CDAX),
	Val is NewCounter * CDAX,
	compute_tyt(AP, Length, NewCounter, TYTList2),
	append(TYTList2, [Val], TYTList).
  
t_sqare(AP, Length, TSquare) :-
    compute_t_square(AP, Length, 0, TSquareList),
	sumlist(TSquareList, TSquare).

compute_t_square(_, Length, Counter, []) :- Counter >= Length.	
compute_t_square(AP, Length, Counter, TSquareList) :-
	Counter < Length,
	NewCounter is Counter + 1,
	Val is NewCounter * NewCounter,
	compute_t_square(AP, Length, NewCounter, TSquareList2),
	append( TSquareList2, [Val], TSquareList).

b(TYT, T,  YQ, TQ, TSquare, TQSquare, B) :-
	B is (TYT - T * YQ * TQ) / (TSquare - T * TQSquare).

a(YQ, B, TQ, A) :-
	A is YQ - B * TQ.
	
mQ(A, B, X, Forecast) :-
	Forecast is A + B * X.

%Gibt die Nachricht aus, ob ein Anstieg bzw. eine Stagnation des Kurses erwartet wird	
%print_mess(+LastValue, +ForecastValue, -Message)	
print_mess(LastElement, Forecast, Message) :-  Forecast > LastElement, Message = "Anstieg erwartet".
print_mess(LastElement, Forecast, Message) :-  Forecast < LastElement, Message = "Stagnation erwartet".
	
/*1.6*/

%TODO

/*1.7*/

%TODO