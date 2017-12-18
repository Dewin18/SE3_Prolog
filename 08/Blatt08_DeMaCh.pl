/* SE3 LP - Aufgabenblatt 08

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 12.12.2017
*/

/*Aufgabe 1*/

/*1.1*/

%Hash Funktion 
%getHash(+Atom, +AnzahlEintraege, -Hashwert)
getHash(Atom, Entries, Hash) :-
	atom_codes(Atom, L),
	sum_list(L, Sum),
	Hash is (Sum mod Entries) + 1. %Hashwert darf nicht 0 werden, deshalb + 1!!!

%Erzeugt eine neue, leere Hashtabelle der groesse N
%myHash(?Entries, -Hashtable)	
myHash(0, []).
myHash(N, [[]|HT]) :-
	N > 0,
	N1 is N - 1,
	myHash(N1, HT).
	
myHash(N, HT) :-
	findall([], between(1, N, _), HT).
	
%Fügt einer Hashtabelle einen neuen Eintrag an der Stelle des Keys hinzu
%addEntryToHashtable(+Schluessel, +Wert, +Oldhashtable, -Newhashtable)
addEntryToHashtable(Key,Value,Oldhash,Newhash):-aETHelper(Key,Value,Oldhash,[],Newhash).

aETHelper(Key,Value,[],Newhash,Output):-Output = Newhash.
aETHelper(Key,Value,[[Key|Ys]|Xs],Newhash,Output):-append([Key|Ys],[Value],Valuedlist),append(Newhash,[Valuedlist],Temphash),aETHelper(Key,Value,Xs,Temphash,Output).
aETHelper(Key,Value,[X|Xs],Newhash,Output):-append(Newhash,[X],Temphash),aETHelper(Key,Value,Xs,Temphash,Output).

/*1.3*/

%Liest den Wert zu einem Schlüssel aus einer Hashliste aus.
%getEntryfromHash(+Schluessel, +Hashliste, -Ausgabe)
getEntryfromHash(Key,[],Data).
getEntryfromHash(Key,[[Key|Values]|Xs],Data):-Data = Values.
getEntryfromHash(Key,[X|Xs],Data):-getEntryfromHash(Key,Xs,Data).

/*1.4*/
%Unsere definition fügt im Falle einen schon vorhandenen Wertes zu dem jeweiligen Schlüssel den anderen Wert einfach hinten an die Liste an, so das im eine List [Key,Value1,Value2,...,ValueN] ensteht.

/*Aufgabe 2*/

/*2.1*/

%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

%Entfernt das letzte Element aus einer Liste und gibt die Subliste zurueck
remove_last([_], []).
remove_last([X|Xs], [X|Removed]) :- remove_last(Xs, Removed).

%Prueft, ob eine Binaerzahl gerade ist
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

%Prueft, ob eine Binaerzahl vorliegt
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

/*Die Definition ist extensional, da die gesamte "Berechnung" in Form
von Fakten definiert wurde.*/

%Addiert zwei Binaerzahlen gemaess Volladierer
%add_bin(+Binary1, +Binary2, ?Cin, ?Cout, -Sum)
add_bin(0, 0, 0, 0, 0).
add_bin(0, 0, 1, 0, 1).
add_bin(0, 1, 0, 0, 1).
add_bin(0, 1, 1, 1, 0).
add_bin(1, 0, 0, 0, 1).
add_bin(1, 0, 1, 1, 0).
add_bin(1, 1, 0, 1, 0).
add_bin(1, 1, 1, 1, 1).

/*2.7*/
%Berechnet die Summer beliebig langer Binaerzahlen
%add_large_bin(+BinaryList1, +BinaryList2, -Sum)
add_large_bin(L1, L2, Result) :-
	length(L1, Length1),                 %Laenge der ersten Binaerliste bestimmen
	length(L2, Length2),			     %Laenge der zweiten Binaerliste bestimmen
	Max is max(Length1, Length2),        %Maximale Listenlaenge bestimmen
	adapt_length(L1, Max, EL1),          %Binaerliste1 evtl. auf maximale Laenge erweitern
	adapt_length(L2, Max, EL2),          %Binaerliste2 evtl. auf maximale Laenge erweitern
	getSum(EL1, EL2, 0, Cout, R1),       %Summe mit dem Praedikat getSum berechnen
	removeLeadingZero(R1, Cout, Result). %Entfernt eine moegliche fuehrende Null (der letzte Cout von getSum/5)

%Hilfspraedikat um eine Liste Max lang zu machen, damit eine Addition via Volladierer moeglich ist
%adapt_length(+BinaryList, +MaxLength, -NewList)
adapt_length(L1, Max, L1) :- length(L1, Length), Length =:= Max.
adapt_length(L1, Max, NewList) :-
	length(L1, Length),
	Length < Max,
	Difference is Max - Length,
	getZeroList(Difference, ZeroList),
	append(L1, ZeroList, NewList).

%Gibt eine Liste der groesse N zurueck, bei der jedes Element 0 ist.
%getZeroList(+NumberOfElments, -List) 
getZeroList(0, []).
getZeroList(N, L) :-
	N > 0,
	N1 is N - 1,
	getZeroList(N1, L2),
	append(L2, [0], L).

%Berechnung der Summe in der gesamten Liste fuer jeweils zwei Bits 
%getSum(+BinaryList1, +BinaryList2, ?Cin, ?Cout, -Sum)
getSum([], [], Cin, Cin, [Cin]).	
getSum(L1, L2, Cin, Cout, S) :-
		head(H1, L1),
		head(H2, L2),
		add_bin(H1, H2, Cin, Cout2, S2),
		tail(L1, T1),
		tail(L2, T2),
		getSum(T1, T2, Cout2, Cout3, S3),	
		Cout is Cout3,
		append([S2], S3, S). 	

%Hilfspraedikat um die fuehrende 0 aus einer Liste zu entfernen
%removeLeadingZero(+BinaryList, +Cout, -NewList)		
removeLeadingZero(L, Cout, L) :- Cout =:= 1.		
removeLeadingZero(L, Cout, L1) :-
	Cout =:= 0,
	remove_last(L, L1).
		

%Und noch mal eine andere, leichtere Variante :P
%addBinCool(+BinaryList1, +BinaryList2, -Result)
add_bin_cool(L1, L2, Result) :-
	binToInt(L1, N1),
	binToInt(L2, N2),
	intToBin((N1 + N2), Result).

/*2.8*/ %TODO

mult_bin([1], M2, M2).
mult_bin(M1, M2, []) :- bin_even(M1).
mult_bin(M1, M2, Result) :-
	bin_half(M1, Half),
	bin_double(M2, Doubled),
	mult_bin(Half, Doubled, R2),
	add_large_bin(Half, Doubled, R3),
	add_large_bin(R2, R3, Result).
	
	
