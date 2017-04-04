;================================================================================
;
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
;

;================================================================================
;
;MAXIM DS1511 REAL-TIME CLOCK INITIALIZATION DATA
;
;                        ———————————————————————————————————————————————————————————————————————
;                        Each entry in this table consists of a chip register offset paired with
;                        the parameter that is to be loaded into the register.  Use caution when
;                        editing this table, as changing the order in which parameters are load-
;                        ed may cause the device to malfunction.  Table entries are read in rev-
;                        erse order during device setup.
;                        ———————————————————————————————————————————————————————————————————————
;
d11tab                            .byte wr_crb, wr_crbpb  ;CRB : updates & WDT IRQs on
                                  .byte wr_seca,wr_secap  ;SECA: no alarm secs IRQ
                                  .byte wr_mina,wr_minap  ;MINA: no alarm min IRQ
                                  .byte wr_hrsa,wr_hrsap  ;HRSA: no alarm hour IRQ
                                  .byte wr_dowa,wr_dowap  ;DOWS: no alarm date/day IRQ
                                  .byte wr_wdms,wr_wdmsp  ;WDMS: 10 ms underflows LSB
                                  .byte wr_wds, wr_wdsp   ;WDS : 10 ms underflows MSB
                                  .byte wr_crb, wr_crbpa  ;CRB : updates & WDT IRQs off

                                  s_d11tab = * - d11tab   ;table size



;================================================================================ 
; 
;alarm: SET AN ALARM 
; 
;	 
;	Preparatory Ops: .X: 16 bits: alarm vector (3) 
;	                 .Y: 16 bits: alarm time in secs (1,2) 
;	                  
;	Returned Values: .A: entry value 
;	                 .B: entry value 
;	                 .X: entry value 
;	                 .Y: entry value 
; 
;	MPU Flags: NVmxDIZC 
;	           |||||||| 
;	           ||||||++> entry values 
;	           |||||+> 0 (IRQs on) 
;	           +++++> entry values 
; 
;	Notes: 1) The alarm time is interpreted as the number of seconds in the 
;	          future when the alarm will expire ("go off").  The minimum 
;	          allowable alarm time is 2 seconds. 
; 
;	       2) If the alarm time is less than 2 seconds a pending alarm will 
;	          be canceled. 
; 
;	       3) The alarm vector is the address of the code that will be ex- 
;	          ecuted when the alarm goes off.  If the vector is $0000 no 
;	          alarm will be set. 
; 
;	       4) This function results in a jump to the alarm vector when the 
;	          alarm goes of.  Calling a subroutine after setting an alarm 
;	          will leave the stack in an unbalanced state if the alarm goes 
;	          off before the subroutine returns.  USE CAUTION! 
; 
;	Examples: longx           ;16 bit .X & .Y 
;	          ldxw alarmvec   ;alarm vector 
;	          ldyw 600        ;600 secs 
;	          jsr alarm       ;set the alarm 
;	 
; 
alarm                             .proc    
                                  cli                   ;IRQs mustn't be masked 
                                  php                   ;save MPU state 
                                  longr 
                                  cpyw 2                ;alarm time less than 2 sec? 
                                  bcs .0000020          ;no 
; 
l10                               stz alarmtim          ;yes, cancel alarm 
                                  stz alarmvec 
                                  bra .0000040 
; 
l20                               cpxw 0                ;null vector? 
                                  beq l10          ;yes, cancel alarm 
; 
                                  pha                   ;save for exit 
                                  shorta 
                                  stx alarmvec          ;set alarm vector 
; 
l30                               lda utirqct           ;wait 'til msec count... 
                                  bne l30          ;reaches zero 
; 
                                  sei                   ;no IRQ while setting time 
                                  longa 
                                  tya                   ;alarm time 
                                  adc utsecct           ;add current uptime to... 
                                  sta alarmtim          ;alarm time 
                                  lda utsecct+s_word 
                                  adcw 0                ;account for carry 
                                  sta alarmtim+s_word 
                                  pla                   ;restore entry value 
; 
l40                               plp                   ;restore MPU state... 
; 
;	 
;	Alarm time starts with the PLP instruction. 
;	 
; 
                                  rts
                                  .endp
 
; 
;================================================================================ 
; 
;constime: SET CONSOLE TIME 
; 
constime                          .proc
                                  lda #nvrtzoff+1       ;bytes to get 
        ldx #<ibuffer         ;where to store 
        ldy #>ibuffer 
        jsr getnvr            ;get TZ data 
        ldx #<auxbuf 
        ldy #>auxbuf 
        jsr getdtr            ;get date & time 
        lda ibuffer+nvrtzoff  ;timezone offset 
        tax                   ;save a copy 
        and #@11000000        ;get DST bits &... 
        sta faca              ;save 
        txa                   ;restore offset... 
        and #@00111111        ;extract hour value &... 
        sta facb              ;save it 
        lda auxbuf+wr_hrst    ;get UTC hour 
        sed                   ;do decimal arithmetic 
        rol faca              ;get direction 
        bcs .0000010          ;behind UTC 
