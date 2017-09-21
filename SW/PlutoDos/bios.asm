        .include "include/bios.inc"
        .include "include/zp.inc"
        .include "include/strings.inc"

;;;
;;  PRINT_SPACE: Send a space character to terminal.
;;
;;       Preparation:
;;
;;   Returned Values: a: entry value
;;                    x: entry value
;;                    y: entry value
;;
;;
;;   Examples:
;;             jsr print_space  ;call subroutine
;;
;;;
print_space:    .proc
            pha
            lda #' '
            jsr chout
            pla
            rts
            .pend

;;;
;;  INPUT_DEC: Request 1-8 ASCII decimal numbers and convert to binary.
;;
;;       Preparation:
;;                    x: number of decimal characters to read. Max 8.
;;
;;   Returned Values: a: used
;;                    x: number of characters read
;;                    y: used
;;
;;
;;   Examples:
;;             ldx #2         ;read two characters, ie one byte
;;             jsr input_dec  ;call subroutine
;;
;;;
input_dec: .proc
        smb 0,control_flags
        rmb 1,control_flags
        lda #>input_buffer
        ldy #<input_buffer
        jsr read_line
        beq exit
        jsr decimal_input_buffer_to_binary
exit:
        rts
        .pend

;;;
;;  DECIMAL_INPUT_BUFFER_TO_BINARY: Convert decimal ASCII numbers in input_buffer to binary.
;;
;;       Preparation:
;;                    x: number of characters in input_buffer..
;;
;;   Returned Values: a: entry value
;;                    x: entry value
;;                    y: entry value
;;        number_buffer: binary numbers
;;
;;   Examples:
;;             ldx #2                                   ;convert two characters, ie one byte
;;             jsr decimal_input_buffer_to_binary       ;call subroutine
;;
;;;
decimal_input_buffer_to_binary: .proc

        .pend

;;;
;;  INPUT_HEX: Request 1-8 ASCII hex numbers and convert to binary.
;;
;;       Preparation:
;;                    x: number of hex characters to read. Max 8.
;;
;;   Returned Values: a: used
;;                    x: number of characters read
;;                    y: used
;;
;;
;;   Examples:
;;             ldx #2         ;read two characters, ie one byte
;;             jsr input_hex  ;call subroutine
;;
;;;
input_hex:  .proc
        rmb 0,control_flags         ;Set flags
        rmb 1,control_flags         ;for hex input
        lda #>input_buffer
        ldy #<input_buffer
        jsr read_line               ;x will contain number of characters read
        beq exit                    ;Branch if buffer is empty
        jsr input_buffer_to_binary  ;ASCII hex in input_buffer -> binary in number_buffer
exit:
        rts
        .pend

;;;
;;  INPUT_BUFFER_TO_BINARY: Convert ASCII numbers in input_buffer to binary.
;;
;;       Preparation:
;;                    x: number of characters in input_buffer.
;;
;;   Returned Values: a: entry value
;;                    x: entry value
;;                    y: entry value
;;        number_buffer: binary numbers
;;
;;   Examples:
;;             ldx #2                       ;convert two characters, ie one byte
;;             jsr input_buffer_to_binary   ;call subroutine
;;
;;;
input_buffer_to_binary: .proc
        pha                                 ;Preserve A
        phx                                 ;Preserve X
        phy                                 ;Preserve Y
        txa                                 ;Temporary store number of characters in buffer in A
        ldx #3                              ;Zero number_buffer
l1:
        stz number_buffer,x
        dex
        bne l1
        rmb 2,control_flags                 ;Reset flag whether we are converting low or high nybble
        tax                                 ;Transfer number of characters to X
        ldy #0                              ;Set index to number buffer in Y
more:
        lda input_buffer-1,x                ;Get character
        jsr ascii_to_binary                 ;Convert it to binary
        bbr 2,control_flags,low_nybble      ;Branch if we're dealing with low nybble
high_nybble:
        asl                                 ;Move number to high nyble.
        asl
        asl
        asl
        ora number_buffer,y                 ;OR in high nybble into low nybble
        sta number_buffer,y
        iny                                 ;Increase the index in the number_buffer
        rmb 2,control_flags                 ;Reset flag to convert low nybble
        bra done
low_nybble:
        smb 2,control_flags                 ;Set flag to convert high nybble
        sta number_buffer,y                 ;Store binary number in buffer
