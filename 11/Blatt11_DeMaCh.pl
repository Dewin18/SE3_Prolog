/* SE3 LP - Aufgabenblatt 11

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 19.01.2018
*/

:- consult('translations.pl').

tail(T, [_|T]).
head([H|_], H).

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
	trans("DE", GerList, [], EngList).
	

%2. Fall: Uebersetzung von Englisch nach Deutsch	
%translate(-ListOfGermanWords, +ListOfEnglishWords)
translate(GerList, EngList) :- 
	var(GerList),
	trans("EN", EngList, [], GerList).
	
%3. Fall: Deutsche Uebersetzung mit dem Englischen vergleichen.
%translate(+ListOfGermanWords, +ListOfEnglishWords)
translate(GerList, EngList) :- 
	nonvar(GerList),
	nonvar(EngList),
	trans("DE", GerList, [], Translated),
	Translated == EngList.

trans(_, [], NewList, NewList).
trans(Cc, L1, EmptyList, L2) :-
	head(L1, Word1),
	tail(T, L1),
	get_translation(Cc, Word1, Word2),
	append(EmptyList, [Word2], NewList),
	trans(Cc, T, NewList, L2).
	
%TODO -- funktioniert zwar, ein refactoring waere aber angebracht.

%Der Fall, dass das Wort uebersetzt werden kann	
get_translation(P, Word1, Word2) :- P == "DE", translation(Word1, Word2).
get_translation(P, Word1, Word2) :- P == "EN", translation(Word2, Word1).	

%Der Fall, dass das Wort nicht uebersetzt werden kann.	
get_translation(P, Word1, Word2) :- P == "DE", \+ translation(Word1, Word2), Word2 = Word1.	
get_translation(P, Word1, Word2) :- P == "EN", \+ translation(Word2, Word1), Word2 = Word1.
	
	