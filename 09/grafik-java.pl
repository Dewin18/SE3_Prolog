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
	draw_grid(Frame, blue, 31, 15, 3, 20, point(0, 20)),
	draw_filled_object(Frame, circle, 400, black, 100, 100),
	draw_crazy_object(Frame, 350, red, blue), 
	
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
getShape(ShapeName, Shape) :- Shape = 'java.awt.geom.QuadCurve2D$Float', ShapeName = curve. 	

%Draws the grid with all horizontal and vertical waves
%draw_grid(+Frame, +Color, +NumberOfRowsAndColumns, + NumberOfFragments, +Amplitude, +GapBetweenRowsAndColumns)
draw_grid(Frame, Color, RowCol, NumberOfFragments, Amplitude, Gap, Position) :-
	get_point_content(Position, X, Y),
	NextPoint is 2 * Y,
	draw_wave_rows(Frame, Color, RowCol, NumberOfFragments, Amplitude, Gap, point(X, Y), point(NextPoint, Y)),
	draw_wave_columns(Frame, Color, RowCol, NumberOfFragments, Amplitude, Gap, point(Y, X), point(Y, NextPoint)).

 %Draws a filled object on the frame 
 %draw_filled_object(+Frame, +ShapeName, + Size, +AWTColor, +XPosition, +YPosition)
 draw_filled_object(Frame, ShapeName, Size, AWTColor, X, Y) :-
	getShape(ShapeName, ShapeObject),
	jpl_new(ShapeObject, [X, Y, Size, Size], Shape),
	jpl_get('java.awt.Color', AWTColor, Color),
	jpl_call(Frame, addFillShape, [Shape, Color], _).

%Draws ALL wave rows on the frame
%draw_wave_rows(+Frame, +Color, +NumberOfRows, +NumberOfFragments, +Amplitude, +GapBetweenRows, +Startpoint, +Endpoint)	
draw_wave_rows(_, _, 0, _, _, _, _, _).	
draw_wave_rows(Frame, Color, Rows, NumberOfFragments, Amplitude, Gap, SP, EP) :-
    Rows > 0,
	NewRows is Rows - 1,
	draw_hWave(Frame, Amplitude, NumberOfFragments, Color, SP, EP),
	get_point_content(SP, X1, Y1),
	get_point_content(EP, X2, Y2),
	NewY1 is Y1 + Gap,
	NewY2 is Y2 + Gap,
	NewSP = point(X1, NewY1),
	NewEP = point(X2, NewY2),
	draw_wave_rows(Frame, Color, NewRows, NumberOfFragments, Amplitude, Gap, NewSP, NewEP).	
	
%Draws one horizontal wave from startpoint with a given number of wave fragments
%draw_hWave(+Frame, +Amplitude, +NumberOfFragments, +Color, +Startpoint, +EndpointOfFirstWave)	
draw_hWave(_, _, 0, _, _, _). 
draw_hWave(Frame, Amplitude, NumberOfFragments, CurrentColor, SP, EP) :-
	NumberOfFragments > 0,
	Fragments is NumberOfFragments - 1,
	draw_hWave_fragment(Frame, Amplitude, CurrentColor, SP, EP),
	get_point_content(SP, X1, _),
	get_point_content(EP, X2, Y2),
	Diff is X2 - X1,
	NewX1 is X2,
	NewX2 is X2 + Diff,
	NewSP = point(NewX1, Y2),
	NewEP = point(NewX2, Y2),
	draw_hWave(Frame, Amplitude, Fragments, CurrentColor, NewSP, NewEP).	

%Draws one horizontal piece of a wave fragment like one wave period	
%draw_hWave_fragment(+Frame, +Amplitude, +Color, +Startpoint, +Endpoint)
draw_hWave_fragment(Frame, Amplitude, CurrentColor, SP, EP) :-
	get_point_content(SP, X1, Y1),
	get_point_content(EP, X3, Y3),
	XM is ((X1 + X3) / 2),
	AmpX1 is ((X1 + XM) / 2),	
	AmpX2 is ((XM + X3) / 2),	
	AmpY1 is Y1 + Amplitude,
	AmpY2 is Y1 - Amplitude,
    jpl_new('java.awt.geom.QuadCurve2D$Float', [X1, Y1, AmpX1, AmpY1, XM, Y1], Curve1),
	jpl_new('java.awt.geom.QuadCurve2D$Float', [XM, Y3, AmpX2, AmpY2, X3, Y3], Curve2),
	jpl_get('java.awt.Color', CurrentColor, Color),
    jpl_call(Frame, addDrawShape, [Curve1, Color], _),
	jpl_call(Frame, addDrawShape, [Curve2, Color], _).

