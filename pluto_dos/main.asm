* = $8000

; =============================================================================
; RTC
.include "zp_variables.asm"

;
; =============================================================================
; RTC
.include "rtc.asm"

; =============================================================================
; IDE
;.include "basic_ide_routines.asm"

; =============================================================================
; CFS 
;.include "cfs.asm"

; =============================================================================
; xmodem
.include "xmodem.asm"

; =============================================================================
; via subroutines 
.include "acia.asm"

; =============================================================================
; via subroutines 
.include "via.asm"

; =============================================================================
; KERNEL
.include "pluto_kernel.asm"

; =============================================================================
; LOAD ASSEMBLER MACROS
.include "macros.asm"

; =============================================================================

; END
