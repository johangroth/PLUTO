			*=$400

ESC			.byte 27
Query_Device_Code	.text "[c"
Query_Device_Status	.text "[5n"
Query_Cursor_Position	.text "[6n"

; Cursor Control
;Cursor Home 		<ESC>[{ROW};{COLUMN}H
;Cursor Up		<ESC>[{COUNT}A
;Cursor Down		<ESC>[{COUNT}B
;Cursor Forward		<ESC>[{COUNT}C
;Cursor Backward		<ESC>[{COUNT}D
;Force Cursor Position	<ESC>[{ROW};{COLUMN}f
;Save Cursor		<ESC>[s
;Unsave Cursor		<ESC>[u
;Save Cursor & Attrs	<ESC>7
;Restore Cursor & Attrs	<ESC>8

; Erasing text
;Erase End of Line	<ESC>[K
;Erase Start of Line	<ESC>[1K
;Erase Line		<ESC>[2K
;Erase Down		<ESC>[J
;Erase Up		<ESC>[1J
;Erase Screen		<ESC>[2J


;Set display attributes
;Set Attribute Mode	<ESC>[{attr1};...;{attrn}m

;Sets multiple display attribute settings. The following lists standard attributes:
;0	Reset all attributes
;1	Bright
;2	Dim
;4	Underscore	
;5	Blink
;7	Reverse
;8	Hidden

;	Foreground Colours
;30	Black
;31	Red
;32	Green
;33	Yellow
;34	Blue
;35	Magenta
;36	Cyan
;37	White

;	Background Colours
;40	Black
;41	Red
;42	Green
;43	Yellow
;44	Blue
;45	Magenta
;46	Cyan
;47	White

End_Display_Attributes	.text "[0m"
