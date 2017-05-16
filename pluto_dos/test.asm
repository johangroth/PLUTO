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

        TIMEOFDAY = $90
; Read date and time and store in compressed format
                 
;DS1511 CONFIGURATION CONSTANTS — Description Order
;
        wr_wdmsp =$01                  ;10 ms underflows LSB
        wr_wdsp  =$00                  ;10 ms underflows MSB
        wr_dowap =%00000000            ;no alarm date/day IRQ
        wr_hrsap =%00000000            ;no alarm hour IRQ
        wr_minap =%00000000            ;no alarm min IRQ
        wr_secap =%00000000            ;no alarm secs IRQ
        wr_crbpa =%00000000            ;updates & WDT IRQs off
        wr_crbpb =%10100010            ;updates & WDT IRQs on

;
;================================================================================
;
;DS1511 CONTROL MASKS — Description Order
;
        d11noirq =%00000000            ;disable IRQs & updates
        d11onirq =%10100010            ;enable IRQs & updates
        d11aimsk =%00100000            ;enable NVRAM autoincrement
        dlleomsk =%00011111            ;enable oscillator
        d11ecmsk =%11100000            ;extract control values
        d11emmsk =d11ecmsk ^ %11111111 ;extract month value
        d11ismsk =%00000011            ;IRQ sources
        d11sqmsk =%01000000            ;no square wave output
        d11temsk =%10000000            ;stop/start register updates 


;================================================================================
;
;DALLAS DS1511 REAL-TIME CLOCK REGISTER DEFINITIONS
;
        nr_rtc   =32                   ;total registers ($14-$1F reserved)

;
;
;                        register offsets...
;
        wr_sect  =$00                  ;TOD seconds ($00-$59 BCD)
        wr_mint  =$01                  ;TOD minutes ($00-$59 BCD)
        wr_hrst  =$02                  ;TOD hour ($00-$23 BCD)
        wr_dowt  =$03                  ;day of week ($01-$07 BCD)
        wr_datt  =$04                  ;date ($01-$31 BCD)
        wr_mon   =$05                  ;month & control...
;
;                        xxxxxxxx
;                        ||||||||
;                        |||+++++———> month ($01-$12 BCD)
;                        ||+————————> 1: enable 32 Khz at SQW when on battery
;                        |+—————————> 0: enable 32 KHz at SQW when on Vcc
;                        +——————————> 0: enable oscillator
;
        wr_yrlo  =$06                  ;year LSB ($00-$99 BCD)
        wr_yrhi  =$07                  ;year MSB ($00-$39 BCD)
        wr_seca  =$08                  ;alarm seconds & IRQ control...
;
;                        xxxxxxxx
;                        ||||||||
;                        |+++++++———> alarm seconds ($00-$59 BCD)
;                        +——————————> 1: IRQ once per second
;
        wr_mina  =$09                  ;alarm minutes & IRQ control...
;
;                        xxxxxxxx
;                        ||||||||
;                        |+++++++———> alarm minutes ($00-$59 BCD)
;                        +——————————> 1: IRQ when TOD secs = alarm secs
;
        wr_hrsa  =$0a                  ;alarm hour & IRQ control...
;
;                        x0xxxxxx
;                        | ||||||
;                        | ++++++———> alarm hour ($00-$23 BCD)
;                        +——————————> 1: IRQ when TOD secs & mins = alarm secs & mins
;
        wr_dowa  =$0b                  ;alarm date/day & IRQ control...
;
;                        xxxxxxxx
;                        ||||||||
;                        ||++++++———> alarm day ($01-$07 BCD) or date ($01-$31 BCD)
;                        |+—————————> 0: alarm date set
;                        |            1: alarm day set
;                        +——————————> 0: IRQ when TOD & day/date = alarm TOD & day/date
;                                     1: IRQ when TOD = alarm time
;
        wr_wdms  =$0c                  ;watchdog millisecs*10 ($00-$99 BCD)
        wr_wds   =$0d                  ;watchdog seconds ($00-$99 BCD)
        wr_cra   =$0e                  ;control register A...
;
;                        xxxxxxxx
;                        ||||||||
;                        |||||||+———> 1: IRQ pending (read only)
;                        ||||||+————> 1: IRQ = watchdog timer
;                        |||||+—————> 1: IRQ = kickstart (read only)
;                        ||||+——————> 1: IRQ = TOD alarm
;                        |||+———————> 0: PWR pin = active low
;                        |||          1: PWR pin = high-Z
;                        ||+————————> 0: PWR pin = high-Z wo/Vcc present
;                        ||           1: PWR pin = active low wo/Vcc present
;                        |+—————————> 1: aux external battery low (read only)
;                        +——————————> 1: external battery low (read only)
;
        wr_crb   =$0f                  ;control register B...
;
;                        x0xxxxxx
;                        | ||||||
;                        | |||||+———> 0: watchdog generates IRQ
;                        | |||||      1: watchdog generates reset
;                        | ||||+————> 1: watchdog IRQ/reset enabled
;                        | |||+—————> 1: kickstart IRQ enabled
;                        | ||+——————> 1: TOD alarm IRQ enabled
;                        | |+———————> 1: TOD alarm wakeup enabled
;                        | +————————> 1: NVRAM address autoincrement enabled
;                        +——————————> 0: TOD & date register update disabled
;                                     1: TOD & date register update enabled
;
        wr_nvra  =$10                  ;NVRAM address port ($00-$FF)
        wr_rsva  =$11                  ;reserved
        wr_rsvb  =$12                  ;reserved
        wr_nvrd  =$13                  ;NVRAM data port

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
rtcreg   .byte wr_crb          ;control B
         .byte wr_seca         ;alarm sec
         .byte wr_mina         ;alarm min
         .byte wr_hrsa         ;alarm hour
         .byte wr_dowa         ;alarm date/day
         .byte wr_wdms         ;watchdog msecs * 10
         .byte wr_wds          ;watchdog secs
         .byte wr_crb          ;control B
n_rtcreg =*-rtcreg
;
;
;       parameters...
;
rtcparm  .byte wr_crbpb        ;updates & WDT IRQs on
         .byte wr_secap        ;no alarm secs IRQ
         .byte wr_minap        ;no alarm min IRQ
         .byte wr_hrsap        ;no alarm hour IRQ
         .byte wr_dowap        ;no alarm date/day IRQ
         .byte wr_wdmsp        ;10 ms underflows LSB
         .byte wr_wdsp         ;10 ms underflows MSB
         .byte wr_crbpa        ;updates & WDT IRQs off
;
        .if *-rtcparm < n_rtcreg
                .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
        .if *-rtcparm > n_rtcreg
                .error "!!! RTCREG & RTCPARM data tables don't match !!!"
        .endif
;

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
        .null \@        ; Debug string goes here with null termination.
ENDMACRO
        .endm
        
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
;================================================================================ 
; 
;getdtr: READ RTC DATE & TIME REGISTERS 
; 
;    
;   Preparatory Ops: .X: storage address LSB 
;                    .Y: storage address MSB 
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
getdtr  .proc
        lda wr_mont
        ; split into hi and lo byte
        ; or high with seconds
        ; or lo with minutes
        lda wr_mint
        ; split into hi and lo byte
        ; or high with year
        ; or lo with day 
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
;   Preparatory Ops: .X: source address LSB 
;                    .Y: source address MSB 
; 
;                    Source must contain 8 BCD values in 
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
;   Example: ldx #<todbuf 
;            ldy #>todbuf 
;            jsr putdtr 
;    
; 
putdtr  .proc
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


