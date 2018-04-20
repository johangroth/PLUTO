;
;----------------------------------------------------------------
;UART masks and constants
        uart_base = $7fe0


;
;----------------------------------------------------------------
;UART ST16C550 internal registers

        ;Read operation registers
        uart_rhr    = uart_base + %000     ;Receive Holding Register
        uart_ierr   = uart_base + %001     ;Interrupt Enable Register
        uart_isr    = uart_base + %010     ;Interrupt Status Register
        uart_lcrr   = uart_base + %011     ;Line Control Register
        uart_mcrr   = uart_base + %100     ;Modem Control Register
        uart_lsr    = uart_base + %101     ;Line Status Register
        uart_msrr   = uart_base + %110     ;Modem Status Register
        uart_sprr   = uart_base + %111     ;Scratchpad Register

        ;Write operation registers
        uart_thr    = uart_base + %000     ;Transmit Holding Register
        uart_ierw   = uart_base + %001     ;Interrupt Enable Register
        uart_fcr    = uart_base + %010     ;FIFO Control Register
        uart_lcrw   = uart_base + %011     ;Line Control Register
        uart_mcrw   = uart_base + %100     ;Modem Control Register
        uart_sprw   = uart_base + %111     ;Scratchpad Register

        ;Baud Rate Generator Registers (DLL/DLM). Accessible only when LCR bit-7 is set to 1.
        uart_dll    = uart_base + %000     ;LSB of Divisor Latch
        uart_dlm    = uart_base + %001     ;MSB of Divisor Latch
