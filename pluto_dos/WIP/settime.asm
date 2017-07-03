
        * = $500
        CHIN = $8164
        COUT = $8186
        COUT2 = $8183
        CROUT = $81A4
        CR2 = $81A1
        SPC2 = $83F3
        SPC4 = $83F0
        PRASC = $82F8
        DOLLAR = $819C
        PRBYTE = $8305
        PRINDX = $8316
        PROMPT = $8323
        BEEP = $813A
        DELAY1 = $81B1
        DELAY2 = $81B5
        SET = $83CB
        TIMER = $83CD
        RDLINE = $835C
        BN2ASC = $8142
        ASC2BN = $811E
        HEXIN = $81C6
        SAVREGS = $83BD
        RESREGS = $83C4
        INCINDEX = $8258
        DECINDEX = $8193
        PROMPT2 = $856E
        HEXIN2 = $81C0
        HEXIN4 = $81C4
        NMON = $8687
        COLDSTART = $861D
        INTERRUPT = $8777

        ACIA = $7FE0
        VIA = $7FC0
        DS1511 = $7FA0
        PUT_DATE_AND_TIME = $809F

        .include "../zp_variables.asm"
        .include "../1511_constants.asm"
        .include "../1511.asm"

;
;Set the date and time. 
;
        LDA  #$00
        STA  TODBUF+WR_SECT
        LDA  #$44
        STA  TODBUF+WR_MINT
        LDA  #$23
        STA  TODBUF+WR_HRST
        LDA  #$3
        STA  TODBUF+WR_DOWT
        LDA  #$28
        STA  TODBUF+WR_DATT
        LDA  #$06
        STA  TODBUF+WR_MON
        LDA  #$17
        STA  TODBUF+WR_YRLO
        LDA  #$20
        STA  TODBUF+WR_YRHI
        JSR  PUT_DATE_AND_TIME
        RTS

