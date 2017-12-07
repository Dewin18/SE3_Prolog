%TESTING
%---------------------------------%

:- dynamic(directory/5).
:- dynamic(file/6).

% directory(DirId,Name,ParentId,DateCreated,DateModified)

directory(1,root,0,date(2007,5,2),date(2007,5,2)).
directory(2,bilder,1,date(2007,5,2),date(2009,11,2)).
directory(3,musik,1,date(2007,5,2),date(2009,10,4)).
directory(4,dokumente,1,date(2007,5,2),date(2009,11,5)).
directory(5,urlaub,2,date(2008,6,22),date(2009,8,15)).
directory(6,hochzeit,2,date(2008,1,27),date(2008,1,31)).
directory(7,kinder,2,date(2007,5,2),date(2009,9,5)).
directory(8,klassik,3,date(2007,5,2),date(2007,5,2)).
directory(9,pop,3,date(2007,5,2),date(2009,11,5)).
directory(10,urlaub,4,date(2008,5,23),date(2008,11,1)).
directory(11,hochzeit,4,date(2007,12,4),date(2008,1,25)).
directory(12,scheidung,4,date(2009,9,2),date(2009,11,5)).

% file(FileId,DirId,Name,Size,DateCreated,DateModified)

file(1,9,in_the_summertime,56,date(2007,5,2),date(2009,11,5)).
file(2,9,i_am_so_romantic_tonight,31,date(2007,5,2),date(2009,11,5)).
file(3,9,ich_und_du_fuer_immer,67,date(2007,5,2),date(2009,11,5)).
file(4,9,paris,267,date(2008,6,3),date(2008,6,3)).
file(7,10,quartieranfrage,1,date(2007,5,2),date(2009,11,5)).
file(13,5,paris,251,date(2008,6,22),date(2008,6,17)).
file(14,5,dijon,217,date(2008,6,22),date(2008,6,17)).
file(15,5,die_bruecke_von_avignon,191,date(2008,6,22),date(2008,6,17)).
file(21,6,polterabend,238,date(2008,1,27),date(2008,1,31)).
file(22,6,standesamt,244,date(2008,1,27),date(2008,1,31)).
file(23,6,kirche,158,date(2008,1,28),date(2008,1,31)).
file(24,6,festessen,151,date(2008,1,28),date(2008,1,31)).
file(25,11,standesamt,33,date(2007,6,3),date(2007,6,3)).
file(34,12,scheidungsklage,48,date(2009,9,2),date(2009,11,5)).


/*1.3*/
%TODO

getModifiedDate(FileID, DateModified) :- file(FileID, _, _, _, _, DateModified).

getIDAndModifiedDateList(FileID, L) :- 
	getModifiedDate(FileID, DateModified),
	append([DateModified], FileID, L2),
	L = L2.

getIDAndDateList(L) :- findall(DateModified, getIDAndModifiedDateList(_, DateModified), L).	
 	
sortIDDateListX(L) :- 
	getIDAndDateList(L1),
	msort(L1, L2),
	reverse(L2, L3),
	L = L3.
	
%Die Liste soll enthalten [[FileID, [Zugriffspfad], ]]
%Die Liste soll enthalten [[4, [root, musik, pop]], [5, [root, bilder, urlaub]]]

/*
1: Zuerst alle Files mit ID und Datum in einer Liste Speichern,
2: Liste Nach Datum Sortieren
3: Die ersten N herausholen und durch die ID den Zugriffspfad und das Datum anzeigen lassen.
*/

%returns the head of a list and remove the tail
head(E,[E|_]).

%returns the tail of a list and remove the head
tail([_|T], T). 

%getLastModifiedFiles(+NumberOfFiles, -L)
getLastModifiedFilesX(0, []).
getLastModifiedFilesX(N, Y) :-
	
	N > 0,
	N1 is N -1,
	
	head(Head, DateList),
	tail(Head, TailOfHead),
	getDirFromFileID(TailOfHead, DirID),
	getFilePathList(_, DirID, Path),

	getLastModifiedFilesX(N1, Y2),
	
	append(Y2, Entry, Output),
	append([TailOfHead], Path, Entry),
	Y = Output.




