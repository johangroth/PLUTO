; XMODEM/CRC Sender/Receiver for the 65C02
;
; By Daryl Rictor Aug 2002
;
; A simple file transfer program to allow transfers between the SBC and a
; console device utilizing the x-modem/CRC transfer protocol.  Requires
; ~1200 bytes of either RAM or ROM, 132 bytes of RAM for the receive buffer,
; and 12 bytes of zero page RAM for variable storage.
;
;**************************************************************************
; This implementation of XMODEM/CRC does NOT conform strictly to the
; XMODEM protocol STAndard in that it (1) does not accurately time character
; reception or (2) fall back to the Checksum mode.

; (1) For timing, it uses a crude timing loop to provide approximate
; delays.  These have been caliBRAted against a 1MHz CPU clock.  I have
; found that CPU clock speed of up to 5MHz also work but may not in
; every case.  Windows HyperTerminal worked quite well at both speeds!
;
; (2) Most modern terminal programs support XMODEM/CRC which can detect a
; wider range of transmission errors so the fallback to the simple checksum
; calculation was not implemented to save space.
;**************************************************************************
;
; Files transferred via XMODEM-CRC will have the load address contained in
; the first two bytes in little-endian format:
;  FIRST BLOCK
;     offset(0) = lo(load Start address),
;     offset(1) = hi(load Start address)
;     offset(2) = data byte (0)
;     offset(n) = data byte (n-2)
;
; Subsequent blocks
;     offset(n) = data byte (n)
;
; One note, XMODEM send 128 byte blocks.  If the block of memory that
; you wish to save is smaller than the 128 byte block boundary, then
; the last block will be padded with zeros.  Upon reloading, the
; data will be written back to the original location.  In addition, the
; padded zeros WILL also be written into RAM, which could overwrite other
; data.
;
;-------------------------- The Code ----------------------------
;
; zero page variables (adjust these to suit your needs)
;
;
        lastblk = $a5       ; flag for last block
        blkno = $a6         ; block number
        errcnt = $a7        ; error counter 10 is the limit
        bflag = $a7         ; block flag

        crc = $a8           ; CRC lo byte  (two byte variable)
        crch = $a9          ; CRC hi byte

        ptr = INDEX         ; data pointer (two byte variable)
        ptrh = INDEXH       ;   "    "

        eofp = TEMP2        ; end of file address pointer (2 bytes)
        eofph = TEMP2H      ;  "    "   "   "
        retry = $ae         ; retry counter
        retry2 = $af        ; 2nd counter

;
;
; non-zero page variables and buffers
;
;
        Rbuff = $0300       ; temp 132 byte receive buffer
                        ;(PLAce anywhere, page aligned)
;
;
;  tables and conSTAnts
;
;
; The crclo & crchi labels are used to point to a lookup table to calculate
; the CRC for the 128 byte data blocks.  There are two implementations of these
; tables.  One is to use the tables INCluded (defined towards the end of this
; file) and the other is to build them at run-time.  If building at run-time,
; then these two labels will need to be un-commented and DEClared in RAM.
;
;crclo      =   $7D00       ; Two 256-byte tables for quick lookup
;crchi      =   $7E00       ; (should be page-aligned for speed)
;
;
;
; XMODEM Control Character ConSTAnts
        SOH = $01       ; Start block
        EOT = $04       ; end of text marker
        ACK = $06       ; good block acknowledged
        NAK = $15       ; bad block acknowledged
        CAN = $18       ; cancel (not STAndard, not supported)
        CR = $0d        ; carriage return
        LF = $0a        ; line feed
        ESC = $1b       ; ESC to exit

;
;^^^^^^^^^^^^^^^^^^^^^^ Start of Program ^^^^^^^^^^^^^^^^^^^^^^
;
; Xmodem/CRC transfer routines
; By Daryl Rictor, August 8, 2002
;
; v1.0  released on Aug 8, 2002.
;
;;;     *=  $db00 ;;;Start of program (adjust to your needs)

