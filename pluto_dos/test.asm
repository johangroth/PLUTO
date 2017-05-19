
        * = $500
        CHIN = $82F5
        COUT = $8317
        COUT2 = $8314
        CROUT = $8335
        CR2 = $8332
        SPC2 = $8584
        SPC4 = $8581
        PRASC = $8489
        DOLLAR = $832D
        PRBYTE = $8496
        PRINDX = $84A7
        PROMPT = $84B4
        BEEP = $82CB
        DELAY1 = $8342
        DELAY2 = $8346
        SET = $855C
        TIMER = $855E
        RDLINE = $84ED
        BN2ASC = $82D3
        ASC2BN = $82AF
        HEXIN = $8357
        SAVREGS = $854E
        RESREGS = $8555
        INCINDEX = $83E9
        DECINDEX = $8324
        PROMPT2 = $86FF
        HEXIN2 = $8351
        HEXIN4 = $8355
        NMON = $8812
        COLDSTART = $87A8
        INTERRUPT = $8902
        ACIA = $7FE0
        VIA = $7FC0
        DS1511 = $7FA0

        .include "zp_variables.asm"
        .include "1511.asm"
        .include "1511_constants.asm"
        .include "utils.asm"

DEBUGRTC   .macro
        PHA
        PHX
        PHY
        LDA  #<INITTXT
        STA  INDEX
        LDA  #>INITTXT
        STA  INDEXH
        JSR  PROMPT2
        JSR  CROUT
        PLY
        PLX
        PLA
        BRA  ENDMACRO
INITTXT
        .null \@        ; Debug string goes here. .null directive will terminate the string.
ENDMACRO
        .endm
        
        STZ  TODBUF+WR_SECT
        LDA  #$5
        STA  TODBUF+WR_DOWT 
        LDA  #$19
        STA  TODBUF+WR_DATT
        LDA  #$5
        STA  TODBUF+WR_MON
        LDA  #$17
        STA  TODBUF+WR_YRLO
        LDA  #$20
        STA  TODBUF+WR_YRHI
        LDA  #$20
        STA  TODBUF+WR_HRST
        LDA  #$00
        STA  TODBUF+WR_MINT
        JSR  PUT_DATE_AND_TIME
        LDX  #$F
L1
        STZ  TODBUF,X
        DEX
        BPL  L1
;        RTS
        LDX  #$10
L2
        PHX
        JSR  GET_DATE_AND_TIME
        JSR  COMPRESS             ;Convert TODBUF to CFS compressed format
        JSR  PRINT_DATE_AND_TIME
        STZ  DELHI
        STZ  DELLO
        JSR  DELAY2
        PLX
        DEX
        BNE  L2
        RTS

PRINT_DATE_AND_TIME .proc
        LDA  TODBUF+WR_DATT
        JSR  BCDOUT
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_MON
        JSR  BCDOUT
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_YRHI
        JSR  BCDOUT
        LDA  TODBUF+WR_YRLO
        JSR  BCDOUT 
        
        LDA  #' '
        JSR  COUT
        LDA  TODBUF+WR_HRST
        
        
        JSR  BCDOUT
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_MINT
        JSR  BCDOUT
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_SECT
        JSR  BCDOUT
        JSR  CROUT
        RTS
        .pend

;================================================================================ 
; 
;alarm: SET AN ALARM 
; 
;    
;   Preparatory Ops: .X: 16 bits: alarm vector (3) 
;                    .Y: 16 bits: alarm time in secs (1,2) 
;                     
;   Returned Values: .A: entry value 
;                    .B: entry value 
;                    .X: entry value 
;                    .Y: entry value 
; 
;   MPU Flags: NVmxDIZC 
;              |||||||| 
;              ||||||++> entry values 
;              |||||+> 0 (IRQs on) 
;              +++++> entry values 
; 
;   Notes: 1) The alarm time is interpreted as the number of seconds in the 
;             future when the alarm will expire ("go off").  The minimum 
;             allowable alarm time is 2 seconds. 
; 
;          2) If the alarm time is less than 2 seconds a pending alarm will 
;             be canceled. 
; 
;          3) The alarm vector is the address of the code that will be ex- 
;             ecuted when the alarm goes off.  If the vector is $0000 no 
;             alarm will be set. 
; 
;          4) This function results in a jump to the alarm vector when the 
;             alarm goes of.  Calling a subroutine after setting an alarm 
;             will leave the stack in an unbalanced state if the alarm goes 
;             off before the subroutine returns.  USE CAUTION! 
; 
;   Examples: longx           ;16 bit .X & .Y 
;             ldxw alarmvec   ;alarm vector 
;             ldyw 600        ;600 secs 
;             jsr alarm       ;set the alarm 
;    
; 
alarm   .proc
        .pend

