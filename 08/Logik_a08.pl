%Aufgabe 2:

bi-even([0|[_]]).
bi-odd([1|[_]]).

bi-double(Binary, [0|Binary]).
bi-half([First|Rest], Result) :- bi-even([First|Rest]), Result = Rest.

bi-make-even([First|Rest], Result) :- bi-odd([First|Rest]), Result = [0|Rest].

is-binary([]).
is-binary([First|Rest]) :- First = 0, is-binary(Rest).
is-binary([First|Rest]) :- First = 1, is-binary(Rest).

binaryToDecimal(Binary, Decimal) :- convert-helper(Binary, Decimal, 0).
convert-helper([], 0, 0).
binaryToDecimal([First|Rest], Decimal, Counter)