;
; Enter this routine with the beginning address stored in the zero page address
; pointed to by ptr & ptrh and the ending address stored in the zero page address
; pointed to by eofp & eofph.
;
;
UPLOAD  .proc
XModemSend:
        JSR MONPROHILO  ; Reset Prompt pointers
        LDA #$0f                ; send CR, LF, "Upload ..." to terminal
        JSR PROMPT
        JSR MONPROHILO
        LDA #$11        ; Send "address: " to terminal
        JSR Prompt
        LDA #$04        ; Request upload Start address input from terminal
        JSR HEXIN
        TXA             ; GOTO EXITUPLOAD IF no digits were entered
        BEQ EXITUPLOAD
        LDA INDEX       ; ELSE, save Start address on STACK
        PHA
        LDA indexh
        PHA
        JSR CROUT       ; Send CR, LF to terminal
        JSR MONPROHILO  ; Reset Prompt pointers
        LDA #$12        ; Send "Length: " to terminal
        JSR PROMPT
        LDA #$04        ; Request upload length from terminal
        JSR HEXIN
        TXA             ; GOTO DOUPLOAD IF any digits were entered
        BNE DOUPLOAD
        PLA             ; ELSE, pull Start address from STACK, discard
        PLA
EXITUPLOAD:
        RTS

DOUPLOAD:
        PLX             ; High byte
        PLY             ; Low byte
        CLC
        TYA
        ADC INDEX       ; Add Start address to length: find end address
        STA TEMP2
        TXA
        ADC INDEXH
        STA TEMP2H      ; TEMP2 = end address pointer
        TXA
        STA INDEXH      ; INDEX = Start address pointer
        TYA
        STA INDEX

        LDA #$00        ;
        STA errcnt      ; error counter set to 0
        STA lastblk     ; set flag to false
        LDA #$01        ;
        STA blkno       ; set block # to 1

Wait4CRC:
        LDA #$ff        ; 3 SEConds
        STA retry2      ;
        JSR CHIN        ; wait for something to come in...
        ;; BCC  Wait4CRC
        CMP #"C"        ; is it the "C" to Start a CRC xfer?
        BEQ SetstAddr   ; yes
        CMP #ESC        ; is it a cancel? <Esc> Key
        BNE Wait4CRC    ; No, wait for another character
        JMP PrtAbort    ; Print abort msg and exit

SetstAddr:
        LDY #$00        ; init data block offset to 0
        LDX #$04        ; preload X to Receive buffer
        LDA #$01        ; manually load blk number
        STA Rbuff       ; into 1st byte
        LDA #$FE        ; load 1's comp of block #
        STA Rbuff+1     ; into 2nd byte
        LDA ptr         ; load low byte of Start address
        STA Rbuff+2     ; into 3rd byte
        LDA ptrh        ; load hi byte of Start address
        STA Rbuff+3     ; into 4th byte
        BRA Ldbuff1     ; jump into buffer load routine

LdBuffer:
        LDA Lastblk     ; Was the last block sent?
        BEQ LdBuff0     ; no, send the next one
        JMP Done        ; yes, we're done

LdBuff0:
        LDX #$02        ; init pointers
        LDY #$00        ;
        INC Blkno       ; INC block counter
        LDA Blkno       ;
        STA Rbuff       ; save in 1st byte of buffer
        EOR #$FF        ;
        STA Rbuff+1     ; save 1's comp of blkno next

LdBuff1:
        LDA (ptr),y     ; save 128 bytes of data
        STA Rbuff,x     ;

LdBuff2:
        SEC             ;
        LDA eofp        ;
        SBC ptr         ; Are we at the last address?
        BNE LdBuff4     ; no, INC pointer and continue
        LDA eofph       ;
        SBC ptrh        ;
        BNE LdBuff4     ;
        INC LastBlk     ; Yes, Set last byte flag

LdBuff3:
        INX             ;
        CPX #$82        ; Are we at the end of the 128 byte block?
        BEQ SCalcCRC    ; Yes, calc CRC
        LDA #$00        ; Fill rest of 128 bytes with $00
        STA Rbuff,x     ;
        BEQ LdBuff3     ; Branch always

LdBuff4:
        INC ptr         ; Inc address pointer
        BNE LdBuff5     ;
        INC ptrh        ;

LdBuff5:
        INX             ;
        CPX #$82        ; last byte in block?
        BNE LdBuff1     ; no, get the next

SCalcCRC:
        JSR CalcCRC
        LDA crch        ; save Hi byte of CRC to buffer
        STA Rbuff,y     ;
        INY             ;
        LDA crc         ; save lo byte of CRC to buffer
        STA Rbuff,y     ;

Resend:
        LDX #$00        ;
        LDA #SOH
        JSR COUT        ; send SOH

