%SE3 LP - Aufgabenblatt 02
%
%Autor: 
%Dewin Bagci, 6815336
%Christian Cyll, 6870744
%Max Wutz, 6308876
%
%Datum 10.11.2017

%Aufgabe 1

/*

Prädikat:

Ist eine Menge von Klauseln mit gleicher Signatur. Also Klauseln deren Köpfe den gleichen Funktor haben.

zB.:
verbrecher(X) :- mann(X)
mann(X) :- mensch(X), maennlich (X), erwachsen (X)

Klausel:

Sind die Generalisierung von Fakten und Regeln, die Stelligkeit bzw. die Menge der Parameter werden in einem '/' hinter der Klausel angegeben (zB.: mutter_von/2)

Struktur:

Besteht aus einem Namen und mindestens einem Argument. Jedes Argument ist ein Term.

zB.:
hoerspiel(titel('Qualityland'), autor('Marc-Uwe Kling'))

*/

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



