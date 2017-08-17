        .include "include/acia.inc"

;;; Initialise ACIA
acia_init    .proc
        lda  #serial_port_param             ; Initialize serial port (terminal I/O) 6551/65c51 ACIA
        sta  siocon                         ; (19.2K BAUD,no parity,8 data bits,1 stop bit,
        lda  #rec_xmit_irq_enabled          ; receiver and transitter IRQ output enabled)
        sta  siocom
        rts
        .pend
;;; End init ACIA

;;; ACIA ISR
acia_irq .block
        lda siostat             ; Read status register
        bpl exit                ; Check if acia caused interrupt, clear exit else handle IRQ
        bit #acia_receive_mask  ; Check receive bit
        bne receive_char        ; Receive character
        bit #acia_transmit_mask ; Check transmit bit
        bne transmit_char       ; Transmit character
        bra exit                ; IRQ and no receive/transmit bits means /CTS went HIGH so branch
receive_char
        lda siodat              ; Get character from ACIA
        ldy in_buffer_counter   ; Get current number of characters in input buffer
        bmi exit                ; Branch if buffer is full
        ldy in_buffer_tail      ; Get pointer in input buffer
        sta in_buffer,y         ; Store character in input buffer
        iny                     ; Increment tail pointer
        bpl l1                  ; Branch if not wrap-around ($80)
        ldy #0                  ; Reset pointer
l1
        sty in_buffer_tail      ; Update input buffer tail pointer
        inc in_buffer_counter   ; Increment character count

        lda siostat             ; Read status register
        and #acia_transmit_mask ; Check transmit bit
        beq exit                ; Branch if nothing to transmit or still transmitting

transmit_char
        lda out_buffer_counter  ; Get output buffer counter
        beq nodata              ; If nothing to transmit branch
        ldy out_buffer_head     ; Get pointer in output buffer
        lda out_buffer,y        ; Get character to transmit from output buffer
        sta siodat              ; Send character
        iny                     ; Increment head pointer
        bpl l2                  ; Branch if not wrap-around ($80)
        ldy #0                  ; Reset pointer
l2
        sty out_buffer_head     ; Update output buffer head pointer
        dec out_buffer_counter  ; Decrement character count
        bne exit
nodata
        ldy #9
        sty siocom
exit
        jmp (via1_soft_vector)  ; Jump to next ISR
        .bend

;;; End ACIA ISR
