/* SE3 LP - Aufgabenblatt 09

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 03.01.2018
*/

%Aufgabe 2.1

% draw(+Size)
% draws a graphics with a given Size

draw(Size) :-
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new(Display,picture('PROLOG - SNOWMAN',size(SizeD,SizeD))),
   send(Display,open),
   %send(Display,background,colour(black)),
   send(Display,background,colour(@default, 214, 20, 87, hsv)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the objects on the display
   (
		draw_sky(Display),	
		draw_snowman(Display, point(210, 320)), 		
		draw_image(Display, bitmap('32x32/yoshi.xpm'), point(240,130)),	
		draw_frame(Display), 	
		true
   ),
   % if desired save the display as .jpg
   write_ln('Save the graphics (y/n): '),
   get_single_char(A),
   put_code(A),nl,
   (A=:=121 ->
     (write_ln('enter file name: '),
      read_line_to_codes(user_input,X),
      atom_codes(File,X),
      atom_concat(File,'.jpg',FileName),
      get(Display,image,Image),
      send(Image,save,FileName,jpeg) ) ; true ),

   !.
  
%draws the skyblue background as box on the screen
draw_sky(Display) :-
	send(Display, display , new(@sky, box(620,400)) ),
	send(@sky, fill_pattern, colour(@default, 223, 70, 80, hsv)).

%returns the coordinates X and Y for a given point(X, Y)
%get_point_content(+Point, -X, -Y)
get_point_content(Point, X, Y) :-
	Point =.. L,
	L = [_, X, _],
	L = [_, _, Y].	
	
draw_snowman(Display, Position) :-
	get_point_content(Position, X, Y),
	draw_body(Display, colour(white), X, Y), 
	draw_buttons(Display, colour(orange), X, Y),
	draw_hat(Display, colour(black), X, Y),  
	draw_eyes(Display, X, Y),
	draw_mouth(Display, colour(black), X, Y).

%draws the snowmans body
draw_body(Display, Color, X, Y) :- 
	draw_filled_shape(Display, circle(200), Color, point(X, Y)),
	draw_filled_shape(Display, circle(170), Color, point(X + 17, Y - 130)).

%draws the snowmans buttons
draw_buttons(Display, Color, X, Y) :-
	draw_filled_shape(Display, circle(10), Color, point(X + 98, Y + 70)),
	draw_filled_shape(Display, circle(10), Color, point(X + 98, Y + 90)),
	draw_filled_shape(Display, circle(10), Color, point(X + 98, Y + 110)),
	draw_filled_shape(Display, circle(10), Color, point(X + 98, Y + 130)).

%draws the snowmans hat	
draw_hat(Display, Color, X, Y) :-
	draw_filled_shape(Display, box(160, 20), Color, point(X + 20, Y - 120)),
	draw_filled_shape(Display, box(130, 60), Color, point(X + 35, Y - 160)),
	draw_recursive_filled_object(Display, 40, 2, [circle, box], [green, black], point(X + 35, Y - 160)).	
	
%draws the snomans eyes
draw_eyes(Display, X, Y) :-
	draw_recursive_filled_object(Display, 30, 4, [box, circle], [black, white], point(X + 52, Y - 80)),
    draw_recursive_filled_object(Display, 30, 4, [circle], [black, red], point(X + 122, Y - 80)).

%draws the snowmans mouth
draw_mouth(Display, Color, X, Y) :-
	draw_filled_shape(Display, circle(8), Color, point(X + 74, Y - 18)),
	draw_filled_shape(Display, circle(8), Color, point(X + 80, Y - 10)),
	draw_filled_shape(Display, circle(8), Color, point(X + 90, Y - 6)),
    draw_filled_shape(Display, circle(8), Color, point(X + 100, Y - 6)),
	draw_filled_shape(Display, circle(8), Color, point(X + 110, Y - 10)),
	draw_filled_shape(Display, circle(8), Color, point(X + 116, Y - 18)).

%draws all recursive objects for the frame
draw_frame(Display) :-
	draw_left_frame(Display),
	draw_bottom_frame(Display),
	draw_right_frame(Display),
	draw_top_frame(Display).


draw_left_frame(Display) :-
	draw_recursive_filled_object(Display, 62, 4, [box], [red, blue, orange, green], point(0, 0)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle, circle], [white,black, blue], point(0, 62)),
	draw_recursive_filled_object(Display, 62, 4, [box, box, circle], [red, blue, orange, green], point(0, 124)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle], [black, pink], point(0, 186)),
	draw_recursive_filled_object(Display, 62, 2, [box], [red,blue,yellow,green], point(0, 248)),
	draw_recursive_filled_object(Display, 62, 7, [box], [red,white], point(0, 310)),
	draw_recursive_filled_object(Display, 62, 7, [box, circle, circle, circle, box], [orange, black], point(0, 372)),
	draw_recursive_filled_object(Display, 62, 3, [box, circle, box, circle, box, circle], [dark_green, blue, pink], point(0, 434)),
	draw_recursive_filled_object(Display, 62, 12, [box, circle], [white, black], point(0, 496)),
	draw_recursive_filled_object(Display, 62, 2, [box, circle], [black, light_blue], point(0, 558)).
	
