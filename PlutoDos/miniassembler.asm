;;;
;; Disassembler / mini assembler
;;;
        .include "include/miniassembler.inc"
disass: .proc
        ldx #20                     ; disassemble 20 lines
next_line:
        lda pc_low
        sta address_low
        lda pc_high
        sta address_high
        jsr b_hex_address           ; print current address
        lda (pc)
        sta scratch_low         ; Each mnemonic in table is 4 bytes so multiply with 4
        stz scratch_high
        asl scratch_low
        rol scratch_high
        asl scratch_low
        rol scratch_high
        lda #<mnemonics
        clc
        adc scratch_low
        sta scratch_low
        lda #>mnemonics
        adc scratch_high
        sta scratch_high        ; scratch points to mnemonic
        jsr print_mnemonic      ; print machine code and mnemonic
        jsr b_crout
        dex
        bne next_line
        rts
        .pend

;;;
;; print mnemonics
;;;
print_mnemonic .proc
        jsr print_machine_code_store_address_mode_as_text
        jsr inc_scratch                 ; point to mnemonic
        ldy #0
again:
        lda (scratch),y                 ; fill input_buffer with mnemonic characters
        sta input_buffer,y
        iny
        cpy #3
        bne again
        lda #0
        sta input_buffer,y              ; terminate string with 0
        jsr b_space
        lda #<input_buffer
        sta index_low
        lda #>input_buffer
        sta index_high
        jsr b_prout                     ; print mnemonic
        jsr b_space
        jsr print_address_mode
next:
        rts
        .pend

;; '*', Absolute a,                                     3 bytes
;; '@', Implied i, Stack s, Accumulator A               1 byte
;; '~', Absolute Indexed Indirect (a,x)                 3 bytes
;; ':', Absolute Indexed with X a,x                     3 bytes
;; '!', Absolute Indexed with Y a,y                     3 bytes
;; '/', Absolute Indirect (a)                           3 bytes
;; '#', Immediate #                                     2 bytes
;; '$', Program Counter Relative r                      2 bytes
;; '%', Zero Page zp                                    2 bytes
;; '^', Zero Page Indexed Indirect (zp,x)               2 bytes
;; '&', Zero Page Indexed with X zp,x                   2 bytes
;; '(', Zero Page Indexed with Y zp,y                   2 bytes
;; ')', Zero Page Indirect (zp)                         2 bytes
;; '=', Zero Page Indirect Indexed with Y (zp),y        2 bytes
;; '|', not implemented                                 1 byte
;; '[', bbr, bbs zero page, program counter relative r  3 byte
;; ']', rmb, smb Zero Page zp                           2 byte

print_machine_code_store_address_mode_as_text: .proc
        phx
        lda (scratch)         ; load address mode
        sta address_mode
        ldx #three_bytes_tokens_end-three_bytes_tokens
next_three_bytes_token:
        dex
        bmi two_bytes
        cmp three_bytes_tokens,x
        bne next_three_bytes_token
        jmp print_three_bytes

two_bytes:
        ldx #two_byte_token_end-two_byte_token
next_two_bytes_token:
        dex
        bmi one_byte
        cmp two_byte_token,x
        bne next_two_bytes_token
        jmp print_two_bytes

one_byte:
        jmp print_one_byte
        .pend

print_three_bytes: .proc
        jsr b_space
        lda (pc)
        sta op_code                 ; store op code in case of bbr, bbs
        sta temp1
        jsr b_hex_byte
        jsr b_space
        jsr inc_pc
        lda (pc)
        sta addressing_mode_low
        sta temp1
        jsr b_hex_byte
        jsr b_space
        jsr inc_pc
        lda (pc)
        sta addressing_mode_high
        sta temp1
        jsr b_hex_byte
        jsr inc_pc
        jsr b_space
        plx
        rts
        .pend

print_two_bytes: .proc
        jsr b_space
        lda (pc)
        sta op_code                 ; store op code in case of rmb, smb
        sta temp1
        jsr b_hex_byte
        jsr b_space
        jsr inc_pc
        lda (pc)
        sta addressing_mode_low
        sta temp1
        jsr b_hex_byte
        jsr inc_pc
        jsr b_space4
        plx
        rts
        .pend

print_one_byte: .proc
        jsr b_space
        lda (pc)
        sta temp1
        jsr b_hex_byte
        jsr inc_pc
        jsr b_space4
        jsr b_space2
        jsr b_space
        plx
        rts
        .pend

print_address_mode: .proc
        lda address_mode
        cmp #'@'                ; Implied i, Stack s, Accumulator A
        bne check_immediate
;;;
;; Handle implied, stack and accumulator (ie, nothing to do)
;;;
        rts

check_immediate:
        cmp #'#'                ; Immediate #
        bne check_absolute
;;;
;; handle Immediate #
;;;
        lda #'#'
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jmp b_hex_byte
check_absolute:
        cmp #'*'
        bne check_aii             ; Absolute Indexed Indirect (a,x)
;;;
;; handle absolute a
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta address_low
        lda addressing_mode_high
        sta address_high
        jmp b_hex_address

check_aii:
        cmp #'~'
        bne check_aix               ; absolute indexed with x a,x
