var moves,prio,prios,mine,his,patch,marker,ptemp, p, val, myprios;
prio=-10000;
AIX=0;
AIY=0;

moves=ds_list_create();
myprios=ds_priority_create();

/* Check right */
for (p=r2b_x(x)+1; p<=r2b_x(x)+3 && p<board.w; p+=1) {
  if (!canGo(p, r2b_y(y), 1)) { break; }
  else if (isHole(p, r2b_y(y)) && !place_meeting(b2r_x(p), y, patch_obj)) {
    ptemp=30;
    if (ptemp>prio) {
      prio=ptemp;
      AIX=p-r2b_x(x);
      AIY=0;
      ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
      prio=-10000;
      break;
    }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }    
  }
  ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
  prio=-10000;
}

/* Check left */
for (p=r2b_x(x)-1; p>=r2b_x(x)-3 && p>=0; p-=1) {
  if (!canGo(p, r2b_y(y), 1)) { break; }
  else if (isHole(p, r2b_y(y)) && !place_meeting(b2r_x(p), y, patch_obj)) {
    ptemp=30;
    if (ptemp>prio) {
      prio=ptemp;
      AIX=p-r2b_x(x);
      AIY=0;
      ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
      prio=-10000;
      break;
    }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }    
  }
  ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
  prio=-10000;
}

/* Check up */
for (p=r2b_y(y)-1; p>=r2b_y(y)-3 && p>=0; p-=1) {
  if (!canGo(r2b_x(x), p, 1)) { break; }
  else if (isHole(r2b_x(x), p) && !place_meeting(x, b2r_y(p), patch_obj)) {
    ptemp=30;
    if (ptemp>prio) {
      prio=ptemp;
      AIY=p-r2b_y(y);
      AIX=0;
      ds_priority_add(myprios, "0|"+string(p-r2b_y(y)), prio);
      prio=-10000;
      break;
    }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIY=p-r2b_y(y); AIX=0; }    
  }
  ds_priority_add(myprios, "0|"+string(p-r2b_y(y)), prio);
  prio=-10000;
}

/* Check down */
for (p=r2b_y(y)+1; p<=r2b_y(y)+3 && p<board.h; p+=1) {
  if (!canGo(r2b_x(x), p, 1)) {  break;  }
  else if (isHole(r2b_x(x), p) && !place_meeting(x, b2r_y(p), patch_obj)) {
    ptemp=30;
    if (ptemp>prio) {
      prio=ptemp;
      AIY=p-r2b_y(y);
      AIX=0;
      ds_priority_add(myprios, "0|"+string(p-r2b_y(y)), prio);
      prio=-10000;
      break;
    }
  }
  else {
    ptemp=5;
    if (ptemp>prio) { prio=ptemp; AIY=p-r2b_y(y); AIX=0; }    
  }
  ds_priority_add(myprios, "0|"+string(p-r2b_y(y)), prio);
  prio=-10000;
}

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

ds_priority_add(argument0, id, prio);
