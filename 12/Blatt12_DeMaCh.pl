/* SE3 LP - Aufgabenblatt 12

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 20.01.2018
*/

/*1 Wertesemantik*/

/*1. 1 Auswertung:*/

%(list (car (cdr (quote (1 2 3 4)))) (cdr (quote (1 2 3 4))) )
%	   (car (cdr (quote (1 2 3 4))))
%	        (cdr (quote (1 2 3 4)))
%		         (quote (1 2 3 4)
%		         ==> '(1 2 3 4)
%	        ==> '(2 3 4)
%       ==> 2
%       (cdr (quote (1 2 3 4)))
%            (quote (1 2 3 4))
%            ==>  '(1 2 3 4)
%       ==> '(2 3 4)        
%==> (2 (2 3 4))


/*1. 2 Auswertung: if ist eine special-form expression, deshalb wird die condition zuerst geprüft*/

%(if (< (car (cdr (quote (5 -3 4 -2)))) (- 2 6))
%	 0 
%	 1)
%	 (< (car (cdr (quote (5 -3 4 -2)))) (- 2 6))
%	    (car (cdr (quote (5 -3 4 -2))))
%         	 (cdr (quote (5 -3 4 -2)))
%            	  (quote (5 -3 4 -2))
%            	  ==> '(5 -3 4 -2)
%            ==> '(-3 4 -2)
%		==> -3
%       (- 2 6)
%       ==> -4
%    ==> #f
%==> 1

/*1. 3 Evaluation:*/

%(cons (cdr (quote (1 2 3 4)))
%	   (car (quote (1 2 3 4))) )
%
%==> '((2 3 4) . 1)

/*1. 4 Evaluation:*/

%(map (lambda (x)
%       (if (pair? x)
%           (car x)
%           x))
%     (quote (lambda (x)
%              (if (pair? x)
%                  (car x)
%                  x))) )
%
%==> '(lambda x if)

/*1. 5 Evaluation:*/

%(filter (curry > 5) 
%		(reverse (quote (1 3 5 7 9))) )
%
%==> '(3 1)

/*1. 6 Evaluation:*/

%(filter (compose positive?
%                 (lambda (x) (- x 5)) )
%        (quote (1 3 5 7 9)) )
%
%==> '(7 9)

/*2 Programmverstehen*/

/*2.1*/ 
%foo1 prueft, ob die Liste x vollständig, ab Index 0, in der Liste y enthalten ist.

%(foo1 '(a b c) '(a b c d e f g)) ==> #t

/*2.2*/
%foo2 liefert eine Liste zurueck bei der alle duplikate entfernt wurden. 
%Ist ein Element ein Duplikat, so bleibt lediglich sein letzte vorkommen in der Liste erhalten.

%(foo2 '(a b c d c e a)) ==> '(b d c e a)

/*2.3*/
%foo3 liefert eine Liste mit den Elementen zurueck, die gleichzeitig in der Liste x und in der Liste y enthalten sind. 
%Haben beide Listen verschiedene Elemente, wird die leere Liste zurueckgegeben.

%(foo3 '(a b c d e) '(g a b h)) ==> '(a b)

/*2.4*/
%foo4 liefert eine Liste in umgekehrter Reihenfolge und implementiert damit die bekannte reverse Funktion.

%(foo4 '(a b c d e)) ==> '(e d c b a)

/*2.5*/
%foo5 liefert eine Liste zurueck bei der alle Elemente auf der gleichen Ebene sind, d.h. es werden durch klammern 
%verschachtelete paare oder Listen aufgelöst. foo5 Implementiert die funktion flatten aus der Scheme Standardbibliothek.

%(foo5 '((a (b c d e)) (f g) h (i j))) ==> '(a b c d e f g h i j)

/*3 Programmentwicklung*/

%rekursive Definition einer Peano-Zahl in Scheme. Bei dieser Definition werden alle Peano-Zahlen als Liste uebergeben.
%Die 0 wird daher als '(0) uebergeben und jede weitere peano zahl als '(s (0)) bzw. '(s (s (0))) usw.

/*Definition:*/

%(define (peano n)
%  (if (equal? n '(0))      %Rekursionsabbruch
%      0
%      (peano (cadr n) )))  %Rekursionsschritt

/*Beispieleingabe 1*/
%	 (peano '(0)) 
%==> '(0)

/*Beispieleingabe 2*/
%	 (peano '(s (s (s (0)))))
%==> (peano '(s (s (0))))
%==> (peano '(s (0)))
%==> (peano '(0))
%==> '(0)

/*lt/2*/

%In Prolog benoetigen wir fuer dieses Praedikat hoechstens zwei Zeilen (In jeder Zeile eine Klausel).
%In Scheme hingegen benötigen wir 7 Zeilen und zwei zusaetzliche Fallunterscheidungen um zu pruefen, ob
%beide Peano-Zahlen gleich sind oder ob das zweite Argument bereits '(0), die kleinste Peano-Zahl, ist. 
%In beiden Faellen wird false ausgeben, da sonst die Pruefung, ob die erste Peano-Zahl kleiner als 
%die Zweite ist sofort fehlschlaegt. Zusaetzlich ist es in Prolog moeglich das Praedikat unterspezifiziert
%aufzurufen, um sich beispielsweise alle kleineren Peano-Zahlen einer gegebenen Peano-Zahl anzeigen zu lassen.

/*Implementierung des Praedikates lt/2 in Scheme*/

%(define (lt p1 p2)
%  (if (or (equal? p1 p2)				%Rekursionsabbruch, wenn beide eingegebenen Peano-Zahlen gleich sind
%          (equal? '(0) p2))			%Rekursionsabbruch, wenn die rechte Seite der Ungleichung bereits '(0) ist
%      false
%      (if (equal? p1 '(0))
%          true
%          (lt (cadr p1) (cadr p2)))))  %Rekursionsschritt

/*Beispieleingabe 3*/

%	 (lt '(s (s (s (0)))) '(s (s (s (s (0))))))     
%==> (lt '(s (s (0))) '(s (s (s (0)))))
%==> (lt '(s (0)) '(s (s (0))))
%==> (lt '(0) '(s (0)))
%==> #t

/*Beispieleingabe 4*/

%	 (lt '(s (s (0))) '(s (0)))
%==> (lt '(s (0)) '(0))
%==> #f


/*integer2peano/2*/

%In Prolog benoetigen wir fuer die Ausgabe der Peano-Zahl eine zusaetzliche Variable. Dies ist in Scheme nicht noetig, 
%da wir die Implementation in einer endrekursiven Form durchfuehren koennen. Leider faellt auch hier wieder der Vorteil
%des unterspezifizierten Aufrufs weg, sodass der Umgekehrte Weg, peano2int, nicht automatisch vorliegt.

/*Implementierung des Praedikates integer2peano/2 in Scheme*/

%(define (integer2peano n)
%  (integer2peano1 n '(0)))

%(define (integer2peano1 n acc)
%  (if (<= n 0)
%      acc
%      (integer2peano1 (- n 1) (list 's acc))))

/*einige Beispieleingaben*/

%(integer2peano 0) ==> '(0)
%(integer2peano 1) ==> '(s (0))
%(integer2peano 2) ==> '(s (s (0)))
%(integer2peano 6) ==> '(s (s (s (s (s (s (0)))))))

/*TODO add/3 */