SendBlk:
        LDA Rbuff,x     ; Send 132 bytes in buffer to the console
        JSR COUT        ;
        INX             ;
        CPX #$84        ; last byte?
        BNE SendBlk     ; no, get next
        LDA #$FF        ; yes, set 3 SECond delay
        STA retry2      ; and
        JSR ChIn        ; Wait for Ack/Nack
        ;; BCC  Seterror    ; No chr received after 3 SEConds, resend
        CMP #ACK        ; Chr received... is it:
        BEQ LdBuffer    ; ACK, send next block
        CMP #NAK        ;
        BEQ Seterror    ; NAK, INC errors and resend
        CMP #ESC        ;
        BEQ PrtAbort    ; Esc pressed to abort
                        ; fall through to error counter
Seterror:
        INC errcnt      ; Inc error counter
        LDA errcnt      ;
        CMP #$0A        ; are there 10 errors? (Xmodem spec for failure)
        BNE Resend      ; no, resend block

PrtAbort:
        JSR Flush       ; yes, too many errors, flush buffer,
        JMP Print_Err   ; print error msg and exit

Done:
        JMP Print_Good  ; All Done..Print msg and exit
                                  .pend

;
;
;
;DOWNLOAD .proc
XModemReceive .proc
        JSR MONPROHILO  ; Reset the monitor prompt pointer
        LDA #$09
        JSR PROMPT      ; send prompt and info
        LDA #$01
        STA blkno       ; set block # to 1
        STA bflag       ; set flag to get address from block 1

StartCrc:
        LDA #"C"        ; "C" Start with CRC mode
        JSR COUT        ; send it
        LDA #$FF
        STA retry2      ; set loop counter for ~3 SEC delay
        STZ crc
        STZ crch        ; init CRC value
        JSR CHIN        ; wait for input
GotByte:
        CMP #ESC        ; quitting?
        BNE GotByte1    ; no
;   LDA #$FE            ; Error code in "A" of desired
        RTS             ; YES - do BRK or change to RTS if desired

GotByte1:
        CMP #SOH        ; Start of block?
        BEQ BegBlk      ; yes
        CMP #EOT        ;
        BNE BadCrc      ; Not SOH or EOT, so flush buffer & send NAK
        JMP RDoneNow    ; EOT - all done!

StartBlk:
        JSR CHIN        ; get first byte of block
        
BegBlk:
        LDX #$00

GetBlk:
        JSR CHIN        ; get next character

GetBlk2:
        STA Rbuff,x     ; good char, save it in the rcv buffer
        INX             ; INC buffer pointer
        CPX #$84        ; <01> <FE> <128 bytes> <CRCH> <CRCL>
        BNE GetBlk      ; get 132 characters
        LDX #$00        ;
        LDA Rbuff,x     ; get block # from buffer
        CMP blkno       ; compare to expected block #
        BEQ GoodBlk1    ; matched!
        JSR Print_Err   ; Unexpected block number - abort
        JSR Flush       ; mismatched - flush buffer and then do BRK
;       LDA #$FD        ; put error code in "A" if desired
        RTS             ; unexpected block # - fatal error - BRK or RTS

GoodBlk1:
        EOR #$ff        ; 1's comp of block #
        INX             ;
        CMP Rbuff,x     ; compare with expected 1's comp of block #
        BEQ GoodBlk2    ; matched!
        JSR Print_Err   ; Unexpected block number - abort
        JSR Flush       ; mismatched - flush buffer and then do BRK
;       LDA #$FC        ; put error code in "A" if desired
        RTS             ; bad 1's comp of block#

GoodBlk2:
        JSR CalcCRC     ; calc CRC
        LDA Rbuff,y     ; get hi CRC from buffer
        CMP crch        ; compare to calculated hi CRC
        BNE BadCrc      ; bad crc, send NAK
        INY             ;
        LDA Rbuff,y     ; get lo CRC from buffer
        CMP crc         ; compare to calculated lo CRC
        BEQ GoodCrc     ; good CRC

BadCrc:
        JSR Flush       ; flush the input port
        LDA #NAK        ;
        JSR COUT        ; send NAK to resend block
        BRA StartBlk    ; Start over, get the block again

GoodCrc:
        LDX #$02        ;
        LDA blkno       ; get the block number
        CMP #$01        ; 1st block?
        BNE CopyBlk     ; no, copy all 128 bytes
        LDA bflag       ; is it really block 1, not block 257, 513 etc.
        BEQ CopyBlk     ; no, copy all 128 bytes
        LDA Rbuff,x     ; get target address from 1st 2 bytes of blk 1
        STA ptr         ; save lo address
        INX             ;
        LDA Rbuff,x     ; get hi address
        STA ptr+1       ; save it
        INX             ; point to first byte of data
        DEC bflag       ; set the flag so we won't get another address

CopyBlk:
        LDY #$00        ; set offset to zero