done:
        dex                                 ;decrease the index to the input buffer
        bne more
        ply
        plx
        pla
        rts
        .pend
ascii_to_binary: .proc
        sec
        sbc #'0'
        cmp #$a
        bcc exit
        sbc #$7
exit:
        rts
        .pend
;;;
;;  DISPLAY_HEX: Sends to terminal 4 binary numbers converted to ASCII hex, supressing any leading zeroes.
;;       The byte sequence 12 34 00 00 will display as 3412
;;       Preparation: number_buffer contains binary numbers (in little endian) to be displayed in hex.
;;
;;   Returned Values: a: entry value
;;                    x: entry value
;;                    y: entry value
;;
;;
;;   Examples:
;;             jsr display_hex  ;call subroutine
;;
;;;
display_hex: .proc
        pha                     ;Preserve a
        phx                     ;Preserve x
        rmb 0,control_flags     ;Flag for leading zeroes in number_buffer
        ldx #3                  ;Initialise index in number_buffer
next_number:
        lda number_buffer,x     ;Get first number
        pha                     ;Remember original number
        lsr                     ;Move high nybble to low nybble
        lsr
        lsr
        lsr
        jsr binary_to_hex_ascii ;Convert and send ASCII equivalent of digit to terminal
        pla                     ;Restore original number
        and #$f                 ;Get rid of high nybble
        jsr binary_to_hex_ascii ;Convert and send ASCII equivalent of digit to terminal
        dex                     ;Decrement index
        bpl next_number         ;Branch if not negative
        plx                     ;Restore x
        pla                     ;Restore a
        rts
        .pend

;;;
;;  BINARY_TO_HEX_ASCII: Converts a binary number $0-$f to its ASCII equivalent and sends it to the terminal
;;                provided it is not a leading zero.
;;
;;       Preparation: A contains number to be converted
;;
;;   Returned Values: a: used
;;                    x: entry value
;;                    y: entry value
;;
;;
;;   Examples:
;;              lda #$0a
;;              jsr hex_to_ascii  ;convert and send ASCII character to terminal
;;
;;;
binary_to_hex_ascii: .proc
        phy                             ;Preserve y
        bbs 0, control_flags, convert   ;Branch if bit 0 in leading_zero is set, ie no more leading zeroes.
        beq exit                        ;Branch if leading_zero is clear and A is zero to supress any output
        smb 0, control_flags            ;end of leading zeroes
convert:
        tay                             ;Preserve original number
        clc
        adc #$30                        ;Binary 0-9 to ASCII 0-9
        cpy #$0a                        ;If number < $0a ...
        bcc done                        ;branch
        clc
        adc #$07                        ;Add $7 so $a - $f becomes ASCII A-F
done:
        jsr chout                       ;Send to terminal
exit:
        ply                             ;Restore y
        rts
        .pend

;;;
;; READ_LINE subroutine: Read characters from terminal until CR is found or maximum characters have been read.
;;                       Derived work from "6502 ASSEMBLY LANGUAGE SUBROUTINES", ISBN: 0-931988-59-4
;;                       READ_LINE recognises BS and CR and CTRL-X.
;;                       BS - deletes the previous character
;;                       CTRL-X - deletes all characters
;;                       CR - subroutine done
;;      Preparation:
;;              a - high byte of input address
;;              y - low byte of input address
;;              x - maximum length of input line
;;
;;      Effect on registers:
;;              a - used
;;              x - will hold number of characters entered at exit
;;              y - used
;;
;;      Example: Read four hex characters from terminal and place them in in_buffer.
;;              rmb 0,control_flags
;;              rmb 1,control_flags
;;              lda #>in_buffer
;;              ldy #<in_buffer
;;              ldx #4
;;              jsr read_line
;;;
read_line:  .proc
        sta buffer_address_high     ;Save high byte of input buffer address
        sty buffer_address_low      ;Save low byte of input buffer address
        stx buffer_length           ;Save maximum length
init:
        stz buffer_index            ;Initialise buffer index to zero
read_loop:
        jsr read_character          ;Read character from terminal (no echo)
        cmp #a_cr                   ;Is character CR
        beq exit_read_line          ;Exit if it is
        cmp #a_bs                   ;Is character BS
        bne l1                      ;No, branch
        jsr backspace               ;Yes remove character from buffer and send destuctive backspace to terminal
        bra read_loop
l1:
        cmp #a_can                  ;Cancel character(s) received (aka CTRL-X)
        bne l2                      ;If not CTRL-X, branch
