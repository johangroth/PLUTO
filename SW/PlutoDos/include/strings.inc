        .include "ansi_macros.inc"
;;;
;; Welcome message
;;;
welcome:
        #cup "2", "2"
        .text "--- PLUTO SINGLE BOARD COMPUTER ---"
        #cup "3", "3"
        .text "Designed by Johan Groth"
        #cup "9", "4"
        .text "32KiB Static RAM"
        #cup "9", "5"
        .text "32KiB EEPROM"
        #cup "4", "6"
        .text "  Main Processor: WDC W65C02S-14 (ticking at 4MHz)"
        #cup "4", "7"
        .text "Hardware Version: "
        .text "1.0"
        .text " (13/06/2017)"
        #cup "0","36"
        .text "$ "
        .byte 0

clear_screen:
        #ed2
        .byte 0

destructive_backspace:
        .null a_bs, " ", a_bs
