/* SE3 LP - Aufgabenblatt 03

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 22.11.2017
*/

%Aufgabe 1: Unifikation

/*h(g(F,k), g(k,F)) = h(g(m,H), g(H,m)).*/
%Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
%Die Variable F kann mit der konstanten m bzw. die Variable H mit der konstanten k 
%instanziiert werden. 
%Ausgabe in Prolog: 
%F = m, 
%H = k.

/*d(x, d(y, d(z,nil))) = d(X,Y).*/
%Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
%Da X und Y Variablen sind, kann X mit der Konstanten x und Y mit der Struktur d(y, d(z, nil))
%instanziiert werden.
%Ausgabe in Prolog:
%X = x,
%Y = d(y, d(z, nil)).

/*m(X, c(g), h(x)) = m(t(r, s), c(u), h(g(T)), t).*/
%Die Unifikation scheitert. Zunächst ist die Arität beider Terme ungleich. Zusätzlich kann c(g) und c(u) nicht 
%unifiziert werden.
%Ausgabe in Prolog:
%false.

/*p(a, p(b, p(c, nil))) = p(X, p(Y, p(Z, nil))).*/
%Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
%Die Variablen X, Y und Z können mit den konstanten instanziiert werden.
%Ausgabe in Prolog:
%X = a,
%Y = b,
%Z = c.

/*t(t(t(a, b), c), t(d, t(e, f))) = t(P, t(Q, R)).*/
%Die Unifikation ist erfolgreich. Beide Terme haben den gleichen Funktor / Arität.
%Die Variablen P und R können mit den Strukturen instanziiert werden, sowie Q mit der konstanten.
%Ausgabe in Prolog:
%P = t(t(a, b), c),
%Q = d,
%R = t(e, f).

/*False = not(false).*/
%Die Unifikation ist erfolgreich. Da False groß geschrieben ist, handelt es sich um eine Variable mit dem Namen %False, die mit dem Term, not(false) instanziiert wird.
%%Ausgabe in Prolog:
%False = not(false).

%Aufgabe 2: PEANO-Arithmetik