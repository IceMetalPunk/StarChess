/* GoAI(type), where type==Black|Red */
/* TODO: Buff AI; it misses obvious captures */

var prios,val,moves,prio,choice;
prios=ds_priority_create();

/* Rank all possible moves for each and every piece of the specified color */
with (argument0) {
  switch (getType(object_index)) {
    case "Swapper":
      SwapperAI(prios);
      break;
    case "Dropper":
      DropperAI(prios);
      break;
    case "Sweeper":
      SweeperAI(prios);
      break;
    case "Patcher":
      PatcherAI(prios);
      break;
    default:
      // An invalid object is calling this; shouldn't happen!
      //ds_priority_destroy(prios);
      //global.turn=!global.turn;
      //return false;
  }
}

/* If there are no moves to make... */
if (ds_priority_size(prios)<=0) {
  ds_priority_destroy(prios);

  global.turn=!global.turn;
  return false;
}

/* Add all instances that tie for top ranks--after accounting for difficulty--to a list */
moves=ds_list_create();

// Ignore top-ranking ones based on difficulty, if needed
var difficultyAdjust = floor((MAX_DIFFICULTY-global.difficulty)/(MAX_DIFFICULTY+1)) * ds_priority_size(prios);

// Optimize clearing all bu the lowest if the entire thing is meant to be cleared
if (difficultyAdjust>=ds_priority_size(prios)) {
    val=ds_priority_find_min(prios);
    prio=ds_priority_find_priority(prios, val);
    ds_priority_clear(prios);
    ds_priority_add(prios, val, prio);
}

// Or just clear the appropriate fraction of the list.
else {
    for (var p=0; p<difficultyAdjust; ++p) {
        ds_priority_delete_max(prios);
    }   
}

// Grab all moves that tie for top of the remaining list
val=ds_priority_find_max(prios);
prio=ds_priority_find_priority(prios,val);
var oprio=prio;
ds_list_add(moves, ds_priority_delete_max(prios));
ds_list_add(moves, prio);

val=ds_priority_find_max(prios);
prio=ds_priority_find_priority(prios,val);
while (prio==oprio && !ds_priority_empty(prios)) {
 ds_list_add(moves, ds_priority_delete_max(prios));
  ds_list_add(moves, prio);

  val=ds_priority_find_max(prios);
  prio=ds_priority_find_priority(prios,val); 
}

ds_priority_destroy(prios);

/* Pick a random top-ranking move */
choice=irandom(ds_list_size(moves)/2-1)*2;
val=ds_list_find_value(moves, choice);

// Track the choen score for other uses
global.AIScore=ds_list_find_value(moves, choice+1);

ds_list_destroy(moves);

/* Make that move */
with (val) {
  moving=1;
  moveX=board.bx+(r2b_x(x)+AIX)*board.gw;
  moveY=board.by+(r2b_y(y)+AIY)*board.gh;
}

return true;
