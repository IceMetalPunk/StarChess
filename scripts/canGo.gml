/* Syntax: canGo(x,y[, me])

Arguments:
(x,y) - The GRID-SPACE UNIT (x,y) of the potential place
[me] (Optional) - If set to true, specified we want to check the validity of
                  the calling piece's movement, not the currently selected
                  piece's.

Returns: True if can go, false if not.

*/
var piece,x1,y1,x2,y2,type,quit;
x2=argument[0];
y2=argument[1];

/* Determine the piece to check */
if (argument_count>2) { piece=id; }
else {
  piece=noone;
  with (board.pieces[global.controlled]) {
    if (selected) { piece=id; }
  }
}
if (!instance_exists(piece)) {
  return false;
}

/* Only patchers can move onto holes */
if (isHole(x2,y2) && getType(piece.object_index)!="Patcher") {
  return false;
}

type=object_get_parent(piece.object_index);

/* You can't move onto a space occupied by one of your own pieces */
if (type==Red && instance_position(board.bx+x2*board.gw, board.by+y2*board.gh, Red)>=0) {
  return false;
}
else if (type==Black && instance_position(board.bx+x2*board.gw, board.by+y2*board.gh, Black)>=0) {
  return false;
}

/* Get piece's current position */
x1=(piece.x-board.bx) div board.gw;
y1=(piece.y-board.by) div board.gh;

/* You can't move onto the space you're already currently on */
if (x1==x2 && y1==y2) {
  return false;
}

/* Now enforce piece-specific movement restrictions */
switch (getType(piece.object_index)) {
  case "Swapper":
    return canSwapper(x1,y1,x2,y2,type);
    break;
  
  case "Dropper":
    return canDropper(x1,y1,x2,y2,type);
    break;
    
  case "Sweeper":
    return canSweeper(x1,y1,x2,y2,type);
    break;
    
  case "Patcher":
    return canPatcher(x1,y1,x2,y2,type);
    break;
    
  default:
    return false;
}
