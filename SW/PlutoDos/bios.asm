
        .include "include/bios.inc"
        .include "include/zp.inc"

nmi
        nop

;;; coldstart - initialises all hardware
;; power up and reset procedure.
;;;
coldstart .block
        sei                     ;Turn off interrupts
        cld                     ;Make sure MPU is in binary mode
        ldx  #0
l1      stz  0,x                ;zero ZP
        dex
        bne  l1
        ldx  #n_soft_vectors    ;Initialise IRQ ISR soft vector table
l2
        lda initial_soft_vectors-1,x
        sta soft_vector_table-1,x
        dex
        bne l2
        dex                 ;ldx #$ff :)
        txs
        jsr rtc_init
        jsr acia_init
        jsr via_init
        jsr sound_init
        cli
        ; jmp monitor_init
        .bend

irq     .block
        pha
        phx
        phy
        tsx                     ;Get the stack pointer
        lda stack_page+4,x      ;MPU status register
        and #brk_irq_mask       ;Has brk instruction triggered IRQ
        bne do_break            ;Yes, branch
        jmp (rtc_soft_vector)   ;  no, jump to rtc ISR routine
do_break
        jmp (brk_soft_vector)   ;Handle brk instruction
        .bend

irq_end .block
        ply
        plx
        pla
        rti
        .bend

brk_irq .block
        jmp (rtc_soft_vector)
        .bend

rtc_irq .block
        jmp (acia_soft_vector)
        .bend

acia_irq .block
        jmp (via1_soft_vector)
        .bend

via1_irq .block
        jmp (via2_soft_vector)
        .bend

via2_irq  .block
        jmp irq_end
        .bend

        * = $fffa
        .word   nmi         ;NMI
        .word   coldstart   ;RESET
        .word   irq         ;IRQ