draw_bottom_frame(Display) :-
	draw_recursive_filled_object(Display, 62, 4, [box, box, circle, circle, box, circle], [red, blue], point(62, 558)),
	draw_recursive_filled_object(Display, 62, 2, [box, circle, circle, circle, circle, circle], [black, light_green], point(124, 558)),
	draw_recursive_filled_object(Display, 62, 20, [box, circle], [dark_green, red], point(186, 558)),
	draw_recursive_filled_object(Display, 62, 2, [box], [black, yellow], point(248, 558)),
	draw_recursive_filled_object(Display, 62, 2, [box, circle, circle], [white, black], point(310, 558)),
	draw_recursive_filled_object(Display, 62, 2, [box], [pink, dark_grey, red, blue, yellow, green], point(372, 558)),
	draw_recursive_filled_object(Display, 62, 2, [box, box, box, circle], [pink, dark_grey], point(434, 558)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle], [black, green], point(496, 558)),
	draw_recursive_filled_object(Display, 62, 6, [box, circle, circle], [blue, white], point(558, 558)).
	
draw_right_frame(Display) :-
	draw_recursive_filled_object(Display, 62, 4, [box, circle, circle, circle, circle, circle, circle], [grey, white], point(558, 496)),
	draw_recursive_filled_object(Display, 62, 4, [box], [red, orange, yellow], point(558, 434)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle, box, circle], [black, light_blue, yellow, green], point(558, 372)),
	draw_recursive_filled_object(Display, 62, 6, [box, box, circle, circle], [green, dark_green], point(558, 310)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle, circle, circle], [black, red], point(558, 248)),
	draw_recursive_filled_object(Display, 62, 3, [box], [orange, blue], point(558, 186)),
	draw_recursive_filled_object(Display, 62, 9, [box, circle], [white, black, grey], point(558, 124)),
	draw_recursive_filled_object(Display, 62, 3, [box, circle], [black, light_green], point(558, 62)),
	draw_recursive_filled_object(Display, 62, 6, [box, box, circle], [red, pink], point(558, 0)).
	
draw_top_frame(Display) :-
	draw_recursive_filled_object(Display, 62, 2, [box, circle, circle, circle], [yellow, orange], point(496, 0)),
	draw_recursive_filled_object(Display, 62, 5, [box], [black, green], point(434, 0)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle, circle], [red, orange, white], point(372, 0)),
	draw_recursive_filled_object(Display, 62, 8, [box, circle], [black, blue, light_blue], point(310, 0)),
	draw_recursive_filled_object(Display, 62, 2, [box, box, circle], [pink, white, black], point(248, 0)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle, circle, circle, circle, circle, circle, circle, circle, circle, circle], [yellow, violet], point(186, 0)),
	draw_recursive_filled_object(Display, 62, 12, [box], [red, green], point(124, 0)),
	draw_recursive_filled_object(Display, 62, 4, [box, circle], [blue, light_blue, dark_green], point(62, 0)).

