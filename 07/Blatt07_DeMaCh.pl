/* SE3 LP - Aufgabenblatt 07

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 04.12.2017
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


/*1.3*/
%TODO
















