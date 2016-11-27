/* getType(instance_ID) - Returns the type of piece:

Dropper, Swapper, Sweeper, Patcher, or Marker */

var obj,type;
obj=object_get_name(argument0);

type=string_copy(obj,string_length(obj)-6,7);
if (type=="Dropper" || type=="Sweeper" || type=="Swapper" || type=="Patcher") { return type; }

type=string_copy(obj,string_length(obj)-5,6);
if (type=="Marker") { return type; }

return "Unknown";
