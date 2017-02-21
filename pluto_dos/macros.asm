; -----------------------------------------------------------------------------
; MACROS
; For Tali Forth for the 65c02
; Scot W. Stevenson <scot.stevenson@gmail.com>
; Based on Macros for the Übersquirrel SqOS A013
; First version: 19. Jan 2014
; This version:  21. Jan 2014
;
; Used with the Ophis assembler and the py65mon simulator
; -----------------------------------------------------------------------------
; Assumes Tali-Kernel.asm is loaded

;==============================================================================
; ASSEMBLER MACROS FOR THE KERNEL
;==============================================================================

; -----------------------------------------------------------------------------
; MACRO for writing a line. Use with ".invoke wrtline <address>" where
; <address> is the first byte of the string in 16 bit. As a "write"
; command, the string is not terminated by a LF (no new line)
wrtline .macro
        lda #<\1
        sta k_str_l
        lda #>\1
        sta k_str_h
        jsr k_wrtstr
.endm

; -----------------------------------------------------------------------------
; MACRO for printing a line. Use with ".invoke prtline <address>" where
; <address> is the first byte of the string in 16 bit. As a "print"
; command, the string is terminated by a LF (goes to new line)
prtline .macro
        lda #<\1
        sta k_str_l
        lda #>\1
        sta k_str_h
        jsr k_prtstr
.endm

; -----------------------------------------------------------------------------
; MACRO for printing a line feed. Use with ".invoke newline".
; Note this was previously a subroutine k_wrtlfcr
newline .macro
        lda #AscLF
        jsr k_wrtchr
.endm

;==============================================================================
; ASSEMBLER MACROS FOR TALI FORTH
;==============================================================================

; -----------------------------------------------------------------------------
; MACRO for moving (addr n) to TMPADR and TMPCNT.
; Use with ".invoke load_addrn"
; TODO get rid of this to make code more easy to read
load_addrn .macro
        lda $4,x       ; MSB of address
        sta TMPADR+1
        lda $3,x       ; LSB of address
        sta TMPADR

        lda $2,x       ; MSB of counter
        sta TMPCNT+1
        lda $1,x       ; LSB of counter
        sta TMPCNT
.endm

; -----------------------------------------------------------------------------
; MACRO for printing strings via the Forth routines
; Use with ".invoke fprint <string address>"
fprint .macro
        jsr l_lit
        .byte <\1
        .byte >\1
        jsr l_count
        jsr l_type
        jsr l_cr
.endm

;==============================================================================
; TESTING MACROS (NOT USED IN PRODUCTION CODE)
;==============================================================================
; All names start with "test"

; -----------------------------------------------------------------------------
; MACRO to print a single "a".
; Use with ".invoke testprta"
testprta .macro
        lda #'a'
        jsr f_putchr
.endm

; -----------------------------------------------------------------------------
; MACRO to save stack to $0333 and $0334
; Use with ".invoke teststack"
teststack .macro
        lda 1,x
        sta $0333
        lda 2,x
        sta $0334
.endm

; -----------------------------------------------------------------------------
; END
