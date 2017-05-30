
        * = $500
CHIN = $815A
COUT = $817C
COUT2 = $8179
CROUT = $819A
CR2 = $8197
SPC2 = $83E9
SPC4 = $83E6
PRASC = $82EE
DOLLAR = $8192
PRBYTE = $82FB
PRINDX = $830C
PROMPT = $8319
BEEP = $8130
DELAY1 = $81A7
DELAY2 = $81AB
SET = $83C1
TIMER = $83C3
RDLINE = $8352
BN2ASC = $8138
ASC2BN = $8114
HEXIN = $81BC
SAVREGS = $83B3
RESREGS = $83BA
INCINDEX = $824E
DECINDEX = $8189
PROMPT2 = $8564
HEXIN2 = $81B6
HEXIN4 = $81BA
NMON = $867D
COLDSTART = $8613
INTERRUPT = $876D
ACIA6551 = $7FE0
VIA6522 = $7FC0
PRINT_DATE_AND_TIME = $801F 
GET_DATE_AND_TIME  = $8072
BCDOUTA = $80FF


        ACIA = $7FE0
        VIA = $7FC0
        DS1511 = $7FA0
        PUT_DATE_AND_TIME = $8095

        .include "zp_variables.asm"
        ;.include "utils.asm"
        .include "1511_constants.asm"
        .include "1511.asm"

   
        JSR  SEND_ESCAPE
        LDA  SAVE_CURSOR_POSITION_AND_ATTRIBUTES
        JSR  COUT
        JSR  SEND_ESCAPE
        LDA  #'['
        JSR  COUT
        LDA  #'1'
        JSR  COUT
        LDA  #';'
        JSR  COUT
        LDA  #'6'
        JSR  COUT
        LDA  #'2'
        JSR  COUT
        LDA  #'H'
        JSR  COUT
        JSR  SEND_DATE_AND_TIME
        JSR  SEND_ESCAPE
        LDA  RESTORE_CURSOR_POSITION_AND_ATTRIBUTES
        JSR  COUT
        RTS

SEND_ESCAPE
        LDA  #27
        JMP  COUT

SEND_DATE_AND_TIME .PROC
        PHA
        PHX
        PHY
        JSR  GET_DATE_AND_TIME
        LDA  TODBUF+WR_DATT
        JSR  BCDOUTA
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_MON
        JSR  BCDOUTA
        LDA  #'/'
        JSR  COUT
        LDA  TODBUF+WR_YRHI
        JSR  BCDOUTA
        LDA  TODBUF+WR_YRLO
        JSR  BCDOUTA
        LDA  #' '
        JSR  COUT
        LDA  TODBUF+WR_HRST
        JSR  BCDOUTA
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_MINT
        JSR  BCDOUTA
        LDA  #':'
        JSR  COUT
        LDA  TODBUF+WR_SECT
        JSR  BCDOUTA
        JSR  CROUT
        PLY
        PLX
        PLA
        RTS
        .PEND

CLEAR_ENTIRE_SCREEN .NULL "[2J"
MOVE_CURSOR_TO_SCREEN_LOCATION_V_H  .NULL "[<v>;<h>H"
SAVE_CURSOR_POSITION_AND_ATTRIBUTES .TEXT "7"
RESTORE_CURSOR_POSITION_AND_ATTRIBUTES .TEXT "8"