; 
        adc facb              ;add forward TZ offset 
        cmp #midnight         ;cross into next day? 
        bcc .0000020          ;no 
; 
        sbc #midnight         ;normalize hour 
        bra .0000020 
; 
.0000010 sbc facb              ;subtract reverse TZ offset 
        bcs .0000020          ;didn't cross midnight 
; 
        adc #midnight         ;normalize hour 
; 
.0000020 xba                   ;save adjusted hour 
        cld                   ;back to binary mode 
        ldx #<dc_stime 
        ldy #>dc_stime 
        jsr sprint            ;sent time preamble 
        ldy #0 
        xba                   ;recover adjusted hour 
        jsr bcdasc            ;convert to ASCII 
        sta ibuffer,y         ;save MSD 
        iny 
        txa 
        sta ibuffer,y         ;save LSD 
        iny 
        lda auxbuf+wr_mint    ;minute 
        jsr bcdasc 
        sta ibuffer,y         ;save MSD 
        iny 
        txa 
        sta ibuffer,y         ;save LSD 
        iny 
        tyx 
        stz ibuffer,x         ;terminate string 
        ldx #<ibuffer 
        ldy #>ibuffer 
        jmp sprint            ;set console time  
                                  .endp

; 
;================================================================================ 
; 
;getdtr: READ RTC DATE & TIME REGISTERS 
; 
;	 
;	Preparatory Ops: .X: storage address LSB 
;	                 .Y: storage address MSB 
; 
;	Returned Values: .A: entry value 
;	                 .X: entry value 
;	                 .Y: entry value 
; 
;	                 Storage location will contain 8 BCD 
;	                 bytes as follows: 
; 
;	                 Offset  Content 
;	                 -------------- 
;	                   $00   seconds     ($00-$59) 
;	                   $01   minutes     ($00-$59) 
;	                   $02   hours       ($00-$23) 
;	                   $03   day-of-week ($01-$07) 
;	                   $04   date        ($01-$31) 
;	                   $05   month       ($01-$12) 
;	                   $06   year LSB    ($00-$99) 
;	                   $07   year MSB    ($00-$39) 
;	                 -------------- 
; 
;	MPU Flags: NVmxDIZC 
;	           |||||||| 
;	           ++++++++> entry values 
; 
;	Example: ldx #<todbuf 
;	         ldy #>todbuf 
;	         jsr getdtr 
;	 
; 
getdtr                            .proc
                                  phx                   ;preserve 
        phy                   ;likewise 
        php                   ;save register widths 
        longa                 ;16 bit .A 
        pha                   ;preserve .C 
        shortr                ;8 bit regs 
        tya                   ;storage address MSB 
        xba                   ;move to MSB of .C 
        txa                   ;storage address LSB 
        longx                 ;16 bit index regs 
        tax                   ;storage index 
        lda crb_rtc           ;RTC control B 
        pha                   ;save it 
        and #d11sumsk         ;stop register... 
        sta crb_rtc           ;updating 
        ldyw 0                ;RTC register offset 
; 
.0000010 lda io_rtc,y          ;read RTC 
        cpyw wr_mon           ;month register? 
        bne .0000020          ;no 
; 
        and #d11emmsk         ;discard control bits 
; 
.0000020 sta mm_ram,x          ;store in RAM 
        cpyw wr_yrhi-wr_sect  ;all registers read? 
        beq getdtraa          ;yes, done 
; 
        inx                   ;next location 
        iny                   ;next register 
        bra .0000010 
; 
getdtraa pla                   ;get control B value &... 
        sta crb_rtc           ;restore 
        longa 
        pla 
        plp 
        ply 
        plx 
        rts 
                                  .endp
; 
;================================================================================ 
; 
;getutim: GET SYSTEM UP TIME 
; 
;	 
;	Preparatory Ops: .X: 16 bits: storage location 
; 
;	Returned Values: .A: entry value 
;	                 .B: entry value 
;	                 .X: entry value 
;	                 .Y: entry value 
; 
;	MPU Flags: NVmxDIZC 
;	           |||||||| 
;	           ||||||++> entry value 
;	           |||||+> 0 
;	           +++++> entry value 
;	 
; 
getutim                           .proc
cli                   ;IRQs must be enabled 
        php                   ;save MPU state 
        longr 
        pha 
        phx 
        shorta 
