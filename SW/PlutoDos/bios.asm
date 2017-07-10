
        .include "include/bios_include.inc"

coldstart .block
        sei
        ldx  #n_soft_vectors    ;Initialise IRQ ISR soft vector table
l1
        lda initial_soft_vectors-1,x
        sta soft_vector_table-1,x
        dex
        bne l1
        dex         ; ldx  #$ff :)
        txs         ; Initialise stack pointer
        cli         ; Turn on IRQ
        .bend

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
        jmp (rtc_soft_vector)           ;  no, jump to rtc ISR routine
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
        .include "acia_isr.asm"
        jmp (via1_soft_vector)
        .bend

via1_irq .block
        jmp (via2_soft_vector)
        .bend

via2_irq  .block
        jmp irq_end
        .bend

        * = $FFFA
        .word   nmi         ;NMI soft vector
        .word   coldstart   ;RESET
        .word   irq         ;IRQ soft vector
