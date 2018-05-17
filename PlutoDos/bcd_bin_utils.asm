; This technique is very similar to Garth Wilson's, but does away with
; the look up table for powers of two and much simpler than the approach
; used by Lance Leventhal in his books (e.g. subtracting out 1000s, 100s,
; 10s and 1s).
;
; Andrew Jacobs, 28-Feb-2004

bin_to_bcd8:	.proc
		sed				; switch to decimal mode
		lda #0			; ensure the result is clear
		sta bcd+0
		sta bcd+1
		ldx #8			; the number of source bits

convert_bit:
		asl bin			; shift out one bit
		lda bcd+0		; and add into result
		adc bcd+0
		sta bcd+0
		lda bcd+1		; propagating any carry
		adc bcd+1
		sta bcd+1
		dex				; and repeat for next bit
		bne convert_bit
		cld				; back to binary
		rts
		.pend

;Table for BCD -> BIN -> BCD conversion
;BCD representations of 1,2,4,8,16,32,64,128
table1: .byte  $01
        .byte  $02
        .byte  $04
        .byte  $08
        .byte  $16
        .byte  $32
        .byte  $64
        .byte  $28
table2: .byte  $00
        .byte  $00
        .byte  $00
        .byte  $00
        .byte  $00
        .byte  $00
        .byte  $00
        .byte  $01

;
;==============================================================================
;BCD2BIN
;Convert two bytes of BCD data to two byte of binary data
;
;Entry:             BCDNUM = data in big endian format
;Exit:              BINOUT = binary data in big endian format
;
;Registers used:    A, P
bcd2bin: .proc
        byte = $fe
start:
		cld             ;clear decimal mode.
        lda #00         ;clear locations that will hold the binary number.
        ldx #byte
back:
		sta binout+2,x
        inx
        bne back        ;locations have been cleared.
        sec
there:
		ldx #byte       ;rotate the binary number right, moving the remainder from the bcd division into the binary number.
return:
		ror binout+2,x
        inx
        bne return
        bcs out         ;if the carry is set, the conversion is complete.
        ldx #byte
again:
		ror bcdnum+2,x  ;start the division-by-two by shifting bcd number right.
        inx
        bne again       ;remainder will be in carry flag so save it on the stack.
        php
        ldx #byte       ;test bit three of each byte to see if a one was shifted in.
        sec
lake:
		lda bcdnum+2,x
        and #08         ;if so, subtract three.
        beq forwd       ;if not, no correction needed, so test bit seven of each byte to see if a one was shifted in.
        lda bcdnum+2,x
        sbc #03
        sta bcdnum+2,x
forwd:
		lda bcdnum+2,x  ;here bit seven is checked.
        and # $80
        beq arnd        ;no correction.
        lda bcdnum+2,x  ;correction: subtract 30.
        sbc #$30
        sta bcdnum+2,x
arnd:
		inx
        bne lake        ;repeat for all n bytes.
        plp             ;get the carry back because it held the remainder.
        bra there       ;go back and put it in the binary number. then finish.
out:
		rts
        .pend

bin2bcd: .proc
        sed             ;output gets added up in decimal.
        stz binout      ;inititalize output word as 0.
        stz binouth
        ldx #$07        ;x decrements from 7 to 0 for 8 bits
loop:
        asl temp2       ;look at next high bit.  if it's 0,
        bcc l1          ;don't add anything to the output for this bit.
        lda binout      ;otherwise get the running output sum
        clc
        adc table1,x    ;and add the appropriate value for this bit
        sta binout      ;from the table, and store the new sum.
        lda binouth     ;after low byte, do high byte.
        adc table2,x
        sta binouth
l1:
        dex             ;go down to next bit value to loop again.
        bpl loop        ;if still not done, go back for another loop.
        cld
        rts
        .pend

; Convert an 16 bit binary value to BCD
;
; This function converts a 16 bit binary value into a 24 bit BCD. It
; works by transferring one bit a time from the source and adding it
; into a BCD value that is being doubled on each iteration. As all the
; arithmetic is being done in BCD the result is a binary to decimal
; conversion. All conversions take 915 clock cycles.
;
; See BINBCD8 for more details of its operation.
;
; Andrew Jacobs, 28-Feb-2004

bin_to_bcd16: .proc
        sed             ; switch to decimal mode
        lda #0          ; ensure the result is clear
        sta bcd+0
        sta bcd+1
        sta bcd+2
        ldx #16         ; the number of source bits
cnvbit:
		asl bin+0       ; shift out one bit
        rol bin+1
        lda bcd+0       ; and add into result
        adc bcd+0
        sta bcd+0
        lda bcd+1       ; propagating any carry
        adc bcd+1
        sta bcd+1
        lda bcd+2       ; ... thru whole result
        adc bcd+2
        sta bcd+2
        dex             ; and repeat for next bit
        bne cnvbit
        cld             ; back to binary
		rts
        .pend

;Send BCD number in A to terminal
bcdouta: .proc
        pha
        lsr             ;shift high digit to low digit, zero high digit
        lsr
        lsr
        lsr
        jsr  bcdtoasc   ;convert bcd digit to ascii decimal digit, send digit to terminal
        pla             ;read indexed byte from bcd output buffer
        and  #$0f       ;zero the high digit
        jmp  bcdtoasc   ;convert bcd digit to ascii decimal digit, send digit to terminal


;bcdtoasc subroutine:
; convert bcd digit to ascii decimal digit, send digit to terminal
bcdtoasc:
        clc             ;add ascii "0" to digit: convert bcd digit to ascii decimal digit
        adc  #$30
        jmp  b_chout       ;send converted digit to terminal
        .pend
