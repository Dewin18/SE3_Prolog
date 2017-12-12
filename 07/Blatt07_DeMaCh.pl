/* SE3 LP - Aufgabenblatt 07

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 11.12.2017
*/

/*Aufgabe 1*/

%Gibt ein Verzeichnis als Liste mit Verzeichnisnamen zurueck.
%getNameList(+DirectoryID, -List)
getNameList(DirID, L) :- findall(Name, directory(DirID, Name, _, _, _), L).

%Gibt die Verzeichnis ID der Datei zurueck in der sie sich befindet.
%getDirIDFromFile(?Name, ?DirID)
getDirIDFromFile(Name, DirID) :- file(_, DirID, Name, _, _, _).

%Gibt die ID des Oberverzeichnisses zurueck
%getSuperDir(?DirectoryID, ?ParentDirectoryID)
getSuperDirID(DirID, SuperDirID) :- directory(DirID, _, SuperDirID, _, _).

/*1.1*/
%Gibt Zugriffspfad als Liste von Verzeichnisnamen zurueck
%getDirPathList(+DirectoryID, -List)
getDirPathList(1, [root]).
getDirPathList(DirID, List) :- 
	DirID > 1,	
	getSuperDirID(DirID, SuperDirID),
	getNameList(DirID, L2),
	getDirPathList(SuperDirID, L1),
	append(L1, L2, L3),
	List = L3.
	
/*Ausgaben:*/
%?- getDirPathList(0, X).
%false.

%?- getDirPathList(1, X).
%X = [root] ;
%false.
	
%?- getDirPathList(2, X).
%X = [root, bilder] ;
%false.
	
%?- getDirPathList(12, X).
%X = [root, dokumente, scheidung] ;
%false.	

%?- getDirPathList(2, [root, bilder]).
%true .
	
/*1.2*/
%Ermittelt den Zugriffspfad einer Datei.
%getFilePathList(?Name, ?DirectoryID, ?List)
getFilePathList(Name, DirID, List) :-
	getDirIDFromFile(Name, DirID2),
	DirID = DirID2,
	getDirPathList(DirID, List).
	
/*Ausgaben:*/
%?- getFilePathList(Name, VerzeichnisID, Zugriffspfad).
%Name = in_the_summertime,
%VerzeichnisID = 9,
%Zugriffspfad = [root, musik, pop] ;

%...insgesamt 14 Ergebnisse, für jede Datei den Zugriffspfad

%?- getFilePathList(paris, VerzeichnisID, Zugriffspfad).
%VerzeichnisID = 9,
%Zugriffspfad = [root, musik, pop] ;
%VerzeichnisID = 5,
%Zugriffspfad = [root, bilder, urlaub] ;
%false.

%?- getFilePathList(Name, 9, Zugriffspfad).
%Name = in_the_summertime,
%Zugriffspfad = [root, musik, pop] ;
%Name = i_am_so_romantic_tonight,
%Zugriffspfad = [root, musik, pop] ;
%Name = ich_und_du_fuer_immer,
%Zugriffspfad = [root, musik, pop] ;
%Name = paris
%Zugriffspfad = [root, musik, pop] ;
%false.

%?- getFilePathList(paris, 9, Zugriffspfad).
%Zugriffspfad = [root, musik, pop] ;
%false.

%?- getFilePathList(paris, 9, [root, musik, pop]).
%true .

/*1.3
Gemäß der Aufgabenstellung soll der Rueckgabewert der Liste, die File-ID, sowie den Zugriffspfad enthalten.
Das Ergebnis sieht dann in etwa wie folgt aus: [[FileID_X, [Zugriffspfad_X]], [FileID_Y, [Zugriffspfad_Y]], ...], 
wobei das juengste Datum, des zuletzt modifizierten Files, ganz link steht, sodass die Ordnung X > Y > ... gilt.

Vorueberlegungen:

1: Zuerst alle Files mit ID und Datum in einer Liste Speichern,
2: Liste Nach Datum Sortieren
3: Die ersten N Elemente herausholen und durch die ID und den Zugriffspfad anzeigen lassen.

Nach diesen drei Punkten haben wir die folgenden Prädikate entwickelt. 
*/

%Gibt die zugehörige Verzeichnis ID eines Files zurück. 
%getDirFromFileID(?FileID, ?DirID)
getDirFromFileID(FileID, DirID) :- file(FileID, DirID, _, _, _, _).

%Gibt das zuletzt modifizerte Datum des Files zurueck
%getModifiedDate(?FileID, ?DateModified)
getModifiedDate(FileID, DateModified) :- file(FileID, _, _, _, _, DateModified).

