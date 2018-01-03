/* SE3 LP - Aufgabenblatt 09

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 03.01.2018
*/

%Aufgabe 2.2

:- use_module(library(jpl)).

demo_draw :-
	jpl_new('ShapeDrawingFrame', ['PROLOG - RECURSIVE CIRCLE'], Frame),
	jpl_call(Frame, setSize, [620, 620], _),

	add_black_background(Frame),
	
	draw_object(Frame, circle, 500, green, 4, 50, 40),
	draw_object(Frame, circle, 500, red, 20, 50, 40),

	% display Frame
	jpl_call(Frame, setVisible, [@(true)], _),

	save_drawing(Frame).

%add_black_background(+Frame)
add_black_background(Frame) :-
    getShape(rectangle, Shape),
	jpl_call(Frame, getSize, [], Dimension),
	jpl_get(Dimension, height, Height),
	jpl_call(Dimension, getWidth, [], Width),
	jpl_new(Shape, [0, 0, Width, Height], Rectangle),
	jpl_get('java.awt.Color', black, Black),
	jpl_call(Frame, addFillShape, [Rectangle, Black], _).

%returns the class for a rectangle or ellipse
%getShape(+ShapeName, -Shape)
getShape(ShapeName, Shape) :- Shape = 'java.awt.geom.Rectangle2D$Float', ShapeName = rectangle.
getShape(ShapeName, Shape) :- Shape = 'java.awt.geom.Ellipse2D$Float', ShapeName = circle. 	
	
%Draws an object in a recursive way. The recursion factor determines the number of recursion steps. 
%High recursion factor means less recursion steps.
%draw_object(+Frame, +ShapeName, +Size, +Color, +RecursionFactor, +X, +Y)
draw_object(_, _, Size, _, _, _, _) :- Size =< 0.	
draw_object(Name, ShapeName, Size, CurrentColor, RFactor, X, Y) :- 
  getShape(ShapeName, Shape),
  Size > 0,    
  SizeNew is Size - (2 * RFactor),
  jpl_new(Shape, [X, Y, Size, Size], Rectangle),
  jpl_get('java.awt.Color', CurrentColor, Color),
  jpl_call(Name, addDrawShape, [Rectangle, Color], _),
  NewX is X + RFactor,
  NewY is Y + RFactor,
  draw_object(Name, ShapeName, SizeNew, CurrentColor, RFactor, NewX, NewY).
  

% save drawing in the frame (if requested by user)
save_drawing(Frame):-
   % if desired save the display as .png
   write_ln('Save the graphics (y/n): '),
   get_single_char(A),
   put_code(A),nl,
   (A=:=121 ->
     (write_ln('enter file name (without extension): '),
      read_line_to_codes(user_input,X),
      atom_codes(File,X),
      atom_concat(File,'.png',FileName),
      jpl_call(Frame, storeScreenShot, [FileName], _) ) ; true).

% this directive runs the above .
:- demo_draw.