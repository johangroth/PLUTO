;
;----------------------------------------------------------------
;DUART registers, masks and constants
        duart_base = $7fe0


;DUART NXP SC28L92 internal registers

        ;Read operation registers
        duart_mra       = duart_base            ;Mode Register A (MR0A, MR1A, MR2A)
        duart_sra       = duart_base + %0001    ;Status Register A (SRA)
        duart_rxfifoa   = duart_base + %0011    ;Rx Holding Register A (RxFIFOA)
        duart_ipcr      = duart_base + %0100    ;Input Port Change Register (IPCR)
        duart_isr       = duart_base + %0101    ;Interrupt Status Register (ISR)
        duart_ctu       = duart_base + %0110    ;Counter/Timer Upper (CTU)
        duart_ctl       = duart_base + %0111    ;Counter/Timer Lower (CTL)
        duart_mrb       = duart_base + %1000    ;Mode Register B (MR0B, MR1B, MR2B)
        duart_srb       = duart_base + %1001    ;Status Register B (SRB)
        duart_rxfifob   = duart_base + %1011    ;Rx Holding Register B (RxFIFOB)
        duart_ipr       = duart_base + %1101    ;Input Port Register (IPR)
        duart_startcc   = duart_base + %1110    ;start counter command
        duart_stopcc    = duart_base + %1111    ;stop counter command

        ;Write operation registers
        duart_mra       = duart_base + %        ;Mode Register A (MR0A, MR1A, MR2A)
        duart_csra      = duart_base + %0001    ;Clock Select Register A (CSRA)
        duart_cra       = duart_base + %0010    ;Command Register A (CRA)
        duart_txfifoa   = duart_base + %0011    ;Tx Holding Register A (TxFIFOA)
        duart_acr       = duart_base + %0100    ;Auxiliary Control Register (ACR)
        duart_imr       = duart_base + %0101    ;Interrupt Mask Register (IMR)
        duart_ctpu      = duart_base + %0110    ;C/T Upper Preset Register (CTPU)
        duart_ctpl      = duart_base + %0111    ;C/T Lower Preset Register (CTPL)
        duart_mrb       = duart_base + %1000    ;Mode Register B (MR0B, MR1B, MR2B)
        duart_csrb      = duart_base + %1001    ;Clock Select Register B (CSRB)
        duart_crb       = duart_base + %1010    ;Command Register B (CRB)
        duart_txfifob   = duart_base + %1011    ;Tx Holding Register B (TxFIFOB)
        duart_opcr      = duart_base + %1101    ;Output Port Configuration Register (OPCR)
        duart_sopr      = duart_base + %1110    ;Set Output Port Bits Command (SOPR)
        duart_ropr      = duart_base + %1111    ;Reset output Port Bits Command (ROPR)
