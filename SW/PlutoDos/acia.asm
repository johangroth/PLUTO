        .include "include/acia.inc"

;;; Initialise ACIA
acia_init    .proc
        lda  #serial_port_param             ;Initialize serial port (terminal I/O) 6551/65c51 ACIA
        sta  siocon                         ; (19.2K BAUD,no parity,8 data bits,1 stop bit,
        lda  #receiver_output_irq_enabled   ; receiver IRQ output enabled)
        sta  siocom
        rts
        .pend
;;; End init ACIA
