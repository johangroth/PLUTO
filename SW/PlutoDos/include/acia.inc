;
;----------------------------------------------------------------
;ACIA registers, masks and constants
    aciabase = $7FE0        ; <-- put your 65C51 ACIA base address here
                            ;(REQUIRED!)
    aciamask = %10001000    ;Bit 7 interrupt and bit 3 receive register full

;
;ACIA device address:
    siodat   = aciabase     ;ACIA data register
    siostat  = siodat+1     ;ACIA status REGISTER
    siocom   = siodat+2     ;ACIA command REGISTER
    siocon   = siodat+3     ;ACIA control REGISTER

    serial_port_param = $1f ;19.2K BAUD,no parity,8 data bits,1 stop bit,
    receiver_output_irq_enabled = $09   ;receiver IRQ output enabled
