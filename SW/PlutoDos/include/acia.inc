;
;----------------------------------------------------------------
;ACIA registers, masks and constants
    aciabase            = $7FE0         ; 65C51 ACIA base address here
    acia_receive_mask   = %00001000     ; Bit 3 receive register full
    acia_transmit_mask  = %00010000     ; Bit 4 transmitter register empty
;
;ACIA device address:
    siodat   = aciabase     ;ACIA data register
    siostat  = siodat+1     ;ACIA status REGISTER
    siocom   = siodat+2     ;ACIA command REGISTER
    siocon   = siodat+3     ;ACIA control REGISTER

    serial_port_param       = %00011111 ; 19.2K BAUD,no parity,8 data bits,1 stop bit,
    rec_xmit_irq_enabled    = %00000101 ;receiver IRQ output enabled
