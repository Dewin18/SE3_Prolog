/* SE3 LP - Aufgabenblatt 09

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 19.12.2017
*/

/*Aufgabe 1: Chat-Bots*/

chatbot(Pattern,Response) :-
	rule(TempPattern, TempResponse),
	match(TempPattern, Pattern),
	match(TempResponse, Response),
	!.
	
rule([s([ich,habe]),s(Menge),s(Art),w(gegessen),_],[s([warum,hast,du]),s(Menge),s(Art),w(gegessen),w('?')]).


match([],[]).
match([Item|Items],[Word|Words]) :-
	match(Item, Items, Word, Words).

match(w(Word), Items, Word, Words) :-
	match(Items, Words).

match(s([Word|Seg]), Items, Word, Words0) :-
	append(Seg, Words1, Words0),
	match(Items, Words1).
	
/*
	example: chatbot([ich,habe,viel,lachs,gegessen,!],Response). -> Response = [warum, hast, du, viel, lachs, gegessen, ?].
	
*/