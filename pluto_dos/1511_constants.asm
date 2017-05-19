;================================================================================
;
;DS1511 CONFIGURATION CONSTANTS Description Order
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
;DS1511 RUNTIME CONTROL MASKS  Description Order
;
d11noirq =%00000000            ;disable IRQs & updates
d11onirq =%10100010            ;enable IRQs & updates
d11aimsk =%00100000            ;enable NVRAM autoincrement
d11ecmsk =%11100000            ;extract control value
d11emmsk =%00011111            ;extract month value
d11ismsk =%00000011            ;IRQ sources
d11sumsk =%01111111            ;stop register updates
;

;
;================================================================================
;
;RTC IO address
;
    IO_RTC = $7FA0
;Storage area for Time Of Day
    TODBUF = $0400    ;Temporary buffer for RTC time and date registers
    TOD = $A0       ;Compressed Date structure compatible with CFS 0.11
	.end
