        .include "include/1511.inc"

;================================================================================
;
;MAXIM DS1511 WATCHDOG TIMER INITIALIZATION DATA
;
;       These tables consist of register initialisation bit patterns & corresp-
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
rtcreg: .byte wr_crb          ;control B               $0f
        .byte wr_secalarm     ;alarm sec               $08
        .byte wr_minalarm     ;alarm min               $09
        .byte wr_hrsalarm     ;alarm hour              $0a
        .byte wr_dowalarm     ;alarm date/day          $0b
        .byte wr_watchdog_ms  ;watchdog msecs * 10     $0c
        .byte wr_watchdog_s   ;watchdog secs           $0d
        .byte wr_crb          ;control B               $0f
n_rtcreg =*-rtcreg
;
;
;       parameters...
;
rtcparm:.byte wr_irqoff         ;updates on & WDT IRQs off   %10000000
        .byte wr_secap          ;no alarm secs IRQ           %00000000
        .byte wr_minap          ;no alarm min IRQ            %00000000
        .byte wr_hrsap          ;no alarm hour IRQ           %00000000
        .byte wr_dowap          ;no alarm date/day IRQ       %00000000
        .byte wr_watchdog_msp   ;10 ms underflows LSB        %00000001
        .byte wr_watchdog_sp    ;10 ms underflows MSB        %00000000
        .byte wr_crbpa          ;updates & WDT IRQs off      %00000000
;
        .if *-rtcparm < n_rtcreg
            .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
        .if *-rtcparm > n_rtcreg
            .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
;

;;;================================================================================
;; rtc_init: Initialise DS1511Y
;;
;;;
rtc_init: .proc
        lda  cra_rtc        ;interrupt request flag (irqf) is cleared by reading the flag register cra ($oe)
        ldy  #n_rtcreg-1
l10:
        lda  rtcparm,y
        ldx  rtcreg,y
        sta  io_rtc,x
        dey
        bpl  l10
        lda  #$5            ;a delay of 366us is needed
        sta  delay_high
        lda  #$b8
        sta  delay_low      ;to ensure a user register update
        jsr  delay          ;$5b8 will be a ~366µs delay if system clock is 4MHz
        rts
       .pend
;;;
;;print_date_and_time: print rtc date & time registers
;;
;;
;;   preparatory ops: none
;;
;;   returned values: a: entry value
;;                    x: entry value
;;                    y: entry value
;;
;;   example: jsr print_date_and_time
;;
;;;
print_date_and_time: .proc
        pha
        jsr get_date_and_time
        stz index_high
        lda todbuf+wr_dowt  ;load day 1-7
        dea                 ;substract one as index in day_of_week table is zero based
        asl                 ;Muliply by...
        asl                 ;four to find right index day Mon = 0, Tue = 1, and so on.
        sta index_low       ;partial address in index_low
        lda #<days_of_week  ;low address of day of week table
        adc index_low       ;add partial address to get index in day of week table (carry set to 0 by asl above)
        sta index_low
        lda #>days_of_week
        adc index_high
        sta index_high
        jsr b_prout
        lda #','
        jsr b_chout
        jsr b_space
        lda todbuf+wr_datt
        jsr bcdouta
        jsr slash
        lda todbuf+wr_mon
        jsr bcdouta
        jsr slash
        lda todbuf+wr_yrhi
        jsr bcdouta
        lda todbuf+wr_yrlo
        jsr bcdouta
        jsr b_space
        lda todbuf+wr_hrst
        jsr bcdouta
        jsr b_colon
        lda todbuf+wr_mint
        jsr bcdouta
        jsr b_colon
        lda todbuf+wr_sect
        jsr bcdouta
        pla
        rts
        .pend


;;;
;; send forward slash '/' to terminal
;;;
slash:  .proc
        lda #'/'
        jmp b_chout
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
alarm:  .proc
        .pend

;
;================================================================================
;
;constime: SET CONSOLE TIME
;
set_console_time: .proc
        .pend

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
;   Example: JSR GET_DATE_AND_TIME
;
;
;
get_date_and_time: .proc
        pha
        phx
        lda  crb_rtc    ;load control register b
        pha             ;preserve control register b
        and  #d11sumsk  ;turn off update of registers
        sta  crb_rtc
        ldx  #wr_yrhi   ;initialise index
l1:
        lda  io_rtc,x   ;read time data
        cpx  #wr_mon    ;month byte contains control bits
        bne  l2
        and  #d11emmsk  ;get rid of control bits
l2:
        sta  todbuf,x
        dex
        bpl  l1         ;  goto l1, next register
        pla             ;  else, we're done
        sta  crb_rtc    ;  restore all registers
        plx
        pla
        rts
        .pend

;
;================================================================================
;
;SET_DATE_AND_TIME: Write rtc date & time registers
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
set_date_and_time:  .proc
        pha
        phx
        phy             ;delay routine use y so preserve it
        lda  crb_rtc    ;load control register b
        pha             ;preserve control register b
        and  #d11sumsk  ;turn off update of registers
        sta  crb_rtc
        ldx  #wr_yrhi   ;initialise index
l1:
        lda  todbuf,x
        cpx  #wr_mon    ;if x != month register
        bne  l2         ;  goto l2
        lda  io_rtc,x   ;read in month from rtc (month register contains control bits)
        and  #d11ecmsk  ;clear out month data
        ora  todbuf,x   ;copy in month data from todbuf
l2:
        sta  io_rtc,x   ;update register
        dex
        bpl  l1         ;take care of next register
        pla             ;restore control register b
        sta  crb_rtc    ;turn on update of registers
        lda  #$b8       ;a delay of 366us is needed
        sta  delay_low  ;to ensure a user register update
        lda  #$5
        sta  delay_high
        jsr  delay      ;$5b8 in delay_high/low will be a 366us delay
        ply
        plx
        pla
        rts
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
get_system_up_time: .proc
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
utdelay: .proc
        .pend
