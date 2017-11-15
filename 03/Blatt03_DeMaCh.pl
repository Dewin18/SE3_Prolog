/*
!!!
TODO 
Aufgabe 2.1 & 2.2 zugriffspfad ist nicht eindeutig
Großteil von Aufgabe 3
!!!
SE3 LP - Aufgabenblatt 03

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 15.11.2017
*/

/*
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
*/

/*
Aufgabe 2:
Definieren Sie für das in der Datei dateiverzeichnis.pl gegebene Dateiverzeichnis
aus Aufgabenblatt 3 die folgenden Prädikate:


1. Ein Prädikat, das überprüft, ob ein Zugriffspfad zwischen zwei Verzeichnissen 
existiert.
*/
direktesSubVZ(Sub, Root) :- directory(Sub,_,Root,_,_).
direktesSuperVZ(Root, Sub) :- directory(Sub,_,Root,_,_).
superVZ(Root, Sub) :- direktesSuperVZ(Root, Sub).
superVZ(Root, Sub) :- direktesSuperVZ(X, Sub), superVZ(Root, X).
zugriffspfad(VzID1, VzID2) :- subVZ(VzID1, VzID2).
zugriffspfad(VzID1, VzID2) :- superVZ(VzID1, VzID2).


/*
2. Ein Prädikat, das überprüft, ob eine Datei vom Wurzelverzeichnis aus nicht 
mehr erreichbar ist.
*/
dateiErreichbarVonRoot(FileID) :- file(FileID,DirID,_,_,_,_), directory(RootID,root,_,_,_), zugriffspfad(RootID, DirID).


/*
3. Ein Prädikat, das zu einem gegebenen Verzeichnis alle seine Unterverzeichnisse, 
d.h. auch die nur indirekt erreichbaren, ermittelt.
*/
subVZ(Sub, Root) :- direktesSubVZ(Sub, Root).
subVZ(Sub, Root) :- direktesSubVZ(X, Root), subVZ(Sub, X).


/*
4. Ein Prädikat, das die Gesamtgröße aller Dateien in einem Teilbaum des Verzeichnisbaums
berechnet. Hinweis: Mit dem Prädikat sumlist(+Liste,?Summe)
können Sie die Summe einer Liste von Zahlen berechnen.
*/
listeGroesseAllerDatenInSubVZ(Root, Liste) :- findall(Size, (subVZ(Sub, Root), file(_,Sub,_,Size,_,_)), Liste).
groesseAllerDatenInSubVZ(Root, Groesse) :- listeGroesseAllerDatenInSubVZ(Root, Liste), sumlist(Liste,Groesse).


/*
Aufgabe 3:
Sie sollen eine App fur die Besucher eines bekannten osterreichischen Skigebiets
entwickeln. Die Skigebietsverwaltung stellt Ihnen dafur die topograschen Informationen
als relationale Datenbank in der Datei skigebiet.pl zur Verfugung.
Darin sind die Pisten in Form von Teilstrecken durch das Pradikat
strecke(Streckennummer,Startpunkt,Endpunkt,Pistennummer,Laenge)
gegeben. Die Strecken lassen sich im Normalfall der Schwerkraft folgend nur bergab
(vom Startpunkt zum Endpunkt) befahren. Die einzelnen Streckenabschnitte werden
zu Pisten zusammengefasst, d.h. jede Strecke ist eindeutig einer Piste zugeordnet.
Pisten dienen vor allem der Orientierung der Skifahrer. Daher haben Sie
einen Namen und einen Schwierigkeitsgrad, der von blau (einfach) uber rot bis hin
zu schwarz (schwierig) reicht. Diese Informationen sind durch das Pradikat
piste(Pistennummer,Pistenname,Schwierigkeitsgrad).
gegeben.


1. Erkunden Sie das Skigebiet. Ermitteln Sie die hochsten Punkte in dem Skigebiet,
von denen aus alle Pisten bergab fuhren, bzw. die niedrigsten, von denen
aus man nicht weiter ins Tal abfahren kann.
*/
höchstePunkte(Liste) :- findall(Punkt, (strecke(_,Punkt,_,_,_), \+ strecke(_,_,Punkt,_,_)), Liste).


/*
2. Denieren Sie ein Pradikat ist erreichbar(Start,Ziel), das berechnet, ob
zwischen zwei Knotenpunkten Start und Ziel eine durchgangig zu befahrende,
bergabwarts fuhrende Verbindung besteht. Ist Ihre Denition terminierungssicher?
Welche Eigenschaften (analog zu Aufgabe 1) hat sie?
*/
direkteVerbindung(Start, Ziel) :- strecke(_,Start,Ziel,_,_).
istErreichbar(Start, Ziel) :- direkteVerbindung(Start, Ziel).
istErreichbar(Start, Ziel) :- direkteVerbindung(Start, X), istErreichbar(X, Ziel).


/*
3. Bestimmen Sie Paare von Orten, zwischen denen keine direkte Pistenverbindung
besteht.
*/



/*
4. Hans befindet sich auf der Bergstation Rootmoos und Susi auf der Bergstation
Panorama. An welchen Stellen im Skigebiet konnten sie sich treen?
*/


/*
5. Pisten mussen manchmal gesperrt werden (z.B. wegen Bergungs- oder Wartungsarbeiten,
Schneemangel oder Lawinengefahr). Ihre App soll solche temporären 
Einschrankungen berucksichtigen. Erweitern Sie dazu die Datenbank
um ein dynamisches Pradikat gesperrt(Streckennummer) und modizieren
Sie das Pradikat aus Teilaufgabe 2 so, dass es solche Streckenabschnitte nicht
mehr in die Suche einbezieht.
*/


/*
6. Erweitern Sie ihr Pradikat aus der vorangegangenen Teilaufgabe erneut, um
auch den Schwierigkeitsgrad der Pisten berucksichtigen zu konnen. Uberlegen
Sie sich dafur eine Losung, die den unterschiedlichen Vorlieben der Skifahrer
Rechnung tragt: Wahrend die einen (die " Angstlichen") sich einen maximalen
Schwierigkeitsgrad vorgeben (z.B. rot), wollen die anderen (die "Selbstbewussten")
nur auf Pisten fahren, die einen minimalen Schwierigkeitsgrad nicht
unterschreiten. Ein dritter Typ von Fahrern ist wenig 
exibel und mochte
den Schwierigkeitsgrad exakt vorgeben.
*/
