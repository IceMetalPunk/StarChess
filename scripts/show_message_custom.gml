/* show_message_custom(text)

Arguments:
text - The text to show.

*/
// Quick-'n'-dirty patch-in to update for GM:S with no screen_refresh/keyboard_wait methods.
with (instance_create(0,0,Pause_obj)) { text=argument0; }
