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

%1. 4 Evaluation:

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

