/**
SE3 LP - Aufgabenblatt 03

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 15.11.2017

Aufgabe 1:
Welche Eigenschaften (symmetrisch, re
flexiv, transitiv, funktional in einem der
Argumente) haben die folgenden Relationen

- A ist Nachbarland von B:					symmetrisch
- A und B sind (nach deutschem Recht) miteinander verheiratet:	symmetrisch
- A und B sind Geschwister:					symmetrisch, transitiv (Wenn man Halbgeschwister außen vor lässt)
- A ist größer oder gleich B:					reflexiv, transitiv
- A und B haben ein gemeinsames Hobby:				symmetrisch, reflexiv
- A und B sind Häuser in der gleichen Straße:			symmetrisch, reflexiv, transitiv

Aufgabe 2:
Definieren Sie für das in der Datei dateiverzeichnis.pl gegebene Dateiverzeichnis
aus Aufgabenblatt 3 die folgenden Prädikate:
*/

% 1. Ein Prädikat, das überprüft, ob ein Zugriffspfad zwischen zwei Verzeichnissen existiert.

direkterZugriffspfad(VzID1, VzID2) :- directory(VzID1,_,VzID2,_,_).
direkterZugriffspfad(VzID1, VzID2) :- directory(VzID2,_,VzID1,_,_).

zugriffspfad(VzID1, VzID2) :- direkterZugriffspfad(VzID1, VzID2).
zugriffspfad(VzID1, VzID2) :- direkterZugriffspfad(VzID2, VzID3), zugriffspfad(VzID3, VzID1).

% 2. Ein Prädikat, das überprüft, ob eine Datei vom Wurzelverzeichnis aus nicht mehr erreichbar ist.

% 3. Ein Prädikat, das zu einem gegebenen Verzeichnis alle seine Unterverzeichnisse, d.h. auch die nur indirekt erreichbaren, ermittelt.

direktesSubVZ(Sub, Root) :- directory(Sub,_,Root,_,_).

subVZ(Sub, Root) :- direktesSubVZ(Sub, Root).
subVZ(Sub, Root) :- direktesSubVZ(X, Root), subVZ(Sub, X).
