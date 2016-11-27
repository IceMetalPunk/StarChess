/* isHole(x, y) - Returns true if the board cell at (x,y) is a hole or a
   hole-equivalent (a hole patched with the opponent's color) */
var ret;
ret=ds_grid_get(global.holes,argument0,argument1);

if (global.turn==0) {
  ret=(ret && !position_meeting(b2r_x(argument0)+board.gw/2, b2r_y(argument1)+board.gh/2, RedPatch));
}
else {
  ret=(ret && !position_meeting(b2r_x(argument0)+board.gw/2, b2r_y(argument1)+board.gh/2, BlackPatch));
}

return ret;