%Gibt für ein File, dass zuletzt modifizerte Datum, die File ID und den Pfad als Liste zurueck
%getDateIDAndPathAsList(?FileID, ?PfadAlsListe)
getDateIDAndPathAsList(FileID, L) :- 
	getModifiedDate(FileID, DateModified), %holt das zuletzt modifizerte Datum für das File
	getDirFromFileID(FileID, DirID),	   %holt das Verzeichnis für das File
	getDirPathList(DirID, Path),           %holt den Pfad für das Verzeichnis
	append([FileID], [Path], L1),          
	append([DateModified], L1, L2),		   %Fuege Datum, FileID und Pfad zusammen
	L = L2.
	
/*Ausgabe*/
%?- getDateIDAndPathAsList(FileID, L).
%FileID = 1,
%L = [date(2009, 11, 5), 1, [root, musik, pop]] ;
%FileID = 2,
%L = [date(2009, 11, 5), 2, [root, musik, pop]] ;
%...Insgesamt 14 Ergebnisse

%?- getDateIDAndPathAsList(2, L).
%L = [date(2009, 11, 5), 2, [root, musik, pop]] ;
%false.	

%Liefert eine nach Datum sortierte Liste mit (Datum, FileID, Pfad) für jedes File zurueck
%getSortedDateList(-DatumListe)
getSortedDateList(L) :- 
	findall(DateModified, getDateIDAndPathAsList(_, DateModified), L1),
	sort(L1, L2),
	reverse(L2, L).
	
/*Ausgabe*/
%?- getSortedDateList(L).
%L = [[date(2009, 11, 5), 34, [root, dokumente, scheidung]], [date(2009, 11, 5), 7, [root, dokumente, urlaub]], [date(2009, 11, 5), 3, [root, musik, pop]], 
%[date(2009, 11, 5), 2, [root, musik|...]], [date(2009, 11, 5), 1, [root|...]], [date(2008, 6, 17), 15, 
%[...|...]], [date(2008, 6, 17), 14|...], [date(..., ..., ...)|...], [...|...]|...].	
	
%Gibt den Listenkopf zurueck und entfernt die Restliste
head(E,[E|_]).

%Gibt die Restliste zurueck und entfernt den Listenkopf
tail([_|T], T). 

%Liefert eine liste für N files, absteigend sortiert nach Datum mit File-ID und Zugriffspfad
%getLastModifiedFiles(+AnzahlDerFiles, -Ausgabeliste)
getLastModifiedFiles(NumberOfFiles, Output) :-
	getSortedDateList(DateList),	
	getPairs(NumberOfFiles, DateList, ResultList),
	reverse(ResultList, L),
	Output = L.
	
%Hilfsprädikat um die jeweils richtigen Eintraege zusammenzufassen	
%getPairs(+Anzahl, ?Liste, -Ausgabe)
getPairs(N, _, []) :- N =< 0.               % Abbruchbedingung, wenn die Anzahl der Files 0 ist, gib die leere Liste zurueck
getPairs(N, DateList, L) :-
	N > 0,									
	N1 = N - 1,
	head(Head, DateList),					%das erste Element aus der Liste holen
	tail(Head, TailOfHead),                 %das erste Element ist wieder eine Liste, deshalb holen wir uns davon die Restliste, in der sich noch die FileID und das modif. Datum befindet
	Entry = [TailOfHead],                   %instanziieren die Variable Entry mit dem TailOfHead z.B. Entry = [34, [root, dokumente, scheidung]]
	tail(DateList, Tail),					%Liste um den Listenkopf verringern
	getPairs(N1, Tail, L1),					%Rekursiver Aufruf mit N - 1 Files und length(Liste) - 1
	append(L1, Entry, L2),					%Eintraege zusammenzufassen	
	L = L2.

/*Ausgaben:*/
%?- getLastModifiedFiles(0, X).
%X = [] ;
%false.

%?- getLastModifiedFiles(2, X).
%X = [[34, [root, dokumente, scheidung]], [7, [root, dokumente, urlaub]]] ;
%false.

%?- getLastModifiedFiles(14, X).
%X = [[34, [root, dokumente, scheidung]], [7, [root, dokumente, urlaub]], [3, [root, musik, pop]], 
%[2, [root, musik, pop]], [1, [root, musik|...]], [15, [root|...]], [14, [...|...]], [13|...], [...|...]|...] 

%?- getLastModifiedFiles(15, X).
%false.

/*
Reduzierung des Rechenbedarfs: 

Angenommen die die Fakten in der Datenbasis sind bereits nach dem Datum sortiert. Dann muss der Sortieralgorithmus sort/2 nicht
extra aufgerufen werden um die Files zu sortieren, da wir dann direkt N files mit der ID und dem Zuugriffspfad ausgeben können.
*/


