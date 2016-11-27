/* swapperAI(priority) - Determines the ranks of all possible moves for
                         this piece given the rules of Swapper moves.
*/
var moves,prio,prios,mine,his,patch,marker,ptemp,myprios,val,choice;
prio=-10000;
AIX=0;
AIY=0;
prios=argument0;

moves=ds_list_create();
myprios=ds_priority_create();

/* If you're not all the way on the left of the board... */
if (r2b_x(x)>0) {

  /* Determine what, if anything, is 1 square to the left */
  his=instance_place(b2r_x(r2b_x(x)-1), y, enemy);
  mine=instance_place(b2r_x(r2b_x(x)-1), y, me);
  patch=instance_place(b2r_x(r2b_x(x)-1), y, mypatch);
  marker=instance_place(b2r_x(r2b_x(x)-1), y, Marker);
  
  /* If left is a valid move... */
  if (canGo(r2b_x(x)-1, r2b_y(y), 1)) {
    /* If there's nothing there, rank this as 10 points */
    if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
      if (prio<10) { prio=10; AIX=-1; AIY=0; }
    }
    
    /* If there is an opponent piece there, rank according to which piece you'd destroy */
    else if (instance_exists(his)) {
      switch (getType(his.object_index)) {
        case "Sweeper": ptemp=50; break;
        case "Patcher": ptemp=40; break;
        case "Swapper": ptemp=30; break;
        case "Dropper": ptemp=20; break;
        default: ptemp=-99999; break;
      }
      if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=0; }
    }
    
    /* If there's a marker there... */
    else if (instance_exists(marker)) {
      /* And it's got your color, rank it 18 */
      if (marker.image_index==2 || marker.image_index==myNum) {
        ptemp=18;
      }
      /* But if it's only got the opponent's color, rank it -10. This is a crappy move */
      else { ptemp=-10; }
      if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=0; }
    }
    
    /* IF there's a patch of your color there, rank it 14 (safety) */
    else if (instance_exists(patch)) {
      ptemp=14;
      if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=0; }
    }
    /* Otherwise, this is just a normal blank space, so rank it 5 */
    else {
      ptemp=5;
      if (ptemp>prio) { prio=ptemp; AIX=-1; AIY=0; }
    }
  }
}

ds_priority_add(myprios, "-1|0", prio);
show_debug_message("Swapper move -1|0 has "+string(prio));

prio=-10000;

/* Rinse and repeat for 1 space to the right */
if (r2b_x(x)<board.w-1) {
  his=instance_place(b2r_x(r2b_x(x)+1), y, enemy);
  mine=instance_place(b2r_x(r2b_x(x)+1), y, me);
  patch=instance_place(b2r_x(r2b_x(x)+1), y, mypatch);
  marker=instance_place(b2r_x(r2b_x(x)+1), y, Marker);
  
  if (!canGo(r2b_x(x)+1, r2b_y(y),1)) {}
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=+1; AIY=0; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=0; }
  }
  else if (instance_exists(marker)) {
    if (marker.image_index==2 || marker.image_index==myNum) {
      ptemp=18;
    }
    else { ptemp=-10; }
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=0; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=0; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=+1; AIY=0; }
  }
}
ds_priority_add(myprios, "1|0", prio);
show_debug_message("Swapper move 1|0 has "+string(prio));

prio=-10000;

/* Rinse and repeat for 1 space up */
if (r2b_y(y)>0) {
  his=instance_place(x, b2r_y(r2b_y(y)-1), enemy);
  mine=instance_place(x, b2r_y(r2b_y(y)-1), me);
  patch=instance_place(x, b2r_y(r2b_y(y)-1), mypatch);
  marker=instance_place(x, b2r_y(r2b_y(y)-1), Marker);
  
  if (!canGo(r2b_x(x), r2b_y(y)-1,1)) { }
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=0; AIY=-1; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=-1; }
  }
  else if (instance_exists(marker)) {
    if (marker.image_index==2 || marker.image_index==myNum) {
      ptemp=18;
    }
    else { ptemp=-10; }
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=-1; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=-1; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=-1; }
  }
}
ds_priority_add(myprios, "0|-1", prio);
show_debug_message("Swapper move 0|-1 has "+string(prio));

/* Rinse and repeat for 1 space down */
prio=-10000;
if (r2b_y(y)<board.h-1) {
  his=instance_place(x, b2r_y(r2b_y(y)+1), enemy);
  mine=instance_place(x, b2r_y(r2b_y(y)+1), me);
  patch=instance_place(x, b2r_y(r2b_y(y)+1), mypatch);
  marker=instance_place(x, b2r_y(r2b_y(y)+1), Marker);
  
  if (!canGo(r2b_x(x), r2b_y(y)+1,1)) {}
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<11) { prio=11; AIX=0; AIY=+1; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=+1; }
  }
  else if (instance_exists(marker)) {
    if (marker.image_index==2 || marker.image_index==myNum) {
      ptemp=18;
    }
    else { ptemp=-10; }
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=+1; }
  }
  else if (instance_exists(patch)) {
    ptemp=14;
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=+1; }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=0; AIY=+1; }
  }
}
ds_priority_add(myprios, "0|1", prio);
show_debug_message("Swapper move 0|1 has "+string(prio));

/* Find all equally-ranked top moves */
show_debug_message("Swapper has "+string(ds_priority_size(myprios))+" moves");
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

/* Now that we've discovered the highest-ranked move, add us to the priority
   with that rank */
ds_priority_add(prios, id, prio);
