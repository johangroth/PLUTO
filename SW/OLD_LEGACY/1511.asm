;================================================================================ 
; 
;MAXIM DS1511 REAL-TIME CLOCK DEFINITIONS 
; 
nr_rtc   =32                   ;total registers ($14-$1F reserved) 
; 
; 
;	register offsets... 
; 
wr_sect  =$00                  ;TOD seconds ($00-$59 BCD) 
wr_mint  =$01                  ;TOD minutes ($00-$59 BCD) 
wr_hrst  =$02                  ;TOD hour ($00-$23 BCD) 
wr_dowt  =$03                  ;day of week ($01-$07 BCD) 
wr_datt  =$04                  ;date ($01-$31 BCD) 
wr_mon   =$05                  ;month & control... 
; 
;	xxxxxxxx 
;	|||||||| 
;	|||+++++> month ($01-$12 BCD) 
;	||+> 1: enable 32 Khz at SQW when on battery 
;	|+> 0: enable 32 KHz at SQW when on Vcc 
;	+> 0: enable oscillator 
; 
wr_yrlo  =$06                  ;year LSB ($00-$99 BCD) 
wr_yrhi  =$07                  ;year MSB ($00-$39 BCD) 
wr_seca  =$08                  ;alarm seconds & IRQ control... 
; 
;	xxxxxxxx 
;	|||||||| 
;	|+++++++> alarm seconds ($00-$59 BCD) 
;	+> 1: IRQ once per second 
; 
wr_mina  =$09                  ;alarm minutes & IRQ control... 
; 
;	xxxxxxxx 
;	|||||||| 
;	|+++++++> alarm minutes ($00-$59 BCD) 
;	+> 1: IRQ when TOD secs = alarm secs 
; 
wr_hrsa  =$0a                  ;alarm hour & IRQ control... 
; 
;	x0xxxxxx 
;	| |||||| 
;	| ++++++> alarm hour ($00-$23 BCD) 
;	+> 1: IRQ when TOD secs & mins = alarm secs & mins 
; 
wr_dowa  =$0b                  ;alarm date/day & IRQ control... 
; 
;	xxxxxxxx 
;	|||||||| 
;	||++++++> alarm day ($01-$07 BCD) or date ($01-$31 BCD) 
;	|+> 0: alarm date set 
;	|            1: alarm day set 
;	+> 0: IRQ when TOD & day/date = alarm TOD & day/date 
;	             1: IRQ when TOD = alarm time 
; 
wr_wdms  =$0c                  ;watchdog millisecs*10 ($00-$99 BCD) 
wr_wds   =$0d                  ;watchdog seconds ($00-$99 BCD) 
wr_cra   =$0e                  ;control register A... 
; 
;	xxxxxxxx 
;	|||||||| 
;	|||||||+> 1: IRQ pending (read only) 
;	||||||+> 1: IRQ = watchdog timer 
;	|||||+> 1: IRQ = kickstart (read only) 
;	||||+> 1: IRQ = TOD alarm 
;	|||+> 0: PWR pin = active low 
;	|||          1: PWR pin = high-Z 
;	||+> 0: PWR pin = high-Z wo/Vcc present 
;	||           1: PWR pin = active low wo/Vcc present 
;	|+> 1: aux external battery low (read only) 
;	+> 1: external battery low (read only) 
; 
wr_crb   =$0f                  ;control register B... 
; 
;	x0xxxxxx 
;	| |||||| 
;	| |||||+> 0: watchdog generates IRQ 
;	| |||||      1: watchdog generates reset 
;	| ||||+> 1: watchdog IRQ/reset enabled 
;	| |||+> 1: kickstart IRQ enabled 
;	| ||+> 1: TOD alarm IRQ enabled 
;	| |+> 1: TOD alarm wakeup enabled 
;	| +> 1: NVRAM address autoincrement enabled 
;	+> 0: TOD & date register update disabled 
;	             1: TOD & date register update enabled 
; 
wr_nvra  =$10                  ;NVRAM address port ($00-$FF) 
wr_rsva  =$11                  ;reserved 
wr_rsvb  =$12                  ;reserved 
wr_nvrd  =$13                  ;NVRAM data port 
; 
; 
;	absolute register definitions... 
; 
sect_rtc =io_rtc+wr_sect       ;TOD seconds 
mint_rtc =io_rtc+wr_mint       ;TOD minutes 
hrst_rtc =io_rtc+wr_hrst       ;TOD hour 
dowt_rtc =io_rtc+wr_dowt       ;day of week 
datt_rtc =io_rtc+wr_datt       ;date 
mon_rtc  =io_rtc+wr_mon        ;month & control 
yrlo_rtc =io_rtc+wr_yrlo       ;year LSB 
yrhi_rtc =io_rtc+wr_yrhi       ;year MSB 
seca_rtc =io_rtc+wr_seca       ;alarm seconds & IRQ control 
mina_rtc =io_rtc+wr_mina       ;alarm minutes & IRQ control 
hrsa_rtc =io_rtc+wr_hrsa       ;alarm hour & IRQ control 
dowa_rtc =io_rtc+wr_dowa       ;alarm date/day & IRQ control 
wdms_rtc =io_rtc+wr_wdms       ;watchdog millisecs*10 
wds_rtc  =io_rtc+wr_wds        ;watchdog seconds 
cra_rtc  =io_rtc+wr_cra        ;control register A 
crb_rtc  =io_rtc+wr_crb        ;control register B 
nvra_rtc =io_rtc+wr_nvra       ;NVRAM address port 
rsva_rtc =io_rtc+wr_rsva       ;reserved 
rsvb_rtc =io_rtc+wr_rsvb       ;reserved 
nvrd_rtc =io_rtc+wr_nvrd       ;NVRAM data port 
; 
	.end 
