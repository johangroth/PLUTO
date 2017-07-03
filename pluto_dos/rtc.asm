
        .INCLUDE "1511.asm"
        .INCLUDE "1511_constants.asm"

;================================================================================
;
;MAXIM DS1511 WATCHDOG TIMER INITIALIZATION DATA
;
;       These tables consist of register initialization bit patterns & corresp-
;       onding register offsets, & are read backwards,  requiring that register
;       values be in the reverse order in which they should be set up.
;
;       Caution should be exercised in changing the order of these  tables,  as
;       doing so may cause the device to malfunction.  Code at the end of these
;       tables will emit an error message if there is a  mismatch  between  the
;       number of registers & number of parameters.
;
;
;       registers...
;
rtcreg   .byte wr_crb          ;control B               $0f
         .byte wr_seca         ;alarm sec               $08
         .byte wr_mina         ;alarm min               $09
         .byte wr_hrsa         ;alarm hour              $0a
         .byte wr_dowa         ;alarm date/day          $0b 
         .byte wr_wdms         ;watchdog msecs * 10     $0c
         .byte wr_wds          ;watchdog secs           $0d 
         .byte wr_crb          ;control B               $0f 
n_rtcreg =*-rtcreg
;
;
;       parameters...
;
rtcparm  .byte wr_irqoff       ;updates on & WDT IRQs off   %10000000
         .byte wr_secap        ;no alarm secs IRQ           %00000000
         .byte wr_minap        ;no alarm min IRQ            %00000000
         .byte wr_hrsap        ;no alarm hour IRQ           %00000000
         .byte wr_dowap        ;no alarm date/day IRQ       %00000000
         .byte wr_wdmsp        ;10 ms underflows LSB        %00000001
         .byte wr_wdsp         ;10 ms underflows MSB        %00000000
         .byte wr_crbpa        ;updates & WDT IRQs off      %00000000
;
        .if *-rtcparm < n_rtcreg
                .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
        .if *-rtcparm > n_rtcreg
                .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
;

;================================================================================
;
; initrtc: Initialise DS1511Y
;
;
INITRTC .PROC
        LDA  CRA_RTC            ;Interrupt request flag (IRQF) is cleared by reading the flag register CRA ($OE)
        LDY  #N_RTCREG-1
L10
        LDA  RTCPARM,Y
        LDX  RTCREG,Y
        STA  IO_RTC,X
        DEY
        BPL  L10
        LDA  #$5A       ;A delay of 366us is needed
        STA  DELLO      ;to ensure a user register update
        JSR  DELAY1     ;$5A in DELLO will be a ~370us delay
        RTS
       .PEND

DEBUGRTC    .MACRO
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
        .null \@        ; A null terminated debug string goes here.
ENDMACRO
        .ENDM

;
;================================================================================
;
;PRINT_DATE_AND_TIME: PRINT RTC DATE & TIME REGISTERS
;
;
;   Preparatory Ops: None
;
;   Returned Values: A: entry value
;                    X: entry value
;                    Y: entry value
;
;   Example: JSR PRINT_DATE_AND_TIME
;
;
PRINT_DATE_AND_TIME .PROC
        PHA
        PHX
        PHY
        JSR  GET_DATE_AND_TIME
        JSR  CROUT
        LDA  TODBUF+WR_DATT
        JSR  BCDOUTA
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_MON
        JSR  BCDOUTA
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_YRHI
        JSR  BCDOUTA
        LDA  TODBUF+WR_YRLO
        JSR  BCDOUTA
        LDA  #' '
        JSR  COUT
        LDA  TODBUF+WR_HRST
        JSR  BCDOUTA
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_MINT
        JSR  BCDOUTA
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_SECT
        JSR  BCDOUTA
        JSR  CROUT
        PLY
        PLX
        PLA
        RTS
        .PEND

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
ALARM   .PROC
        .PEND

;
;================================================================================
;
;constime: SET CONSOLE TIME
;
SET_CONSOLE_TIME .PROC
        .PEND

;
;================================================================================
;
;GET_DATE_AND_TIME: READ RTC DATE & TIME REGISTERS
;
;
;   Preparatory Ops: None
;
;                    TODBUF will contain 8 BCD values in
;                    the following order:
;
;                    Offset  Content
;                    --------------
;                      $00   seconds     ($00-$59)
;                      $01   minutes     ($00-$59)
;                      $02   hours       ($00-$23)
;                      $03   day-of-week ($01-$07) Day 1 is Monday
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
;   Example: JSR GET_DATE_AND_TIME
;
;
GET_DATE_AND_TIME   .PROC
        PHA
        PHX
        LDA  CRB_RTC    ;Load control register B
        PHA             ;Preserve control register B
        AND  #D11SUMSK  ;Turn off update of registers
        STA  CRB_RTC
        LDX  #WR_YRHI   ;Initialise index
L1
        LDA  IO_RTC,X   ;Read time data
        CPX  #WR_MON    ;Month byte contains control bits
        BNE  L2
        AND  #D11EMMSK  ;Get rid of control bits
L2
        STA  TODBUF,X
        DEX
        BPL  L1         ;  GOTO L1, next register
        PLA             ;  ELSE, we're done
        STA  CRB_RTC    ;  restore all registers
        PLX
        PLA
        RTS
        .PEND

;
;================================================================================
;
;PUT_DATE_AND_TIME: WRITE RTC DATE & TIME REGISTERS
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
PUT_DATE_AND_TIME  .PROC
        PHP
        PHA
        PHX
        PHY             ;Delay routine use Y so preserve it
        LDA  CRB_RTC    ;Load control register B
        PHA             ;Preserve control register B
        AND  #D11SUMSK  ;Turn off update of registers
        STA  CRB_RTC
        LDX  #WR_YRHI   ;Initialise index
L1
        LDA  TODBUF,X
        CPX  #WR_MON    ;IF X != month register
        BNE  L2         ;  GOTO L1 
        LDA  IO_RTC,X   ;Read in month from RTC (month register contains control bits)
        AND  #D11ECMSK  ;Clear out month data
        ORA  TODBUF,X   ;Copy in month data from TODBUF
L2
        STA  IO_RTC,X   ;Update register
        DEX
        BPL  L1         ;Take care of next register
        PLA             ;Restore control register b
        STA  CRB_RTC    ;Turn on update of registers
        LDA  #$5A       ;A delay of 366us is needed
        STA  DELLO      ;to ensure a user register update
        JSR  DELAY1     ;$5A in DELLO will be a ~370us delay
        PLY
        PLX
        PLA
        PLP
        RTS
        .PEND

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
GET_SYSTEM_UP_TIME .PROC
        .PEND

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
UTDELAY .PROC
        .PEND
