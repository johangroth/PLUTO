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
        bpl  next
        rts
        .pend

;;; DELAY2 subroutine: medium delay loop, duration is 16bit number in via2t2cl and via2t2ch / clock rate
delay2:  .proc
        lda delay_high
        sta via2t2ch


;;; DELAY1 subroutine: short delay loop, duratiion is delay_low in µs divided by clock rate.
;; e.g. delay_low = 100 and PHI2 clock is 4MHz will make the delay to be 100 / 4 = 25 µs.
delay1:
        stz via2acr       ;select mode
        lda delay_low     ;delay duration
        sta via2t2cl      ;low part=01hex.  start
        lda #via_timer2_irq_mask    ;mask
loop:
        bit via2ifr       ;time out?
        beq loop
        lda via2t2cl      ;clear timer 2 interrupt
        rts
        .pend
