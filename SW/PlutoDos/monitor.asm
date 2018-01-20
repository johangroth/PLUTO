;;;
;; Initialise the monitor.
;;;
monitor_initialiser: .proc
        ;jsr prompt
        rts
        .pend

;;;
;; Monitor main loop
;;;
monitor_main_loop: .proc
        jsr prompt
l2:
        jsr b_read_char             ;Get char in uppercase from terminal
        tay                         ;Protect read character
        ldx #0
l1:
        cmp command_table,x
        beq execute_command
        lda command_table,x
        cmp #$ff                    ;End of table?
        beq command_not_supported
        tya
        inx
        bra l1

execute_command:
        cmp #'A'
        bcc dont_echo               ;Branch if command is CTRL-<char>, ie non-printable
        jsr b_chout                 ;Echo command
dont_echo:
        txa                         ;Transfer index in command table to A
        asl                         ;Muliply with two to find the command pointer
        tax                         ;Transfer a to the index pointer
        jsr do_command              ;Execute command as a subroutine
        bra monitor_main_loop       ;Wait for next command
do_command:
        jmp (command_pointers,x)    ;execute command (command must do an rts)

command_not_supported:
        jsr b_bell
        bra l2
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
        lda temp1                   ;if temp1 is zero
        beq continue_dump           ;branch as we want to continue where we left off
        lda number_buffer           ;Address ends up in number_buffer
        sta address_low             ;so store it in address
        lda number_buffer+1
        sta address_high
continue_dump:
        ldx #$10                    ;16 hex numbers to print
        jsr print_byte_line         ;print $10 hex numbers starting with $00
        jsr b_crout                 ;CR LF
        jsr print_squiggly_line     ;Print the squiggly line ('~')
        jsr b_crout                 ;CR LF
        ldx #$10                    ;16 lines
next_address:
        ldy #$10                    ;16 bytes / line
        jsr b_hex_address           ;print the address
        jsr b_space
next_byte:
        lda (address_low)           ;get datum at address
        sta temp1                   ;temp1 is used by b_hex_byte (should probably change the name of variable)
        jsr b_hex_byte              ;print byte as hex
        jsr b_space                 ;print a space
        jsr inc_address             ;next byte
        dey
        bne next_byte               ;next column of bytes
        jsr dump_as_ascii           ;send printable ASCII to terminal. Non-printable are shown as inverted '?'.
        jsr b_crout                 ;next line
        dex
        bne next_address            ;next line
        jsr print_squiggly_line     ;ending squiggly line
        jsr b_crout                 ;CR LF
        ldx #$10                    ;16 hex numbers to print
        jsr print_byte_line         ;print $10 hex numbers starting with $00
        rts
        .pend

;;;
;; [F] Fill memory with a value
;;;
fill_memory: .proc
        jsr b_crout
        #print_text fill_start
        ldx #4                      ;Ask for up to 4 hex chars (fill start address)
        jsr b_input_hex             ;Address will be in number_buffer
        lda number_buffer           ;so move it to address_low/high
        sta address_low
        lda number_buffer+1
        sta address_high
        #print_text fill_length
        ldx #4                      ;Ask for up to 4 hex char (number of bytes to fill)
        jsr b_input_hex             ;Length will be in number_buffer
        lda number_buffer           ;so move it to fill_length_low/high
        sta fill_length_low
        lda number_buffer+1
        sta fill_length_high
        #print_text fill_byte
        ldx #2                      ;Ask for up to 2 hex chars (byte to fill memory with)
        jsr b_input_hex
        jsr abort_command           ;Check if user wants to abort
        cmp #a_esc
        beq exit
        lda number_buffer           ;Get value for fill
        ldx fill_length_high        ;Get number of full pages to fill
        beq partial_page            ;Branch if number of pages is 0.
        ldy #0
full_page:
        sta (address_low),y
        iny                         ;Next byte
        bne full_page               ;Branch if not done with this page
        inc address_high            ;Advance to next page
        dex                         ;
        bne full_page               ;Branch if not done with full pages
partial_page:
        ldx fill_length_low         ;Get the reminding number of bytes
        beq exit                    ;Branch if no reminding bytes
        ldy #0
l1:
        sta (address_low),y         ;Store value
        iny                         ;Increment index
        dex                         ;Decrement counter
        bne l1                      ;Branch if partial page is not done
exit:
        rts
        .pend

;;;
;; [H] Print all commands
;;;
print_all_commands: .proc
        jsr b_crout
        #print_text help_text
        rts
        .pend


;;;
;; [T] Display date and time
;;;
display_date_time: .proc
        jsr b_crout
        jsr print_date_and_time
        rts
        .pend

;;;
;; [CTRL-T] Set date and time
;;;
set_date_time: .proc
        jsr display_date_time
        jsr slash
        jsr b_space
        jsr slash
        jsr b_space 
        rts
        .pend


;;;
;; Monitor support routines
;;;

;;;
;; Dump as ASCII, non-printable characters (ie <32 and >126)
;; are printed as inverted '?'
;;;
dump_as_ascii: .proc
        phy
        jsr b_space
        sec
        lda address_low
        sbc #$10                ;start from the beginning of the line
        sta address_low
        lda address_high
        sbc #0
        sta address_high
        ldy #$10
loop:
        lda (address_low)
        cmp #' '
        bcc non_printable       ;Less than space, branch
        cmp #$7f
        bcs non_printable       ;Greater or equal to DEL, branch
        jsr b_chout
        bra next_char
non_printable:
        lda #<inverted_question_mark
        sta index_low
        lda #>inverted_question_mark
        sta index_high
        jsr b_prout
next_char:
        jsr inc_address
        dey
        bne loop
        ply
        rts
        .pend
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
        jsr b_colon
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
        #print_text_rts prompt_text
        .pend

abort_command: .proc
        #print_text abort_command_text
        jmp b_chin
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
        .text "D"   ;[D] Dump 256 bytes memory
        .byte $04   ;[CTRL-D] Download file with XMODEM/CRC
        .text "F"   ;[F] Fill memory
        .text "H"   ;[H] Print all commands
        .text $15   ;[CTRL-U] Upload file with XMODEM/CRC
        .text "T"   ;[T] Display date and time
        .byte $14   ;[CTRL-T] Set date and time
        .text
        .byte $ff   ;end of table

;;;
;; Pointers to monitor commands
;;;
command_pointers:
        .word dump_memory
        .word download
        .word fill_memory
        .word print_all_commands
        .word upload
        .word display_date_time
        .word set_date_time
