PRINTSTAT   .PROC

        .PEND


IRQ_VECTOR
        PHA
        PHX 
        PHY
        TSX
        LDA  $100+4,X       ;Get MPU status register
        AND  #BRKMASK       ;Isolate BRK bit
        BNE  BRKINSTRUCTION ;GOTO BRKINSTRUCTION IF bit = 1, ie BRK instruction
        JMP  (IRQVECTOR)    ; ELSE jump to Soft vectored IRQ handler

BRKINSTRUCTION
        JMP  (BRKINTERRUPT) ;Jump to Soft vectored BRK handler

        PLA                 ;Remove return address low byte to ISR
        PLA                 ;Remove return address high byte to ISR
        PLA                 ;Restore A to pre-interrupt condition
        STA  ACCUM          ;Save in ACCUMULATOR preset/result
        PLA                 ;Pull PROCESSOR STATUS REGISTER from STACK
        STA  PREG           ;Save in PROCESSOR STATUS preset/result
        STX  XREG           ;Save X-REGISTER
        STY  YREG           ;Save Y-REGISTER
        TSX
        STX  SREG           ;Save STACK POINTER
        JSR  CROUT          ;Send CR,LF to terminal
        PLA                 ;Pull RETURN address from STACK then save it in INDEX
        STA  INDEX          ;Low byte
        PLA
        STA  INDEXH         ;High byte
        JSR  CROUT          ;Send CR,LF to terminal
        JSR  PRINTSTAT      ;Display content of all preset/result memory locations
        JSR  CROUT          ;Send CR,LF to terminal
        JSR  DISLINE        ;Disassemble then display instruction at address pointed to by INDEX
        LDA  #$00           ;Clear all PROCESSOR STATUS REGISTER bits
        PHA
        PLP
        LDX  #$FF           ;Set STACK POINTER to $FF
        TXS
        LDA  #$7F           ;Set STACK POINTER preset/result to $7F
        STA  SREG
        LDA  INCNT          ;Remove keystrokes from keystroke input buffer
        STA  OUTCNT
        JMP  MONITOR.NMON   ;Done interrupt service process, re-enter monitor

