/* canDropper(x1, y1, x2, y2) - Returns true if a dropper can move from board
                                cell (x1, y1) to board cell (x2, y2) legally.
*/
var x1,y1,x2,y2,type,xx,yy;
x1=argument0;
y1=argument1;
x2=argument2;
y2=argument3;
type=argument4;

/* Can only move diagonally and no more than 2 spaces */
if (abs(x2-x1)!=abs(y2-y1) || abs(x2-x1)>2) { return false; }

else {
  /* Moving only one square, make sure it's not occupied by one of your pieces or a hole */
  if (abs(x2-x1)==1) {
   return (!position_meeting(b2r_x(x1+sign(x2-x1))+board.gw/2, b2r_y(y1+sign(y2-y1))+board.gh/2, type) && !isHole(x1+sign(x2-x1),y1+sign(y2-y1)));
  }
  
  /* Moving 2 squares, make sure you don't have to pass a hole or your own piece on the way there */
  else if (abs(x2-x1)==2) {
    return !(position_meeting(b2r_x(x1+sign(x2-x1))+board.gw/2, b2r_y(y1+sign(y2-y1))+board.gh/2, pieceobj) || position_meeting(b2r_x(x1+2*sign(x2-x1))+board.gw/2, b2r_y(y1+2*sign(y2-y1))+board.gh/2, type) || isHole(x1+sign(x2-x1),y1+sign(y2-y1)) || isHole(x1+2*sign(x2-x1),y1+2*sign(y2-y1)));
  }
}
