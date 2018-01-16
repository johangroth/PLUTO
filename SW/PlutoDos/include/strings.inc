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
        #cup "0","34" ;Move cursor to last line -1 that is supported by Geoff Graham's VT100 terminal
        .byte 0

clear_screen:
        #ed2
        .byte 0

destructive_backspace:
        .null a_bs, " ", a_bs

prompt_text:
        .null "M-"

inverted_question_mark:
        #sgr7
        .text '?'
        #sgr0
        .byte 0

crlf:   .macro
        .byte a_cr, a_lf
        .endm

print_text: .macro
        lda #<\1
        sta index_low
        lda #>\1
        sta index_high
        jsr b_prout
        .endm

print_text_rts: .macro
        lda #<\1
        sta index_low
        lda #>\1
        sta index_high
        jmp b_prout
        .endm

;;;
;; Help text for all the monitor commands.
;;;
help_text:
        .text "D Dump memory"
        #crlf
        .text "CTRL-D Download file"
        #crlf
        .text "F Fill memory"
        #crlf
        .text "H This text"
        #crlf
        .byte $00

abort_command_text:
        .null "[ESC] to abort, any other to proceed"

;;;
;;  Fill prompts
;;;
fill_start:
        .null "Fill start: $"
fill_length:
        .null "Len: $"
fill_byte:
        .null "Value: $"
