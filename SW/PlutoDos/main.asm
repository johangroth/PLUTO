        * = $8000
        .cpu "w65c02"

; =============================================================================
; LOAD ASSEMBLER MACROS
;.include "macros.asm"

; =============================================================================
; Zero page variables
;.include "zp_variables.asm"

;
; =============================================================================
; RTC main file
.include "rtc.asm"

; =============================================================================
; IDE
.include "ide_routines.asm"

; =============================================================================
; CFS (Commodore File System, part of IDE64 project)
;.include "cfs.asm"

; =============================================================================
; xmodem
.include "xmodem.asm"

; =============================================================================
; ascii_to_binary subroutines
.include "ascii_to_bin.asm"

; =============================================================================
; binary to ascii subroutines
.include "bin_to_ascii.asm"

; =============================================================================
; acia subroutines
.include "acia.asm"

; =============================================================================
; via subroutines
.include "via.asm"

; =============================================================================
; sound subroutines
.include "sound.asm"

; =============================================================================
; utils subroutines (bcd->bin->bcd and out)
;.include "utils.asm"

; =============================================================================
; Monitor
.include "monitor.asm"

; =============================================================================
; Mini-assembler
;.include "miniassembler.asm"

; =============================================================================
; KERNEL
.include "bios.asm"

; =============================================================================
; END
.end
