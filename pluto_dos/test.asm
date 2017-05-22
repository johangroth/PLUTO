
        * = $500
        CHIN = $82F5
        COUT = $8148
        COUT2 = $8314
        CROUT = $8335
        CR2 = $8332
        SPC2 = $8584
        SPC4 = $8581
        PRASC = $8489
        DOLLAR = $832D
        PRBYTE = $8496
        PRINDX = $84A7
        PROMPT = $84B4
        BEEP = $82CB
        DELAY1 = $8173
        DELAY2 = $8346
        SET = $855C
        TIMER = $855E
        RDLINE = $84ED
        BN2ASC = $82D3
        ASC2BN = $82AF
        HEXIN = $8357
        SAVREGS = $854E
        RESREGS = $8555
        INCINDEX = $83E9
        DECINDEX = $8324
        PROMPT2 = $86FF
        HEXIN2 = $8351
        HEXIN4 = $8355
        NMON = $8812
        COLDSTART = $87A8
        INTERRUPT = $8902
        ACIA = $7FE0
        VIA = $7FC0
        DS1511 = $7FA0
        PUT_DATE_AND_TIME = $8095

        .include "zp_variables.asm"
        .include "utils.asm"
        .include "1511_constants.asm"
        .include "1511.asm"

;
;Set the date and time. 
;
        LDA  #$00
        STA  TODBUF+WR_SECT
        LDA  #$49
        STA  TODBUF+WR_MINT
        LDA  #$3
        STA  TODBUF+WR_HRST
        LDA  #$1
        STA  TODBUF+WR_DOWT
        LDA  #$22
        STA  TODBUF+WR_DATT
        LDA  #$5
        STA  TODBUF+WR_MON
        LDA  #$17
        STA  TODBUF+WR_YRLO
        LDA  #$20
        STA  TODBUF+WR_YRHI
        JSR  PUT_DATE_AND_TIME
        RTS

        LDX  #$F
L1
        STZ  TODBUF,X
        DEX
        BPL  L1
        RTS

