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
        jsr b_chin                    ;Get char from terminal
        ldx #0
l1:
        cmp command_table,x
        beq execute_command
        cmp #$ff                    ;End of table?
        beq command_not_supported
        inx
        bra l1

execute_command:
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
        lda #'D'
        jsr b_chout
        ldx #4                      ;Ask for up to 4...
        jsr b_input_hex             ;...characters
        jsr print_squiggly_line     ;Print the squiggly line ('~')
        ldx #$10
        jsr print_byte_line         ;print $10 hex numbers starting with $00
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
        jsr b_crout
        lda #'~'
        ldx #80
again:
        jsr b_chout
        dex
        bne again
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
        phy
        jsr b_space4
        lda #0
        ;sta temp
again:
        lda #'0'
        jsr b_chout
        ;lda temp

        jsr b_chout
        ;inc temp
        dex
        bne again
        ply
        pla
        rts
        .pend

;;;
;; Print monitor prompt
;;;
prompt: .proc
        jsr b_crout
        lda #<help_text
        sta index_low
        lda #>help_text
        sta index_high
        jmp b_prout
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
