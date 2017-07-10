        .include "include/via.inc"

via_init .proc
        ldx  #n_via1_registers
next
        lda via1_init_table,x
        sta via1base,x
        lda via2_init_table,x
        sta via2base,x
        dex
        bpl  next
        rts
        .pend
