/* SE3 LP - Aufgabenblatt 11

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 19.01.2018
*/

:- consult('translations.pl').

%Uebersetzung von Deutsch nach Englisch
%translate(?ListOfGermanWords, ?ListOfEnglischWords)
translate(GerList, EngList) :- 
	var(EngList),
	translation(GerList, EngList).

%Uebersetzung von Englisch nach Deutsch	
%translate(?ListOfGermanWords, ?ListOfEnglischWords)
translate(GerList, EngList) :- 
	var(GerList),
	translation(GerList, EngList).




	