% draw(+Size)
% draws a graphics with a given Size

draw(Size) :-
   % define size of the display (picture size + scroll bar area)
   SizeD is Size+20,
   % create a new display and open it
   new(Display,picture('*** Your picture''s name ***',size(SizeD,SizeD))),
   send(Display,open),
   send(Display,background,colour(white)), %* MK: ggf. Farbe auf 'white' stellen

   % draw the object on the display
   (
		draw_filled_shape(Display, box(100, 100), orange, point(25,25)),
	    draw_normal_shape(Display, box(100, 100), green, point(78,78)),
		draw_filled_shape(Display, circle(100), orange, point(25,25)),
		draw_image(Display, bitmap('32x32/yoshi.xpm'), point(100,100)),	
		
		%draw_xmas_tree(Display, Size, Color, Position)
		draw_triangle2(Display, 20, point(50,50)),

        draw_recursive_shape(Display, _, 200, red, point(225,25)),

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


% draw_recursive_shape(Display,Size,CurrentSize,*** add additional parameters here, if needed ***)
% draws a gradient graphics of size Size into Display
% CurrentSize is decreased recursively fom Size to 0
draw_recursive_shape(_,_,0,_). 
draw_recursive_shape(Name, Size, CSize, Color, Position) :- 
	ObjName = @_,
	CSize > 0 ,        % only for positive integers
	send(Name , display, new(ObjName ,box(CSize,CSize)), Position),
	send(ObjName, colour(Color)),	
	CSizeNew is CSize - 2,
	draw_recursive_shape(Name, Size, CSizeNew, Color, Position).

%draw_filled_shape(+Display, +ObjectName, +Shape, +Color, +Position)	
draw_filled_shape(Name, Shape, Color, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, Shape), Position),
	send(ObjName, fill_pattern, colour(Color)).
	
%draw_normal_shape(+Display, +ObjectName, +Shape, +Color, +Position)	
draw_normal_shape(Name, Shape, Color, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, Shape), Position),
	send(ObjName, colour(Color)).	

draw_image(Name, ImagePath, Position) :-
	ObjName = @_,
	send(Name, display, new(ObjName, ImagePath), Position).
	
%draw_triangle(Name, Size, Color, X1, X2, Y1, Y2) :-
%	ObjName = @_,
%	send(Name, display, new(ObjName, line(X1, X2, Y1, Y2))),
%	send(ObjName, Color).
	
getPointContent(Point, X, Y) :-
	Point =.. L,
	L = [_, X, _],
	L = [_, _, Y].	
	
draw_triangle2(Name, Size, Point) :-
	ObjName = @_,
	get_triangle_bottom_coords(Point, Size, X1, Y1, X2, Y2),
	get_triangle_left_coords(Point, Size, P1, Q1, P2, Q2),
	get_triangle_right_coords(Point, Size, A1, B1, A2, B2),
	send(Name, display, new(@t1, line(X1, Y1, X2, Y2))),
	send(Name, display, new(@t2, line(P1, Q1, P2, Q2))),
	send(Name, display, new(@t3, line(A1, B1, A2, B2))).
	
get_triangle_bottom_coords(Point, Size, X1, Y1, X2, Y2) :-
	getPointContent(Point, X, Y),
	X1 is X - (Size / 2),
	Y1 is Y - (Size / 2),
	X2 is X + (Size / 2),
	Y2 is Y - (Size / 2).
	
get_triangle_left_coords(Point, Size, X1, Y1, X2, Y2) :-
	getPointContent(Point, X, Y),
	X1 is X - (Size / 2),
	Y1 is Y - (Size / 2),
	X2 is X,
	Y2 is Y + (Size / 2).
	
get_triangle_right_coords(Point, Size, X1, Y1, X2, Y2) :-
	getPointContent(Point, X, Y),
	X1 is X + (Size / 2),
	Y1 is Y - (Size / 2),
	X2 is X,
	Y2 is Y + (Size / 2).
	
% Call the program and see the result
%geradeLinien:line(X-Anfangspunkt,Y-Anfangspunkt,X-Endpunkt,Y-Endpunkt)

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

