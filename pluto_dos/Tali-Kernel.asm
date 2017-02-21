; -----------------------------------------------------------------------------
; KERNEL
; for the Übersquirrel Mark Zero
; Scot W. Stevenson <scot.stevenson@gmail.com>
;
; First version 19. Jan 2014
; This version  11. Feb 2015
; -----------------------------------------------------------------------------
; Very basic and thin software layer to provide a basis for the Forth system
; to run on.

; -----------------------------------------------------------------------------
; Used with the Ophis assembler and the py65mon simulator
; -----------------------------------------------------------------------------

; SIMULATOR LINES MARKED WITH "+PY65+", CHANGE THESE FOR PRODUCTION

;==============================================================================
; DEFINITIONS
;==============================================================================
; These should be changed by the user. Note that the Forth memory map is a
; separate file that needs to be changed as well. They are not combined
; into one definition file so it is easier to move Forth to a different system
; with its own kernel.

k_ramend = $7FFF   ; End of continuous RAM that starts at $0000
                   ; redefined by Forth

; -----------------------------------------------------------------------------
; Zero Page Defines
; -----------------------------------------------------------------------------
; $D0 to $EF are used by the kernel for booting, Packrat doesn't touch them

k_com1_l = $D0 ; lo byte for general kernel communication, first word
k_com1_h = $D1 ; hi byte for general kernel communication
k_com2_l = $D2 ; lo byte for general kernel communication, second word
k_com2_h = $D3 ; hi byte for general kernel communication
k_str_l  = $D4 ; lo byte of string address for print routine
k_str_h  = $D5 ; hi byte of string address for print routine
zp0 = $D6 ; General use ZP entry

; =============================================================================
; INITIALIZATION
; =============================================================================
; Kernel Interrupt Handler for RESET button, also boot sequence.

k_resetv:
        jmp k_init65c02 ; initialize CPU

ContPost65c02:
        jmp k_initRAM   ; initialize and clear RAM

ContPostRAM:
        jsr k_initIO    ; initialize I/O (ACIA, VIA)

        ; Print kernel boot message
        #newline
        #prtline ks_welcome
        #prtline ks_author
        #prtline ks_version

        ; Turn over control to Forth
        jmp FORTH

; -----------------------------------------------------------------------------
; Initialize 65c02. Cannot be a subroutine because we clear the stack
; pointer
k_init65c02:

        ldx #$FF        ; reset stack pointer
        txs

        lda #$00        ; clear all three registers
        tax
        tay

        pha             ; clear all flags
        plp
        sei             ; disable interrupts

        bra ContPost65c02

; -----------------------------------------------------------------------------
; Initialize system RAM, clearing from RamStr to RamEnd. Cannot be a
; subroutine because the stack is cleared, too. Currently assumes that
; memory starts at $0000 and is 32 kByte or less.
k_initRAM:
        lda #<k_ramend
        sta $00
        lda #>k_ramend  ; start clearing from the bottom
        sta $01         ; hi byte used for counter

        lda #$00
        tay

-       sta ($00),y     ; clear a page of the ram
        dey             ; wraps to zero
        bne -

        dec $01         ; next hi byte value
        bpl -           ; wrapping to $FF sets the 7th bit, "negative"

        stz $00         ; clear top bytes
        stz $01

        bra ContPostRAM


; -----------------------------------------------------------------------------
; Initialize the I/O: 65c51, 65c22
k_initIO:

        lda #<_IOTable          ; save start address of table
        sta k_com1_l
        lda #>_IOTable
        sta k_com1_h

        ; Change next value for different hardware
        ldx #$06                ; number of ports to initialize, ends when zero

_loop:
        ldy #$00                ; clear index

        lda (k_com1_l),y        ; get low and hi byte of register address
        sta k_com2_l
        iny
        lda (k_com1_l),y
        sta k_com2_h
        iny

        lda (k_com1_l),y        ; get value for register
        sta (k_com2_l)          ; output to port, only 65c02

        lda k_com1_l            ; move to next array entry
        clc
        adc #$03
        sta k_com1_l
        bcc +                   ; if we carried, incease hi byte as well
        inc k_com1_h

+       dex                     ; loop counter
        bne _loop

        rts

