/* moveTo(x,y) - Triggers the selected piece to move to board cell (x,y) */

var piece;
piece=-1;
with (pieces[global.controlled]) {
  if (selected) { piece=id; }
}
if (!instance_exists(piece)) {
  return false;
}
else {
  piece.moving=1;
  piece.moveX=board.bx+argument0*board.gw;
  piece.moveY=board.by+argument1*board.gh;
  return true;
}
