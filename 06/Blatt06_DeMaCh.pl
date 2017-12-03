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
wachszins(B1,Basiszins,Zinszuwachs,0,A1,Endguthaben).

/*
Ausgabe und Test:
?- wachszins(100,5,0,0,1,E).
E = 105.0 .

?- wachszins(100,5,1,1,1,E).
E = 106.0 .

?- wachszins(100,5,1,5,5,E).
E = 128.8436625 .

?- zins(100,5,5,E).
E = 127.62815624999999 
*/
