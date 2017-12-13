/* SE3 LP - Aufgabenblatt 08

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 12.12.2017
*/

/*Aufgabe 1*/

%Hash Funktion 
%getHash(+Atom, +AnzahlEintraege, -Hashwert)
getHash(Atom, Entries, Hash) :-
	atom_codes(Atom, L),
	sum_list(L, Sum),
	Hash is Sum mod Entries.
	
empty(0, []).
empty(N, [[]|HT]) :-
	N > 0,
	N1 is N - 1,
	empty(N1, HT).
	
empty(N, HT) :-
	findall([], between(1, N, _), HT).

/*Aufgabe 2*/

/*2.1*/

%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

%Prüft, ob eine Binaerzahl gerade ist
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

%Prüft, ob eine Binaerzahl ungerade ist
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
%Verdoppelt eine Binaerzahl
%bin_double(?BinaryList, ?Doubled)
bin_double([0], [0]).
bin_double(L, Doubled) :-
	Doubled = [0|L].
	
%Ausgaben:

%?- bin_double([1], L).
%L = [0, 1].

%?- bin_double([1, 0, 0, 1], L).
%L = [0, 1, 0, 0, 1].

%Halbiert eine Binaerzahl, wenn sie gerade ist
%bin_half(?BinaryList, ?Half)
bin_half(L, Half) :-
	bin_double(Half, L).
	
%Ausgaben:	

%?- bin_half([1], L).
%false.

%?- bin_half([0, 0, 1], L).
%L = [0, 1]

/*2.3*/

%Ueberfuehrt eine ungerade Binaerzahl in eine gerade, durch subtraktion von 1
%make_bin_even(+BinaryList, -EvenBinaryList)
make_bin_even([1], [0]).
make_bin_even(L, Even) :-
	bin_odd(L),
	tail(L, Tail),
	Even = [0|Tail].

%Ausgaben:	
	
%?- make_bin_even([1, 1], L).
%L = [0, 1].

%?- make_bin_even([0, 1, 1, 1, 1], L).
%false.

/*2.4*/

%Prüft, ob eine Binaerzahl vorliegt
%is_bin(+BinaryList)
is_bin([LSB]) :- LSB =< 1.
is_bin(L) :- 
	length(L, Length),
	Length > 0,
	head(LSB, L),
	LSB =< 1,
	tail(L, Tail),
	is_bin(Tail).

%Ausgaben

%?- is_bin([]).
%false.

%?- is_bin([1]).
%true .

%?- is_bin([0]).
%true .

%?- is_bin([0, 1, 0, 1, 1]).
%true .

%?- is_bin([0, 1, 0, 9, 1]).
%false.

%?- is_bin([0, 1, 0, 0]).
%true .

/*2.4 Bonus*/

%Prüft, ob eine Binaerzahl vorliegt, die keine fuehrenden Nullen enthaelt.
%is_bin_bonus(+BinaryList)
is_bin_bonus([0]) :- true.
is_bin_bonus(L) :-
	reverse(L, L2),
	head(LSB, L2),
	LSB =\= 0,
	is_bin(L).

%Ausgaben:

%?- is_bin_bonus([0]).
%true .

%?- is_bin_bonus([1]).
%true .

%?- is_bin_bonus([1, 0, 1, 0, 1]).
%true .

%?- is_bin_bonus([1, 0, 1, 1, 0]).
%false.

%?- is_bin_bonus([1, 0, 1, 9, 1]).
%false.

/*2.5*/
%Wandelt eine Binaerzahl in eine Natuerliche Zahl um
%binToInt(+BinaryList, +Nat)
binToInt(L, Int) :-
	convertBin(L, 1, Int).

%Hilfsprädikat für die Umrechnung
%convertBin(+BinaryList, +ExpoSequence, -Nat)	
convertBin([1], C, C).	
convertBin([0], 1, 0). 
convertBin(L, C, N) :-	
	length(L, Length), 
	Length > 0,			
	head(LSB, L),					%Wir holen uns den Listenkopf LSB
    tail(L, Tail),					%Die liste wird um den Listenkopf verringert
	TempResult is  C * LSB,			%Das Zwischenergebnis ist am Anfang 1 oder 0, da LSB 1 oder 0 ist und C = 1 am Anfang gilt
	NextC is 2 * C,					%C wird nun verdoppelt und hat im nächsten rek. Aufruf den Wert 2
	convertBin(Tail, NextC, N2),	%Rekursiver Aufruf mit der Restliste, 2, und N2
	N is N2 + TempResult.			%Zuletzt werden alle Zwischenergebnisse addiert. 

%Ausgaben

%?- binToInt([0], X).
%X = 0 ;
%false.

%?- binToInt([1], X).
%X = 1 ;
%false.
	
%?- binToInt([1, 0, 1], X).
%X = 5 ;
%false.

%?- binToInt([1, 0, 1, 0, 1, 0, 1, 0, 1, 1], X).
%X = 853 ;
%false.

%?- binToInt([1, 0, 1, 0, 1, 0], X).
%false.	

%Wandelt eine Natuerliche Zahl in eine Binaerzahl um
%intToBin(+Integer, -BinaryList)
intToBin(0, []).		
intToBin(Int, L) :-
	Int > 0,
	Rem is Int / 2,
	DivRem is floor(Rem),
	ModRem is Int mod 2,
	intToBin(DivRem, L2),
	append([ModRem], L2, L).

%Ausgaben

%?- intToBin(1, X).
%X = [1] ;
%false.	

%?- intToBin(2, X).
%X = [0, 1] ;
%false.	

%?- intToBin(255, X).
%X = [1, 1, 1, 1, 1, 1, 1, 1] 
%false.

%?- intToBin(256, X).
%X = [0, 0, 0, 0, 0, 0, 0, 0, 1] 
%false.

/*2.6*/

%TODO