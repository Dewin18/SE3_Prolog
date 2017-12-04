/* SE3 LP - Aufgabenblatt 06

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 03.12.2017
*/

%Aufgabe 1.1:

%zins(+Anlagebetrag,+Zinsfaktor,+Anlagedauer,?Endguthaben)

zins(Anlagebetrag,Zinsfaktor,0,Endguthaben):-Endguthaben is Anlagebetrag.
zins(Anlagebetrag,Zinsfaktor,Anlagedauer,Endguthaben):-
	A1 is Anlagedauer - 1,
	B1 = Anlagebetrag + (Anlagebetrag * (Zinsfaktor * 0.01)),
	zins(B1,Zinsfaktor,A1,Endguthaben).

/*

Beispielnutzung:

?- zins(100,5,2,E).
E = 110.25 .

?- zins(100,5,1,E).
E = 105.0 .

Die Ergebnisse sind wie erwartet richtig, da die Berechnung ganz einfach anhand der Funktion aufgebaut werden. Dies ist schön zu sehen wenn man die erste Zeile
"zins(Anlagebetrag,Zinsfaktor,0,Endguthaben):-Endguthaben is Anlagebetrag." durch "zins(Anlagebetrag,Zinsfaktor,0,Endguthaben):-Endguthaben = Anlagebetrag."
Ersetzt. Dann erhält man diese Ausgabe:

?- zins(100,5,2,E).
E = 100+100*(5*0.01)+(100+100*(5*0.01))*(5*0.01) 

*/

%Aufgabe 1.2:

%zins2(+Anlagebetrag,+Zinsfaktor,+Anlagedauer,?Endguthaben)

zins2(Anlagebetrag, Zinsfaktor, Anlagedauer, Endguthaben):-
	Endguthaben is Anlagebetrag * (1 + (Zinsfaktor * 0.01)) ** Anlagedauer.
	
%Vergleich
%?- zins(100, 5, 3, X).
%X = 115.7625 

%?- zins2(100, 5, 3, X)
%X = 115.76250000000002.

%In einigen Fällen werden bei dem zins2/4 Prädikat deutlich mehr Nachkommastellen angezeigt

%Aufgabe 1.3:
/*
Das von mir intuitiv Programmierte Prädikat in 1.1 ist schon endrekursiv. Es wird ein Term aufgebaut und dann in einem Schritt ausgerechnet, keine Aufwärtskurve.
*/

%Aufgabe 1.4:

%wachszins(+Anlagebetrag,+Basiszins,+Zinswachs,+Wachsphase,+Anlagedauer,?Endguthaben)

wachszins(Anlagebetrag,Basiszins,Zinszuwachs,Wachsphase,0,Endguthaben):- Endguthaben is Anlagebetrag.

wachszins(Anlagebetrag,Basiszins,Zinszuwachs,0,Anlagedauer,Endguthaben):-
	A1 is Anlagedauer - 1,
	B1 = Anlagebetrag + (Anlagebetrag * (Basiszins * 0.01)),
	wachszins(B1,Basiszins,Zinszuwachs,0,A1,Endguthaben).

wachszins(Anlagebetrag,Basiszins,Zinszuwachs,Wachsphase,Anlagedauer,Endguthaben):-
	W1 is Wachsphase - 1,
	A1 is Anlagedauer - 1,
	Z1 is Basiszins + Zinszuwachs,
	B1 = Anlagebetrag + (Anlagebetrag * (Z1 * 0.01)),
	wachszins(B1,Z1,Zinszuwachs,W1,A1,Endguthaben).

/*
Ausgabe und Test:

?- wachszins(100,2,0,0,4,E).
E = 108.243216 .

?- zins(100,2,4,E).
E = 108.243216 

*/

%Aufgabe 1.4:
/*
Zinssatz über die Jahre:
			1	2	3	4	5	6	7	8	9
Ohne Wachstumsphase:	2%	2%	2%	2%	2%	2%	2%	2%	2%
Kurze Wachstumsphase:	1%	2%	3%	3%	3%	3%	3%	3%	3%
Lange Wachstumsphase:	1%	1.5%	2%	2.5%	3%	3.5%	4%	4%	4%

Bei einer Anlagedauer von bis zu 3 Jahren is der feste Zinssatz OHNE Wachstum im Vorteil, bei einer Anlagedauer von bis zu 7 Jahrender Zinssatz mit kurzer Wachstumsphase und ab 7 Jahren Anlagedauer ist die lange Wachstumsphase besser. Alles leicht durch das Prädikat Wachszins auszuprobieren.

?- wachszins(100,2,0,0,3,E).
E = 106.1208 .

?- wachszins(100,0,1,3,3,E).
E = 106.11059999999999

?- wachszins(100,0,1,3,7,E).
E = 119.42841513438599 .

?- wachszins(100,0.5,0.5,7,7,E).
E = 118.82897937729 .

?- wachszins(100,0,1,3,8,E).
E = 123.01126758841757 .

?- wachszins(100,0.5,0.5,7,8,E).
E = 123.5821385523816 .

*/

%Aufgabe 2:

% 2.1
% pi-nr(+Rekursionsschritte, ?Resultat) naiv-rekursive Variante
pi-nr(0, 0).
pi-nr(Rekursionsschritte, Resultat) :- 
	Rekursionsschritte =\= 0, 
	X is (Rekursionsschritte - 1), 
	pi-nr(X, Zwischenergebnis),
	Resultat is (4 * (-1)^(Rekursionsschritte + 1))/(2 * Rekursionsschritte - 1) + Zwischenergebnis.
%getestet mit pi-nr(0, Resultat), pi-nr(1, Resultat), pi-nr(10, Resultat), pi-nr(50, Resultat), pi-nr(100, Resultat), pi-nr(1000, Resultat), pi-nr(10000, Resultat), pi-nr(100000, Resultat)

