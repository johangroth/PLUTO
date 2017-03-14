	
	ESC = $1b
	
Auto_wrap_mode_off                     ESC [?7l
Auto_wrap_mode_on_(default)            ESC [?7h 
Set_36_lines_per_screen                ESC [?9l 
Set_24_lines_per_screen_(default)      ESC [?9h 
 
Set_alternate_keypad_mode              ESC = 
Set_numeric_keypad_mode_(default)      ESC > 
 
Turn_off_all_character_attributes      ESC [m   -or-   ESC [0m 
Turn_underline_mode_on                 ESC [4m 
Turn_reverse_video_on_                 ESC [7m 
Turn_invisible_text_mode_on            ESC [8m 
Select_font_#2_(large_characters)      ESC [3m 
Select_font_#2_(jumbo_characters)      ESC [6m 
 
Move_cursor_up_n_lines                 ESC [<n>A 
Move_cursor_down_n_lines               ESC [<n>B 
Move_cursor_right_n_lines              ESC [<n>C 
Move_cursor_left_n_lines               ESC [<n>D 
Move_cursor_to_upper_left_corner       ESC [H 
Move_cursor_to_upper_left_corner       ESC [;H 
Move_cursor_to_screen_location_v,h     ESC [<v>;<h>H 
Move cursor to upper left corner       ESC [f 
Move cursor to upper left corner       ESC [;f 
Move cursor to screen location v,h     ESC [<v>;<h>f 
Move/scroll window up one line         ESC D 
Move/scroll window down one line       ESC M 
Move to next line                      ESC E 
Save cursor position and attributes    ESC 7 
Restore cursor position and attributes ESC 8 
 
Clear line from cursor right           ESC [K 
Clear line from cursor right           ESC [0K 
Clear line from cursor left            ESC [1K 
Clear entire line                      ESC [2K 
Clear screen from cursor down          ESC [J 
Clear screen from cursor down          ESC [0J 
Clear screen from cursor up            ESC [1J 
Clear entire screen                    ESC [2J 
 
Device status report                   ESC 5n  (response is ESC 0n) 
 
Get cursor position                    ESC 6n 
   Response: cursor is at v,h          ESC <v>;<h>R 
 
Identify what terminal type            ESC [c 
Identify what terminal type (another)  ESC [0c  (response is ESC [?1;0c) 
 
Reset terminal to initial state        ESC c 
 
Turn off all three LEDs                ESC [0q 
Turn on LED Num Lock                   ESC [1q 
Turn on LED Caps Lock                  ESC [2q 
Turn on LED Scroll                     ESC [3q 
 
Draw a line                            ESC [Z1;<x1>;<y1>;<x2>;<y2>Z 
Draw a box                             ESC [Z2;<x1>;<y1>;<x2>;<y2>Z 
Draw a filled box                      ESC [Z3;<x1>;<y1>;<x2>;<y2>Z 
Draw a circle                          ESC [Z4;<x1>;<y1>;<r>Z 
Draw a filled circle                   ESC [Z5;<x1>;<y1>;<r>Z 
 
 
VT52 compatibility mode codes 
 
Enter/exit ANSI mode (VT52)            ESC < 
Enter alternate keypad mode            ESC = 
Exit alternate keypad mode             ESC > 
 
Move cursor up one line                ESC A 
Move cursor down one line              ESC B 
Move cursor right one char             ESC C 
Move cursor left one char              ESC D 
Move cursor to upper left corner       ESC H 
Move cursor to v,h location            ESC <v><h> 
Generate a reverse line-feed           ESC I 
 
Erase to end of current line           ESC K 
Erase to end of screen                 ESC J 
 
Identify what the terminal is          ESC Z 
   Response:                           ESC /Z 

;;; VT100 Special Key Codes
;;; These are sent from the terminal back to the computer when the particular key is
;;; pressed on the PS2 keyboard.  Note that the numeric keypad keys send different
;;; codes in alternate mode.  See escape codes above to change the keypad mode.
 
UP        ESC [A 
DOWN      ESC [B 
LEFT      ESC [D 
RIGHT     ESC [C 
HOME      ESC [1~ 
INSERT    ESC [2~ 
DEL       ESC [3~ 
END       ESC [4~ 
PUP       ESC [5~ 
PDOWN     ESC [6~ 
F1        ESC [11~ 
F2        ESC [12~ 
F3        ESC [13~ 
F4        ESC [14~ 
F5        ESC [15~ 
F6        ESC [17~ 
F7        ESC [18~ 
F8        ESC [19~ 
F9        ESC [20~ 
F10       ESC [21~ 
F11       ESC [23~ 
F12       ESC [24~ 
F3+0x20   ESC [25~ 
 
 
;;; VT52 Special Key Codes
;;; These codes are sent when the terminal is in VT52 mode.  All other keys will
;;; generate the VT100 codes listed above.
 
UP        ESC A 
DOWN      ESC B 
LEFT      ESC D 
RIGHT     ESC C 

