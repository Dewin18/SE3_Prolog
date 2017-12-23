% draw(+Size)
% draws a graphics with a given Size

draw(Size) :-
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new(Display,picture('*** Your picture''s name ***',size(SizeD,SizeD))),
   send(Display,open),
   send(Display,background,colour(@default, 214, 20, 87, hsv)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the objects on the display
   (
		draw_sky(Display), 
		draw_snowman(Display, white, point(210, 350)), 	
		draw_image(Display, bitmap('32x32/yoshi.xpm'), point(270,160)),	
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
  
%sraws the skyblue background as box on the screen
draw_sky(Display) :-
	send(Display, display , new(@sky, box(620,400)) ),
	send(@sky, fill_pattern, colour(@default, 223, 70, 80, hsv)).

%returns the coordinates X and Y for a given point(X, Y)
%get_point_content(+Point, -X, -Y)
get_point_content(Point, X, Y) :-
	Point =.. L,
	L = [_, X, _],
	L = [_, _, Y].	
   
draw_snowman(Display, Color, Position) :-
	get_point_content(Position, X, Y),
	
	%draw the snowmans body
	draw_filled_shape(Display, circle(200), Color, point(X, Y)),
	draw_filled_shape(Display, circle(170), Color, point(X + 17, Y - 130)),
	
	%draws the snowmans hat
	draw_filled_shape(Display, box(160, 20), black, point(X + 20, Y - 120)),
	draw_filled_shape(Display, box(130, 60), black, point(X + 35, Y - 160)),
    
	%draws the snomans eyes
	draw_recursive_circle(Display, 30, 2, point(260,270)),
    draw_recursive_circle(Display, 30, 2, point(330,270)).

% draw_recursive_shape(+Display, +Size, +RecursionFactor, +Position)
% The recursion factor determines the number of recursion steps. High recursion factor means
% less recursion steps.
draw_recursive_circle(Name, Size, RFactor, Position) :- 
  get_point_content(Position, X, Y),
  draw_recursive(Name, Size, RFactor, X, Y).

%helper predicate to draw a circle recursvie  
draw_recursive(_, Size, _, _, _) :- Size =< 0.
draw_recursive(Name, Size, RFactor, X, Y) :-
  Size > 0,     
  SizeNew is Size - (2 * RFactor),
  NewX is X + RFactor,
  NewY is Y + RFactor,
  draw_recursive(Name, SizeNew, RFactor, NewX, NewY),
  send(Name, display, new(@_,circle(Size)), point(NewX, NewY)).

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

