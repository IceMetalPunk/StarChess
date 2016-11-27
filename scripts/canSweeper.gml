/* canSweeper(x1, y1, x2, y2) - Returns true if a sweeper can move from board
                                cell (x1, y1) to board cell (x2, y2) legally.
*/
var x1,y1,x2,y2,type,xx,yy;
x1=argument0;
y1=argument1;
x2=argument2;
y2=argument3;
type=argument4;

/* Can't move in any direction except a cardinal straight line */
if (x2!=x1 && y2!=y1) {
  return false;
}

/* If you're moving vertically... */
if (x2==x1) {
  /* And down... */
  if (y1<y2) {
  
    /* Check every position along the line for an invalid space */
    for (yy=y1+1; yy<=y2; yy+=1) {
      if ((position_meeting(b2r_x(x1)+board.gw/2, b2r_y(yy)+board.gh/2, pieceobj) && yy!=y2) || position_meeting(b2r_x(x1)+board.gw/2, b2r_y(yy)+board.gh/2, type) || isHole(x1,yy)) {
        return false;
      }
    }
  }
  
  /* Or up... */
  else {
  
    /* Check every position along the line for an invalid space */
    for (yy=y1-1; yy>=y2; yy-=1) {
      if ((position_meeting(b2r_x(x1)+board.gw/2, b2r_y(yy)+board.gh/2, pieceobj) && yy!=y2) || position_meeting(b2r_x(x1)+board.gw/2, b2r_y(yy)+board.gh/2, type) || isHole(x1,yy)) {
        return false;
      }
    }
  }
}

/* If you're moving horizontally... */
else if (y1==y2) {

  /* And right... */
  if (x1<x2) {
  
    /* Check every position along the line for an invalid space */
    for (xx=x1+1; xx<=x2; xx+=1) {
      if ((position_meeting(b2r_x(xx)+board.gw/2, b2r_y(y1)+board.gh/2, pieceobj) && xx!=x2) || position_meeting(b2r_x(xx)+board.gw/2, b2r_y(y1)+board.gh/2, type) || isHole(xx,y1)) {
        return false;
      }
    }
  }
  
  /* Or left... */
  else {
  
    /* Check every position along the line for an invalid space */
    for (xx=x1-1; xx>=x2; xx-=1) {
      if ((position_meeting(b2r_x(xx)+board.gw/2, b2r_y(y1)+board.gh/2, pieceobj) && xx!=x2) || position_meeting(b2r_x(xx)+board.gw/2, b2r_y(y1)+board.gh/2, type) || isHole(xx,y1)) {
        return false;
      }
    }
  }
}

/* If all of the above checks pass, then the move is legal */
return true;
