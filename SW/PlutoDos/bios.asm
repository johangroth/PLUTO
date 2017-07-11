
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
        ply
        plx
        pla
        sta accumulator
        stx x_register
        sty y_register
        pla                     ;Get MPU status register
        sta mpu_status_register
        tsx
        stx stack_pointer
        plx                     ;Pull low byte of return address
        stx program_counter_low
        stx index_low           ;For disassemble line
        plx
        stx program_counter_high
        stx index_high          ;For disassemble line
;
; The following 3 subroutines are contained in the base Monitor and S/O/S code
;	- if replaced with new code, either replace or remove these routines
;
		;jsr	decindex      ;decrement index to show brk flag byte in register display
		;jsr	prstat1	      ;display contents of all preset/result memory locations
		;jsr	disline       ;disassemble then display instruction at address pointed to by index

        lda #0      ;clear all processor status flags
        pha
        plp
        stz in_buffer_counter
        stz in_buffer_tail
        stz in_buffer_head

        jmp (monitor_soft_vector)
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
