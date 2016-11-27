/* dropperAI(priority) - Determines the ranks of all possible moves for
                         this piece given the rules of Dropper moves.
*/
var moves,prio,prios,mine,his,patch,marker,ptemp, val, myprios;
prio=-10000;
AIX=0;
AIY=0;
prios=argument0;

moves=ds_list_create();
myprios=ds_priority_create();

/* If we have room to move 1-up-left... */
if (r2b_x(x)>0 && r2b_y(y)>0) {

  /* Find what's 1 space up-left */
  his=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)-1), enemy);
  mine=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)-1), me);
  patch=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)-1), mypatch);
  
  /* If 1-up-left is valid... */
  if (!canGo(r2b_x(x)-1, r2b_y(y)-1,1)) { }
  
  /* If there are no enemies to destroy here and no safety patch, it's a 10-point move */
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<10) { prio=10; AIX=-1; AIY=-1; }
  }
  
  /* Otherwise award points for what we can destroy */
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=-1; }
  }
  
  /* Or give 14 points for landing on a safety-patch */
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=-1; }
  }
  
  /* Just in case all else fails, default to crappy 5-points */
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=-1; }
  }
}
ds_priority_add(myprios, "-1|-1", prio);
prio=-10000;

/* Rinse and repeat for 1-up-right */
if (r2b_x(x)<board.w-1 && r2b_y(y)>0) {
  his=instance_place(b2r_x(r2b_x(x)+1), r2b_y(b2r_y(y)-1), enemy);
  mine=instance_place(b2r_x(r2b_x(x)+1), r2b_y(b2r_y(y)-1), me);
  patch=instance_place(b2r_x(r2b_x(x)+1), r2b_y(b2r_y(y)-1), mypatch);
  
  if (!canGo(r2b_x(x)+1, r2b_y(y)-1,1)) {}
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<10) { prio=10; AIX=+1; AIY=-1; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=-1; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=-1; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=-1; }
  }
}
ds_priority_add(myprios, "1|-1", prio);
prio=-10000;

/* Rinse and repeat for 2-up-left */
if (r2b_y(y)>1 && r2b_x(x)>1) {
  his=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)-2), enemy);
  mine=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)-2), me);
  patch=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)-2), mypatch);
  
  if (!canGo(r2b_x(x)-2, r2b_y(y)-2,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=-2; AIY=-2; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=-2; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=-2; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=-2; }
  }
}
ds_priority_add(myprios, "-2|-2", prio);
prio=-10000;

/* Rinse and repeat for 2-up-right */
if (r2b_y(y)>1 && r2b_x(x)<board.w-2) {
  his=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)-2), enemy);
  mine=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)-2), me);
  patch=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)-2), mypatch);
  
  if (!canGo(r2b_x(x)+2, r2b_y(y)-2,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=+2; AIY=-2; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=+2; AIY=-2; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=+2; AIY=-2; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=+2; AIY=-2; }
  }
}
ds_priority_add(myprios, "2|-2", prio);
prio=-10000;

/* Rinse and repeat for 1-down-left */
if (r2b_y(y)<board.h-1 && r2b_x(x)>0) {
  his=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)+1), enemy);
  mine=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)+1), me);
  patch=instance_place(b2r_x(r2b_x(x)-1), b2r_y(r2b_y(y)+1), mypatch);
  
  if (!canGo(r2b_x(x)-1, r2b_y(y)+1,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=-1; AIY=1; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=1; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=1; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=1; }
  }
}
ds_priority_add(myprios, "-1|1", prio);
prio=-10000;

/* Rinse and repeat for 1-down-right */
if (r2b_y(y)<board.h-1 && r2b_x(x)<board.w-1) {
  his=instance_place(b2r_x(r2b_x(x)+1), b2r_y(r2b_y(y)+1), enemy);
  mine=instance_place(b2r_x(r2b_x(x)+1), b2r_y(r2b_y(y)+1), me);
  patch=instance_place(b2r_x(r2b_x(x)+1), b2r_y(r2b_y(y)+1), mypatch);
  
  if (!canGo(r2b_x(x)+1, r2b_y(y)+1,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=1; AIY=1; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=1; AIY=1; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=1; AIY=1; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=1; AIY=1; }
  }
}
ds_priority_add(myprios, "1|1", prio);
prio=-10000;

/* Rinse and repeat for 2-down-left */
if (r2b_y(y)<board.h-2 && r2b_x(x)>1) {
  his=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)+2), enemy);
  mine=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)+2), me);
  patch=instance_place(b2r_x(r2b_x(x)-2), b2r_y(r2b_y(y)+2), mypatch);
  
  if (!canGo(r2b_x(x)-2, r2b_y(y)+2,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=-2; AIY=2; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=2; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=2; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=-2; AIY=2; }
  }
}
ds_priority_add(myprios, "-2|2", prio);
prio=-10000;

/* Rinse and repeat for 2-down-right */
if (r2b_y(y)<board.h-2 && r2b_x(x)<board.w-2) {
  his=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)+2), enemy);
  mine=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)+2), me);
  patch=instance_place(b2r_x(r2b_x(x)+2), b2r_y(r2b_y(y)+2), mypatch);
  
  if (!canGo(r2b_x(x)+2, r2b_y(y)+2,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch)) {
    if (prio<8) { prio=8; AIX=2; AIY=2; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=2; AIY=2; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=2; AIY=2; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=2; AIY=2; }
  }
}
ds_priority_add(myprios, "2|2", prio);
prio=-10000;

/* Find all equally-ranked top moves */
val=ds_priority_find_max(myprios);
prio=ds_priority_find_priority(myprios,val);
ds_list_add(moves, ds_priority_delete_max(myprios));
ds_list_add(moves, prio);


val=ds_priority_find_max(myprios);
prio=ds_priority_find_priority(myprios,val);
while (prio==ds_list_find_value(moves,1) && !ds_priority_empty(myprios)) {
 ds_list_add(moves, ds_priority_delete_max(myprios));
  ds_list_add(moves, prio);

  val=ds_priority_find_max(myprios);
  prio=ds_priority_find_priority(myprios,val); 
}

ds_priority_destroy(myprios);

/* And pick one at random */
choice=irandom(ds_list_size(moves)/2-1)*2;
val=ds_list_find_value(moves, choice);
AIX = real(string_copy(val, 1, string_pos("|", val)-1));
AIY = real(string_delete(val, 1, string_pos("|", val)));
prio=ds_list_find_value(moves, choice+1);

ds_list_destroy(moves);

/* Now that we've found our best move, add us to the priority with its rank */
ds_priority_add(prios, id, prio);
