;
;
; Subroutine library only. It must be included in an executable source file.
; 
;

;;; VIA device addresses:
    VIABASE = $7FC0 ;Write Output Register B, Read Input Register B
    VIARB   = VIABASE+0     ; Write Output Register B, Read Input Register B
    VIARA   = VIABASE+1     ; Write Output Register A, Read Input Register A
    VIADDRB = VIABASE+2     ; Data Direction Register B
    VIADDRA = VIABASE+3     ; Data Direction Register A
    VIAT1CL = VIABASE+4     ; Write T1 Low-Order Latches, Read T1 Low-Order Counter
    VIAT1CH = VIABASE+5     ; T1 High-Order Counter
    VIAT1LL = VIABASE+6     ; T1 Low-Order Latches
    VIAT1LH = VIABASE+7     ; T1 High-Order Latches
    VIAT2CL = VIABASE+8     ; Write T2 Low-Order Latches, Read T2 Low-Order Counter
    VIAT2CH = VIABASE+9     ; T2 High-Order Counter
    VIASR   = VIABASE+$A    ; Shift Register
    VIAACR  = VIABASE+$B    ; Auxiliary Control Register
    VIAPCR  = VIABASE+$C    ; Peripheral Control Register
    VIAIFR  = VIABASE+$D    ; Interrupt Flag Register
    VIAIER  = VIABASE+$E    ; Interrupt Enable Register
    VIARANH = VIABASE+$F    ; Same as Reg A except no "Handshake"

    VIAIFRIRQ = 7
    VIATIMER1MASK = 6
    VIATIMER2MASK = 5


INITVIA .proc
        LDX  #$0E
NEXT
        LDA  VIAINITTABLE,X
        STA  VIABASE,X
        DEX
        BPL  NEXT
        RTS
        .pend

VIAINITTABLE
        .byte   $00     ; PRB
        .byte   $00     ; PRA
        .byte   $00     ; DDRB
        .byte   $00     ; DDRA
        .byte   $00     ; T1CL
        .byte   $00     ; T1CH
        .byte   $00     ; T1LL
        .byte   $00     ; T1LH
        .byte   $00     ; T2CL
        .byte   $00     ; T2CH
        .byte   $00     ; SR
        .byte   $00     ; ACR
        .byte   $00     ; PCR
        .byte   $7F     ; IFR
        .byte   $7F     ; IER

;
;
; end of file
