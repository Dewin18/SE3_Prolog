%SE3 LP - Aufgabenblatt 02
%
%Autor: 
%Dewin Bagci, 6815336
%Christian Cyll, 6870744
%Max Wutz, 6308876
%
%Datum 10.11.2017

%Aufgabe 1

%1.1

%Prädikat:
%
%Ist eine Menge von Klauseln mit gleicher Signatur. Also Klauseln deren Köpfe den gleichen Funktor haben.
%
%zB.:
%verbrecher(X) :- mann(X)
%mann(X) :- mensch(X), maennlich (X), erwachsen (X)
%
%Klausel:
%
%Sind die Generalisierung von Fakten und Regeln, die Stelligkeit bzw. die Menge der Parameter werden in einem '/' hinter der Klausel angegeben 
%
%zB.: mutter_von/2
%
%Struktur:
%
%Besteht aus einem Namen und mindestens einem Argument. Jedes Argument ist ein Term.
%
%zB.:
%hoerspiel(titel('Qualityland'), autor('Marc-Uwe Kling'))

%1.2

%Suche:
%
%Die Suche ist bei Prolog ein besonders interessantes Thema da die Datenstrukturen ja meist in Relationen aufgebaut sind und somit 
%besonders einfach und besonders schön durchsucht bzw. zugeordnet werden können
%
%Variable:
%
%Auch hier eine Besonderheit von Prolog, Variablen haben keinen vorgeschriebenen Datentyp. Es muss also nicht begrenzt werden was gespeichert 
%bzw adressiert werden kann, genau so wie es keine (sichtbaren) Pointer gibt.
%
%Instanziierung:
%
%Man kann beim ausführen eines Prädikates Variablen mitgeben, je nachdem ob man einen Wert oder einen Platzhalter mitgibt, reagiert das 
%Prädikat teilweise unterschiedlich. Vollständig instanziiert, vollständig uninstanziiert, teilweise instanziiert.

%Aufgabe 2

:- consult('haeuser.pl').

%2.1 Welche Haeuser stehen in der Bahnhofsstraße?

%Falls nur die Objekttypen der Haeuser in der Bahnhofsstr. angezeigt werden sollen.
:- - findall(obj(ObjNr, ObjTyp), obj(ObjNr, ObjTyp, bahnhofsstr, _, _), L).
%Ausgabe: L = [obj(2, efh), obj(3, efh), obj(4, mfh), obj(5, bahnhof), obj(6, kaufhaus)].

%Alternativ auch der Objekttyp, die Hausnummer und das Baujahr der Haeuser in der Bahnhofsstr.
:- obj(_, Objekttyp, bahnhofsstr, Hausnummer, Baujahr).
%Ausgabe: 

%Objekttyp = efh,
%Hausnummer = 27,
%Baujahr = 1943 ;
%Objekttyp = efh,
%Hausnummer = 29,
%Baujahr = 1997 ;
%Objekttyp = mfh,
%Hausnummer = 28,
%Baujahr = 1989 ;
%Objekttyp = bahnhof,
%Hausnummer = 30,
%Baujahr = 1901 ;
%Objekttyp = kaufhaus,
%Hausnummer = 26,
%Baujahr = 1997.

%2.2 Welche Haeuser wurden vor 1950 gebaut?
:- findall(obj(ObjNr, ObjTyp, Str, HausNr,  BJahr), (obj(ObjNr, ObjTyp, Str, HausNr, BJahr), BJahr<1950), L).
%Ausgabe: L = [obj(2, efh, bahnhofsstr, 27, 1943), obj(5, bahnhof, bahnhofsstr, 30, 1901)].

%2.3 Wer besitzt Haeuser, die mehr als 300.000 Euro wert sind?
:- findall(bew(HausBesitzer, Wert), (bew(_, _, _, HausBesitzer, Wert, _), Wert>300000), L).
%Ausgabe: L = [bew(mueller, 315000), bew(piepenbrink, 1500000)].

%Aufgabe 3

:- consult('dateiverzeichnis.pl').

%Die Regeln zu Aufgabe 3 befinden sich in der Datenbasis. Der Vollständigkeitshalber haben wir sie hier in Form von kommentaren beigefügt

%3.1
%fileIdNameConversion(FileId, Name) :- file(FileId, _, Name, _, _, _).
%1 Ausgabebeispiel: mit fileIdNameConversion(X, Paris). bekommen wir als Ausgabe X = 4; X = 13, welche genau die IDs (Schlüssel) des Dateinnamens sind.
%2 Ausgabebeispiel: mit fileIdNameConversion(4, X). liefert uns das Programm X = paris, da 4 die ID (Schlüssel) von dem Dateinamen paris ist.

%3.2
%directoryIdNameConversion(DirId, Name) :- directory(DirId, Name, _, _, _).
%1 Ausgabebeispiel: directoryIdNameConversion(X, urlaub). liefert als Ausgabe X = 5; X = 10, welche genau die IDs des Verzeichnisses mit dem Namen urlaub sind.
%2 Ausgabebeispiel: directoryIdNameConversion(1, X). liefert als Ausgabe X = root, da root der name der ID 1 ist.

%3.3
%fileNameToDirInfo(FileName, DirName):- file(_, DirId,FileName, _, _, _), directory(DirId, DirName, _, _, _).
%1 Ausgabebeispiel: Die Anfrage fileNameToDirInfo(X, urlaub). liefert als Ausgabe: X = quartieranfrage; X = paris; X = dijon; X = die_bruecke_von_avignon;, 
%da sich diese Datein alle im Verzeichnis urlaub befinden.
%2 Ausgabebeispiel: fileNameToDirInfo(paris, X). liefert als Ausgabe X = pop; X = urlaub., da sich die Datei paris in den Verzeichnissen pop und urlaub befindet.

%3.4
%parentDirInfo(DirName, ParentDirID) :- directory(_, DirName, ParentDirID, _, _).
%1 Ausgabebeispiel: parentDirInfo(X, 1). liefert als Ausgabe X = bilder; X = musik; X = dokumente., da diese Verzeichnisse das Verzeichnis mit der ID 1 als parent directoy haben.
%2 Ausgabebeispiel: parentDirInfo(kinder, X). liefert als Ausgabe X = 2., da sich das Verzeichnis kinder im Verzeichnis mit der ID 2 befindet. 

%Aufgabe 4

