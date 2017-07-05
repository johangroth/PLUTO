        * = $500

        .INCLUDE "1511.asm"
        .INCLUDE "1511_constants.asm"

        ORG_IRQ_VECTOR = $310
        INTERRUPTVECTORS    = $0300
        NMIVECTOR           = INTERRUPTVECTORS
        IRQVECTOR           = INTERRUPTVECTORS+2
        RTC_IRQ_ON          = %00100010

CHANGE_IRQ_ADDRESS
        SEI
        LDA  IRQVECTOR
        STA  ORG_IRQ_VECTOR
        LDA  IRQVECTOR+1
        STA  ORG_IRQ_VECTOR+1
        LDA  #<NEW_IRQ
        STA  IRQVECTOR
        LDA  #>NEW_IRQ
        STA  IRQVECTOR+1
        LDA  CRB_RTC
        ORA  #RTC_IRQ_ON
        STA  CRB_RTC
        CLI
        RTS

NEW_IRQ
;;; HANDLE RTC IRQ
        JMP  (ORG_IRQ_VECTOR)
 