_IOTable:
        ; Each entry has three bytes: Address of register (lo, hi) and
        ; the initializing data
        ; TODO Enable interrupts

        ; -------------------------------
        ; ACIA 65c51 data (2 entries)

        .word siocon    ; ACIA control register, for configuration
        ; .byte %00010110 ; no rx IRQ, no tx IRQ, 8 data 1 stop, /64 -> 28.8 baud
        .byte %10010110 ; rx IRQ, no tx IRQ, 8 data 1 stop, /64 -> 28.8 baud
        ; .byte %10110110 ; rx IRQ, tx IRQ, 8 data 1 stop, /64 -> 28.8 baud

        ; -------------------------------
        ; VIA 65c22 data (4 entries)
        ; Reset makes all lines input, clears all internal registers

        .word VIAier    ; VIA Interrupt Enable Register
        .byte %01111111 ;  - disable all interrupts (automatic after reset)
        .word VIAddrA   ; VIA data dir reg Port A
        .byte $00       ;  - set all pins to input
        .word VIAddrB   ; VIA data dir reg Port B
        .byte $FF       ;  - set all pins to output
        .word VIApcr    ; VIA peripheral control register
        .byte $00       ;  - make all control lines inputs


; =============================================================================
; KERNEL FUNCTIONS AND SUBROUTINES
; =============================================================================
; These start with k_

; -----------------------------------------------------------------------------
; Kernel panic: Don't know what to do, so just reset the whole system.
; We redirect the NMI interrupt vector here to be safe, though this
; should never be reached.
k_nmiv:
k_panic:
        jmp k_resetv       ; Reset the whole machine

; -----------------------------------------------------------------------------
; Get a character from the ACIA
k_getchr:

        ; Hack for py65mon for testing, comment out for production code
        ; This is the blocking location of the py65mon
        ; +PY65+
        lda py65_getc
        rts

        ; Production code, polling version. Only reached if testing code
        ; disabled. Waits (blocks) until chacter received.
; *       lda ACIAst              ; check status register
        ; lsr                     ; data received?
        ; bcc -                   ; if no, loop
        ; lda ACIArx              ; get character
        ; rts

        ; Production code, interrupt version. Only reached if testing code
        ; and polled version disabled. Does not wait (block) until char
        ; received. Assumes that this is the only interrupt in the system
        ; TODO rewrite for various interrupts
        ; lda ACIArx              ; get character
        ; rts


; -----------------------------------------------------------------------------
; Write a character to the ACIA. Assumes character is in A. Because this is
; "write" command, there is no line feed at the end
k_wrtchr:

        ; Hack for py65mon for testing, comment out for production code
        ; +PY65+
        sta py65_putc
        rts

        ; Production code, polled. Only reached if testing code disabled.
        ; TODO change this to interrupt version
        pha                     ; save the character to print
        lda #%00000010          ; see if transmitter buffer is empty
-       bit ACIAst              ; check status register
        beq -                   ; if no, loop
        pla                     ; get character back
        sta ACIAtx              ; print
        rts

; -----------------------------------------------------------------------------
; Write a string to the ACIA. Assumes string address is in k_str.
; If we come here from k_prtstr, we add a line feed

k_wrtstr:
        stz zp0                 ; flag: don't add line feed
        bra +

k_prtstr:
        lda #$01                ; flag: add line feed
        sta zp0

+       phy                     ; save Y register
        ldy #$00                ; index

-       lda (k_str_l),y         ; get the string via address from zero page
        beq _done               ; if it is a zero, we quit and leave
        jsr k_wrtchr            ; if not, write one character
        iny                     ; get the next byte
        bra -

_done:
        lda zp0                 ; if this is a print command, add linefeed
        beq _leave
        #newline

_leave:
        ply
        rts


; -----------------------------------------------------------------------------
; Write characters to the VIA ports. TODO code these.


k_getchrVIAa:
        nop
        rts

k_getchrVIAb:
        nop
        rts

k_wrtchrVIAa:
        nop
        rts

k_wrtchrVIAb:
        nop
        rts


; =============================================================================
; KERNEL STRINGS
; =============================================================================
; Strings beginn with ks_ and are terminated by 0

; General OS strings
ks_welcome: .text "Booting Kernel for the Uberquirrel Mark Zero",0
ks_author:  .text "Scot W. Stevenson <scot.stevenson@gmail.com>",0
ks_version: .text "Kernel Version Alpha 004 (11. Feb 2015)",0

; =============================================================================
; END
