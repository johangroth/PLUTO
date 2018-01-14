        .include "ansi_macros.inc"
;;;
;; Welcome message
;;;
welcome:
        #cup "1", "1"
        .text "--- PLUTO SINGLE BOARD COMPUTER ---"
        #cup "1", "2"
        .text "Designed by Johan Groth"
        #cup "1", "4"
        .text "RAM               32KiB Static"
        #cup "1", "5"
        .text "ROM               32KiB EEPROM"
        #cup "1", "6"
        .text "Main Processor    WDC W65C02S-14 (ticking at 4MHz)"
        #cup "1", "7"
        .text "Serial port       19200 baud, 8-N-1"
        #cup "1", "8"
        .text "Hardware Version  "
        .text "1.0"
        .text " (13/06/2017)"
        #cup "0","36" ;Move cursor to last line as supported by Geoff Graham's VT100 terminal 
        .byte 0

clear_screen:
        #ed2
        .byte 0

destructive_backspace:
        .null a_bs, " ", a_bs

prompt_text:
        .null "M-"

;;;
;; Help text for all the monitor commands.
;;;
help_text:
        .null "D Dump memory"
