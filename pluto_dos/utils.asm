

;Table for BCD -> BIN -> BCD conversion
;BCD representations of 1,2,4,8,16,32,64,128 
TABLE1     .BYTE  $01
           .BYTE  $02
           .BYTE  $04
           .BYTE  $08
           .BYTE  $16
           .BYTE  $32
           .BYTE  $64
           .BYTE  $28
TABLE2     .BYTE  $00
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
;Convert one byte of BCD data to one byte of binary data
;
;Entry:             Register A = BCD data
;Exit:              BINOUT = binary data
;
;Registers used:    A, P
BCD2BIN .proc
        ;Multiply upper nibble by 10 and save it
        ;Temp = upper nibble * 10 which equals upper nibble * (8 + 2)
        PHY
        TAY             ;Save original value
        AND #$F0        ;Get upper nibble
        LSR             ;Divide by 2 which = upper nibble * 8
        STA TEMP        ;Save * 8
        LSR             ;Divide by 4
        LSR             ;Divide by 8: A = upper nibble * 2
        CLC
        ADC TEMP
        STA TEMP        ;REG A = upper nibble * 10
        TYA             ;Get original value
        AND #$0F        ;Get lower nibble
        CLC
        ADC TEMP        ;Add to upper nibble
        STA BINOUT
        PLY
        RTS
        .pend

BIN2BCD .proc
        SED             ;Output gets added up in decimal.
        STZ BINOUT      ;Inititalize output word as 0.
        STZ BINOUTH   
        LDX #$07        ;X decrements from 7 to 0 for 8 bits
LOOP    
        ASL TEMP2       ;Look at next high bit.  If it's 0,
        BCC L1          ;don't add anything to the output for this bit.
        LDA BINOUT      ;Otherwise get the running output sum
        CLC
        ADC TABLE1,X    ;and add the appropriate value for this bit
        STA BINOUT      ;from the table, and store the new sum.
        LDA BINOUTH     ;After low byte, do high byte.
        ADC TABLE2,X
        STA BINOUTH
L1
        DEX             ;Go down to next bit value to loop again.
        BPL LOOP        ;If still not done, go back for another loop.
        CLD
        RTS
        .pend