; 
.0000010 lda utirqct           ;wait 'til seconds... 
        bne .0000010          ;hit zero 
; 
        longa                 ;word at a time 
        sei                   ;stop updating 
        lda utsecct           ;up time LSW 
        sta mm_ram,x          ;store 
        .rept s_word 
          inx 
        .endr 
        lda utsecct+s_word    ;up time MSW 
        cli                   ;resume updating 
        sta mm_ram,x          ;store 
        plx                   ;restore MPU state 
        pla 
        plp 
        rts 
                                  .endp

; 
;================================================================================ 
; 
;putdtr: WRITE RTC DATE & TIME REGISTERS 
; 
;	 
;	Preparatory Ops: .X: source address LSB 
;	                 .Y: source address MSB 
; 
;	                 Source must contain 8 BCD values in 
;	                 the following order: 
; 
;	                 Offset  Content 
;	                 -------------- 
;	                   $00   seconds     ($00-$59) 
;	                   $01   minutes     ($00-$59) 
;	                   $02   hours       ($00-$23) 
;	                   $03   day-of-week ($01-$07) 
;	                   $04   date        ($01-$31) 
;	                   $05   month       ($01-$12) 
;	                   $06   year LSB    ($00-$99) 
;	                   $07   year MSB    ($00-$39) 
;	                 -------------- 
; 
;	Returned Values: .A: entry value 
;	                 .X: entry value 
;	                 .Y: entry value 
; 
;	MPU Flags: NVmxDIZC 
;	           |||||||| 
;	           ++++++++> entry values 
; 
;	Example: ldx #<todbuf 
;	         ldy #>todbuf 
;	         jsr putdtr 
;	 
; 
putdtr                            .proc
                                   phx                   ;preserve 
        phy                   ;likewise 
        php                   ;save register widths 
        longa                 ;16 bit .A 
        pha                   ;preserve .C 
        shortr                ;8 bit regs 
        tya                   ;storage address MSB 
        xba                   ;move to MSB of .C 
        txa                   ;storage address LSB 
        longx                 ;16 bit index regs 
        tax                   ;source index 
        lda crb_rtc           ;RTC control B 
        pha                   ;save it 
        and #d11sumsk         ;stop register... 
        sta crb_rtc           ;updating 
        ldyw 0                ;register offset 
; 
.0000010 lda #0                ;dummy value 
        cpyw wr_mon           ;month register? 
        bne .0000020          ;no 
; 
        lda io_rtc,y          ;get month & control 
        and #d11ecmsk         ;extract control bits... 
; 
.0000020 ora mm_ram,x          ;get new value 
        sta io_rtc,y          ;write RTC 
        cpyw wr_yrhi-wr_sect  ;all registers written? 
        beq getdtraa          ;yes, done 
; 
        inx                   ;next location 
        iny                   ;next register 
        bra .0000010 
                                  .endp

; 
;================================================================================ 
; 
;utdelay: GENERATE USER-DEFINED TIME DELAY 
; 
;	 
;	Preparatory Ops: .A: 16 bit delay time in secs 
; 
;	Returned Values: .A: entry value 
;	                 .B: entry value 
;	                 .X: entry value 
;	                 .Y: entry value 
; 
;	MPU Flags: NVmxDIZC 
;	           |||||||| 
;	           ++++++++> entry values 
; 
;	Notes: 1) Delay time is approximate. 
;	       2) A delay time of zero will cause an 
;	          immediate exit. 
; 
;	Examples: longa           ;16 bit .A 
;	          lda #600        ;600 secs 
;	          jsr utdelay 
; 
;	          or... 
; 
;	          shorta          ;8 bit .A 
;	          lda #>600       ;600 secs MSB in .A 
;	          xba             ;transfer to .B 
;	          lda #<600       ;600 secs LSB in .A 
;	          jsr utdelay 
;	 
; 
utdelay                           .proc
                                  php                   ;save MPU state 
        longa 
        oraw 0                ;zero delay? 
        beq .0000020          ;yes, exit 
; 
        pha                   ;save entry value 
        sei                   ;don't interrupt during setup 
        sta tdsecct           ;set timer seconds 
        shorta 
        lda #hz               ;jiffy IRQ rate 
        sta tdirqct           ;set msec counter 
        longa 
        cli                   ;delay time starts now 
; 
.0000010 wai                   ;wait for any interrupt 
        lda tdsecct           ;read timer 
        bne .0000010          ;still running 
; 
        pla                   ;restore entry value 
; 
.0000020 plp                   ;restore MPU state 
        rts 
;       
                                  .endp
 
