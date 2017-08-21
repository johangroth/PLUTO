        .include "include/bios.inc"
        .include "include/zp.inc"
        .include "include/strings.inc"


bin2asc:    .proc

        .pend

;;;
;; DOLLAR subroutine: Send dollar sign to terminal.
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr crout
;;;
dollar: .proc
        pha
        lda #'$'
        bra crout.sendit
        .pend

;;;
;; CR2 subroutine: Send CR/LF twice to terminal.
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr cr2
;;;
cr2:    .proc
        jsr crout
        .pend

;;;
;; CROUT subroutine: Send CR/LF to terminal.
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr crout
;;;
crout:   .proc
        pha
        lda #a_cr
        jsr chout
        lda #a_lf
sendit:
        jsr chout
        pla
        rts
        .pend

;;;
;; BELL subroutine: Send a bell sound to terminal.
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - destroyed
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;             jsr bell
;;;
bell:   .proc
        lda #a_bel
        jmp chout
        .pend

;;;
;; PROUT subroutine: Send a zero terminated string to terminal.
;;      Preparation:
;;              index_low  low byte address to string
;;              index_high high byte address to string
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;          text    .null "hello world"
;;                  lda #<text
;;                  sta index_low
;;                  lda #>text
;;                  sta index_high
;;                  jsr prout
;;;
prout:   .proc
        pha                         ;Preserve A
        phy                         ;Preserve Y
        ldy #0                      ;Initialise index
l1:
        lda (index_low),y           ;Get character
        beq exit                    ;If eq zero, branch
        jsr chout                   ;Send character to termnial
        iny                         ;Next character
        bra l1                      ;Loop back
exit:
        ply                         ;Restore Y
        pla                         ;Restore A
        rts
        .pend

;;; CHIN subroutine: Wait for a character in input buffer, return character in A register.
;;; receive is interrupt driven and buffered with a size of 128 bytes.
chin:    .proc
        lda in_buffer_counter       ; Get number of characters in buffer
        beq chin                    ; If zero wait for characters
        phy                         ; Preserve Y register
        php                         ; Preserve MPU state
        ldy in_buffer_head          ; Get in buffer head pointer
        lda in_buffer,y             ; Get the character from the in buffer
        iny                         ; Increment the buffer index
        bpl l1                      ; Branch if not wrap-around ($80)
        ldy #0                      ; Reset the buffer index
l1:
        sty in_buffer_head          ; Update the pointer
        dec in_buffer_counter       ; Decrement the character counter
        plp                         ; Restore MPU state
        ply                         ; Restore Y register
        rts
        .pend

;;; CHOUT subroutine: Place register A in output buffer, register A is preserved.
;;; transmit is interrupt driven and buffered with a size of 128 bytes
chout:   .proc
        phy                         ; Preserve Y register
out_buffer_full:
        ldy out_buffer_counter      ; Get number of characters in buffer
        bmi out_buffer_full         ; Loop back if buffer is full (ACIA ISR will empty buffer)
        php                         ; Preserve MPU state
        ldy out_buffer_tail         ; Get buffer tail pointer
        sta out_buffer,y            ; and store it in buffer
        iny                         ; Increment the buffer index
        bpl l1                      ; Branch if not wrap-around ($80)
        ldy #0                      ; Reset the buffer index
l1:
        sty out_buffer_tail         ; Update the pointer
        inc out_buffer_counter      ; Increment the counter
        plp                         ; Restore MPU state
        ply                         ; Restore Y register
        rts
        .pend

nmi:
        rti

;;;
;; coldstart - initialises all hardware
;; power up and reset procedure.
;;;
coldstart: .block
        sei                     ;Turn off interrupts
        cld                     ;Make sure MPU is in binary mode
        ldx  #0
l1:
        stz  0,x                ;zero ZP
        dex
        bne  l1
        dex                     ;effectively ldx #$ff
        txs
        ldx  #n_soft_vectors    ;Initialise IRQ ISR soft vector table
l2:
        lda initial_soft_vectors-1,x
        sta soft_vector_table-1,x
        dex
        bne l2
        jsr acia_init
        jsr via_init
        jsr rtc_init
        jsr sound_init
        cli

        jsr bell
        lda #<clear_screen
        sta index_low
        lda #>clear_screen
        sta index_high
        jsr prout
        lda #<welcome
        sta index_low
        lda #>welcome
        sta index_high
        jsr prout
again:
        jsr chin
        cmp #$0d
        bne notcr
        jsr chout
        lda #$0a
notcr:
        jsr chout
        bra again
        ; jmp monitor_init
        .bend



irq:
        .block
        pha
        phx
        phy
        tsx                     ;Get the stack pointer
        lda stack_page+4,x      ;MPU status register
        and #brk_irq_mask       ;Has brk instruction triggered IRQ
        bne do_break            ;Yes, branch
        jmp (rtc_soft_vector)   ;  no, jump to rtc ISR routine
do_break:
        jmp (brk_soft_vector)   ;Handle brk instruction
        .bend

irq_end: .block
        ply
        plx
        pla
        rti
        .bend

brk_irq: .block
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

rtc_irq: .block
        jmp (acia_soft_vector)          ;Jump to next ISR
        .bend

via1_irq: .block
        jmp (via2_soft_vector)          ;Jump to next ISR
        .bend

via2_irq:  .block
        jmp irq_end                     ;Jump to the end of ISR
        .bend

        * = $fffa
        .word   nmi         ;NMI
        .word   coldstart   ;RESET
        .word   irq         ;IRQ