;;;
;; handle Absolute Indexed Indirect (a,x)
;;;
        lda #'('
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta address_low
        lda addressing_mode_high
        sta address_high
        jsr b_hex_address
        jsr print_indexed_with_x
        lda #')'
        jsr b_chout
        rts

check_aix:
        cmp #':'
        bne check_aiy             ; absolute indexed with y a,y

;;;
;; handle absolute indexed with x a,x
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta address_low
        lda addressing_mode_high
        sta address_high
        jsr b_hex_address
        jsr print_indexed_with_x
        rts
check_aiy:
        cmp #'!'
        bne check_ai              ; absolute indirect (a)

;;;
;; handle absolute indexed with y a,y
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta address_low
        lda addressing_mode_high
        sta address_high
        jsr b_hex_address
        jsr print_indexed_with_y
        rts
check_ai:
        cmp #'/'
        bne check_pc_relative     ; all branch op codes

;;;
;; handle absolute indirect (a)
;;;
        lda #'('
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta address_low
        lda addressing_mode_high
        sta address_high
        jsr b_hex_address
        lda #')'
        jsr b_chout

        rts
check_pc_relative:
        cmp #'$'
        bne check_zero_page         ; zero page

;;;
;; handle all branch op codes except for bbr, sbr,
;;;
        jsr b_dollar
        lda addressing_mode_low
        bmi negative_address
        clc
        adc pc_low
        sta address_low
        lda pc_high
        adc #0                      ; add possible carry
        sta address_high
        bra address_out             ; print the address
negative_address:
        eor #$ff                    ; find two-compliment
        ina
        sta temp1
        sec
        lda pc_low
        sbc temp1
        sta address_low
        lda pc_high
        sbc #0
        sta address_high
address_out:
        jmp b_hex_address

check_zero_page:
        cmp #'%'
        bne check_zp_ii           ; zero page indexed indirect (zp,x)

;;;
;; handle zero page
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        rts

check_zp_ii:
        cmp #'^'
        bne check_zp_ix           ; zero page indexed with x zp,x
;;;
;; handle zero page indexed indirect (zp,x)
;;;
        lda #'('
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        jsr print_indexed_with_x
        lda #')'
        jsr b_chout
        rts

check_zp_ix:
        cmp #'&'
        bne check_zp_iy           ; zero page indexed with y zp,y
;;;
;; handle zero page indexed with x zp,x
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        jsr print_indexed_with_x
        rts

check_zp_iy:
        cmp #'('
        bne check_zp_i            ; zero page indirect (zp)
;;;
;; handle zero page indexed with y zp,y
;;;
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        jsr print_indexed_with_y
        rts

check_zp_i:
        cmp #')'
        bne check_zp_iiy          ; zero page indirect indexced with y (zp),y
;;;
;; handle zero page indirect (zp)
;;;
        lda #'('
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        lda #')'
        jsr b_chout
        rts

check_zp_iiy:
        cmp #'='
        bne check_bbr_bbs
;;;
;; handle zero page indirect indexced with y (zp),y
;;;
        lda #'('
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        lda #')'
        jsr b_chout
        jsr print_indexed_with_y
        rts

check_bbr_bbs:
        cmp #'['
        bne check_rmb_smb
;;;
;; handle bbr and bbs
;;;
        lda #1
        sta control_flags       ; decimal mode for bin -> ascii conversion
        jsr clear_number_buffer
        lda op_code
        and #$70                ; we're left with $00, $10, $20, $30, $40, $50, $60 or $70
        lsr                     ; move high nybble to low nybble
        lsr
        lsr
        lsr                     ; leaving us with 0 - 7 in .A
        sta number_buffer
        pha
        phx
        phy
        jsr binary_to_ascii
        jsr b_prout
        ply
        plx
        pla
        lda #','
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
        lda addressing_mode_high
        sta addressing_mode_low
        lda #','
        jsr b_chout
        lda #'$'
        jmp check_pc_relative

check_rmb_smb:
        cmp #']'
        bne exit                ; unknown op-code, '???' has already been printed
;;;
;; handle rmb and smb
;;;
        lda #1
        sta control_flags       ; decimal mode for bin -> ascii conversion
        jsr clear_number_buffer
        lda op_code
        and #$70                ; we're left with $00, $10, $20, $30, $40, $50, $60 or $70
        lsr                     ; move high nybble to low nybble
        lsr
        lsr
        lsr                     ; leaving us with 0 - 7 in .A
        sta number_buffer
        pha
        phx
        phy
        jsr binary_to_ascii
        jsr b_prout
        ply
        plx
        pla
        lda #','
        jsr b_chout
        jsr b_dollar
        lda addressing_mode_low
        sta temp1
        jsr b_hex_byte
exit:
        rts
        .pend

inc_scratch: .proc
        inc scratch_low
        bne return
        inc scratch_high
return:
        rts
        .pend

inc_pc: .proc
        inc pc_low
        bne done
        inc pc_high
done:
        rts
        .pend

print_indexed_with_x: .proc
        #print_text index_with_x
        rts
        .pend

print_indexed_with_y: .proc
        #print_text index_with_y
        rts
        .pend