; 
;================================================================================ 
; 
;constime: SET CONSOLE TIME 
; 
constime    .proc
        .pend

;
; Read date and time and store in compressed format
;================================================================================ 
; 
;GET_DATE_AND_TIME: READ RTC DATE & TIME REGISTERS 
; 
;    
;   Preparatory Ops: None 
; 
;   Returned Values: .A: entry value 
;                    .X: entry value 
;                    .Y: entry value 
; 
;                    Storage location will contain 4 
;                    bytes as follows: 
; 
; Packed Creation / Modification time bytes / bits:
; +============+============+===+===============+============+===+===+===+===+
; | Byte / Bit |     7      | 6 |       5       |     4      | 3 | 2 | 1 | 0 |
; +============+============+===+===============+============+===+===+===+===+
; | Byte 0     | Month HIGH     | Second (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 1     | Month LOW      | Minute (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 2     | Hour HIGH      | Year (0-63)                                |
; +------------+----------------+---------------+----------------------------+
; | Byte 3     | Hour LOW                       | Day (1-31)                 |
; +------------+--------------------------------+----------------------------+
; Month (1-12), Hour (0-23). Year begins from 1980, so 2001 is 21.
; 
;   MPU Flags: NVmxDIZC 
;              |||||||| 
;              ++++++++> entry values 
; 
;   Example: ldx #<todbuf 
;            ldy #>todbuf 
;            jsr getdtr 
;    
; 
GET_DATE_AND_TIME   .proc
        PHA
        PHX
        LDA  CRB_RTC    ;Load control register B
        PHA             ;Preserve control register B
        AND  #D11SUMSK  ;Turn off update of registers
        STA  CRB_RTC    
        LDX  #0         ;Initialise index
L1
;        #DEBUGRTC "RTC"
        LDA  IO_RTC,X   ;Read time data
        CPX  #WR_MON    ;Month byte contains control bits
        BNE  L2
        AND  #D11EMMSK  ;Get rid of control bits
L2      STA  TODBUF,X
        INX
        CPX  #WR_SECA   ;IF X != Alarm seconds register
        BNE  L1         ;  GOTO L1, next register
;        JSR  COMPRESS   ;Convert TODBUF (BCD format) to CFS compressed date format as described above
        PLA             ;  ELSE, we're done 
        ORA  #%10000000 ; TEMP FIX FOR REGISTER UPDATE
        STA  CRB_RTC    ;  restore all registers
        PLX
        PLA
        RTS
        .pend

; Convert TODBUF to compressed binary format 
COMPRESS    .proc
        LDA  TODBUF+WR_SECT     ;Get seconds
        STZ  BCDNUM
        STA  BCDNUML
        JSR  BCD2BIN            ;Result in BINOUT
        LDA  BINOUTL
        STA  TOD
        LDA  TODBUF+WR_MON      ;Get month
        STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        PHA                     ;Preserve original value
        AND  #%00001100         ;Month high
        ASL                     ;Move month high to bit 6 and 7
        ASL
        ASL
        ASL
        ORA  TOD                ;Merge seconds and month high
        STA  TOD                ;Store month high and second (0-59)
        LDA  TODBUF+WR_MINT     ;Load minute
        STA  BCDNUML
        JSR  BCD2BIN            ;Convert to binary, result is in BINOUT
        LDA  BINOUTL
        STA  TOD+1
        PLA                     ;Restore month value
        AND  #%00000011         ;Remove everything but the low byte (the AND might be redunant).
        ASL                     ;Move month low to bit 6 and 7
        ASL
        ASL
        ASL
        ASL
        ASL
        ORA  TOD+1              ;Merge minutes and month low
        STA  TOD+1              ;Store month low and minute (0-59)

        ;Convert year bcd digits to binary and substract 1980 
        LDA  TODBUF+WR_YRLO
        STA  BCDNUML
        LDA  TODBUF+WR_YRHI
        STA  BCDNUM
        JSR  BCD2BIN
        SEC
        LDA  BINOUTL            ;Time starts at 1980 ($7BC) so substract that from year
        SBC  #$BC
        STA  TOD+2
        LDA  TODBUF+WR_HRST
        STZ  BCDNUM
        STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        PHA
        AND  #%00011000         ;Hour high
        ASL                     ;Move hour high to bit 6 and 7
        ASL
        ASL
        ORA  TOD+2              ;Merge year and hour high
        STA  TOD+2              ;Store year and hour high 
        LDA  TODBUF+WR_DATT     ;Load date (1-31)
        STZ  BCDNUM
        STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        STA  TOD+3
        PLA
        AND  #%00000111         ;Keep three lower bits of month
        ASL
        ASL
        ASL
        ASL
        ASL
        ORA  TOD+3              ;Merge date and month low
        STA  TOD+3              ;Store date and month low
        RTS        
        .pend



; 
;================================================================================ 
; 
;getutim: GET SYSTEM UP TIME 
; 
;    
;   Preparatory Ops: .X: 16 bits: storage location 
; 
;   Returned Values: .A: entry value 
;                    .B: entry value 
;                    .X: entry value 
;                    .Y: entry value 
; 
;   MPU Flags: NVmxDIZC 
;              |||||||| 
;              ||||||++> entry value 
;              |||||+> 0 
;              +++++> entry value 
;    
; 
getutim .proc
        .pend

; 
;================================================================================ 
; 
;putdtr: WRITE RTC DATE & TIME REGISTERS 
; 
;    
;   Preparatory Ops: Fill TODBUF with data 
; 
;                    TODBUF must contain 8 BCD values in 
;                    the following order: 
; 
;                    Offset  Content 
;                    -------------- 
;                      $00   seconds     ($00-$59) 
;                      $01   minutes     ($00-$59) 
;                      $02   hours       ($00-$23) 
;                      $03   day-of-week ($01-$07) 
;                      $04   date        ($01-$31) 
;                      $05   month       ($01-$12) 
;                      $06   year LSB    ($00-$99) 
;                      $07   year MSB    ($00-$39) 
;                    -------------- 
; 
;   Returned Values: .A: entry value 
;                    .X: entry value 
;                    .Y: entry value 
; 
;   MPU Flags: NVmxDIZC 
;              |||||||| 
;              ++++++++> entry values 
; 
; 
PUT_DATE_AND_TIME  .proc
        PHA
        PHX
        PHY
        LDA  CRB_RTC    ;Load control register B
        PHA             ;Preserve control register B
        AND  #D11SUMSK  ;Turn off update of registers
        STA  CRB_RTC    
        LDX  #WR_YRHI   ;Initialise index
L1
;        #DEBUGRTC "RTC"
        LDA  TODBUF,X
        CPX  #WR_MON    ;IF X = month register
        BNE  L2         ;  GOTO L1 (month register contains control bits)
        LDA  IO_RTC,X   ;Read in month from RTC
        AND  #D11ECMSK  ;Clear out month data
        ORA  TODBUF,X   ;Copy in month data from TODBUF
L2
        STA  IO_RTC,X   ;Update register
        DEX
        BPL  L1         ;Take care of next register
        PLA             ;Restore control register b
        ORA  #%10000000 ;temp fix for register update
        STA  CRB_RTC    ;Turn on update of registers
        PLY
        PLX
        PLA
        RTS
        .pend

; 
;================================================================================ 
; 
;utdelay: GENERATE USER-DEFINED TIME DELAY 
; 
;    
;   Preparatory Ops: .A: 16 bit delay time in secs 
; 
;   Returned Values: .A: entry value 
;                    .B: entry value 
;                    .X: entry value 
;                    .Y: entry value 
; 
;   MPU Flags: NVmxDIZC 
;              |||||||| 
;              ++++++++> entry values 
; 
;   Notes: 1) Delay time is approximate. 
;          2) A delay time of zero will cause an 
;             immediate exit. 
; 
;   Examples: longa           ;16 bit .A 
;             lda #600        ;600 secs 
;             jsr utdelay 
; 
;             or... 
; 
;             shorta          ;8 bit .A 
;             lda #>600       ;600 secs MSB in .A 
;             xba             ;transfer to .B 
;             lda #<600       ;600 secs LSB in .A 
;             jsr utdelay 
;    
; 
utdelay .proc
        .pend


