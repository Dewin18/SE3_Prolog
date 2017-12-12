/* SE3 LP - Aufgabenblatt 08

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 12.12.2017
*/

/*Aufgabe 1*/

%TODO

/*Aufgabe 2*/

/*2.1*/

%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

%Prüft, ob eine Binärzahl gerade ist
%bin_even(+BinaryList)
bin_even([]).
bin_even(L) :- 
	head(LSB, L),
	LSB =:= 0.
	
%Ausgaben:

%?- bin_even([]).
%true 

%?- bin_even([0,1,1]).
%true.

%?- bin_even([1,1,1]).
%false.

%Prüft, ob eine Binärzahl ungerade ist
%bin_odd(+BinaryList)
bin_odd(L) :- 
	head(LSB, L),
	LSB =:= 1.
	
%Ausgaben:

%?- bin_odd([]).
%false.

%?- bin_odd([0,1,1]).
%false.

%?- bin_odd([1,1,1]).
%true.

/*2.2*/
%Verdoppelt eine Binärzahl
%bin_double(?BinaryList, ?Doubled)
bin_double([0], [0]).
bin_double(L, Doubled) :-
	Doubled = [0|L].
	
%Ausgaben:

%Halbiert eine Binärzahl, wenn sie gerade ist
%bin_half(?BinaryList, ?Half)
bin_half(L, Half) :-
	bin_double(Half, L).
	
%Ausgaben:	