% draw(+Size)
% draws a graphics with a given Size

draw(Size) :-
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new(Display,picture('*** Your picture''s name ***',size(SizeD,SizeD))),
   send(Display,open),
   %send(Display,background,colour(black)),
   send(Display,background,colour(@default, 214, 20, 87, hsv)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the objects on the display
   (
		draw_sky(Display, colour(@default, 223, 70, 80, hsv)),
		%draw_recursive_filled_object(Display, 620, 4, [circle, box], [white, black], point(0, 0)),
		%draw_recursive_filled_object(Display, 220, 4, [circle, box], [red, black], point(200, 200)),		
		draw_snowman(Display, point(210, 350)), 	
		draw_recursive_filled_object(Display, 40, 2, [circle, box], [green, black], point(245, 190)),
		draw_recursive_filled_object(Display, 60, 2, [box], [red, blue, yellow, green, orange], point(0, 560)),
		
		draw_image(Display, bitmap('32x32/yoshi.xpm'), point(270,160)),	

	
		%draw_recursive_filled_object(Display, 200, 40, [circle], [blue, black, white], point(50, 50)),
		%draw_recursive_filled_object(Display, 200, 40, [circle], [blue, black, white], point(370, 50)),
		%draw_recursive_filled_object(Display, 40, 4, [circle], [blue, white, black], point(130, 130)),
		%draw_recursive_filled_object(Display, 40, 4, [circle], [blue, white, black], point(450, 130)),
		%draw_recursive_normal_object(Display, 200, 4, green, point(200,200)),
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
draw_sky(Display, Color) :-
	send(Display, display , new(@sky, box(620,400)) ),
	send(@sky, fill_pattern, Color).

%returns the coordinates X and Y for a given point(X, Y)
%get_point_content(+Point, -X, -Y)
get_point_content(Point, X, Y) :-
	Point =.. L,
	L = [_, X, _],
	L = [_, _, Y].	
   
draw_snowman(Display, Position) :-
	get_point_content(Position, X, Y),
	draw_body(Display, white, X, Y), 
	draw_hat(Display, black, X, Y),  
	draw_eyes(Display, X, Y),
	draw_mouth(Display, black, X, Y).

%draws the snowmans body
draw_body(Display, Color, X, Y) :- 
	draw_filled_shape(Display, circle(200), Color, point(X, Y)),
	draw_filled_shape(Display, circle(170), Color, point(X + 17, Y - 130)).

%draws the snowmans hat	
draw_hat(Display, Color, X, Y) :-
	draw_filled_shape(Display, box(160, 20), Color, point(X + 20, Y - 120)),
	draw_filled_shape(Display, box(130, 60), Color, point(X + 35, Y - 160)).
	
%draws the snomans eyes
draw_eyes(Display, X, Y) :-
	draw_recursive_filled_object(Display, 30, 4, [box, circle], [black, white], point(X + 52, Y - 80)),
    draw_recursive_filled_object(Display, 30, 4, [circle], [black, red], point(X + 122, Y - 80)).
	
draw_mouth(Display, Color, X, Y) :-
	draw_filled_shape(Display, circle(8), Color, point(X + 74, Y - 18)),
	draw_filled_shape(Display, circle(8), Color, point(X + 80, Y - 10)),
	draw_filled_shape(Display, circle(8), Color, point(X + 90, Y - 6)),
    draw_filled_shape(Display, circle(8), Color, point(X + 100, Y - 6)),
	draw_filled_shape(Display, circle(8), Color, point(X + 110, Y - 10)),
	draw_filled_shape(Display, circle(8), Color, point(X + 116, Y - 18)).
	

% draw_recursive_shape(+Display, +Size, +RecursionFactor, +Position)
% The recursion factor determines the number of recursion steps. High recursion factor means
% less recursion steps.
draw_recursive_normal_object(Name, Size, RFactor, Color, Position) :- 
  get_point_content(Position, X, Y),
  draw_normal_object(Name, Size, RFactor, Color, X, Y).

%helper predicate to draw a circle recursvie  
 draw_normal_object(_, Size, _, _, _, _) :- Size =< 0.
 draw_normal_object(Name, Size, RFactor, Color, X, Y) :-
  ObjName = @_,
  Size > 0,     
  SizeNew is Size - (2 * RFactor),
  NewX is X + RFactor,
  NewY is Y + RFactor,
  draw_normal_object(Name, SizeNew, RFactor, Color, NewX, NewY),
  send(Name, display, new(ObjName, circle(Size)), point(NewX, NewY)),  
  send(ObjName, colour(Color)).

draw_recursive_filled_object(Name, Size, RFactor, ObjList, ColorList, Position) :- 
  get_point_content(Position, X, Y),
  draw_filled_object(Name, Size, 0, 0, RFactor, ObjList, ColorList, X, Y).
  
%helper predicate to draw a circle recursvie  
draw_filled_object(_, Size, _, _, _, _, _, _, _) :- Size =< 0.
draw_filled_object(Name, Size, ObjIndex, ColorIndex, RFactor, ObjList, ColorList, X, Y) :-
  nth0(ObjIndex, ObjList, ObjectName),
  getObject(ObjectName, Size, Object),
  nth0(ColorIndex, ColorList, Color),
  ObjName = @_,
  Size > 0,     
  SizeNew is Size - (2 * RFactor),
  NewObjIndex is ObjIndex + 1,
  NewColIndex is ColorIndex + 1,
  adaptIndex(ObjList, NewObjIndex, O),
  adaptIndex(ColorList, NewColIndex, I),
  NewX is X + RFactor,
  NewY is Y + RFactor,
  send(Name, display, new(ObjName, Object), point(X, Y)),  
  send(ObjName, fill_pattern, colour(Color)),
  draw_filled_object(Name, SizeNew, O, I, RFactor, ObjList, ColorList, NewX, NewY).  
  
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
	send(ObjName, fill_pattern, colour(Color)).
	
%draw_normal_shape(+Display, +Shape, +Color, +Position)	
draw_normal_shape(Name, Shape, Color, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, Shape), Position),
	send(ObjName, colour(Color)).	

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

