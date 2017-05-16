;
;----------------------------------------------------------------
;ACIA registers, masks and constants
    ACIABASE = $7FE0
    ACIAMASK = %10001000    ;Bit 7 interrupt and bit 3 receive register full

;
;ACIA device address:
    SIODAT   = $7FE0        ;ACIA data register   <--put your 6551 ACIA base address here
                ;(REQUIRED!)

    SIOSTAT  = SIODAT+1     ;ACIA status REGISTER
    SIOCOM   = SIODAT+2     ;ACIA command REGISTER
    SIOCON   = SIODAT+3     ;ACIA control REGISTER
;

;;; Initialise ACIA
INITACIA    .proc
        LDA  #$1F     ;Initialize serial port (terminal I/O) 6551/65c51 ACIA
        STA  SIOCON   ; (19.2K BAUD,no parity,8 data bits,1 stop bit,
        LDA  #$09     ;  receiver IRQ output enabled)
        STA  SIOCOM
        RTS
        .pend
;;; End init ACIA

