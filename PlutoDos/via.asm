        .include "include/via.inc"

via_init: .proc
        jsr  via1_init
        jmp  via2_init
        .pend

via1_init: .proc
        ldx  #n_via1_registers
next:
        lda via1_init_table,x
        sta via1base,x
        dex
        bpl  next
        rts
        .pend

via2_init: .proc
        ldx  #n_via2_registers
next:
        lda via2_init_table,x
        sta via2base,x
        dex
        bpl next
        rts
        .pend

;;; DELAY subroutine: medium delay loop, duration is 16bit number in via2t2cl and via2t2ch / clock rate
;; e.g. delay_low = 100 and PHI2 clock is 4MHz will make the delay to be 100 / 4 = 25 µs.
delay:  .proc
        stz via1acr       ;select mode
        lda delay_high
        sta via1t2ch

        lda delay_low     ;delay duration
        sta via1t2cl      ;low part=01hex.  start
        lda #via_timer2_irq_mask    ;mask
loop:
        bit via1ifr       ;time out?
        beq loop
        lda via1t2cl      ;clear timer 2 interrupt
        rts
        .pend
