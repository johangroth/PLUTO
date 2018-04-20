;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;*                                                                             *
;*                CONVERT 32-BIT BINARY TO ASCII NUMBER STRING                 *
;*                                                                             *
;*                             by BigDumbDinosaur                              *
;*                                                                             *
;* This 6502 assembly language program converts a 32-bit unsigned binary value *
;* into a null-terminated ASCII string whose format may be in  binary,  octal, *
;* decimal or hexadecimal.                                                     *
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
;* ter what, you're getting a great deal.                                      *
;*                                                                             *
;* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;
;    CALLING SYNTAX:
;
;            LDA #RADIX         ;radix character, see below
;            LDX #<OPERAND      ;binary value address LSB
;            LDY #>OPERAND      ;binary value address MSB
;            (ORA #%10000000)   ;radix suppression, see below
;            JSR BINSTR         ;perform conversion
;            STX ZPPTR          ;save string address LSB
;            STY ZPPTR+1        ;save string address MSB
;            TAY                ;string length
;    LOOP    LDA (ZPPTR),Y      ;copy string to...
;            STA MYSPACE,Y      ;safe storage, will include...
;            DEY                ;the terminator
;            BPL LOOP
;
;    CALLING PARAMETERS:
;
;    .A      Conversion radix, which may be any of the following:
;
;            '%'  Binary.
;            '@'  Octal.
;            '$'  Hexadecimal.
;
;            If the radix is not one of the above characters decimal will be
;            assumed.  Binary, octal & hex conversion will prepend the radix
;            character to the string.  To suppress this feature set bit 7 of
;            the radix.
;
;    .X/.Y   The address of the 32-bit binary value (operand) that is to be
;            converted.  The operand must be in little-endian format.
;
;    REGISTER RETURNS:
;
;    .A      The printable string length.  The exact length will depend on
;            the radix that has been selected, whether the radix is to be
;            prepended to the string & the number of significant digits.
;            Maximum possible printable string lengths for each radix type
;            are as follows:
;
;            %  Binary   33
;            @  Octal    12
;               Decimal  11
;            $  Hex       9
;
;    .X/.Y   The LSB/MSB address at which the null-terminated conversion
;            string will be located.  The string will be assembled into a
;            statically allocated buffer and should be promptly copied to
;            user-defined safe storage.
;
;    .C      The carry flag will always be clear.
;
;    APPROXIMATE EXECUTION TIMES in CLOCK CYCLES:
;
;            Binary    5757
;            Octal     4533
;            Decimal  13390
;            Hex       4373
;
;    The above execution times assume the operand is $FFFFFFFF, the radix
;    is to be prepended to the conversion string & all workspace other than
;    the string buffer is on zero page.  Relocating ZP workspace to absolute
;    memory will increase execution time approximately 8 percent.
;
;================================================================================
;
;ATOMIC CONSTANTS
;
;
a_hexdec: = 'A'-'9'-2                   ;hex to decimal difference
m_bits: = 32                            ;operand bit size
m_cbits: = 48                           ;workspace bit size
m_strlen: = m_bits+1                    ;maximum printable string length
s_pfac: = m_bits/8                      ;primary accumulator size
s_ptr:  = 2                             ;pointer size
s_wrkspc: = m_cbits/8                   ;conversion workspace size
;
;================================================================================
;
;ZERO PAGE ASSIGNMENTS
;All ZP assignments are in include/zp.inc.
;

;
;================================================================================
;
;CONVERT 32-BIT BINARY TO NULL-TERMINATED ASCII NUMBER STRING
;
binary_to_ascii: .proc
        lda control_flags               ;get radix, 00=>HEX, 01=>DEC, 10=>BIN
        and #radix_mask                 ;keep only radix bits
        sta radix                       ;save radix index for later
        stz stridx                      ;initialise string index
        bbr 0,radix,l06                 ;branch if not converting to decimal
;
;    ------------------------------
;    prepare for decimal conversion
;    ------------------------------
;
        jsr facbcd                      ;convert operand to BCD
        bra l09                         ;skip binary stuff
;
;    -------------------------------------------
;    prepare for binary, octal or hex conversion
;    -------------------------------------------
;
l06:
        ldy #0                          ;operand index
        ldx #s_wrkspc-1                 ;workspace index
l07:
        lda number_buffer,y             ;copy operand to...
        sta wrkspc01,x                  ;workspace in...
        dex                             ;big-endian order
        iny
        cpy #s_pfac
        bne l07
l08:
        stz wrkspc01,x                  ;pad workspace
        dex
        bpl l08
;
;    ----------------------------
;    set up conversion parameters
;    ----------------------------
;
l09:
        stz wrkspc02                    ;initialize byte counter
        ldy radix                       ;radix index
        lda numstab,y                   ;numerals in string
        sta wrkspc02+1                  ;set remaining numeral count
        lda bitstab,y                   ;bits per numeral
        sta wrkspc02+2                  ;set
        lda lzsttab,y                   ;leading zero threshold
        sta wrkspc02+3                  ;set
;
;    --------------------------
;    generate conversion string
;    --------------------------
;
l10:
        lda #0
        ldy wrkspc02+2                  ;bits per numeral
l11:
        ldx #s_wrkspc-1                 ;workspace size
        clc                             ;avoid starting carry
l12:
        rol wrkspc01,x                  ;shift out a bit...
        dex                             ;from the operand or...
        bpl l12                         ;BCD conversion result
        rol                             ;bit to A
        dey
        bne l11                         ;more bits to grab
        tay                             ;if numeral isn't zero...
        bne l13                         ;skip leading zero tests
        ldx wrkspc02+1                  ;remaining numerals
        cpx wrkspc02+3                  ;leading zero threshold
        bcc l13                         ;below it, must convert
        ldx wrkspc02                    ;processed byte count
        beq l15                         ;discard leading zero
l13:
        cmp #10                         ;check range
        bcc l14                         ;is 0-9
        adc #a_hexdec                   ;apply hex adjust
l14:
        adc #'0'                        ;change to ASCII
        ldy stridx                      ;string index
        sta strbuf,y                    ;save numeral in buffer
        inc stridx                      ;next buffer position
        inc wrkspc02                    ;bytes=bytes+1
l15:
        dec wrkspc02+1                  ;numerals=numerals-1
        bne l10                         ;not done
;
;    -----------------------
;    terminate string & exit
;    -----------------------
;
        ldx stridx                      ;printable string length
        stz strbuf,x                    ;terminate string
        txa
        ldx #<strbuf                    ;converted string LSB
        stx index_low
        ldy #>strbuf                    ;converted string MSB
        sty index_high
        clc                             ;all okay
        rts
;
;================================================================================
;
;CONVERT number_buffer into BCD using the double/dabble algorithm.
;We can use this method to convert base two numerals to base 10.
;When we see a 1 we dabble: that is we double and add 1.
;When we see a 0 we double: that is we double the number we have.
;Try: 1 1 0 0 1 1 1 0 1
; We start with the first 1. The next 1 means we dabble, so 1 x 2 + 1 = 3.
; Next we have a 0 so we double: 3 x 2 = 6.
; Again we have a 0, so we double: 2 x 6 = 12.
; Now we have a 1, so we dabble 2 x 12 + 1 = 25.
; Another 1, another dabble: 2 x 25 + 1 = 51.
; Another 1, another dabble: 2 x 51 + 1 = 103.
; Next we have a 0, so we double: 2 x 103 = 206.
; Lastly, we have a 1 so we dabble: 2 x 206 + 1 = 413.
facbcd:
        ldx #s_pfac-1                   ;primary accumulator size -1
facbcd01:
        lda number_buffer,x             ;store value to be converted...
        pha                             ;...on the stack
        dex
        bpl facbcd01                    ;next
        lda #0
        ldx #s_wrkspc-1                 ;workspace size
facbcd02:
        stz wrkspc01,x                  ;clear final result
        stz wrkspc02,x                  ;clear scratchpad
        dex
        bpl facbcd02
        inc wrkspc02+s_wrkspc-1
        sed                             ;select decimal mode
        ldy #m_bits-1                   ;bits to convert -1
facbcd03:
        ldx #s_pfac-1                   ;operand size
        clc                             ;no carry at start
facbcd04:
        ror number_buffer,x             ;grab LS bit in operand
        dex
        bpl facbcd04
        bcc facbcd06                    ;LS bit clear
        clc
        ldx #s_wrkspc-1
facbcd05:
        lda wrkspc01,x                  ;partial result
        adc wrkspc02,x                  ;scratchpad
        sta wrkspc01,x                  ;new partial result
        dex
        bpl facbcd05
        clc
facbcd06:
        ldx #s_wrkspc-1
facbcd07:
        lda wrkspc02,x                  ;scratchpad
        adc wrkspc02,x                  ;double &...
        sta wrkspc02,x                  ;save
        dex
        bpl facbcd07
        dey
        bpl facbcd03                    ;next operand bit
        ldx #0
facbcd08:
        pla                             ;operand
        sta number_buffer,x             ;restore
        inx
        cpx #s_pfac
        bne facbcd08                    ;next
        cld                             ;switch back to binary mode
        rts
;
;================================================================================
;
;PER RADIX CONVERSION TABLES
;
;Radix order of tables is hex, dec, bin
bitstab: .byte 4,4,1                    ;bits per numeral
lzsttab: .byte 3,2,9                    ;leading zero suppression thresholds
numstab: .byte 12,12,48                 ;maximum numerals
        .pend
