;IDE variables
    master_slave = $9e
    delay_counter = $9f
    sector_buffer_ptr = $a0

    ide_lba0 = $a1			; LBA of desired sector LSB
    ide_lba1 = ide_lba0 + 1
    ide_lba2 = ide_lba1 + 1
    ide_lba3 = ide_lba2 + 1 	; - LBA of desired sector MSB

    ide_status = $a5

;16-bit variables
    BCDNUM  = $A6       ;High byte BCD number to be converted
    BCDNUML = BCDNUM+1  ;Low byte
    BINOUT  = $A8       ;High byte binary out after BCD conversion
    BINOUTL = BINOUT+1  ;Low byte

;8-bit variables
    STATUSREGISTER = $AB
    VIATEMP  = $AC
    SAVEACC  = $AD
    SAVEX    = $AE
    SAVEY    = $AF

;14 byte buffer
    INBUFF   = $B0      ;14 bytes ($B0-$BD)
;
;16-bit variables:
    COMLO   = $BE
    COMHI   = COMLO+1
    DELLO   = $C0
    DELHI   = DELLO+1
    PROLO   = $C2
    PROHI   = PROLO+1
    BUFADR  = $C4
    BUFADRH = BUFADR+1
    TEMP2   = $C6
    TEMP2H  = TEMP2+1
    INDEX   = $C8
    INDEXH  = INDEX+1
    TEMP3   = $CA
    TEMP3H  = TEMP3+1
;
;8-bit variables and constants:
    TEMP     = $CC
    BUFIDX   = $CD
    BUFLEN   = $CE
    BSPIND   = $CF
    IDX      = $D0
    IDY      = $D1
    SCNT     = $D2
    OPLO     = $D3
    OPHI     = $D4
    STEMP    = $D5
    RT1      = $D6
    RT2      = $D7
    SETIM    = $D8
    LOKOUT   = $D9
    ACCUM    = $DA
    XREG     = $DB
    YREG     = $DC
    SREG     = $DD
    PREG     = $DE
    POINTER  = $DF
    HPHANTOM = $00E0    ; HPHANTOM MUST be located (in target memory) immediatly below the HEX0AND1 variable
    HEX0AND1 = $E1
    HEX2AND3 = $E2
    HEX4AND5 = $E3
    HEX6AND7 = $E4
    DPHANTOM = $00E4    ; DPHANTOM MUST be located (in target memory) immediatly below the DEC0AND1 variable
    DEC0AND1 = $E5
    DEC2AND3 = $E6
    DEC4AND5 = $E7
    DEC6AND7 = $E8
    DEC8AND9 = $E9
    INQTY    = $EA
    INCNT    = $EB
    OUTCNT   = $EC
    AINTSAV  = $ED
    XINTSAV  = $EE
    YINTSAV  = $EF
