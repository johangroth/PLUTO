        .include "include/ansi_macros.inc"

scr_clear       #ed2
                .byte 0

clear   .proc
        pha
        lda #<scr_clear
        sta index_low
        lda #>scr_clear
        sta index_high
        jsr prout
        pla
        rts
        .pend