%draw_recursive_filled_object(+Display, +Size, +RecursionFactor, +ObjectList, +ColorList, +Position)
%The recursion factor determines the number of recursion steps. High recursion factor means
%less recursion steps.
draw_recursive_filled_object(Name, Size, RFactor, ObjList, ColorList, Position) :- 
  get_point_content(Position, X, Y),
  draw_filled_object(Name, Size, 0, 0, RFactor, ObjList, ColorList, X, Y).
  
%helper predicate to draw the recursive objects from the ObjectList 
draw_filled_object(_, Size, _, _, _, _, _, _, _) :- Size =< 0.
draw_filled_object(Name, Size, ObjIndex, ColorIndex, RFactor, ObjList, ColorList, X, Y) :-
  nth0(ColorIndex, ColorList, Color),
  nth0(ObjIndex, ObjList, ObjectName),
  getObject(ObjectName, Size, Object),
  ObjName = @_,
  Size > 0,     
  NewSize is Size - (2 * RFactor),
  NewObjIndex is ObjIndex + 1,
  NewColIndex is ColorIndex + 1,
  adaptIndex(ObjList, NewObjIndex, O),
  adaptIndex(ColorList, NewColIndex, I),
  NewX is X + RFactor,
  NewY is Y + RFactor,
  send(Name, display, new(ObjName, Object), point(X, Y)),  
  send(ObjName, fill_pattern, colour(Color)),
  draw_filled_object(Name, NewSize, O, I, RFactor, ObjList, ColorList, NewX, NewY).  
  
adaptIndex(List, CIndex, NIndex) :-
	length(List, Length),
	CIndex < Length,
	NIndex is CIndex.
	
adaptIndex(List, CIndex, NIndex) :-
	length(List, Length),
	CIndex >= Length,
	NIndex is 0.			
	
getObject(ObjName, Size, ObjType) :- ObjType = box(Size, Size), ObjName = box.	
getObject(ObjName, Size, ObjType) :- ObjType = circle(Size), ObjName = circle.	
  
%draw_filled_shape(+Display, +Shape, +Color, +Position)	
draw_filled_shape(Name, Shape, Color, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, Shape), Position),
	send(ObjName, fill_pattern, Color).
	
%draw_image(+Display, +xpmPath, +Position)
draw_image(Name, ImagePath, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, ImagePath), Position).
	
% Call the program and see the result

:- draw( 600 ).   % specify the desired display size in pixel here (required argument)   


% ========== Tests from XPCE-guide Ch 5 ==========

% destroy objects
mkfree :-
   free(@p),
   free(@bo),
   free(@ci),
   free(@bm),
   free(@tx),
   free(@bz).

% create picture / window
mkp :-
   new( @p , picture('Demo Picture') ) ,
   send( @p , open ).

% generate objects in picture / window
mkbo :-

   send( @p , display , new(@bo,box(100,100)) ).
mkci :-
   send( @p , display , new(@ci,circle(50)) , point(25,25) ).
mkbm :-
   send( @p , display , new(@bm,bitmap('32x32/yoshi.xpm')) , point(100,100) ).
mktx :-
   send( @p , display , new(@tx,text('Hello')) , point(120,50) ).
mkbz :-
   send( @p , display , new(@bz,bezier_curve(
	 point(50,100),point(120,132),point(50,160),point(120,200))) ).

% modify objects
mkboc :-
   send( @bo , radius , 10 ).
mkcic :-
   send( @ci , fill_pattern , colour(orange) ).
mktxc :-
   send( @tx , font , font(times,bold,18) ).
mkbzc :-
   send( @bz , arrows , both ).

