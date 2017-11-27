/* SE3 LP - Aufgabenblatt 03

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 22.11.2017
*/

%Aufgabe 1: Unifikation

%h(g(F,k), g(k,F)) = h(g(m,H), g(H,m)).
/*
Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
Die Variable F kann mit der konstanten m bzw. die Variable H mit der konstanten k 
instanziiert werden. 
Ausgabe in Prolog: 
F = m, 
H = k.
*/

%d(x, d(y, d(z,nil))) = d(X,Y).
/*
Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
Da X und Y Variablen sind, kann X mit der Konstanten x und Y mit der Struktur d(y, d(z, nil))
instanziiert werden.
Ausgabe in Prolog:
X = x,
Y = d(y, d(z, nil)).
*/

%m(X, c(g), h(x)) = m(t(r, s), c(u), h(g(T)), t).
/*
Die Unifikation scheitert. Die Arität beider Terme ist ungleich. Zusätzlich kann c(g) und c(u) nicht 
unifiziert werden.
Ausgabe in Prolog:
false.
*/

%p(a, p(b, p(c, nil))) = p(X, p(Y, p(Z, nil))).
/*
Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
Die Variablen X, Y und Z können mit den konstanten instanziiert werden.
Ausgabe in Prolog:
X = a,
Y = b,
Z = c.
*/

%t(t(t(a, b), c), t(d, t(e, f))) = t(P, t(Q, R)).
/*
Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
Die Variablen P und R können mit den Strukturen instanziiert werden, sowie Q mit der konstanten.
Ausgabe in Prolog:
P = t(t(a, b), c),
Q = d,
R = t(e, f). 
*/

%False = not(false).
/*
Die Unifikation ist erfolgreich. Da False groß geschrieben ist, handelt es sich um eine Variable mit dem Namen 
False, die mit dem Term, not(false) instanziiert wird.
Ausgabe in Prolog:
False = not(false).
*/

%Aufgabe 2: PEANO-Arithmetik

%peano2int(+peano,?integer)
/*
Hier muss die Peano angegeben werden und für Integer eine Variable zur Ausgabe mitgegeben werden, damit das Programm funktioniert.
*/

peano2int(P,I):-p2int(P,I,0).

p2int(0,I,N):-I is N.
p2int(s(P),I,N):-
	N1 is N + 1,
	p2int(P,I,N1).

%next_peano(+peano,?neachste_peano)
/*
Hier muss auch wieder eine Peanozahl angegeben werden (ansonsten könnte ja kein Nachfolger bestimmt werden. Zusätzlich eine Variable zur Ausgabe der Folgezahl.
*/

next_peano(P,N):-N=s(P).

%pre_peano(+peano,?vorherige_peano)

/*
Hier muss auch wieder eine Peanozahl angegeben werden (ansonsten könnte ja kein Vorgänger bestimmt werden. Zusätzlich eine Variable zur Ausgabe der Vorgängerzahl.
*/

pre_peano(s(P),V):-V=P.

%sm_eq_peano(+peano1,+peano2)
/*
Hier müssen zwei Peanozahlen angegeben werden, da ansonsten kein Vergleich möglich ist. Es wird geprüft ob Peano1 <= Peano2.
*/

sm_eq_peano(0,P2).
sm_eq_peano(s(P1),s(P2)):-
	sm_eq_peano(P1,P2).

%verdoppelt(+Peano1,+Peano2)
/*
Hier müssen zwei Peanozahlen angegeben werden. Es gäbe bestimmt eine Möglichkeit es so zu implementieren das einfach nur eine Peanozahl halbiert und verglichen wird. Die folgende Lösung war aber die mir am logischen erscheinende.
*/

verdoppelt(P1,P2):-verdoppelt_peano(P1,P2,P1).

verdoppelt_peano(0,P2,T):-T=P2.
verdoppelt_peano(s(P1),s(P2),T):-
	verdoppelt_peano(P1,P2,T).

%sub_peano(+Peano1,+Peano2,?Ergebnis)
/*
Hier müssen zwei Peanozahlen angegeben werden, da die Subtraktion von Zwei zahlen nur funktioniert wenn auch beide angegeben sind. Außerdem eine Variable für die Ausgabe. Hier wird Peano1-Peano2 gerechnet und in Ergebnis ausgegeben.
*/
sub_peano(P1,0,E):-E = P1.
sub_peano(s(P1),s(P2),E):-
	sub_peano(P1,P2,E).

%min_peano(+Peano1,+Peano2,?PeanoMin)
min_peano(P1,P2,PeanoMin):-min_peano_helper(P1,P2,PeanoMin,P1,P2).
min_peano_helper(0,P2,PeanoMin,P1t,P2t):-PeanoMin= P1t.
min_peano_helper(P1,0,PeanoMin,P1t,P2t):-PeanoMin= P2t.
min_peano_helper(s(P1),s(P2),PeanoMin,P1t,P2t):-min_peano_helper(P1,P2,PeanoMin,P1t,P2t).