%Draws ALL wave columns on the frame
%draw_wave_columns(+Frame, +Color, +NumberOfColumns, +NumberOfFragments, +Amplitude, +GapBetweenRows, +Startpoint, +Endpoint)		
draw_wave_columns(_, _, 0, _, _, _, _, _).	
draw_wave_columns(Frame, Color, Columns, NumberOfFragments, Amplitude, Gap, SP, EP) :-
    Columns > 0,
	NewColumns is Columns - 1,
	draw_vWave(Frame,  Amplitude, NumberOfFragments, Color, SP, EP),
	get_point_content(SP, X1, Y1),
	get_point_content(EP, X2, Y2),
	NewX1 is X1 + Gap,
	NewX2 is X2 + Gap,
	NewSP = point(NewX1, Y1),
	NewEP = point(NewX2, Y2),
	draw_wave_columns(Frame, Color, NewColumns, NumberOfFragments, Amplitude, Gap, NewSP, NewEP).	

%Draws one vertical wave from startpoint with a given number of wave fragments
%draw_vWave(+Frame, +Amplitude, +NumberOfFragments, +Color, +Startpoint, +EndpointOfFirstWave)		
draw_vWave(_, _, 0, _, _, _). 
draw_vWave(Frame, Amplitude, NumberOfFragments, CurrentColor, SP, EP) :-
	NumberOfFragments > 0,
	Fragments is NumberOfFragments - 1,
	draw_vWave_fragment(Frame, Amplitude, CurrentColor, SP, EP),
	get_point_content(SP, _, Y1),
	get_point_content(EP, X2, Y2),
	Diff is Y2 - Y1,
	NewY1 is Y2,
	NewY2 is Y2 + Diff,
	NewSP = point(X2, NewY1),
	NewEP = point(X2, NewY2),
	draw_vWave(Frame, Amplitude, Fragments, CurrentColor, NewSP, NewEP).	

%Draws one vertical piece of a wave fragment like one wave period	
%draw_vWave_fragment(+Frame, +Amplitude, +Color, +Startpoint, +Endpoint)	
draw_vWave_fragment(Frame, Amplitude, CurrentColor, SP, EP) :-
	get_point_content(SP, X1, Y1),
	get_point_content(EP, X3, Y3),
	YM is ((Y1 + Y3) / 2),
	AmpY1 is ((Y1 + YM) / 2),	
	AmpY2 is ((Y3 + YM) / 2),	
	AmpX1 is X1 + Amplitude,
	AmpX2 is X1 - Amplitude,
    jpl_new('java.awt.geom.QuadCurve2D$Float', [X1, Y1, AmpX1, AmpY1, X1, YM], Curve1),
	jpl_new('java.awt.geom.QuadCurve2D$Float', [X3, YM, AmpX2, AmpY2, X3, Y3], Curve2),
	jpl_get('java.awt.Color', CurrentColor, Color),
    jpl_call(Frame, addDrawShape, [Curve1, Color], _),
	jpl_call(Frame, addDrawShape, [Curve2, Color], _).

%draw_crazy_object(+Frame, +Amplitude, +Color1, +Color2)	
draw_crazy_object(Frame, Amp, Color1, Color2) :-
	draw_grid(Frame, Color1, 11, 1, Amp + 0, 20, point(200, 205)),
	draw_grid(Frame, Color2, 11, 1, Amp + 1, 20, point(199, 204)),
	draw_grid(Frame, Color1, 11, 1, Amp + 2, 20, point(198, 203)),
	draw_grid(Frame, Color2, 11, 1, Amp + 3, 20, point(197, 202)),
	draw_grid(Frame, Color1, 11, 1, Amp + 4, 20, point(196, 201)),
	draw_grid(Frame, Color2, 11, 1, Amp + 5, 20, point(195, 200)).	
 
%returns the coordinates X and Y for a given point(X, Y)
%get_point_content(+Point, -X, -Y)
get_point_content(Point, X, Y) :-
	Point =.. L,
	L = [_, X, _],
	L = [_, _, Y].
	
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