% pi-er(+Rekursionsschritte, ?Resultat) end-rekursive Variante
pi-er(Rekursionsschritte, Resultat) :- pi-wrap(Rekursionsschritte, Resultat, 0).
pi-wrap(0, Resultat, Resultat).
pi-wrap(Rekursionsschritte, Resultat, Akkumulator) :- 
	Rekursionsschritte =\= 0, X is (Rekursionsschritte - 1), 
	Zwischenergebnis is (4 * (-1)^(Rekursionsschritte + 1))/(2 * Rekursionsschritte - 1) + Akkumulator,
	pi-wrap(X, Resultat, Zwischenergebnis).
%getestet mit den gleichen Werten wie oben

% 2.2
% Die Naiv-rekursive Variante ist meiner ansicht nach einfacher zu verstehen, sie ist allerdings auch bedeutend langsamer
% was wohl auf die intensive Nutzung des Stacks zur�ckzuf�hren ist.

% 2.3
%pi-wallis(+Rekursionsschritte, ?Resultat) Implementation der Wallis'schen Formel
pi-wallis(Rekursionsschritte, Resultat) :- pi-wrap2(Rekursionsschritte, Resultat, 2).
pi-wrap2(0, Resultat, Resultat).
pi-wrap2(Rekursionsschritte, Resultat, Akkumulator) :- Rekursionsschritte =\= 0, X is (Rekursionsschritte - 1), 
	Zwischenergebnis is ((2 * Rekursionsschritte) / (2 * Rekursionsschritte - 1)) * ((2 * Rekursionsschritte) / (2 * Rekursionsschritte + 1)) * Akkumulator,
	pi-wrap2(X, Resultat, Zwischenergebnis).
%getest mit den gleichen Werten wie oben

% 4.1
%Berechnung des Binomialkoeffizienten, naiv-rekursiv.
%binom(+N, +K, ?Resultat)
binom(N, K, R):- once(binom1(N, K, R)).
binom1(N, K, 1) :- K = N; K = 0.
binom1(N, K, R) :-
	K < N,
	N1 is N-1,
	K1 is K-1,
	binom(N1, K1, R1), binom(N1, K, R2),
	R is R1 + R2.

/*Ausgaben:*/	
%?- binom(100, 0 , X).	
%X = 1.

%?- binom(0, 100, X)
%false.

%?- binom(49, 6, X)
%X = 13983816.

%Bonus 1: 
/*
Innerhalb des Prädikates binom/3, wird das Prädikat zwei mal rekusriv aufgerufen, wodurch
die Rechenzeit deutlich verlängert wird. Eine endrekursive Implementation würde diesen
Aufwand reduzieren. 
*/

%Standard Fakultätsberechnung, naiv-rekursiv
%fak(+N, ?Resultat)
fak(0, 1).
fak(N, K) :- 
	N > 0,
	N1 is N - 1,
	fak(N1, K2),
	K is K2 * N.
		
%Berechnung des Binomialkoeffizienten nach der zweiten Formel n! / (k! * (n - k)!)
%binom2(+N, +K, ?R)	
binom2(N, K, R) :-
	fak(N, FakN),
	fak(K, FakK), 
	Diff is N - K,
	fak(Diff, FakDiff),
	R is FakN / (FakK * FakDiff).
	
%Inkrementiert eine Zahl um 1
%increment(+Zahl, ?Resultat)	
increment(N1, N2) :- N2 is N1 + 1.	
	
%Berechnung des Binomialkoeffizienten nach der dritten Formel
%binom3(+N, +K, +Zaehler, ?Resultat)
binom3(N, K, J, 1) :- J = K.
binom3(N, K, J, R) :-
	J < K,
	increment(J, J2),
	binom3(N, K, J2, R1),
	R is R1 * ((N + 1 - J2) / J2).

%Vergleich von binom/3, binom2/3 und binom3/4

/*
Anders als das Prädikat binom/2, ruft das Prädikat binom2/2 drei mal die naiv-rekursive Fakultätsfunktion fak/2 auf. 
auf. Die Laufzeit für die Berechnung von FakN, FakK und FakDiff liegt im Fakultätsbereich, was natürlich immer noch langsam ist,
jedoch schneller als die Berechnung durch das Prädikat binom/3. 

Das schnellste Ergebnis wird durch das Prädikat binom3/4 erzielt, da wir lediglich 2 * N (Rek. Abstieg / Aufstieg) rekursive Aufrufe haben.
Wir müssen allerdings einen zaehler J, welchen wir mit dem Startwert 0 beim Prädikatsaufruf instanziieren, als zusätzliches Argument übergeben.
*/	
	
/*Laurzeitvergleich*/

/*N = 49, K = 6*/

%?- time(binom(49, 6 , X)).
% 192,348,809 inferences, %13.906 CPU in 13.938 seconds (100% CPU, 13831824 Lips)
% X = 13983816.


%?- time(binom2(49, 6 , X)).
% 299 inferences, 0.000 CPU in 0.000 seconds (?% CPU, Infinite Lips)
% X = 13983816 


%?- time(binom3(49, 6, 0, X)).
% 37 inferences, 0.000 CPU in 0.000 seconds (?% CPU, Infinite Lips)
% X = 13983816.0 


/*Mit groesseren Zahlen: N = 20000, K = 6*/

%?- time(binom2(20000, 6 , X)).
% 120,005 inferences, 5.891 CPU in 5.952 seconds (99% CPU, 20372 Lips)
% X = 88822241108611263330000


%?- time(binom3(20000, 6, 0, X)).
% 37 inferences, 0.000 CPU in 0.000 seconds (?% CPU, Infinite Lips)
% X = 8.882224110861127e+22 

	