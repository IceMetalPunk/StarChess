/* canPatcher(x1, y1, x2, y2) - Returns true if a patcher can move from board
                                cell (x1, y1) to board cell (x2, y2) legally.
*/
var x1,y1,x2,y2,type,p,ret;
x1=argument0;
y1=argument1;
x2=argument2;
y2=argument3;
type=argument4;

/* Can only move cardinally */
if (x1!=x2 && y1!=y2) { return false; }

/* Can't move more than 3 spaces */
if ((x1==x2 && abs(y2-y1)>3) || (y1==y2 && abs(x2-x1)>3)) { return false; }

/* If we're moving vertically... */
if (x1==x2) {

  /* Check one space ahead for an invalid space */
  ret=!position_meeting(b2r_x(x1)+board.gw/2, b2r_y(y1+sign(y2-y1))+board.gh/2, pieceobj);
  ret=ret && (!isHole(x1, y1+sign(y2-y1)) || abs(y2-y1)==1);
  
  /* Continue checking up to the distance of the move for invalid spaces */  
  for (p=2; p<=abs(y2-y1); p+=1) {
    ret=(ret && !position_meeting(b2r_x(x1)+board.gw/2, b2r_y(y1+p*sign(y2-y1))+board.gh/2, pieceobj));
    
    /* Note that for patchers, a hole is not invalid so long as you don't try to jump over it */
    if (p!=abs(y2-y1) && isHole(x1, y1+p*sign(y2-y1))) { return false; }
  }
  return ret;
}

/* Similar for horizontal moves */
else if (y1==y2) {
  ret=!position_meeting(b2r_x(x1+sign(x2-x1))+board.gw/2, b2r_y(y1)+board.gh/2, pieceobj);
  ret=ret && (!isHole(x1+sign(x2-x1), y1) || abs(x2-x1)==1);
  
  for (p=2; p<=abs(x2-x1); p+=1) {
    ret=(ret && !position_meeting(b2r_x(x1+p*sign(x2-x1))+board.gw/2, b2r_y(y1)+board.gh/2, pieceobj));
    if (p!=abs(x2-x1) && isHole(x1+p*sign(x2-x1), y1)) { return false; }
  }
  return ret;
}

/* Any other moves are invalid */
return false;
