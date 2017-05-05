;
;
; Subroutine library only. It must be included in an executable source file.
; 
;

;;; VIA device addresses:
    VIARB   = $7FC0 ;Write Output Register B, Read Input Register B
    VIARA   = VIARB+1   ;Write Output Register A, Read Input Register A
    VIADDRB = VIARB+2   ;Data Direction Register B
    VIADDRA = VIARB+3   ;Data Direction Register A
    VIAT1CL = VIARB+4   ;Write T1 Low-Order Latches, Read T1 Low-Order Counter
    VIAT1CH = VIARB+5   ;T1 High-Order Counter
    VIAT1LL = VIARB+6   ;T1 Low-Order Latches
    VIAT1LH = VIARB+7   ;T1 High-Order Latches
    VIAT2CL = VIARB+8   ;Write T2 Low-Order Latches, Read T2 Low-Order Counter
    VIAT2CH = VIARB+9   ;T2 High-Order Counter
    VIASR   = VIARB+$A  ;Shift Register
    VIAACR  = VIARB+$B  ;Auxiliary Control Register
    VIAPCR  = VIARB+$C  ;Peripheral Control Register
    VIAIFR  = VIARB+$D  ;Interrupt Flag Register
    VIAIER  = VIARB+$E  ;Interrupt Enable Register
    VIARANH = VIARB+$F  ;Same as Reg A except no "Handshake"


VIAINIT .proc
        LDX  #$0E
NEXT
        LDA  VIAINITTABLE,X
        STA  VIARB,X
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
