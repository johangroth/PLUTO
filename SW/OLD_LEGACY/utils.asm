;Table for BCD -> BIN -> BCD conversion 
;BCD representations of 1,2,4,8,16,32,64,128 
TABLE1: .BYTE  $01
        .BYTE  $02
        .BYTE  $04
        .BYTE  $08
        .BYTE  $16
        .BYTE  $32
        .BYTE  $64
        .BYTE  $28
TABLE2: .BYTE  $00
        .BYTE  $00
        .BYTE  $00
        .BYTE  $00
        .BYTE  $00
        .BYTE  $00
        .BYTE  $00
        .BYTE  $01

; 
;============================================================================== 
;BCD2BIN 
;Convert two bytes of BCD data to two byte of binary data 
; 
;Entry:             BCDNUM = data in big endian format 
;Exit:              BINOUT = binary data in big endian format 
; 
;Registers used:    A, P 
BCD2BIN: .proc
        BYTE = $FE
START:  CLD             ;Clear decimal mode.
        LDA #00         ;Clear locations that will hold the binary number.
        LDX #BYTE
BACK:   STA BINOUT+2,X
        INX
        BNE BACK        ;Locations have been cleared.
        SEC
THERE:  LDX #BYTE       ;Rotate the binary number right, moving the remainder from the BCD division into the binary number.
RETURN: ROR BINOUT+2,X
        INX
        BNE RETURN
        BCS OUT         ;If the carry is set, the conversion is complete.
        LDX #BYTE
AGAIN:  ROR BCDNUM+2,X  ;Start the division-by-two by shifting BCD number right.
        INX
        BNE AGAIN       ;Remainder will be in carry flag so save it on the stack.
        PHP
        LDX #BYTE       ;Test bit three of each byte to see if a one was shifted in.
        SEC
LAKE:   LDA BCDNUM+2,X
        AND #08         ;If so, subtract three.
        BEQ FORWD       ;If not, no correction needed, so test bit seven of each byte to see if a one was shifted in.
        LDA BCDNUM+2,X
        SBC #03
        STA BCDNUM+2,X
FORWD:  LDA BCDNUM+2,X  ;Here bit seven is checked.
        AND # $80
        BEQ ARND        ;No correction.
        LDA BCDNUM+2,X  ;Correction: subtract 30.
        SBC #$30
        STA BCDNUM+2,X
ARND:   INX
        BNE LAKE        ;Repeat for all N bytes.
        PLP             ;Get the carry back because it held the remainder.
        BRA THERE       ;Go back and put it in the binary number. Then finish.
OUT:    RTS
        .pend

BIN2BCD: .proc
        SED             ;Output gets added up in decimal.
        STZ BINOUT      ;Inititalize output word as 0.
        STZ BINOUTH
        LDX #$07        ;X decrements from 7 to 0 for 8 bits
LOOP: 
        ASL TEMP2       ;Look at next high bit.  If it's 0,
        BCC L1          ;don't add anything to the output for this bit.
        LDA BINOUT      ;Otherwise get the running output sum
        CLC
        ADC TABLE1,X    ;and add the appropriate value for this bit
        STA BINOUT      ;from the table, and store the new sum.
        LDA BINOUTH     ;After low byte, do high byte.
        ADC TABLE2,X
        STA BINOUTH
L1: 
        DEX             ;Go down to next bit value to loop again.
        BPL LOOP        ;If still not done, go back for another loop.
        CLD
        RTS
        .PEND

;Send BCD number in A to terminal 
BCDOUTA: .proc
        PHA
        LSR             ;Shift high digit to low digit, zero high digit
        LSR
        LSR
        LSR
        JSR  BCDTOASC   ;Convert BCD digit to ASCII DECIMAL digit, send digit to terminal
        PLA             ;Read indexed byte from BCD output buffer
        AND  #$0F       ;Zero the high digit
        JSR  BCDTOASC   ;Convert BCD digit to ASCII DECIMAL digit, send digit to terminal
        RTS             ;Done BCDOUT subroutine, RETURN

;BCDTOASC subroutine: 
; convert BCD digit to ASCII DECIMAL digit, send digit to terminal 
BCDTOASC: 
        CLC             ;Add ASCII "0" to digit: convert BCD digit to ASCII DECIMAL digit
        ADC  #$30
        JMP  COUT       ;Send converted digit to terminal
        .pend

