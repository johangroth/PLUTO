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
        jsr b_crout
        lda temp1                   ;if temp1 is zero
        beq continue_dump           ;branch as we want to continue where we left off
        lda number_buffer           ;Address ends up in number_buffer
        sta address_low             ;so store it in address
        lda number_buffer+1
        sta address_high
continue_dump:
        ldx #$10                    ;16 hex numbers to print
        jsr print_byte_line         ;print numbers $01 to $10
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
        jsr b_crout
        #print_text fill_length
        ldx #4                      ;Ask for up to 4 hex char (number of bytes to fill)
        jsr b_input_hex             ;Length will be in number_buffer
        lda number_buffer           ;so move it to fill_length_low/high
        sta fill_length_low
        lda number_buffer+1
        sta fill_length_high
        jsr b_crout
        #print_text fill_byte
        ldx #2                      ;Ask for up to 2 hex chars (byte to fill memory with)
        jsr b_input_hex
        jsr b_crout
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
;; Fills todbuf with data and calls put_date_and_time to update RTC.
;;
;;                    Offset  Content
;;                    --------------
;;                      $00   seconds     ($00-$59)
;;                      $01   minutes     ($00-$59)
;;                      $02   hours       ($00-$23)
;;                      $03   day-of-week ($01-$07)
;;                      $04   date        ($01-$31)
;;                      $05   month       ($01-$12)
;;                      $06   year LSB    ($00-$99)
;;                      $07   year MSB    ($00-$39)
;;                    --------------
;;
;; Input order will DDD dd mm yyyy hh MM ss
;; Ring bell if DDD can't be found in days_of_week table
;;;
set_date_time: .proc
        jsr display_date_time
        jsr b_crout
        ; input day of week
        jsr input_day_of_week
        sta todbuf+3                ;Store day of week
        jsr b_space2
        ; input day of month
        lda #2                      ;Input of two numbers
        sta temp2
        jsr input_time_date_info
        sta todbuf+4                ;Store day in month
        #print_char '/'
        ; input month
        lda #2
        sta temp2
        jsr input_time_date_info
        sta todbuf+5
        #print_char '/'
        ; input year, no validation
        lda #4                      ;Input of four numbers
        sta temp2
        jsr input_time_date_info
        sta todbuf+6
        sty todbuf+7
        ; input hour
        jsr b_space
        lda #2                      ;Input of two numbers
        sta temp2
        jsr input_time_date_info
        sta todbuf+2
        jsr set_date_and_time
        ; input minutes
        #print_char ':'
        lda #2                      ;Input of two numbers
        sta temp2
        jsr input_time_date_info
        sta todbuf+1
        jsr set_date_and_time
        ; input seconds
        #print_char ':'
        lda #2                      ;Input of two numbers
        sta temp2
        jsr input_time_date_info
        sta todbuf
        jsr set_date_and_time
        rts
        .pend


;;;
;; Monitor support routines
;;;

;;;
;; Input date and time.
;; No validations are made whether values are correct
;;;
input_time_date_info: .proc
        smb 0,control_flags     ;%01 in control_flags means decimal input.
        rmb 1,control_flags
read_date_again:
        ldy #<input_buffer
        lda #>input_buffer
        ldx temp2               ;The amount of characters that should be read
        jsr b_read_line         ;Read .X decimal numbers
        phx                     ;Preserve number of characters read
        jsr ascii_to_bin        ;Convert to binary
        plx                     ;Restore number of characters read
        lda number_buffer+1     ;High byte, only used for year input
        sta bin+1
        lda number_buffer
        sta bin
        jsr bin_to_bcd16
        lda bcd
        ldy bcd+1
        rts
        .pend

;;;
;; Input day of week. BELL rings if day is not found.
;; Register A will hold day of week 1 being Monday
;;;
input_day_of_week:  .proc
        phx
        phy
        smb 0,control_flags     ;%11 in control_flags means ASCII input
        smb 1,control_flags
read_week_day_again:
        #print_text clear_line
        #print_text beginning_of_line
        ldy #<input_buffer      ;low byte of where read line will place input
        lda #>input_buffer      ;high byte of where read line will place input
        ldx #3                  ;Ask for three characters
        jsr b_read_line
        cpx #3                  ;Have we read three characters
        beq correct             ;Yes, Branch
        jsr b_bell              ;No, sound bell and clear line
        bra read_week_day_again

        ;; three characters have been read
correct:
        ldx #1                  ;Day of week, 1 being Monday
        lda #<days_of_week      ;Initialise address pointer with days of week table address
        sta address_low
        sta tmp                 ;Holds the index in the table
        lda #>days_of_week
        sta address_high
        sta tmp+1

; Search for week day in table
check_next_entry:
        jsr strcmp
        bcs exit
        jsr next_entry_in_week_day_table
        inx
        cpx #8
        bne check_next_entry
        jsr b_bell
        bra read_week_day_again
exit:
        txa                     ;Day of week 1-7, 1 being Monday
        ply
        plx
        rts
        .pend

next_entry_in_week_day_table: .proc
        ldy #4
l1:
        inc tmp
        bne done
        inc tmp+1
done:
        dey
        bne l1
        lda tmp
        sta address_low
        lda tmp+1
        sta address_high
        rts
        .pend

;;;
;; strcmp
;;;

strcmp: .proc
        pha
        phy
        ldy #0
l2:
        lda (address_low),y
        cmp input_buffer,y
        bne no_match            ;Exit when characters doesn't match
        cmp #0                  ;Has end of string been reached
        beq match               ;Yes, strings match
        iny                     ;character
        bra l2
no_match:
        clc                     ;Carry cleared == strings are not matching
        bra exit
match:
        sec                     ;Set carry to indicate strings match
exit:
        ply
        pla
        rts
        .pend

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
        #print_text inverted_question_mark
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
;; Print a sequence of bytes starting with 00 as HEX
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
;; Add A to address
;;;
add_a_to_address: .proc
        clc
        adc address_low
        sta address_low
        lda #0
        adc address_high
        sta address_high
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
