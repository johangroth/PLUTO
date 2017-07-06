
        .include "include/bios_include.inc"

coldstart
        sei

        ldx  #$ff
        txs
        cli

nmi .block
    .bend
    
irq .block
        pha
        phx
        phy
        tsx                     ;Get the stack pointer
        lda $100+4,x            ;MPU status register
        and #brk_irq_mask       ;Has brk instruction triggered IRQ
        bne do_break            ;Yes, branch
        jmp (irq_soft_vector)   ;  no, jump to soft vector irq routine
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
        jmp (rtc_irq)
        .bend

rtc_irq .block
        jmp (acia_irq)
        .bend

acia_irq .block
        jmp (t1_irq)
        .bend

t1_irq .block
        jmp (t2_irq)
        .bend

t2_irq  .block
        rti
        .bend

        * = $FFFA
        .word   nmi         ;NMI soft vector
        .word   coldstart   ;RESET
        .word   irq         ;IRQ soft vector
