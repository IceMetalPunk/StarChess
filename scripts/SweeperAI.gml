var moves,prio,prios,mine,his,patch,marker,ptemp, p, val, myprios;
prio=-10000;
AIX=0;
AIY=0;

moves=ds_list_create();
myprios=ds_priority_create();

/* Check right */
for (p=r2b_x(x)+1; p<board.w; p+=1) {
  his=instance_place(b2r_x(p), y, enemy);
  mine=instance_place(b2r_x(p), y, me);
  patch=instance_place(b2r_x(p), y, mypatch);
  marker=instance_place(b2r_x(p), y, Marker);
  
  if (!canGo(p, r2b_y(y), 1)) { break; }
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=p-r2b_x(x); AIY=0; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }
  }
  else if (instance_exists(marker)) {
    /* And it's got the opponent's color color, rank it 18 */
    if (marker.image_index==2 || marker.image_index==!myNum) {
      ptemp=18;
    }
    /* But if it's only got your color, rank it a basic 5. This is a crappy move */
    else { ptemp=5; }
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }
  }
  ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
  prio=-10000;
}

/* Check left */
for (p=r2b_x(x)-1; p>=0; p-=1) {
  his=instance_place(b2r_x(p), y, enemy);
  mine=instance_place(b2r_x(p), y, me);
  patch=instance_place(b2r_x(p), y, mypatch);
  marker=instance_place(b2r_x(p), y, Marker);
  
  if (!canGo(p, r2b_y(y), 1)) { break; }
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=p-r2b_x(x); AIY=0; }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }
  }
  else if (instance_exists(marker)) {
    /* And it's got the opponent's color color, rank it 18 */
    if (marker.image_index==2 || marker.image_index==!myNum) {
      ptemp=18;
    }
    /* But if it's only got your color, rank it a basic 5. This is a crappy move */
    else { ptemp=5; }
    if (ptemp>prio) { prio=ptemp; AIX=p-r2b_x(x); AIY=0; }
  }
  ds_priority_add(myprios, string(p-r2b_x(x))+"|0", prio);
  prio=-10000;
}

/* Check up */
for (p=r2b_y(y)-1; p>=0; p-=1) {
  his=instance_place(x, b2r_y(p), enemy);
  mine=instance_place(x, b2r_y(p), me);
  patch=instance_place(x, b2r_y(p), mypatch);
  marker=instance_place(x, b2r_y(p), Marker);
  
  if (!canGo(r2b_x(x), p, 1)) { break; }
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=0; AIY=p-r2b_y(y); }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIY=p-r2b_y(y); AIX=0; }
  }
  else if (instance_exists(marker)) {
    /* And it's got the opponent's color color, rank it 18 */
    if (marker.image_index==2 || marker.image_index==!myNum) {
      ptemp=18;
    }
    /* But if it's only got your color, rank it a basic 5. This is a crappy move */
    else { ptemp=5; }
    if (ptemp>prio) { prio=ptemp; AIY=p-r2b_y(y); AIX=0; }
  }
  ds_priority_add(myprios, "0|"+string(p-r2b_y(y)), prio);
  prio=-10000;
}

/* Check down */
for (p=r2b_y(y)+1; p<board.h; p+=1) {
  his=instance_place(x, b2r_y(p), enemy);
  mine=instance_place(x, b2r_y(p), me);
  patch=instance_place(x, b2r_y(p), mypatch);
  marker=instance_place(x, b2r_y(p), Marker);
  
  if (!canGo(r2b_x(x), p, 1)) { break; }
  else if (!instance_exists(his) && !instance_exists(patch) && !instance_exists(marker)) {
    if (prio<10) { prio=10; AIX=0; AIY=p-r2b_y(y); }
  }
  else if (instance_exists(his)) {
    switch (getType(his.object_index)) {
      case "Sweeper": ptemp=50; break;
      case "Patcher": ptemp=40; break;
      case "Swapper": ptemp=30; break;
      case "Dropper": ptemp=20; break;
      default: ptemp=-99999; break;
    }
    if (ptemp>prio) { prio=ptemp; AIY=p-r2b_y(y); AIX=0; }
  }
  else if (instance_exists(marker)) {
    /* And it's got the opponent's color color, rank it 18 */
    if (marker.image_index==2 || marker.image_index==!myNum) {
      ptemp=18;
    }
    /* But if it's only got your color, rank it a basic 5. This is a crappy move */
    else { ptemp=5; }
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
