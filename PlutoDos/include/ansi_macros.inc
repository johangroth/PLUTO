;;;
;; 
;; STANDARD ANSI VT100 DEFINITIONS
;; 
;;;

        .include "ascii.inc"

ansi_cs         .macro
                .text a_esc, "["
                .endm

decawm          .macro
		        #ansi_cs
		        .text "?7h"	; auto-wrap mode on (default)
                .endm

decawmo         .macro
        		#ansi_cs
        		.text "?7l"	; auto-wrap mode off
                .endm

declrg          .macro
                #ansi_cs
                .text "?9l"     ;Set 36 lines per screen
                .endm

decsml          .macro
                #ansi_cs        ;Set 24 lines per screen (default)
                .text "?9h"
                .endm

sgr0            .macro
		        #ansi_cs
		        .text "m"	;turn off character attributes
                .endm

sgr0m           .macro
		        #ansi_cs
		        .text "0m"	;turn off character attributes
                .endm

sgr3            .macro
                #ansi_cs
                .text "3m"      ;select font 2 (large characters)
                .endm

sgr4            .macro
		        #ansi_cs
                .text "4m"	;turn underline mode on
                .endm

sgr6            .macro
                #ansi_cs
                .text "6m"	;select font 2 (jumbo characters)
                .endm

sgr7            .macro
		        #ansi_cs
                .text "7m"	;turn reverse video on
                .endm

sgr8            .macro
		        #ansi_cs
                .text "8m"	;turn invisible text mode on
                .endm

cuu             .macro
                #ansi_cs
                .text \1, "A"   ; move cursor up n lines
                .endm

cud             .macro
                #ansi_cs
                .text \1, "B"	; move cursor down n lines
                .endm

cuf             .macro
                #ansi_cs
                .text \1, "C"	;move cursor right n lines
                .endm

cub             .macro
                #ansi_cs
                .text \1, "D"	;move cursor left n lines
                .endm

cursorhome      .macro
		        #ansi_cs
                .text "H"	;move cursor to upper left corner
                .endm

cursorhome1     .macro
                #ansi_cs
                .text ";H"	;move cursor to upper left corner
                .endm

cup             .macro
                #ansi_cs
                .text \2, ";", \1, "H"	;move cursor to screen location x,y
                .endm

hvhome          .macro
                #ansi_cs
                .text "f"	;move cursor to upper left corner
                .endm

hvhome1          .macro
                 #ansi_cs
                 .text ";f"	;move cursor to upper left corner
                .endm

cup1            .macro
                #ansi_cs
                .text \1, ";", \2, "f"	;move cursor to screen location v,h
                .endm

ind             .macro
                .text a_esc, "D"	;move/scroll window up one line
                .endm

ri              .macro
                .text a_esc, "M"	;move/scroll window down one line
                .endm

nel             .macro
                .text a_esc, "E"	;move to next line
                .endm

decsc           .macro
                .text a_esc, "7"	;save cursor position and attributes
                .endm

decscr          .macro
                .text a_esc, "8"	;restore cursor position and attributes
                .endm

el01            .macro
                #ansi_cs
                .text "K"	;clear line from cursor right
                .endm

el02            .macro
                #ansi_cs
                .text "0K"	;clear line from cursor right
                .endm

el1             .macro
                #ansi_cs
                .text "1K"	;clear line from cursor left
                .endm

el2             .macro
                #ansi_cs
                .text "2K"	;clear entire line
                .endm


ed01            .macro
                #ansi_cs
                .text "J"	;clear screen from cursor down
                .endm

ed02            .macro
                #ansi_cs
                .text "0J"	;clear screen from cursor down
                .endm

ed1             .macro
                #ansi_cs
                .text "1J"	;clear screen from cursor up
                .endm

ed2             .macro
                #ansi_cs
                .text "2J"	;clear entire screen
                .endm


dsr             .macro
                .text a_esc, "5n"	;device status report
                                        ;Esc0n	;response: terminal is ok
                                        ;Esc3n	;response: terminal is not ok
                .endm

curpos          .macro
                .text a_esc, "6n"	;get cursor position
                                        ;response is EscLine;ColumnR
                .endm

rstterm         .macro
                .text a_esc, "c"        ; reset terminal to initial state
                .endm

drawline        .macro                  ; draw a line from x1, y1 to x2, y2
                #ansi_cs
                .text "Z1;"
                .text \1                ; x1
                .text ";"
                .text \2                ; y1
                .text ";"
                .text \3                ; x2
                .text ";"
                .text \4                ; y2
                .text "Z"
                .endm

drawbox         .macro                  ; draw a box with upper left corner x1, y2 and lower right corner x2, y2
                #ansi_cs
                .text "Z2;"
                .text \1                ; x1
                .text ";"
                .text \2                ; y1
                .text ";"
                .text \3                ; x2
                .text ";"
                .text \4                ; y2
                .text "Z"
                .endm

drawfbox        .macro                  ;draw a filled box with upper left corner x1, y2 and lower right corner x2, y2
                #ansi_cs
                .text "Z3;"
                .text \1                ; x1
                .text ";"
                .text \2                ; y1
                .text ";"
                .text \3                ; x2
                .text ";"
                .text \4                ; y2
                .text "Z"
                .endm

drawcircle      .macro                  ;Draw a circle x, y, r
                .text "Z4;"
                .text \1                ; x
                .text ";"
                .text \2                ; y
                .text ";"
                .text \3                ; r
                .text "Z"
                .endm

drawfcircle     .macro                  ;Draw a filled circle x, y, r
                .text "Z5;"
                .text \1                ; x
                .text ";"
                .text \2                ; y
                .text ";"
                .text \3                ; r
                .text "Z"
                .endm

up              .macro
                #ansi_cs
                .text "A"
                .endm

down            .macro
                #ansi_cs
                .text "B"
                .endm

left            .macro
                #ansi_cs
                .text "C"
                .endm

right           .macro
                #ansi_cs
                .text "D"
                .endm

home          .macro
                #ansi_cs
                .text "1~"
                .endm

inserts          .macro
                #ansi_cs
                .text "2~"
                .endm

del             .macro
                #ansi_cs
                .text "3~"
                .endm

end             .macro
                #ansi_cs
                .text "4~"
                .endm

pup             .macro
                #ansi_cs
                .text "5~"
                .endm

pdown           .macro
                #ansi_cs
                .text "6~"
                .endm

f1              .macro
                #ansi_cs
                .text "11~"
                .endm

f2              .macro
                #ansi_cs
                .text "12~"
                .endm

f3              .macro
                #ansi_cs
                .text "13~"
                .endm

f4              .macro
                #ansi_cs
                .text "14~"
                .endm

f5              .macro
                #ansi_cs
                .text "15~"
                .endm

f6              .macro
                #ansi_cs
                .text "17~"
                .endm

f7              .macro
                #ansi_cs
                .text "18~"
                .endm

f8              .macro
                #ansi_cs
                .text "19~"
                .endm

f9              .macro
                #ansi_cs
                .text "20~"
                .endm

f10             .macro
                #ansi_cs
                .text "21~"
                .endm

f11             .macro
                #ansi_cs
                .text "23~"
                .endm

f12             .macro
                #ansi_cs
                .text "24~"
                .endm
