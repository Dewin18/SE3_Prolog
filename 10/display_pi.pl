/* SE3 LP - Aufgabenblatt 10

Autor: 
Dewin Bagci, 6815336
Christian Cyll, 6870744
Max Wutz, 6308876

Datum 15.01.2018
*/

% init_display(Display-Objekt,Fenster-Ueberschrift,Fensterbreite,Fensterhoehe)
init_display(Name,Label,Width,Height):-
   free(Name),
   retractall(display_parameters(_,_,_)),
   assert(display_parameters(Name,Width,Height)),
   new(Name,picture(Label,size(Width,Height))),
   send(Name,open).
   
% display_sequence(Displayname,Liste,Skalierung-x, Skalierung-y)
display_sequence(Name,Color,L,Sx,Sy):-
  ds(Name,Color,L,10,1,Sx,Sy).  % y-offset muss an das Problem angepasst werden 

%ds(Displayname,Liste,Offset-x,Offset-y,Skalierung-x,Skalierung-y)
ds(_,_,[ ],_,_,_,_).
ds(_,_,[_],_,_,_,_).
ds(Name,Color,[E1,E2|T],Ox,Oy,Sx,Sy):-
  ObjName = @_,
  Ox1 is Ox+Sx,
  display_parameters(Name,_,Height),
  E1s is (Height - (E1 + Oy) * Sy),
  E2s is (Height - (E2 + Oy) * Sy),
  send(Name,display,new(ObjName, line(Ox,E1s,Ox1,E2s,none))),
  send(ObjName, colour(Color)),
  send(Name,flush),
  ds(Name,Color,[E2|T],Ox1,Oy,Sx,Sy).

%display(Fenster-Ueberschrift,Liste)
display(Label,L):-
   init_display(@d,Label,1280,700),                    
   display_sequence(@d,black,L,2.5,30).
                                
%displayTwo(Fenster-Ueberschrift,Liste1,Liste2)									 
displayTwo(Label, L1, L2):-
   init_display(@d,Label,1280,700),                                  
   display_sequence(@d,black,L1,2.5,30),
   display_sequence(@d,blue,L2,2.5,30).   