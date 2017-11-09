%SE3 LP - Aufgabenblatt 01
%
%Autor: 
%Dewin Bagci, 6815336
%Christian Cyll, 6870744
%Max Wutz, 6308876
%
%Datum 30.10.2017

%Aufgabe 1:

%Antwort: Der Pfad muss in Hochkommas gesetzt werden, da er sonst 
%nicht als String interpretiert wird.

:- consult('familie.pl').
%Systemausgabe: true (Datenbasis erfolgreich geladen)

:- listing([mutter_von, vater_von]).

:- assert(entwickler(dewin)).
:- asserta(entwickler(max)).
:- assertz(entwickler(christian)).

:- listing(entwickler).

/*Bei allen Eingaben ergibt die Systemausgabe: true, 
bedeutet die Klauseln wurden erfolgreich hinzugefügt.

assert/1: Das Prädikat fügt eine neue Klausel mit dem gleichen 
Funktor und Stelligkeit am Ende hinzu. Das Prädikat assert/1 ist 
jedoch deprecated.

asserta/1: Das Prädikat fügt eine neue Klausel mit dem gleichen 
Funktor und Stelligkeit am Anfang hinzu. 

assertz/1: Das Prädikat fügt eine neue Klausel mit dem gleichen 
Funktor und Stelligkeit am Ende hinzu. 

existieren noch keine Klauseln mit gleichen Funktor und Selligkeit,
wird die Klausel neu erzeugt.*/

%Aufgabe 2:
%2.1

% a)
:- vater_von(walter, magdalena). 
%Ausgabe: true 

% b)
:- mutter_von(julia, hans). 
%Ausgabe: false

% c)
:- mutter_von(M, andrea).
%Ausgabe: M = barbara

% d)
:- vater_von(M, walter).
%Ausgabe: false

% e)
:- mutter_von(barbara, K).
%Ausgabe: K = klaus, K = andrea

% f)
:- bagof(Kind, mutter_von(Mutter, Kind); vater_von(Vater, Kind), L).
/*Ausgabe: insgesamt 14 Ergebnisse mit Mutter Kind 
bzw. Vater Kind beziehung*/

% g)
:- mutter_von(magdalena, K).
%Ausgabe: false, bedeutet Magdalena hat keine Kinder

%Alternatives Ergebnis zu g)
:- not(mutter_von(magdalena, K)).
%Ausgabe: true, bedeutet hier ebenfalls, dass magdalena keine Kinder hat

% h)
:- not(vater_von(otto, K)).
%Ausgabe: false, bedeutet otto hat Kinder

%Alternatives Ergebnis zu h)
:- \+ vater_von(otto, K).
%Ausgabe: false

% i)
:- vater_von(johannes, K).
%Ausgabe: K = klaus, K = andrea

%2.2

:- mutter_von(charlotte, M), (mutter_von(M, K); vater_von(M, K)).
%Ausgabe M = barbara, K = klaus
%        M = barbara, K = andrea

%2.3

:- trace.
:- mutter_von(magdalena, X).
:- nodebug.

%Allgemeine Erklärung: 
/* Zunächst wird mit Call in der Datenbasis nach einem passenden Eintrag gesucht.
Existiert kein passender Eintrag, wird die Suche mit Fail beendet, ansonsten wird die Suche auf der
aktuellen Eben mit Exit beendet und mit dem Zwischenergebnis in der nächst tieferen Ebene weitergesucht.
Dieser Vorgang kann sich beliebig tief schachteln. Nachdem die Suche auf der untersten Ebene beendet ist, 
wird ein Ergebnis bzw. Fail ausgegeben. In jedem Fall springt das Programm an den letzten Exit Punkt zurück
(Backtracking) und führt die Suche fort (redo). */