CopyBlk3:
        LDA Rbuff,x     ; get data byte from buffer
        STA (ptr),y     ; save to target
        INC ptr         ; point to next address
        BNE CopyBlk4    ; did it step over page boundary?
        INC ptr+1       ; adjust high address for page crossing

CopyBlk4:
        INX             ; point to next data byte
        CPX #$82        ; is it the last byte
        BNE CopyBlk3    ; no, get the next one

IncBlk:
        INC blkno       ; done.  Inc the block #
        LDA #ACK        ; send ACK
        JSR COUT        ;
        JMP StartBlk    ; get next block

RDoneNow:
        LDA #ACK        ; last block, send ACK and exit.
        JSR COUT        ;
        JSR Flush       ; get leftover characters, if any
        JSR Print_Good  ;
        RTS
       .pend     
;
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;======================================================================
;  I/O Device Specific Routines
;
;  Two routines are used to communicate with the I/O device.
;
; "CHIN in SyMonIII" routine will scan the input buffer for a character.  It will
; return the character in the "A" register if one was present.
;
; "COUT in SyMonIII" routine will write one byte to the output port.  Its alright
; if this routine waits for the port to be ready.  its assumed that the
; character was send upon return from this routine.
;
; Here is an example of the routines used for a STAndard 6551 ACIA.
; You would call the ACIA_Init prior to running the xmodem transfer
; routine.
;
;
; input chr from ACIA (no waiting)
;

;=========================================================================
;
; subroutines
;
;
;

;
;========================================================================
; Flush: In case of any error, or we are done, flush the input buffer 
;        by making both INCNT and OUTCNT zero. CHIN will then loop until
;        a character is recevied.
;
Flush   .proc
        STZ INCNT       ; If INCNT equals OUTCNT there are no characters to read  
        STZ OUTCNT      ; so CHIN will loop until a character is received.
        RTS
        .pend
;
PrintMsg    .proc
        LDA #<Msg
        STA INDEX
        LDA #>Msg
        STA INDEXH
        JMP PROMPT2
        .pend
Msg:
        .text   "Begin XMODEM/CRC transfer.  Press <Esc> to abort..."
        .byte   CR, LF
        .byte   0

; PRINT Error message
Print_Err   .proc
        LDA #<ErrMsg
        STA INDEX
        LDA #>ErrMsg
        STA INDEXH
        JMP PROMPT2
        .pend

ErrMsg:
        .text   "Transfer Error!"
        .BYTE   CR, LF
        .byte   0

; PRINT Good Transfer message
Print_Good  .proc
        LDA #<GoodMsg
        STA INDEX
        LDA #>GoodMsg
        STA INDEXH
        JMP PROMPT2
        .pend
GoodMsg:
        .byte   EOT,CR,LF,EOT,CR,LF,EOT,CR,LF,CR,LF
        .text   "Transfer Successful!"
        .byte   CR, LF
        .byte   0


;
;
;=========================================================================
;
;
;  CRC subroutines
;
;
CalcCRC .proc
        LDA #$00        ; yes, calculate the CRC for the 128 bytes
        STA crc         ;
        STA crch        ;
        LDY #$02        ;

CalcCRC1:
        LDA Rbuff,y     ;
        EOR crc+1       ; Quick CRC computation with lookup tables
        TAX             ; updates the two bytes at crc & crc+1
        LDA crc         ; with the byte send in the "A" register
        EOR CRCHI,X
        STA crc+1
        LDA CRCLO,X
        STA crc
        INY             ;
        CPY #$82        ; done yet?
        BNE CalcCRC1    ; no, get next
        RTS             ; y=82 on exit
        .pend
;
; The following tables are used to calculate the CRC for the 128 bytes
; in the xmodem data blocks.  You can use these tables if you PLAn to
; store this program in ROM.  If you choose to build them at run-time,
; then just delete them and define the two labels: crclo & crchi.
; low byte CRC lookup table (should be page aligned for speed)
    ;;      *= $DE00
