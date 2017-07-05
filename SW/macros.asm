; -----------------------------------------------------------------------------
; MACROS
;==============================================================================
; ASSEMBLER MACROS FOR THE KERNEL
;==============================================================================

; -----------------------------------------------------------------------------
; MACRO to print out debug information
; Use with #debug <number>
DEBUG   .macro
        JSR  SAVREGS
        LDA  #<DEBUGTEXT
        STA  INDEX
        LDA  #>DEBUGTEXT
        STA  INDEXH
        JSR  PROMPT2
        JSR  CROUT
        JSR  RESREGS
        BRA  ENDDEBUGMACRO
DEBUGTEXT
        .null \@
ENDDEBUGMACRO
        .endm

; -----------------------------------------------------------------------------
; END
