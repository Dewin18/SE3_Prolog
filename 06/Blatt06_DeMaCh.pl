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

/*
Ich wüsste nicht wie man in Prolog ein nicht rekursives Prädikat aufbauen sollte, so das es trotzdem den Zinseszins berechnet. Es fehlt and IF und WHILE Clausus für sowetwas
*/

%Aufgabe 1.3:
/*
Das von mir intuitiv Programmierte Prädikat in 1.1 ist schon endrekursiv. Es wird ein Term aufgebaut und dann in einem Schritt ausgerechnet, keine Aufwärtskurve.
*/

%Aufgabe 1.4:

%wachszins(+Anlagebetrag,+Basiszins,+Zinswachs,+Wachsphase,+Anlagedauer,?Endguthaben)

wachszins(Anlagebetrag,Basiszins,Zinszuwachs,Wachsphase,0,Endguthaben):-Endguthaben is Anlagebetrag.

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

%Aufgabe 1:

%Aufgabe 2:

% 2.1
% pi-nr(+Rekursionsschritte, ?Resultat) naiv-rekursive Variante
pi-nr(0, 0).
pi-nr(Rekursionsschritte, Resultat) :- Rekursionsschritte =\= 0, X is (Rekursionsschritte - 1), pi-nr(X, Zwischenergebnis),
Resultat is (4 * (-1)^(Rekursionsschritte + 1))/(2 * Rekursionsschritte - 1) + Zwischenergebnis.
%getestet mit pi-nr(0, Resultat), pi-nr(1, Resultat), pi-nr(10, Resultat), pi-nr(50, Resultat), pi-nr(100, Resultat), pi-nr(1000, Resultat), pi-nr(10000, Resultat), pi-nr(100000, Resultat)

% pi-er(+Rekursionsschritte, ?Resultat) end-rekursive Variante
pi-er(Rekursionsschritte, Resultat) :- pi-wrap(Rekursionsschritte, Resultat, 0).
pi-wrap(0, Resultat, Resultat).
pi-wrap(Rekursionsschritte, Resultat, Akkumulator) :- Rekursionsschritte =\= 0, X is (Rekursionsschritte - 1), 
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