crclo:
        .byte $00,$21,$42,$63,$84,$A5,$C6,$E7,$08,$29,$4A,$6B,$8C,$AD,$CE,$EF
        .byte $31,$10,$73,$52,$B5,$94,$F7,$D6,$39,$18,$7B,$5A,$BD,$9C,$FF,$DE
        .byte $62,$43,$20,$01,$E6,$C7,$A4,$85,$6A,$4B,$28,$09,$EE,$CF,$AC,$8D
        .byte $53,$72,$11,$30,$D7,$F6,$95,$B4,$5B,$7A,$19,$38,$DF,$FE,$9D,$BC
        .byte $C4,$E5,$86,$A7,$40,$61,$02,$23,$CC,$ED,$8E,$AF,$48,$69,$0A,$2B
        .byte $F5,$D4,$B7,$96,$71,$50,$33,$12,$FD,$DC,$BF,$9E,$79,$58,$3B,$1A
        .byte $A6,$87,$E4,$C5,$22,$03,$60,$41,$AE,$8F,$EC,$CD,$2A,$0B,$68,$49
        .byte $97,$B6,$D5,$F4,$13,$32,$51,$70,$9F,$BE,$DD,$FC,$1B,$3A,$59,$78
        .byte $88,$A9,$CA,$EB,$0C,$2D,$4E,$6F,$80,$A1,$C2,$E3,$04,$25,$46,$67
        .byte $B9,$98,$FB,$DA,$3D,$1C,$7F,$5E,$B1,$90,$F3,$D2,$35,$14,$77,$56
        .byte $EA,$CB,$A8,$89,$6E,$4F,$2C,$0D,$E2,$C3,$A0,$81,$66,$47,$24,$05
        .byte $DB,$FA,$99,$B8,$5F,$7E,$1D,$3C,$D3,$F2,$91,$B0,$57,$76,$15,$34
        .byte $4C,$6D,$0E,$2F,$C8,$E9,$8A,$AB,$44,$65,$06,$27,$C0,$E1,$82,$A3
        .byte $7D,$5C,$3F,$1E,$F9,$D8,$BB,$9A,$75,$54,$37,$16,$F1,$D0,$B3,$92
        .byte $2E,$0F,$6C,$4D,$AA,$8B,$E8,$C9,$26,$07,$64,$45,$A2,$83,$E0,$C1
        .byte $1F,$3E,$5D,$7C,$9B,$BA,$D9,$F8,$17,$36,$55,$74,$93,$B2,$D1,$F0

; hi byte CRC lookup table (should be page aligned for speed)
    ;; *= $DF00
crchi:
        .byte $00,$10,$20,$30,$40,$50,$60,$70,$81,$91,$A1,$B1,$C1,$D1,$E1,$F1
        .byte $12,$02,$32,$22,$52,$42,$72,$62,$93,$83,$B3,$A3,$D3,$C3,$F3,$E3
        .byte $24,$34,$04,$14,$64,$74,$44,$54,$A5,$B5,$85,$95,$E5,$F5,$C5,$D5
        .byte $36,$26,$16,$06,$76,$66,$56,$46,$B7,$A7,$97,$87,$F7,$E7,$D7,$C7
        .byte $48,$58,$68,$78,$08,$18,$28,$38,$C9,$D9,$E9,$F9,$89,$99,$A9,$B9
        .byte $5A,$4A,$7A,$6A,$1A,$0A,$3A,$2A,$DB,$CB,$FB,$EB,$9B,$8B,$BB,$AB
        .byte $6C,$7C,$4C,$5C,$2C,$3C,$0C,$1C,$ED,$FD,$CD,$DD,$AD,$BD,$8D,$9D
        .byte $7E,$6E,$5E,$4E,$3E,$2E,$1E,$0E,$FF,$EF,$DF,$CF,$BF,$AF,$9F,$8F
        .byte $91,$81,$B1,$A1,$D1,$C1,$F1,$E1,$10,$00,$30,$20,$50,$40,$70,$60
        .byte $83,$93,$A3,$B3,$C3,$D3,$E3,$F3,$02,$12,$22,$32,$42,$52,$62,$72
        .byte $B5,$A5,$95,$85,$F5,$E5,$D5,$C5,$34,$24,$14,$04,$74,$64,$54,$44
        .byte $A7,$B7,$87,$97,$E7,$F7,$C7,$D7,$26,$36,$06,$16,$66,$76,$46,$56
        .byte $D9,$C9,$F9,$E9,$99,$89,$B9,$A9,$58,$48,$78,$68,$18,$08,$38,$28
        .byte $CB,$DB,$EB,$FB,$8B,$9B,$AB,$BB,$4A,$5A,$6A,$7A,$0A,$1A,$2A,$3A
        .byte $FD,$ED,$DD,$CD,$BD,$AD,$9D,$8D,$7C,$6C,$5C,$4C,$3C,$2C,$1C,$0C
        .byte $EF,$FF,$CF,$DF,$AF,$BF,$8F,$9F,$6E,$7E,$4E,$5E,$2E,$3E,$0E,$1E
;
;
; End of File
;
