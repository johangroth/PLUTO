;
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                                                                             *
;*                CONVERT ASCII NUMBER STRING TO 32-BIT BINARY                 *
;*                                                                             *
;*                             by BigDumbDinosaur                              *
;*                                                                             *
;* This 6502 assembly language program converts a null-terminated ASCII number *
;* string into a 32-bit unsigned binary value in little-endian format.  It can *
;* accept a number in binary, octal, decimal or hexadecimal format.            *
;*                                                                             *
;* --------------------------------------------------------------------------- *
;*                                                                             *
;* Copyright (C)1985 by BCS Technology Limited.  All rights reserved.          *
;*                                                                             *
;* Permission is hereby granted to copy and redistribute this software,  prov- *
;* ided this copyright notice remains in the source code & proper  attribution *
;* is given.  Any redistribution, regardless of form, must be at no charge  to *
;* the end user.  This code MAY NOT be incorporated into any package  intended *
;* for sale unless written permission has been given by the copyright holder.  *
;*                                                                             *
;* THERE IS NO WARRANTY OF ANY KIND WITH THIS SOFTWARE.  It's free, so no mat- *
;* ter what, you'll get your money's worth.                                    *
;*                                                                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;
;    Calling Syntax for HEX ASCII to bin:
;        rmb 0,control_flags
;        rmb 1,control_flags
;        ldx #number_of_char_to_convert
;        jsr ascii_to_bin
;        bcs error
;
;    All registers are modified.  The result of the conversion is left in
;    location number_buffer in unsigned, little-endian format (see source code).
;    The contents of number_buffer are undefined if ascii_to_bin exits with an error.
;    The maximum number that can be converted is 4,294,967,295 or (2^32)-1.
;
;    A null-terminated character string stored at input_buffer is in the format:
;
;        DDD...DDD
;
;    DDD...DDD represents the characters that comprise the number that is
;    to be converted.  Permissible values for each instance of D are:
;
;        Description  D - D
;        ------------------
;        Binary       0 - 1
;        Octal        0 - 7
;        Decimal      0 - 9
;        Hexadecimal  0 - 9
;                     A - F
;        ------------------
;
;    Conversion is not case-sensitive.  Leading zeros are permissible, but
;    not leading blanks.  The maximum string length including the null
;    terminator is 127.  An error will occur if a character in the string
;    to be converted is not appropriate for the selected radix, the con-
;    verted value exceeds $FFFFFFFF or an undefined radix is specified.
;
;================================================================================
;
;ATOMIC CONSTANTS
;

;
a_hexnum: = 'A'-'9'-1                   ;hex to decimal difference
n_radix: = 3                            ;number of supported radixes
radix_mask: = 3                         ;bit 0 and 1 in control_flags holds the radix
s_fac:  = 4                             ;binary accumulator size

;
;================================================================================
;
;CONVERSION TABLES
;
basetab: .byte 16,10,2                  ;number bases per radix, HEX, DEC, BIN
bits_per_digit_table: .byte 4,3,1       ;bits per digit per radix

;
;================================================================================
;
;CONVERT STRING TO 32 BIT BINARY
;

;
ascii_to_bin: .proc
        cpx #0                          ; if x != 0 then
        bne convert                     ; convert characters to binary, so branch
        stz temp1                       ; else no characters to convert so return to caller.
        rts

convert:
        stz input_buffer,x              ;Zero terminate input string.
        ldx #s_fac-1                    ;accumulator size
;
l01:
        stz number_buffer,x             ;clear the result buffer
        dex
        bpl l01
        stz stridx                      ;clear string index
;
;
        lda control_flags               ;0=>HEX, 1=>DEC, 2=>BIN
        and #radix_mask                 ;Mask away everything but radix bits.
        tax                             ;Put base in X
        lda bits_per_digit_table,x      ;get bits per digit
        sta bits_per_digit              ;store
;
;    --------------------------------
;    process number portion of string
;    --------------------------------
;
        ldy #0                          ;Y holds index in input_buffer.
l06:
        clc                             ;assume no error for now
        lda input_buffer,y              ;get numeral
        beq l17                         ;end of string
;
        inc stridx                      ;point to next
        cmp #'A'                        ;check char range
        bcc l07                         ;not ASCII
;
        cmp #'Z'+1
        bcs l08                         ;not ASCII
;
l07:
        sec
l08:
        sbc #'0'                        ;change numeral to binary
        bcc l16                         ;numeral > 0
;
        cmp #10
        bcc l09                         ;numeral is 0-9
;
        sbc #a_hexnum                   ;do a hex adjust
;
l09:
;
        sta curntnum                    ;save processed numeral
        bbr 0,control_flags,l11         ;branch if not working in base 10
;
;    -----------------------------------------------------------
;    Prior to combining the most recent numeral with the partial
;    result, it is necessary to left-shift the partial result
;    result 1 digit.  The operation can be described as N*base,
;    where N is the partial result & base is the number base.
;    N*base with binary, octal & hex is a simple repetitive
;    shift.  A simple shift won't do with decimal, necessitating
;    an (N*8)+(N*2) operation.  number_buffer is copied to SFAC to gener-
;    ate the N*2 term.
;    -----------------------------------------------------------
;
        ldx #0
        ldy #s_fac                      ;accumulator size
        clc
;
l10:
        lda number_buffer,x             ;N
        rol                             ;N=N*2
        sta sfac,x
        inx
        dey
        bne l10
;
        bcs l17                         ;overflow = error
;
l11:
        ldx bits_per_digit              ;bits per digit
;
l12:
        asl number_buffer               ;compute N*base for binary,...
        rol number_buffer+1             ;octal &...
        rol number_buffer+2             ;hex or...
        rol number_buffer+3             ;N*8 for decimal
        bcs l17                         ;overflow
;
        dex
        bne l12                         ;next shift
;
        bbr 0,control_flags,l14         ;branch if not working in base 10
;
;    -------------------
;    compute (N*8)+(N*2)
;    -------------------
;
        ldx #0                          ;accumulator index
        ldy #s_fac
;
l13:
        lda number_buffer,x             ;N*8
        adc sfac,x                      ;N*2
        sta number_buffer,x             ;now N*10
        inx
        dey
        bne l13
;
        bcs l17                         ;overflow
;
;    -------------------------------------
;    add current numeral to partial result
;    -------------------------------------
;
l14:
        clc
        lda number_buffer               ;N
        adc curntnum                    ;N=N+D
        sta number_buffer
        ldx #1
        ldy #s_fac-1
;
l15:
        lda number_buffer,x
        adc #0                          ;account for carry
        sta number_buffer,x
        inx
        dey
        bne l15
;
        bcs l17                         ;overflow
;
;    ----------------------
;    ready for next numeral
;    ----------------------
;
        ldy stridx                      ;string index
        bpl l06                         ;get another numeral
;
;    ----------------------------------------------
;    if string length > 127 fall through with error
;    ----------------------------------------------
;
l16:
        sec                             ;flag an error
;
l17:
        lda #$ff                        ;Indicate a conversion has taken place
        sta temp1
        rts                             ;done
        .pend