l3:
        jsr backspace               ;Remove character from buffer and send BS to terminal
        lda buffer_index            ;Is buffer empty
        bne l3                      ;No, continue deleting
        bra read_loop               ;Read next character
        ; Not a special character
        ; Check if buffer full
        ; If not store character and echo
l2:
        bbs 1,control_flags,check_buffer    ;Bit 1 is set which means any character is allowed, so try to store it
        bbs 0,control_flags,decimal_input   ;Bit 0 is set which means decimal input
        ; Hexdecimal input
        cmp #'A'
        bcc decimal_input           ;Branch if character is < 'A' (check 0-9)
        cmp #'F'+1
        bcc check_buffer            ;Branch if character is < 'F'+1
decimal_input:
        cmp #'0'
        bcc ring_bell               ;Branch if character is < '0'
        cmp #'9'+1
        bcs ring_bell               ;Branch if character is >= '9'+1
check_buffer:
        ldy buffer_index            ;Is buffer
        cpy buffer_length           ;full
        bcc store_character         ;Branch if room in buffer
ring_bell:
        jsr bell                    ;Ring the bell, buffer is full
        bra read_loop               ;Continue
store_character:
        sta (buffer_address_low),y  ;Store the character
        jsr chout                   ;Send character to terminal
        inc buffer_index
        bra read_loop               ;Read next character
exit_read_line:
        jsr crout                   ;Send CR/LF to terminal
        ldx buffer_index            ;Exit with X containing amount of characters read
        rts
        .pend

;;;
;; BACKSPACE subroutine: Send BS, SPC, BS to terminal and decrement the readline input buffer index.
;;      NOTE: This subroutine should only be used by read_line as the buffer is private
;;            to read_line.
;;
;;          BS - deletes the previous character
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr dec_index
;;;
backspace: .proc
        pha
        lda buffer_index            ;Check for empty buffer
        beq sound_bell              ;If no characters in buffer, branch
        dec buffer_index            ;Decrement the buffer index
        lda #<destructive_backspace ;Get low byte of BS string
        sta index_low               ;Store it in index_low
        lda #>destructive_backspace ;Get high byte of BS string
        sta index_high              ;Store it in index_high
        jsr prout                   ;Send string to terminal
        bra exit
sound_bell:
        jsr bell
exit:
        pla
        rts
        .pend

;;;
;; READ_CHARACTER subroutine: Read a character from terminal and convert it to uppercase.
;;
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - character in uppercase
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr read_character
;;;
read_character: .proc
        jsr chin
        and #extended_ascii_mask        ;Remove all ASCII codes over $7f
        cmp #'a'                        ;Is character less 'a'
        bcc exit                        ;branch if yes, ie number, symbol, uppercase or control character
        sbc #$20                        ;Otherwise substract $20 to convert character to uppercase
exit:
        rts
        .pend


;;;
;; DEC_INDEX subroutine: Decrement 16 bit variable index_low, index_high
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - destroyed
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr dec_index
;;;
dec_index:  .proc
        dec index_low       ;Decrement low
        lda index_low       ;Check if decrement
        cmp #$ff            ;wrapped around from $00 to $ff
        bne done            ;if not, branch
        dec index_high      ;  yes, decrement high
done:
        rts
        .pend

;;;
;; INC_INDEX subroutine: Increment 16 bit variable index_low, index_high.
;;      Preparation:
;;              none
;;
;;      Effect on registers:
;;              a - entry value
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;              jsr inc_index
;;;
inc_index:  .proc
        inc index_low       ;Increment low
        bne done            ;if no wrap-around from $ff to $00 take branch
        inc index_high      ;  yes, wrap-around so increment high
done:
        rts
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
;;              a - used
;;              x - entry value
;;              y - entry value
;;
;;      Example:
;;             jsr bell
;;;
bell:   .proc
        lda #a_bel
        bra chout
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

;;;
;; Initialise termnial
;;;
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

        ;test code
        ldx #3
        jsr input_hex
        jsr crout
        jsr display_hex
        jsr cr2
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

        * = $ff00
jmp_table:
        jmp input_hex
        jmp read_line
        jmp chout
        jmp chin
        jmp crout
        jmp cr2
        jmp prout
        jmp bell

        * = $fffa
        .word   nmi         ;NMI
        .word   coldstart   ;RESET
        .word   irq         ;IRQ
