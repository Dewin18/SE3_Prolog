/* SE3 LP - Aufgabenblatt 11

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 19.01.2018
*/

:- consult('translations.pl').

%Bei diesem Design ergeben sich genau drei Faelle fuer die Uebersetzung.

%1. Fall: Es gibt nur die Liste mit deutschen Woertern. Dann wird jedes
%         Wort, wenn moeglich, ins Englische uebersetzt und die Liste der englischen Woerter
%         zurueckgegeben.

%2. Fall: Analog zum ersten Fall liegt diesmal nur die Liste mit englischen Wortern vor.

%3. Fall. Es liegt sowohl die Liste der deutschen, als auch die Liste der englischen Woerter vor.
%         Dann wird das Deutsche ins Englische uebersetzt und ueberprüft, ob das Uebersetzte 
%         mit dem Englischen uebereinstimmt.

%1. Fall: Uebersetzung von Deutsch nach Englisch
%translate(+ListOfGermanWords, -ListOfEnglishWords)
translate(GerList, EngList) :- 
	var(EngList),
	translation(GerList, EngList).

%2. Fall: Uebersetzung von Englisch nach Deutsch	
%translate(-ListOfGermanWords, +ListOfEnglishWords)
translate(GerList, EngList) :- 
	var(GerList),
	translation(GerList, EngList).

%3. Fall: Deutsche Uebersetzung mit dem Englischen vergleichen.
%translate(+ListOfGermanWords, +ListOfEnglishWords)
translate(GerList, EngList) :- 
	nonvar(GerList),
	nonvar(EngList),

	translation(GerList, EngList).


	