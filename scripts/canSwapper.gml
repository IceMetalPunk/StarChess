/* canSwapper(x1, y1, x2, y2) - Returns true if a swapper can move from board
                                cell (x1, y1) to board cell (x2, y2) legally.
*/
var x1,y1,x2,y2,type;
x1=argument0;
y1=argument1;
x2=argument2;
y2=argument3;
type=argument4;

/* Can only move one space in any cardinal direction & not onto a hole or your own piece. */
return (abs(y2-y1)+abs(x2-x1)==1 && !position_meeting(b2r_x(x2)+board.gw/2, b2r_y(y2)+board.gh/2, type) && !isHole(x2,y2));
