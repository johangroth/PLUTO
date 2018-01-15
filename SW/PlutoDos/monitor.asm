;;;
;; Initialise the monitor.
;;;
monitor_initialiser: .proc
        jsr prompt
        rts
        .pend

;;;
;; Monitor main loop
;;;
monitor_main_loop: .proc
        jsr b_read_char             ;Get char in uppercase from terminal
        ldx #0
l1:
        cmp command_table,x
        beq execute_command
        cmp #$ff                    ;End of table?
        beq command_not_supported
        inx
        bra l1

execute_command:
        jsr b_chout                 ;Echo command
        txa                         ;Transfer index in command table to A
        asl                         ;Muliply with two to find the command pointer
        tax                         ;Transfer a to the index pointer
        jmp (command_pointers,x)    ;execute command (command must do an rts)
        bra monitor_main_loop       ;Wait for next command

command_not_supported:
        jsr b_bell
        bra monitor_main_loop
        .pend

;;;
;; Monitor commands
;;;

;;;
;; [D] Dumps 256 bytes of memory
;;;
dump_memory: .proc
        jsr print_colon_dollar
        ldx #4                      ;Ask for up to 4...
        jsr b_input_hex             ;...characters
        lda number_buffer           ;Address ends up in number_buffer
        sta address_low               ;so store it in index
        lda number_buffer+1
        sta address_high
        jsr print_squiggly_line     ;Print the squiggly line ('~')
        jsr b_crout                 ;next line
        ldx #$10
        jsr print_byte_line         ;print $10 hex numbers starting with $00
        jsr b_crout
        ldx #$10
next_address:
        ldy #$10
        jsr b_hex_address           ;print the address
next_byte:
        lda (address_low)           ;get datum at address
        sta temp1
        jsr b_hex_byte              ;print byte as hex
        jsr b_space                 ;print a space
        jsr inc_address             ;next byte
        dey
        bpl next_byte
        jsr b_crout
        dex
        bne next_address
        jsr print_squiggly_line
        jsr b_crout
        rts
        .pend


;;;
;; Monitor support routines
;;;

;;;
;; Print a row of '~'
;;;
print_squiggly_line: .proc
        pha
        phx
        lda #'~'
        ldx #80
again:
        jsr b_chout
        dex
        bne again
        plx
        pla
        rts
        .pend


;;;
;; Print a colon followed by a dollar
;;      Preparation:
;;              none
;;      Register usage:
;;              a:  entry value
;;              x:  entry value
;;              y:  entry value
;;
;;          Example:
;;              jsr print_colon_dollar
;;
;;          Terminal output
;;                  :$
;;;
print_colon_dollar: .proc
        pha
        lda #':'
        jsr b_chout
        jsr b_dollar
        pla
        rts
        .pend

;;;
;; Print a sequence of bytes starting with 00
;;      Preparation:
;;              x:  number of bytes to write to terminal
;;      Register usage:
;;              a:  entry value
;;              x:  used
;;              y:  entry value
;;
;;          Example:
;;              ldx #$04
;;              jsr print_byte_line
;;
;;          Terminal output
;;                  00 01 02 03
;;;
print_byte_line: .proc
        pha
        txa             ;protect X
        ldx #5          ;six spaces
        jsr b_spacex    ;send to terminal
        tax             ;restore number of bytes to X
        stz temp1
loop:
        jsr b_hex_byte  ;print temp1 as HEX ASCII
        jsr b_space     ;a space char
        inc temp1       ;next number
        dex
        bne loop        ;branch if not done
        pla             ;restore calling value
        rts             ;"return to sender"
        .pend

;;;
;; Print monitor prompt
;;;
prompt: .proc
        jsr b_crout
        lda #<prompt_text
        sta index_low
        lda #>prompt_text
        sta index_high
        jmp b_prout
        .pend

;;;
;; Increment address with one.
;;;
inc_address: .proc
        inc address_low
        bne done
        inc address_high
done:
        rts
        .pend
;;;
;; Table of all commands
;;;
command_table:
        .text "D"
        .byte $ff   ;end of table

;;;
;; Pointers to monitor commands
;;;
command_pointers:
        .word dump_memory
