;
;
;***************************************************
;* S/O/S SyMon III (c)1990,2007 By Brian M. Phelps *
;*                                                 *
;*         BIOS, Monitor, Micro-assembler          *
;*           For the 6502/65c02 family             *
;*         of microprocessor units (MPU)           *
;*                                                 *
;*   Includes text editor, text and byte string    *
;*  search utility, data upload/download utility   *
;*                                                 *
;*              Version 06/07/07                   *
;*                                                 *
;*          (Requires 8kb of memory)               *
;***************************************************
;
;14 byte buffer
	INBUFF   = $B0      ;14 bytes ($B0-$BD)
;
;16-bit variables:
	COMLO   = $BE
	COMHI   = COMLO+1
	DELLO   = $C0
	DELHI   = DELLO+1
	PROLO   = $C2
	PROHI   = PROLO+1
	BUFADR  = $C4
	BUFADRH = BUFADR+1
	TEMP2   = $C6
	TEMP2H  = TEMP2+1
	INDEX   = $C8
	INDEXH  = INDEX+1
	TEMP3   = $CA
	TEMP3H  = TEMP3+1
;
;8-bit variables and constants:
	TEMP     = $CC
	BUFIDX   = $CD
	BUFLEN   = $CE
	BSPIND   = $CF
	IDX      = $D0
	IDY      = $D1
	SCNT     = $D2
	OPLO     = $D3
	OPHI     = $D4
	STEMP    = $D5
	RT1      = $D6
	RT2      = $D7
	SETIM    = $D8
	LOKOUT   = $D9
	ACCUM    = $DA
	XREG     = $DB
	YREG     = $DC
	SREG     = $DD
	PREG     = $DE
	POINTER  = $DF
	HPHANTOM = $00E0    ; HPHANTOM MUST be located (in target memory) immediatly below the HEX0AND1 variable
	HEX0AND1 = $E1
	HEX2AND3 = $E2
	HEX4AND5 = $E3
	HEX6AND7 = $E4
	DPHANTOM = $00E4    ; DPHANTOM MUST be located (in target memory) immediatly below the DEC0AND1 variable
	DEC0AND1 = $E5
	DEC2AND3 = $E6
	DEC4AND5 = $E7
	DEC6AND7 = $E8
	DEC8AND9 = $E9
	INQTY    = $EA
	INCNT    = $EB
	OUTCNT   = $EC
	AINTSAV  = $ED
	XINTSAV  = $EE
	YINTSAV  = $EF
;
;16 byte buffer
	SRCHBUFF = $00F0    ;16 bytes ($F0-$FF) (notice that this variable MUST be expressed as a 16 bit address
;                        even though it references a zero-page address)
;
;Keystroke input buffer address:
	KEYBUFF  = $0200    ;256 bytes: ($200-$2FF) keystrokes (data from ACIA) are stored here
                       ; by SyMon's IRQ service routine.
;
;ACIA device address:
	SIODAT   = $7FE0    	;ACIA data register   <--put your 6551 ACIA base address here
				;(REQUIRED!)

	SIOSTAT  = SIODAT+1 	;ACIA status REGISTER
	SIOCOM   = SIODAT+2 	;ACIA command REGISTER
	SIOCON   = SIODAT+3 	;ACIA control REGISTER
;

;;; VIA device address:
	VIARB   = $7FC0	;Write Output Register B, Read Input Register B
	VIARA   = VIARB+1	;Write Output Register A, Read Input Register A
	VIADDRB = VIARB+2	;Data Direction Register B
	VIADDRA = VIARB+3	;Data Direction Register A
	VIAT1CL = VIARB+4	;Write T1 Low-Order Latches, Read T1 Low-Order Counter
	VIAT1CH = VIARB+5	;T1 High-Order Counter
	VIAT1LL = VIARB+6	;T1 Low-Order Latches
	VIAT1LH = VIARB+7	;T1 High-Order Latches
	VIAT2CL = VIARB+8	;Write T2 Low-Order Latches, Read T2 Low-Order Counter
	VIAT2CH = VIARB+9	;T2 High-Order Counter
	VIASR   = VIARB+$A	;Shift Register
	VIAACR  = VIARB+$B	;Auxiliary Control Register
	VIAPCR  = VIARB+$C	;Peripheral Control Register
	VIAIFR  = VIARB+$D	;Interrupt Flag Register
	VIAIER  = VIARB+$E	;Interrupt Enable Register
	VIARANH = VIARB+$F	;Same as Reg A except no "Handshake"

	;; ***************
	;; * XMODEM 6502 *
	;; ***************
	;;

 	.include "xmodem.asm"

;
;;;         * =  $E000 ; Target address range $E000 through $FFFF will be used

;
;
;***************
;* Subroutines *
;***************
;
;ASC2BN subroutine: Convert 2 ASCII HEX digits to a binary (byte) value.
; Enter: ACCUMULATOR = high digit, Y-REGISTER = low digit
; Returns: ACCUMULATOR = binary value
ASC2BN 	.proc
	PHA           ;Save high digit on STACK
                                  TYA           ;Copy low digit to ACCUMULATOR
                                  JSR  BINARY   ;Convert digit to binary nybble: result in low nybble
                                  STA  TEMP     ;Store low nybble
                                  PLA           ;Pull high digit from STACK
                                  JSR  BINARY   ;Convert digit to binary nybble: result in low nybble
                                  ASL        ;Move low nybble to high nybble
                                  ASL
                                  ASL
                                  ASL
                                  ORA  TEMP     ;OR high nybble with stored low nybble
                                  RTS           ;Done ASC2BN subroutine, RETURN
BINARY:
	SEC           ;Clear BORROW
                                  SBC  #$30     ;Subtract $30 from ASCII HEX digit
                                  CMP  #$0A     ;GOTO BNOK IF result < $0A
                                  BCC  BNOK
                                  SBC  #$07     ; ELSE, subtract $07 from result
BNOK:
	RTS           ;Done BINARY subroutine, RETURN
	.pend
;
;ASCTODEC subroutine: convert ASCII DECIMAL digits to BCD
ASCTODEC                          .proc         ;Initialize (zero) BCD digit input buffer:
                                  STZ  DEC0AND1 ; two most significant BCD digits
                                  STZ  DEC2AND3
                                  STZ  DEC4AND5
                                  STZ  DEC6AND7
                                  STZ  DEC8AND9 ; two least significant BCD digits
                                  LDX  BUFIDX   ;Read number of digits entered: ASCII digit buffer index
                                  BEQ  A2DDONE  ;GOTO A2DDONE IF BUFIDX = 0: no digits were entered
                                  LDY  #$05     ; ELSE, Initialize BCD input buffer index: process up to 5 BCD bytes (10 digits)
ATODLOOP:
	JSR  A2DSUB   ;Read ASCII digit then convert to BCD
                                  STA  DPHANTOM,Y ;Write BCD digit to indexed buffer location (index always > 0)
                                  JSR  A2DSUB   ;Read ASCII digit then convert to BCD
                                  ASL        ;Make this BCD digit the more significant in the BCD byte
                                  ASL
                                  ASL
                                  ASL
                                  ORA  DPHANTOM,Y ;OR with the less significant digit
                                  STA  DPHANTOM,Y ;Write BCD byte to indexed buffer location (index always > 0)
                                  DEY           ;Decrement BCD input buffer index
                                  BNE  ATODLOOP ;GOTO ATODLOOP IF buffer index <> 0: there is room to process another digit
A2DDONE:
	RTS           ; ELSE, done ASCTODEC, RETURN
	.pend

;Read indexed ASCII DECIMAL digit from text buffer then convert digit to 4 bit BCD
A2DSUB	.proc
	TXA           ;GOTO A2DCONV IF digit buffer index <> 0: there are more digits to process
                                  BNE  A2DCONV
                                  PLA           ; ELSE, pull return address from STACK
                                  PLA
                                  RTS           ;Done ASCTODEC, RETURN
A2DCONV:
	LDA  INBUFF-1,X ;Read indexed ASCII DECIMAL digit
                                  SEC           ;Subtract ASCII "0" from ASCII DECIMAL digit: convert digit to BCD
                                  SBC  #$30
                                  DEX           ;Decrement ASCII digit buffer index
                                  RTS           ;A2DSUB done, RETURN
	.pend
;
;BCDOUT subroutine: convert 10 BCD digits to ASCII DECIMAL digits then send result to terminal.
;Leading zeros are supressed in the displayed result.
;Call with 10 digit (5 byte) BCD value contained in variables DEC0AND1 through DEC8AND9:
;DEC0AND1 ($E5) Two most significant BCD digits
;DEC2AND3 ($E6)
;DEC4AND5 ($E7)
;DEC6AND7 ($E8)
;DEC8AND9 ($E9) Two least significant BCD digits
BCDOUT                            .proc
	LDX  #$00     ;Initialize BCD output buffer index: point to MSB
                                  LDY  #$00     ;Initialize leading zero flag: no non-zero digits have been processed
BCDOUTL:
	LDA  DEC0AND1,X ;Read indexed byte from BCD output buffer
                                  LSR        ;Shift high digit to low digit, zero high digit
                                  LSR
                                  LSR
                                  LSR
                                  JSR  BCDTOASC ;Convert BCD digit to ASCII DECIMAL digit, send digit to terminal
                                  LDA  DEC0AND1,X ;Read indexed byte from BCD output buffer
                                  AND  #$0F     ;Zero the high digit
                                  JSR  BCDTOASC ;Convert BCD digit to ASCII DECIMAL digit, send digit to terminal
                                  INX           ;Increment BCD output buffer index
                                  CPX  #$05
                                  BNE  BCDOUTL  ;LOOP back to BCDOUTL IF output buffer index <> 5
                                  CPY  #$00
                                  BNE  BCDOUTDN ; ELSE, GOTO BCDOUTDN IF any non-zero digits were processed
                                  LDA  #$30     ; ELSE, send "0" to terminal
                                  JSR  COUT
BCDOUTDN:
	RTS           ;Done BCDOUT subroutine, RETURN
	.pend

;BCDTOASC subroutine:
; convert BCD digit to ASCII DECIMAL digit, send digit to terminal IF it's not a leading zero
BCDTOASC	.proc
	BNE  NONZERO  ;GOTO NONZERO IF BCD digit <> 0
                                  CPY  #$00     ; ELSE, GOTO BTADONE IF no non-zero digits have been processed
                                  BEQ  BTADONE  ;  (supress output of leading zeros)
NONZERO:
	INY           ; ELSE, indicate that a non-zero digit has been processed (Y REGISTER <> 0)
                                  CLC           ;Add ASCII "0" to digit: convert BCD digit to ASCII DECIMAL digit
                                  ADC  #$30
                                  JSR  COUT     ;Send converted digit to terminal
BTADONE:
	RTS           ;Done BCDTOASC subroutine, RETURN
	.pend
;
;
;BEEP subroutine: Send ASCII [BELL] to terminal
BEEP	.proc
	PHA           ;Save ACCUMULATOR on STACK
                                  LDA  #$07     ;Send ASCII [BELL] to terminal
                                  JSR  COUT
                                  PLA           ;Restore ACCUMULATOR from STACK
                                  RTS           ;Done BEEP subroutine, RETURN
	.pend
;
;BN2ASC subroutine: Convert byte in ACCUMULATOR to two ASCII HEX digits.
; Returns: ACCUMULATOR = high digit, Y-REGISTER = low digit
BN2ASC	.proc
	TAX           ;Copy ACCUMULATOR to X-REGISTER
                                  AND  #$F0     ;Mask (zero) low nybble
                                  LSR        ;Move high nybble to low nybble: high nybble now = 0
                                  LSR
                                  LSR
                                  LSR
                                  JSR  ASCII    ;Convert nybble to an ASCII HEX digit
                                  PHA           ;Save high digit on STACK
                                  TXA           ;Restore ACCUMULATOR from X-REGISTER
                                  AND  #$0F     ;Mask (zero) high nybble
                                  JSR  ASCII    ;Convert nybble to an ASCII HEX digit
                                  TAY           ;Copy low digit to Y-REGISTER
                                  PLA           ;Pull high digit from STACK to ACCUMULATOR
                                  RTS           ;Done BN2ASC subroutine, RETURN
	.pend

ASCII	.proc
	CMP  #$0A     ;GOTO ASOK IF nybble < $A
                                  BCC  ASOK
                                  CLC           ; ELSE, clear CARRY
                                  ADC  #$07     ;ADD $07
ASOK:
	ADC  #$30     ;ADD $30
                                  RTS           ;Done BN2ASC or ASCII subroutine, RETURN
	.pend
;
;BSOUT subroutine: send [BACKSPACE] to terminal
BSOUT	.proc
	LDA  #$08     ;Send [BACKSPACE] to terminal
                                  JMP  COUT     ; then done BSOUT subroutine, RETURN
	.pend

;
;CHIN subroutine: Wait for a keystroke, return with keystroke in ACCUMULATOR
CHIN	.proc
	STX  TEMP     ;Save X REGISTER
CHINLOOP:
	CLI           ;Enable external IRQ response
                                  LDA  INCNT    ;(Keystroke buffer input counter)
                                  CMP  OUTCNT   ;(Keystroke buffer output counter)
                                  BEQ  CHIN     ;LOOP back to CHIN IF INCNT = OUTCNT: there are no keystrokes in buffer
                                  LDX  OUTCNT   ; ELSE, read indexed keystroke from buffer
                                  LDA  KEYBUFF,X
                                  INC  OUTCNT   ;Remove keystroke from buffer
                                  LDX  TEMP     ;Restore X REGISTER
                                  RTS           ;Done CHIN subroutine, RETURN
	.pend

;
;CHREG subroutine: Display HEX byte value in ACCUMULATOR, request HEX byte input from terminal
CHREG                             .proc
	JSR  PRBYTE   ;Display HEX value of ACCUMULATOR
                                  JSR  SPC      ;Send [SPACE] to terminal
                                  JMP  HEXIN2   ;Request HEX byte input from terminal (result in ACCUMULATOR)
	              ; then done CHREG subroutine, RETURN
                                  .pend

;
;COUT subroutines: Send byte in ACCUMULATOR to terminal (1,2 or 3 times)
COUT3:	JSR  COUT     ;(Send byte 3 times)
COUT2:	JSR  COUT     ;(Send byte 2 times)
COUT                              .proc
	PHA           ;Save ACCUMULATOR on STACK
COUTL:	LDA  SIOSTAT  ;Read ACIA status register
                                  AND  #$10     ;Isolate transmit data register status bit
                                  BEQ  COUTL    ;LOOP back to COUTL IF transmit data register is full
                                  PLA           ; ELSE, restore ACCUMULATOR from STACK
                                  STA  SIODAT   ;Write byte to ACIA transmit data register
                                  RTS           ;Done COUT subroutine, RETURN
                                  .pend

;
;DECINPUT subroutine: request 1 to 10 DECIMAL digits from terminal. Result is
; stored in zero-page address INBUFF through (INBUFF + $0A)
;Setup RDLINE subroutine parameters:
DECINPUT                          .proc
	LDA  #$FF     ;  Allow only valid ASCII DECIMAL digits to be entered:
                                  STA  LOKOUT   ;   variable LOKOUT = $FF
                                  LDY  #INBUFF  ;  Y-REGISTER = buffer address low byte
                                  LDA  #$00     ;  ACCUMULATOR = buffer address high byte
                                  LDX  #$0A     ;  X-REGISTER = maximum number of digits allowed
                                  JSR  RDLINE   ;Request ASCII DECIMAL digit(s) input from terminal
                                  RTS           ;Done DECINPUT subroutine, RETURN
                                  .pend

;
;DECINDEX subroutine: decrement 16 bit system variable INDEX,INDEXH
DECINDEX                          .proc
	LDA  INDEX
	BNE  DECDONE
	DEC  INDEXH
DECDONE:
	DEC  INDEX
                                  RTS           ;Done DECINDEX subroutine, RETURN
                                  .pend

;
;DOLLAR subroutine: Send "$" to terminal
;CROUT subroutines: Send CR,LF to terminal (1 or 2 times)
DOLLAR                            .proc
	PHA           ;Save ACCUMULATOR on STACK
                                  LDA  #'$'     ;Send "$" to terminal
                                  BRA  SENDIT   ;GOTO SENDIT
                                  .pend

;Send CR,LF to terminal 2 times
CR2                               .proc
	JSR  CROUT    ;Send CR,LF to terminal
                                  .pend
;Send CR,LF to terminal 1 time
CROUT                             .proc
	PHA           ;Save ACCUMULATOR
                                  LDA  #$0D     ;Send [RETURN] to terminal
                                  JSR  COUT
                                  LDA  #$0A     ;Send [LINEFEED] to terminal
                                  .pend

SENDIT                            .proc
	JSR  COUT
                                  PLA           ;Restore ACCUMULATOR from STACK
                                  RTS           ;Done CROUT or DOLLAR subroutine, RETURN
                                  .pend

;
;DELAY1 subroutine: short delay loop, duratiion is (1 * DELLO)
;DELAY2 subroutine: medium delay loop, duration is (DELHI * DELLO)
DELAY1                            .proc
	LDX  #$01     ;Preset delay multiplier to 1
                                  JMP  ITER
DELAY2:
	LDX  DELHI    ;Read delay multiplier variable
ITER:
	LDY  DELLO    ;Read delay duration variable
WAIT:
	DEY           ;Decrement duration counter
                                  BNE  WAIT     ;LOOP back to WAIT IF duration <> 0
                                  DEX           ; ELSE, decrement multiplier
                                  BNE  ITER     ;LOOP back to ITER IF multiplier <> 0
                                  RTS           ; ELSE, done DELAYn subroutine, RETURN
                                  .pend

;HEXIN subroutines: Request 1 to 4 ASCII HEX digit input from terminal
; then convert digits into a binary (byte or word) value
;IF 1 OR 2 digits are REQUESTED, returns byte in ACCUMULATOR
;IF 3 OR 4 digits are REQUESTED, returns word in variable INDEX (low byte),INDEXH (high byte)
;Variable SCNT will contain the number of digits entered
HEXIN2                            .proc
	LDA  #$02     ;Request 2 ASCII HEX digits from terminal: 8 bit value
                                  BRA  HEXIN    ;GOTO HEXIN: always branch
                                  .pend

HEXIN4                            .proc
	LDA  #$04     ;Request 4 ASCII HEX digits from terminal: 16 bit value
                                  .pend

HEXIN                             .proc
	STA  INQTY    ;Store number of digits to allow: value = 1 to 4 only
                                  JSR  DOLLAR   ;Send "$" to terminal
;Setup RDLINE subroutine parameters:
                                  LDA  #$80     ;  Allow only valid ASCII HEX digits to be entered:
                                  STA  LOKOUT   ;   make variable LOKOUT <> 0
                                  LDA  #$00     ;  ACCUMULATOR = buffer address high byte
                                  LDY  #INBUFF  ;  Y-REGISTER = buffer address low byte
                                  LDX  INQTY    ;  X-REGISTER = maximum number of digits allowed
                                  JSR  RDLINE   ;Request ASCII HEX digit(s) input from terminal
                                  STX  SCNT     ;Save number of digits entered to SCNT
                                  LDA  INQTY    ;GOTO JUST4 IF 4 digits were REQUESTED
                                  CMP  #$04
                                  BEQ  JUST4
                                  CMP  #$03     ; ELSE, GOTO JUST3 IF 3 digits were REQUESTED
                                  BEQ  JUST3
                                  CPX  #$00     ; ELSE, GOTO IN2 IF 0 OR 2 digits were entered
                                  BEQ  IN2
                                  CPX  #$02
                                  BEQ  IN2
                                  JSR  JUST4.JUSTBYTE ; ELSE, move digit from INBUFF to INBUFF+1, write "0" to INBUFF
IN2:
	LDA  INBUFF   ;Convert 2 ASCII HEX digits in INBUFF(high digit),
                                  LDY  INBUFF+1 ; INBUFF+1(low digit) to a binary value,
                                  JMP  ASC2BN   ; (result in ACCUMULATOR) then RETURN (done HEXIN subroutine)
JUST3:
	CPX  #$00     ;GOTO IN3 IF 0 OR 3 digits were entered
                                  BEQ  IN3
                                  CPX  #$03
                                  BEQ  IN3
                                  CPX  #$02     ; ELSE, GOTO SHFT3 IF 2 digits were entered
                                  BEQ  SHFT3
                                  JSR  JUST4.JUSTBYTE ; ELSE, move digit from INBUFF to INBUFF+1, write "0" to INBUFF
SHFT3:
	JSR  JUST4.SHIFT    ;Move digits from INBUFF+1 to INBUFF+2, INBUFF to INBUFF+1
IN3:
	LDA  #$30     ;Convert 2 ASCII HEX digits, "0"(high digit),
                                  LDY  INBUFF   ; INBUFF(low digit) to a binary value,
                                  JSR  ASC2BN   ; result in ACCUMULATOR
                                  STA  INDEXH   ;Store in variable INDEXH(high byte)
                                  LDA  INBUFF+1 ;Convert 2 ASCII HEX digits in INBUFF+1(high digit),
                                  LDY  INBUFF+2 ; INBUFF+2(low digit) to a binary value,
                                  JSR  ASC2BN   ; result in ACCUMULATOR
                                  STA  INDEX    ;Store in variable INDEX(low byte)
                                  RTS           ;Done HEXIN subroutine, RETURN
                                  .pend

JUST4                             .proc
	CPX  #$00     ;GOTO IN4 IF 0 OR 4 digits were entered
                                  BEQ  IN4
                                  CPX  #$04
                                  BEQ  IN4
                                  CPX  #$03     ; ELSE, GOTO X3 IF 3 digits were entered
                                  BEQ  X3
                                  CPX  #$02     ; ELSE, GOTO X2 IF 2 digits were entered
                                  BEQ  X2
                                  JSR  JUSTBYTE ; ELSE, move digit from INBUFF to INBUFF+1, write "0" to INBUFF
X2:
	JSR  SHIFT    ;Move digits from INBUFF+1 to INBUFF+2, INBUFF to INBUFF+1
X3:
	LDA  INBUFF+2 ;Move digits from INBUFF+2 to INBUFF+3
                                  STA  INBUFF+3
                                  JSR  SHIFT    ;Move digits from INBUFF+1 to INBUFF+2, INBUFF to INBUFF+1
IN4:
	LDA  INBUFF   ;Convert 2 ASCII HEX digits in INBUFF(high digit),
                                  LDY  INBUFF+1 ; INBUFF+1(low digit) to a binary value,
                                  JSR  ASC2BN   ; result in ACCUMULATOR
                                  STA  INDEXH   ;Store in variable INDEXH(high byte)
                                  LDA  INBUFF+2 ;Convert 2 ASCII HEX digits in INBUFF+2(high digit),
                                  LDY  INBUFF+3 ; INBUFF+3(low digit) to a binary value,
                                  JSR  ASC2BN   ; result in ACCUMULATOR
                                  STA  INDEX    ;Store in variable INDEX(low byte)
                                  RTS           ;Done HEXIN subroutine, RETURN
SHIFT:
	LDA  INBUFF+1 ;Move digit from INBUFF+1 to INBUFF+2
                                  STA  INBUFF+2
JUSTBYTE:
	LDA  INBUFF   ;Move digit from INBUFF to INBUFF+1
                                  STA  INBUFF+1
                                  LDA  #$30     ;Write "0" to INBUFF
                                  STA  INBUFF
                                  RTS           ;Done SHIFT or JUSTBYTE subroutine, RETURN
                                  .pend

;
;
;HEXOUT subroutine: convert 8 HEX digits to ASCII HEX digits then send result to terminal.
;Leading zeros are supressed in the displayed result.
;Call with 8 digit (4 byte) HEX value contained in variables HEX0AND1 through HEX6AND7:
;HEX0AND1 Two most significant HEX digits
;HEX2AND3
;HEX4AND5
;HEX6AND7 Two least significant HEX digits
HEXOUT                            .proc
	LDX  #$00     ;Initialize HEX output buffer index: point to MSB
                                  LDY  #$00     ;Initialize leading zero flag: no non-zero digits have been processed
HEXOUTL:
	LDA  HEX0AND1,X ;Read indexed byte from HEX output buffer
                                  LSR        ;Shift high digit to low digit, zero high digit
                                  LSR
                                  LSR
                                  LSR
                                  JSR  HEXTOASC ;Convert HEX digit to ASCII HEX digit, send digit to terminal
                                  LDA  HEX0AND1,X ;Read indexed byte from HEX output buffer
                                  AND  #$0F     ;Zero the high digit
                                  JSR  HEXTOASC ;Convert HEX digit to ASCII HEX digit, send digit to terminal
                                  INX           ;Increment HEX output buffer index
                                  CPX  #$04
                                  BNE  HEXOUTL  ;LOOP back to HEXOUTL IF output buffer index <> 4
                                  CPY  #$00
                                  BNE  HEXOUTDN ; ELSE, GOTO HEXOUTDN IF any non-zero digits were processed
                                  LDA  #$30     ; ELSE, send "0" to terminal
                                  JSR  COUT
HEXOUTDN:
	RTS           ;Done HEXOUT subroutine, RETURN
                                  .pend

;
;HEXTOASC subroutine:
; convert HEX digit to ASCII HEX digit then send digit to terminal IF it's not a leading zero
HEXTOASC                          .proc
	BNE  HNONZERO ;GOTO HNONZERO IF HEX digit <> 0
                                  CPY  #$00     ; ELSE, GOTO HTADONE IF no non-zero digits have been processed
                                  BEQ  HTADONE  ;  (supress output of leading zeros)
HNONZERO:
	INY           ; ELSE, indicate that a non-zero digit has been processed (Y REGISTER <> 0)
                                  PHA           ;Save HEX digit on STACK
                                  SEC
                                  SBC  #$0A
                                  BCS  HEXDIGIT ;GOTO HEXDIGIT IF digit > 9
                                  PLA           ; ELSE, restore digit from STACK
                                  ADC  #$30     ;Add ASCII "0" to digit: convert $00 through $09 to ASCII "0" through "9"
                                  BCC  SENDIGIT ;GOTO SENDIGIT: always branch
HEXDIGIT:
	CLC
                                  PLA           ;Restore digit from STACK
                                  ADC  #$37     ;Add ASCII "7" to digit: convert $0A through $0F to ASCII "A" through "F"
SENDIGIT:
	JSR  COUT     ;Send converted digit to terminal
HTADONE:
	RTS           ;Done HEXTOASC subroutine, RETURN
                                  .pend

;
;
;INCINDEX subroutine: increment 16 bit system variable INDEX,INDEXH
INCINDEX                          .proc
	INC  INDEX
	BNE  INCDONE
	INC  INDEXH
INCDONE:
                                  RTS           ;Done INCINDEX subroutine, RETURN
                                  .pend

;
;
;PRASC subroutine: Send byte in ACCUMULATOR to terminal IF it is a printable ASCII character,
; ELSE, send "." to terminal. Printable ASCII byte values = $20 through $7E
;PERIOD subroutine: Send "." to terminal
PRASC                             .proc
	CMP  #$7F
                                  BCS  PERIOD   ;GOTO PERIOD IF byte >= $7F
                                  CMP  #$20
                                  BCS  ASCOUT   ; ELSE, GOTO ASCOUT IF byte >= $20
PERIOD:
	LDA  #$2E     ;  ELSE, load ACCUMULATOR with "."
ASCOUT:
	JMP  COUT     ;Send byte in ACCUMULATOR to terminal then done PRASC subroutine, RETURN
                                  .pend

;
;PRBYTE subroutine: Send 2 ASCII HEX digits to terminal which represent value in ACCUMULATOR
PRBYTE                            .proc
	JSR  SAVREGS  ;Save ACCUMULATOR, X,Y REGISTERS on STACK
                                  JSR  BN2ASC   ;Convert byte in ACCUMULATOR to 2 ASCII HEX digits
                                  JSR  COUT     ;Send most significant HEX digit to terminal
                                  TYA
                                  JSR  COUT     ;Send least significant HEX digit to terminal
                                  JSR  RESREGS  ;Restore ACCUMULATOR, X,Y REGISTERS from STACK
                                  RTS           ;Done PRBYTE subroutine, RETURN
                                  .pend

;
;PRINDX subroutine: Send 4 ASCII HEX digits to terminal which represent value in
; 16 bit variable INDEX,INDEXH
PRINDX                            .proc
	PHA           ;Save ACCUMULATOR
                                  LDA  INDEXH   ;Display INDEX high byte
                                  JSR  PRBYTE
                                  LDA  INDEX    ;Display INDEX low byte
                                  JSR  PRBYTE
                                  PLA           ;Restore ACCUMULATOR
                                  RTS           ;Done PRINDX subroutine, RETURN
                                  .pend

;
;PROMPT subroutine: Send indexed text string to terminal. Index is ACCUMULATOR,
; strings buffer address is stored in variable PROLO, PROHI.
; PROMPT subroutine.

PROMPT                            .proc
	JSR  SAVREGS    ;Save ACCUMULATOR, X,Y REGISTERS on STACK
                                  TAX             ;Initialize string counter from ACCUMULATOR
	LDY  #0         ;Initialize byte counter
FIND:
	LDA  (PROLO),Y  ;Read indexed byte from buffer
                                  BEQ  ZERO       ;GOTO ZERO IF byte = $00
NEXT:
	INY             ; ELSE, increment byte counter
                                  BNE  FIND       ;GOTO FIND IF counter != 0
                                  INC  PROHI      ; ELSE, increment page
                                  BRA  FIND       ;GOTO FIND
ZERO:
	DEX             ;Decrement string counter
                                  BNE  NEXT       ;LOOP back to NEXT IF string counter <> 0
                                  INY
;Send indexed string to terminal
STRINGL:
	LDA  (PROLO),Y  ;Read indexed byte from buffer
                                  BEQ  QUITP      ;GOTO QUITP IF byte = $00
                                  JSR  COUT       ; ELSE, send byte to terminal
                                  INY             ;Increment byte counter
                                  BNE  STRINGL    ;LOOP back to STRINGL: always branch
                                  INC  PROHI      ;Message > 255 chars, so increment page
                                  BRA  STRINGL    ;LOOP back to STRINGL
QUITP:
	JSR  RESREGS    ;Restore ACCUMULATOR, X,Y REGISTERS from STACK
                                  RTS             ;Done PROMPT subroutine, RETURN
                                  .pend


;
;READ subroutine: Read from address pointed to by INDEX,INDEXH
READ                              .proc
	LDY  #$00
                                  LDA  (INDEX),Y
                                  RTS           ;Done READ subroutine, RETURN
                                  .pend

;
;RDCHAR subroutine: Wait for a keystroke then clear bit 7 of keystroke value.
; IF keystroke is a lower-case alphabetical, convert it to upper-case
RDCHAR                            .proc
	JSR  CHIN     ;Request keystroke input from terminal
                                  AND  #$7F     ;Clear bit 7 of keystroke value
                                  CMP  #$61
                                  BCC  AOK      ;GOTO AOK IF keystroke value < $61: a control code, upper-case alpha or numeral
                                  SEC           ; ELSE, subtract $20: convert to upper-case
                                  SBC  #$20
AOK:
	RTS           ;Done RDCHAR subroutine, RETURN
                                  .pend

;
;The following subroutine (RDLINE) is derivative of published material:
; (pp. 418-424)
; "6502 assembly language subroutines"
; By Lance A. Leventhal, Winthrope Saville
; copyright 1982 by McGraw-Hill
; ISBN: 0-931988-59-4
;RDLINE subroutine: Setup a keystroke input buffer then store keystrokes in buffer
; until [RETURN] key it struck. Lower-case alphabeticals are converted to upper-case.
;Call with:
; ACCUMULATOR = buffer address high byte
; Y REGISTER  = buffer address low byte
; X REGISTER  = buffer length
;IF variable LOKOUT = $00 then allow all keystrokes.
;IF variable LOKOUT = $FF then allow only ASCII DECIMAL numeral input: 0123456789
;IF variable LOKOUT = $01 through $FE then allow only valid ASCII HEX numeral input: 0123456789ABCDEF
;[BACKSPACE] key removes keystrokes from buffer.
;[ESCAPE] key aborts RDLINE then re-enters monitor.
RDLINE                            .proc
	STA  BUFADRH  ;Store buffer address high byte
                                  STY  BUFADR   ;Store buffer address low byte
                                  STX  BUFLEN   ;Store buffer length
                                  STZ  BUFIDX   ;Initialize RDLINE buffer index: # of keystrokes stored in buffer = 0
RDLOOP:
	JSR  RDCHAR   ;Request keystroke input from terminal, convert lower-case Alpha. to upper-case
                                  CMP  #$1B     ;GOTO NOTESC IF keystroke <> [ESCAPE]
                                  BNE  NOTESC
                                  JMP  MONITOR.NMON     ; ELSE, abort RDLINE, GOTO NMON: re-enter monitor
;****Replace above JMP NMON with NOP, NOP, NOP to DISABLE********************************************************
; [ESCAPE] key function during RDLINE keystroke input,
; including HEXIN subroutine digit input
; This will prevent application users from inadvertently
; entering SyMon monitor****
NOTESC:
	CMP  #$0D     ;GOTO EXITRD IF keystroke = [RETURN]
                                  BEQ  EXITRD
                                  CMP  #$08     ; ELSE, GOTO BACK IF keystroke = [BACKSPACE]
                                  BEQ  BACK
                                  LDX  LOKOUT   ; ELSE, GOTO FULTST IF variable LOKOUT = $00: keystroke filter is disabled
                                  BEQ  FULTST
                                  CMP  #$30     ; ELSE, filter enabled, GOTO INERR IF keystroke value < $30: value < ASCII "0"
                                  BCC  INERR
                                  CMP  #$47     ; ELSE, GOTO INERR IF keystroke >= $47: value >= ASCII "G" ("F" + 1)
                                  BCS  INERR
                                  CMP  #$41     ; ELSE, GOTO DECONLY IF keystroke >= $41: value >= ASCII "A"
                                  BCS  DECONLY
                                  BCC  DECTEST  ; ELSE, GOTO DECTEST: keystroke < $41: value < ASCII "A"
DECONLY:
	CPX  #$FF     ;GOTO FULTST IF LOKOUT variable != $FF: ASCII DECIMAL digit filter disabled
                                  BNE  FULTST
DECTEST:
	CMP  #$3A     ; ELSE, DECIMAL filter enabled, GOTO INERR IF keystroke = OR > $3A:
                                  BCS  INERR    ;   value >= ASCII ":" ("9" + 1)
FULTST:
	LDY  BUFIDX   ; ELSE, GOTO STRCH IF BUFIDX != BUFLEN: buffer is not full
                                  CPY  BUFLEN
                                  BCC  STRCH
INERR:
	JSR  BEEP     ; ELSE, Send [BELL] to terminal
                                  BNE  RDLOOP   ;LOOP back to RDLOOP: always branch
STRCH:
	STA  (BUFADR),Y ;Store keystroke in buffer
                                  JSR  COUT     ;Send keystroke to terminal
                                  INC  BUFIDX   ;Increment buffer index
                                  BNE  RDLOOP   ;LOOP back to RDLOOP: always branch
EXITRD:
	LDX  BUFIDX   ;Copy keystroke count to X-REGISTER
                                  RTS           ;Done RDLINE subroutine, RETURN
                                  .pend

;Perform a destructive [BACKSPACE]
BACK                              .proc
	LDA  BUFIDX   ;GOTO BSERROR IF buffer is empty
                                  BEQ  BSERROR
                                  DEC  BUFIDX   ; ELSE, decrement buffer index
                                  JSR  BSOUT    ;Send [BACKSPACE] to terminal
                                  JSR  SPC      ;Send [SPACE] to terminal
                                  JSR  BSOUT    ;Send [BACKSPACE] to terminal
                                  BRA  RDLINE.RDLOOP   ;LOOP back to RDLOOP: always branch
BSERROR:
	JSR  BEEP     ;Send [BELL] to terminal
                                  BRA  RDLINE.RDLOOP   ;LOOP back to RDLOOP: always branch
                                  .pend

;
;RESREGS subroutine: restore ACCUMULATOR, X,Y REGISTERS from the copy previously saved
; on the STACK by the SAVREGS subroutine
RESREGS                           .proc
	PLA           ;Pull RTS RETURN address high byte from STACK
                                  STA  RT1      ;Save RTS RETURN address high byte to memory
                                  PLA           ;Pull RTS RETURN address low byte from STACK
                                  STA  RT2      ;Save RTS RETURN address low byte to memory
                                  PLX           ;Pull saved X REGISTER from STACK
                                  PLY           ;Pull saved Y REGISTER from STACK
                                  PLA           ;Pull saved ACCUMULATOR from STACK
                                  STA  STEMP    ;Save ACCUMULATOR to memory
                                  LDA  RT2      ;Read RTS RETURN address low byte from memory
                                  PHA           ;Push RTS RETURN address low byte onto STACK
                                  LDA  RT1      ;Read RTS RETURN address high byte from memory
                                  PHA           ;Push RTS RETURN address high byte onto STACK
                                  LDA  STEMP    ;Restore ACCUMULATOR from memory
                                  RTS           ;Done RESREGS subroutine, RETURN
                                  .pend

;
;SAVREGS subroutine: save a copy of ACCUMULATOR, X,Y REGISTERS on the STACK.
;This is used in conjunction with the RESREGS subroutine
SAVREGS                           .proc
	STA  STEMP    ;Save ACCUMULATOR to memory
                                  PLA           ;Pull RTS RETURN address high byte from STACK
                                  STA  RT1      ;Save RTS RETURN address high byte to memory
                                  PLA           ;Pull RTS RETURN address low byte from STACK
                                  STA  RT2      ;Save RTS RETURN address low byte to memory
                                  LDA  STEMP    ;Restore ACCUMULATOR from memory
                                  PHA           ;Push ACCUMULATOR onto STACK
                                  PHY           ;Push Y REGISTER onto STACK
                                  PHX           ;Push X REGISTER onto STACK
                                  LDA  RT2      ;Read RTS RETURN address low byte from memory
                                  PHA           ;Push RTS RETURN address low byte onto STACK
                                  LDA  RT1      ;Read RTS RETURN address high byte from memory
                                  PHA           ;Push RTS RETURN address high byte onto STACK
                                  LDA  STEMP    ;Restore ACCUMULATOR from memory
                                  RTS           ;Done SAVREGS subroutine, RETURN
                                  .pend

;
;SBYTSTR subroutine: request 0 - 16 byte string from terminal, each byte followed by [RETURN].
; [ESCAPE] aborts. String will be stored in 16 byte buffer beginning at address SRCHBUFF.
; Y REGISTER holds number of bytes in buffer. This is used by monitor text/byte string
; search commands
SBYTSTR                           .proc
	LDY  #$00     ;Initialize index/byte counter
SBLOOP:
	STY  IDY      ;Save index/byte counter
                                  LDA  #$02     ;Request 2 HEX digit input from terminal (byte value)
                                  JSR  HEXIN
                                  JSR  SPC2     ;Send 2 [SPACE] to terminal
                                  LDY  IDY      ;Restore index/byte counter
                                  CPX  #$00     ;GOTO DONESB IF no digits were entered
                                  BEQ  DONESB
                                  STA  SRCHBUFF,Y ; ELSE, Store byte in indexed buffer location
                                  INY           ;Increment index/byte counter
                                  CPY  #$10     ;LOOP back to SBLOOP IF index/byte counter < $10
                                  BNE  SBLOOP
DONESB:
	RTS           ; ELSE, done SBYTSTR, RETURN
                                  .pend

;
;SENGINE subroutine: Scan memory range $0300 through $FFFF for exact match to string
; contained in buffer SRCHBUFF (1 to 16 bytes/characters). Display address of first
; byte/character of each match found until the end of memory is reached.
; This is used by monitor text/byte string search commands
SENGINE                           .proc
	CPY  #$00     ;GOTO DUNSENG IF SRCHBUFF buffer is empty
                                  BEQ  DUNSENG
                                  STY  IDY      ; ELSE, save buffer byte/character count
                                  LDA  #$03     ;Initialize memory address pointer to $0300: skip over $0000 through $0200
                                  STA  INDEXH
                                  LDY  #$00     ; and initialize (zero) memory address index
                                  STY  INDEX
SENGBR2:
	LDX  #$00     ;Initialize buffer index: point to first byte/character in buffer
SENGBR3:
	LDA  (INDEX),Y ;Read current memory location
                                  CMP  SRCHBUFF,X ;GOTO SENGBR1 IF memory matches indexed byte/character in buffer
                                  BEQ  SENGBR1
                                  LDX  #$00     ; ELSE, initialize buffer index: point to first byte/character in string
                                  LDA  (INDEX),Y ;Read current memory location
                                  CMP  SRCHBUFF,X ;GOTO SENGBR2 IF memory matches indexed byte/character in buffer
                                  BEQ  SENGBR2
                                  JSR  SINCPTR  ; ELSE, increment memory address pointer, test for end of memory
                                  JMP  SENGBR2  ;LOOP back to SENGBR2
SENGBR1:
	JSR  SINCPTR  ;Increment memory address pointer, test for end of memory
                                  INX           ;Increment buffer index
                                  CPX  IDY      ;LOOP back to SENGBR3 IF buffer index <> memory index
                                  BNE  SENGBR3
                                  SEC           ; ELSE, subtract buffer index from memory address pointer:
                                  LDA  INDEX    ;  (point to first byte of matching string found in memory)
                                  SBC  IDY
                                  STA  INDEX
                                  LDA  INDEXH
                                  SBC  #$00
                                  STA  INDEXH
                                  LDA  #$0A     ;Send "found " to terminal
                                  JSR  PROMPT
                                  LDA  #$0C     ;Send "at: $" to terminal
                                  JSR  PROMPT
                                  LDA  INDEXH   ;Display address of matching string
                                  JSR  PRBYTE
                                  LDA  INDEX
                                  JSR  PRBYTE
                                  LDA  #$0E     ;Send "N=Next? " to terminal
                                  JSR  PROMPT
                                  JSR  CHIN     ;Request a keystroke from terminal
                                  AND  #$DF     ;Convert lower case Alpha. to upper case
                                  CMP  #$4E     ;GOTO DUNSENG IF keystroke <> "N"
                                  BNE  DUNSENG
                                  JSR  SINCPTR  ;ELSE, increment memory address pointer, test for end of memory
                                  JMP  SENGBR2  ;LOOP back to SENGBR2
DUNSENG:
	LDA  INCNT    ;Remove last keystroke from keystroke input buffer
                                  STA  OUTCNT
                                  RTS           ;Done SENGINE subroutine, RETURN
;Increment memory address pointer. If pointer high byte = 00 (end of memory),
; send "not found" to terminal then return to monitor
SINCPTR:
	JSR  INCINDEX ;Increment memory address pointer
                                  CMP  #$00     ;GOTO DUNSINC IF memory address pointer high byte <> 00
                                  BNE  DUNSINC
                                  LDA  #$0B     ; ELSE, send "not " to terminal
                                  JSR  PROMPT
                                  LDA  #$0A     ;Send "found " to terminal
                                  JSR  PROMPT
                                  LDA  INCNT    ;Remove last keystroke from keystroke input buffer
                                  STA  OUTCNT
                                  JMP  NMON     ;Done SRCHBYT or SRCHTXT command, GOTO NMON: return to monitor
DUNSINC:
	RTS           ;Done SINCPTR subroutine, RETURN
                                  .pend

;
;SET subroutine: Set TIMER duration from X REGISTER then call TIMER.
;TIMER subroutine: Perform a long delay. Duration is SETIM * (DELLO * DELHI)
SET                               .proc
	STX  SETIM    ;Store duration value in SETIM variable
TIMER:
	JSR  SAVREGS  ;Save ACCUMULATOR, X,Y REGISTERS on STACK
                                  LDX  SETIM    ;Copy SETIM to TEMP variable: TIMER multiplier
                                  STX  TEMP
TIMERL:
	JSR  DELAY1.DELAY2   ;Perform a medium delay. Duration is DELLO * DELHI
                                  DEC  TEMP     ;Decrement TIMER multiplier
                                  BNE  TIMERL   ;LOOP back to TIMERL IF TIMER multiplier <> 0
                                  JSR  RESREGS  ; ELSE, restore ACCUMULATOR, X,Y REGISTERS from STACK
                                  RTS           ;Done SET or TIMER subroutine, RETURN
                                  .pend

;
;SETUP subroutine: Request HEX address input from terminal
SETUP                             .proc
	JSR  COUT     ;Send command keystroke to terminal
                                  JSR  SPC      ;Send [SPACE] to terminal
;Request a 0-4 digit HEX address input from terminal
                                  JSR  HEXIN4   ; result in variable INDEX,INDEXH
                                  LDA  #$3A     ;Send ":" to terminal
                                  JSR  COUT
                                  JMP  DOLLAR   ;Send "$" to terminal then done SETUP subroutine, RETURN
                                  .pend

;
;SPC subroutines: Send [SPACE] to terminal 1,2 or 4 times
SPC4                              .proc
	JSR  SPC2     ;Send 4 [SPACE] to terminal
                                  .pend

SPC2                              .proc
	JSR  SPC      ;Send 2 [SPACE] to terminal
                                  .pend


SPC                               .proc
	PHA           ;Save ACCUMULATOR
                                  LDA  #$20     ;Send [SPACE] to terminal
                                  JSR  COUT
                                  PLA           ;Restore ACCUMULATOR
                                  RTS           ;Done SPC(n) subroutine, RETURN
                                  .pend

;
;GET_UP_TO_16_CHR_STRING subroutine: request 1 - 16 character text string from terminal, followed by [RETURN].
; [ESCAPE] aborts, [BACKSPACE] erases last keystroke. String will be stored in
; 16 byte buffer beginning at address SRCHBUFF. Y REGISTER holds number of characters in buffer
; This is used by monitor text/byte string search commands
GET_UP_TO_16_CHR_STRING           .proc
	LDY  #$00     ;Initialize index/byte counter
STLOOP:
	JSR  CHIN     ;Request keystroke input from terminal
                                  CMP  #$0D     ;GOTO STBR1 IF keystroke = [RETURN]
                                  BEQ  STBR1
                                  CMP  #$1B     ; ELSE, GOTO STBR2 IF keystroke <> [ESCAPE]
                                  BNE  STBR2
                                  LDY  #$00     ; ELSE, indicate that there are no keystrokes to process
STBR1:
	RTS           ;Done GET_UP_TO_16_CHR_STRING subroutine, RETURN
STBR2:
	CMP  #$08     ;GOTO STBR3 IF keystroke <> [BACKSPACE]
                                  BNE  STBR3
                                  TYA           ; ELSE, LOOP back to STLOOP IF buffer is empty
                                  BEQ  STLOOP
                                  JSR  BSOUT    ; ELSE, send [BACKSPACE] to terminal
                                  DEY           ;Decrement index/byte counter
                                  JMP  STLOOP   ;LOOP back to STLOOP
STBR3:
	STA  SRCHBUFF,Y ;Store character in indexed buffer location
                                  JSR  COUT     ;Send character to terminal
                                  INY           ;Increment index/byte counter
                                  CPY  #$10     ;LOOP back to STLOOP IF index/byte counter < $10
                                  BNE  STLOOP
                                  RTS           ; ELSE, done GET_UP_TO_16_CHR_STRING subroutine, RETURN
                                  .pend

;
;
;******************************
;* Monitor command processors *
;******************************
;
;[invalid] command: No command assigned to keystroke. This handles unassigned keystrokes
ERR                               .proc
	JSR  BEEP     ;Send ASCII [BELL] to terminal
                                  PLA           ;Remove normal return address because we don't
                                  PLA           ; want to send a monitor prompt in this case
                                  JMP  MONITOR.CMON     ;GOTO CMON re-enter monitor
                                  .pend

;
;
;[F] MFILL command: Fill a specified memory range with a specified value
MFILL                             .proc
	JSR  ASMPROHILO ;Point to prompt strings array
                                  LDA  #$02     ;Send CR,LF, "fill start: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN4   ;Request 4 digit HEX value input from terminal. Result in variable INDEX,INDEXH
                                  LDX  SCNT     ;GOTO DUNFILL IF no digits were entered
                                  BEQ  DONEFILL
                                  LDA  INDEX    ; ELSE, copy INDEX,INDEXH to TEMP2,TEMP2H: memory fill start address
                                  STA  TEMP2
                                  LDA  INDEXH
                                  STA  TEMP2H
                                  LDA  #$03     ;Send CR,LF, "length: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN4   ;Request 4 digit HEX value input from terminal. Result in variable INDEX,INDEXH: memory fill length
                                  LDX  SCNT     ;GOTO DUNFILL IF no digits were entered
                                  BEQ  DONEFILL
                                  LDA  #$04     ; ELSE, send CR,LF, "value: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN2   ;Request 2 digit HEX value input from terminal. Result in ACCUMULATOR: fill value
                                  LDX  SCNT     ;GOTO DUNFILL IF no digits were entered
                                  BEQ  DONEFILL
                                  PHA           ;Save fill value on STACK
                                  LDA  #$01     ;Send CR,LF, "Esc key exits, any other to proceed" to terminal
                                  JSR  PROMPT
                                  JSR  CHIN     ;Request keystroke input from terminal
                                  CMP  #$1B     ;GOTO QUITFILL IF keystroke = [ESCAPE]
                                  BEQ  QUITFILL
                                  PLA           ; ELSE, pull fill value from STACK
USERFILL:
	LDX  INDEXH   ;Copy INDEXH to X REGISTER: X = length parameter page counter
                                  BEQ  FILEFT   ;GOTO FILEFT IF page counter = $00
                                  LDY  #$00     ; ELSE, initialize page byte address index
PGFILL:
	STA  (TEMP2),Y ;Store fill value at indexed current page address
                                  INY           ;Increment page byte address index
                                  BNE  PGFILL   ;LOOP back to PGFILL IF page byte address index <> $00
                                  INC  TEMP2H   ; ELSE, Increment page address high byte
                                  DEX           ;Decrement page counter
                                  BNE  PGFILL   ;LOOP back to PGFILL IF page counter <> $00
FILEFT:
	LDX  INDEX    ; ELSE, copy INDEX to X REGISTER: X = length parameter byte counter
                                  BEQ  DONEFILL ;GOTO DONEFILL IF byte counter = $00
                                  LDY  #$00     ; ELSE, initialize page byte address index
FILAST:
	STA  (TEMP2),Y ;Store fill value at indexed current page address
                                  INY           ;Increment page byte address index
                                  DEX           ;Decrement byte counter
                                  BNE  FILAST   ;LOOP back to FILAST IF byte counter <> $00
QUITFILL:
	PLA           ;Pull saved fill value from STACK: value not needed, discard
DONEFILL:
                                  RTS           ;Done MFILL command, RETURN
                                  .pend

;
;The following command processor (MOVER) is derivative of published material:
; (pp. 197-203)
; "6502 assembly language subroutines"
; By Lance A. Leventhal, Winthrope Saville
; copyright 1982 by McGraw-Hill
; ISBN: 0-931988-59-4
;[M] MOVER command: Move (copy) specified source memory area to specified destination memory area
MOVER                             .proc
	JSR  ASMPROHILO ;Point to prompt strings array
                                  LDA  #$05     ;Send CR,LF, "move source: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN4   ;Request 4 digit HEX value input from terminal. Result in variable INDEX,INDEXH: memory move source address
                                  LDX  SCNT     ;GOTO QUITMV IF no digits were entered
                                  BEQ  QUITMV
                                  STA  TEMP3    ; ELSE, store source address in variable TEMP3,TEMP3H
                                  LDA  INDEXH
                                  STA  TEMP3H
                                  LDA  #$06     ;Send CR,LF, "destination: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN4   ;Request 4 digit HEX value input from terminal. Result in variable INDEX,INDEXH: memory move destination address
                                  LDX  SCNT     ;GOTO QUITMV IF no digits were entered
                                  BEQ  QUITMV
                                  STA  TEMP2    ; ELSE, store destination address in variable TEMP2,TEMP2H
                                  LDA  INDEXH
                                  STA  TEMP2H
                                  LDA  #$03     ;Send CR,LF, "length: " to terminal
                                  JSR  PROMPT
                                  JSR  HEXIN4   ;Request 4 digit HEX value input from terminal. Result in variable INDEX,INDEXH: memory move length
                                  LDX  SCNT     ;GOTO QUITMV IF no digits were entered
                                  BEQ  QUITMV
                                  LDA  #$01     ;Send CR,LF, "Esc key exits, any other to proceed" to terminal
                                  JSR  PROMPT
                                  JSR  CHIN     ;Request keystroke input from terminal
                                  CMP  #$1B     ;GOTO QUITMV IF keystroke = [ESCAPE]
                                  BEQ  QUITMV
                                  LDA  TEMP2    ; ELSE, GOTO RIGHT IF source memory area is above destination memory area
                                  SEC           ;  AND overlaps it (destination address - source address) < length of move
                                  SBC  TEMP3
                                  TAX           ;   X REGISTER = destination address low byte - source address low byte
                                  LDA  TEMP2H
                                  SBC  TEMP3H
                                  TAY           ;   Y REGISTER = destination address high byte - (source address high byte + borrow)
                                  TXA
                                  CMP  INDEX    ;   produce borrow IF (destination address low - source address low) < destination low
                                  TYA
                                  SBC  INDEXH   ;   produce borrow IF ((destination address high - source address high) + borrow) < dest. high
                                  BCC  RIGHT    ;   Branch if a borrow was produced (unmoved source memory overwrite condition detected)
;Move memory block first byte to last byte
                                  LDY  #$00     ; ELSE, initialize page byte index
                                  LDX  INDEXH   ;Copy length high byte to X REGISTER: page counter
                                  BEQ  MVREST   ;GOTO MVREST IF move length is < $100 bytes
MVPGE:
	LDA  (TEMP3),Y ; ELSE, move (copy) byte from indexed source to indexed destination memory
                                  STA  (TEMP2),Y
                                  INY           ;Increment page byte index
                                  BNE  MVPGE    ;LOOP back to MVPAGE IF page byte index <> 0: loop until entire page is moved
                                  INC  TEMP3H   ; ELSE, increment source page address
                                  INC  TEMP2H   ;Increment destination page address
                                  DEX           ;Decrement page counter
                                  BNE  MVPGE    ;LOOP back to MVPAGE IF page counter <> 0: there are more full pages to move
                                                ; ELSE,(page byte index (Y REGISTER) = 0 at this point)
MVREST:
	LDX  INDEX    ;Copy length parameter low byte to X REGISTER: byte counter
                                  BEQ  QUITMV   ;GOTO QUITMV IF byte counter = 0: there are no bytes left to move
REST:
	LDA  (TEMP3),Y ; ELSE, move (copy) byte from indexed source to indexed destination memory
                                  STA  (TEMP2),Y
                                  INY           ;Increment page byte index
                                  DEX           ;Decrement byte counter
                                  BNE  REST     ;LOOP back to REST IF byte counter <> 0: loop until all remaining bytes are moved
QUITMV:
	RTS           ; ELSE, done MOVER command, RETURN

;Move memory block last byte to first byte (avoids unmoved source memory overwrite in certain source/dest. overlap)
RIGHT
	LDA  INDEXH   ;Point to highest address page in source memory block
                                  CLC           ;  source high byte = (source high byte + length high byte)
                                  ADC  TEMP3H
                                  STA  TEMP3H
                                  LDA  INDEXH   ;Point to highest address page in destination memory block
                                  CLC           ;  destination high byte = (destination high byte + length high byte)
                                  ADC  TEMP2H
                                  STA  TEMP2H
                                  LDY  INDEX    ;Copy length low byte to Y REGISTER: page byte index
                                  BEQ  MVPAG    ;GOTO MVPAG IF page byte index = 0: no partial page to move
RT:
	DEY           ; ELSE, decrement page byte index
                                  LDA  (TEMP3),Y ;Move (copy) byte from indexed source to indexed destination memory
                                  STA  (TEMP2),Y
                                  CPY  #$00     ;LOOP back to RT IF page byte index <> 0: loop until partial page is moved
                                  BNE  RT
MVPAG:
	LDX  INDEXH   ; ELSE, copy length high byte to X REGISTER: page counter
                                  BEQ  QUITMV   ;GOTO QUITMV IF page counter = 0: no full pages left to move
RDEC:
	DEC  TEMP3H   ; ELSE, decrement source page address
                                  DEC  TEMP2H   ;Decrement destination page address
RMOV:
	DEY           ;Decrement page byte index
                                  LDA  (TEMP3),Y ;Move (copy) byte from indexed source to indexed destination memory
                                  STA  (TEMP2),Y
                                  CPY  #$00     ;LOOP back to RMOV IF page byte index <> 0: loop until entire page is moved
                                  BNE  RMOV
                                  DEX           ; ELSE, decrement page counter
                                  BNE  RDEC     ;LOOP back to RDEC IF page counter <> 0: loop until all full pages are moved
                                  RTS           ; ELSE, done MOVER command, RETURN
                                  .pend

;
;
;
;PRBIT subroutine: Send "0" or "1" to terminal depending on condition of indexed bit in
; PROCESSOR STATUS preset/result
PRBIT                             .proc
	LDA  #':'     ;Send ":" to terminal
                                  JSR  COUT
                                  LDA  PREG     ;Read PROCESSOR STATUS preset/result
;Select number of shifts required to isolate indexed bit
                                  CPX  #$0B
                                  BEQ  LS1
                                  CPX  #$0E
                                  BEQ  LS2
                                  CPX  #$11
                                  BEQ  LS4
                                  CPX  #$14
                                  BEQ  LS5
                                  CPX  #$17
                                  BEQ  LS6
                                  CPX  #$1A
                                  BEQ  LS7
;Left-shift indexed bit into CARRY flag
                                  ASL        ;Bit 0 CARRY
LS7:
	ASL        ;Bit 1 ZERO
LS6:
	ASL        ;Bit 2 INTERRUPT REQUEST
LS5:
	ASL        ;Bit 3 DECIMAL
LS4:
	ASL        ;Bit 4 BREAK
                                  ASL        ;Bit 5 (This bit is undefined in the 6502 PROCESSOR STATUS REGISTER)
LS2:
	ASL        ;Bit 6 OVERFLOW
LS1:
	ASL        ;Bit 7 NEGATIVE
                                  BCS  BITSET   ;Send "0" to terminal IF bit is clear
                                  LDA  #$30
                                  BNE  RDONE
BITSET:
	LDA  #$31     ; ELSE, Send "1" to terminal
RDONE:
	JSR  COUT
                                  JMP  SPC      ;Send [SPACE] to terminal then done PRBIT subroutine, RETURN
                                  .pend

REGARA:
	.text  "AXYSP"
                                  .text  "-> NEGOVRBRK"
                                  .text  "DECIRQZERCAR "
;
;[S] STACK POINTER command: Display then change STACK POINTER preset/result
SRG                               .proc
	LDA  #$10     ;Send "stack pointer:$" to terminal
                                  JSR  PROMPT
                                  LDA  SREG     ;Read STACK POINTER preset/result
                                  JSR  CHREG    ;Display preset/result, request HEX byte input from terminal
                                  LDX  SCNT     ;GOTO NCSREG IF no digits were entered
                                  BEQ  NCSREG
                                  STA  SREG     ; ELSE, write entered byte to STACK POINTER preset/result
NCSREG:
	RTS           ;Done SRG command, RETURN
                                  .pend

;
;
	
PROMPT2                           .proc
	LDY  #$00     ;Read from current view memory address
                                  LDA  (INDEX),Y
                                  BEQ  VIEWEXIT ;GOTO VIEWEXIT IF byte read = 0
                                  JSR  COUT     ; ELSE, send character/byte read to terminal
                                  JSR  INCINDEX ;Increment view memory address pointer
                                  BRA  PROMPT2  ;LOOP back to PROMPT2
VIEWEXIT:
	RTS           ;Done VIEWTXT command, RETURN
                                  .pend

;
;[W] WATCH command: Continuously read then display contents of a specified address, loop until keystroke
WATCH                             .proc
	JSR  SETUP    ;Request HEX address input from terminal
                                  .pend

WATCHL                            .proc
	JSR  READ     ;Read specified address
                                  JSR  PRBYTE   ;Display HEX value read
                                  JSR  DELAY1.DELAY2   ;Do a medium (~ 0.2 second) delay
                                  LDA  #$08     ;Send 2 [BACKSPACE] to terminal
                                  JSR  COUT2
                                  CLI           ;Enable IRQ service
                                  LDA  INCNT    ;LOOP back to WATCHL IF INCNT = OUTCNT: no key was struck
                                  CMP  OUTCNT
                                  BEQ  WATCHL
                                  SEI           ; ELSE, Disable IRQ service
                                  INC  OUTCNT   ;Remove last keystroke from buffer
                                  RTS           ;Done WATCH command, RETURN
                                  .pend


;
;[CNTL-L] LISTER command: call disassembler
LISTER                            .proc
	JSR  ASMPROHILO ;Point to assembler/disassembler prompt strings
                                  JSR  LIST     ;Call disassembler
	JSR  MONPROHILO ;Point to monitor prompt strings
                                  RTS           ;Done LISTER command, RETURN
                                  .pend

;
;
;[CNTL-W] WIPE command: clear (write: $00) RAM memory from $0000 through $7FFF then coldstart SyMon
WIPE                              .proc
	LDA  #$15     ;Send "Wipe RAM?" to terminal
                                  JSR  PROMPT
	JSR  ASMPROHILO	;Point INDEX to strings
                                  LDA  #$01     ;Send CR,LF,"ESC key exits, any other to proceed" to terminal
                                  JSR  PROMPT
                                  JSR  CHIN     ;Request a keystroke from terminal
                                  CMP  #$1B     ;GOTO DOWIPE IF keystroke <> [ESC]
                                  BNE  DOWIPE
                                  RTS           ; ELSE, abort WIPE command, RETURN
DOWIPE:
	LDA  #$02     ;Initialize temporary address pointer to $0002
                                  STA  $00
                                  LDA  #$00
                                  STA  $01
                                  TAX           ;Make index offset, ACCUMULATOR both = $00
WIPELOOP:
	STA  ($00,X)  ;Write $00 to current address
                                  INC  $00      ;Increment address pointer
                                  BNE  WIPELOOP
                                  INC  $01
                                  BPL  WIPELOOP ;LOOP back to WIPELOOP IF address pointer < $8000
                                  STA  $01      ; ELSE, clear address pointer
                                  .pend

; Done WIPE command, GOTO COLDSTART
;
;
;*********************************
;* COLDSTART: Power-up OR        *
;* pushbutton RESET vectors here *
;* Also WIPE command will call   *
;* this.
;*********************************
;
COLDSTART                         .proc
	CLD           ;Disable decimal mode
                                  LDX  #$FF     ;Initialize STACK POINTER
                                  TXS
;;; Initialise ACIA
                                  LDA  #$1F     ;Initialize serial port (terminal I/O) 6551/65c51 ACIA
                                  STA  SIOCON   ; (19.2K BAUD,no parity,8 data bits,1 stop bit,
                                  LDA  #$09     ;  receiver IRQ output enabled)
                                  STA  SIOCOM
;;; End init ACIA

;;; Initialise VIA
	LDA  #$FF
	STA  VIADDRA		;Set PA pins to be output
	STA  VIADDRB		;Set PB pins to be output
	STA  VIAIER		;Enable interrupts for everything
;;; End init VIA

;;; Initialise IDE
	JSR IDE_INIT_DEVICES
;;; End init IDE

;;; Initialise SyMonIII
;;; Initialise system variables as follows:
                                  STA  DELLO    ; delay time low byte
                                  STA  DELHI    ; high byte
	JSR  MONPROHILO	;prompt string buffer address pointer high and low byte
                                  STZ  ACCUM    ; ACCUMULATOR preset/result value
                                  STZ  XREG     ; X-REGISTER preset/result value
                                  STZ  YREG     ; Y-REGISTER preset/result value
                                  STZ  PREG     ; PROCESSOR STATUS REGISTER preset/result value
                                  STZ  OUTCNT   ; keystroke buffer 'read from' counter
                                  STZ  INCNT    ; keystroke buffer 'written to' counter
                                  LDA  #$7F
                                  STA  SREG     ; USER program/application STACK POINTER preset/result value
                                  LDX  #$01     ; Set delay time
                                  JSR  SET      ; do short delay
                                  JSR  CR2      ; Send 2 CR,LF to terminal
;;; Send BIOS logon messages to terminal
                                  LDA  #$03     ; Send big PLUTO + "S/O/S BIOS/monitor (c)1990 B.Phelps" to terminal
                                  JSR  PROMPT
                                  JSR  CROUT    ; Send CR,LF to terminal
	JSR  MONPROHILO
                                  LDA  #$01     ; Send "Version mm.dd.yy" to terminal
                                  JSR  PROMPT
                                  JSR  CROUT    ; Send CR,LF to terminal
                                  LDA  #$02     ; Send "[ctrl-a] runs sub-assembler" to terminal
                                  JSR  PROMPT
                                  JSR  CR2      ; Send 2 CR,LF to terminal
                                  LDA  #$0B     ; Send "SyMon III" to terminal
                                  JSR  PROMPT
                                  .pend
;
;
;**********************
;* SyMon III monitor  *
;* command input loop *
;**********************
;
MONITOR                           .proc
                                  STZ  LOKOUT   ;Disable ASCII HEX/DEC digit filter, (RDLINE subroutine uses this)
                                  JSR  CR2      ;Send 2 CR,LF to terminal
	JSR  MONPROHILO
                                  LDA  #$0C     ;Send "Monitor:" to terminal
                                  JSR  PROMPT
                                  JSR  BEEP     ;Send ASCII [BELL] to terminal
NMON:
	LDX  #$FF     ;Initialize STACK POINTER
                                  TXS
                                  JSR  MONPROHILO ;Restore monitor prompt string buffer address pointer
                                                  ; in case a monitor command, user or an application changed it
                                  JSR  CR2	;Send 2 CR,LF to terminal
	LDA  #'M'	;Send "M" to terminal
                                  JSR  COUT
	LDA  #'-'	;Send "-" to terminal
                                  JSR  COUT
CMON:
	JSR  RDCHAR   ;Wait for keystroke: RDCHAR converts lower-case Alpha. to upper-case
                                  PHA           ;Save keystroke to STACK
                                  ASL        	;Multiply keystroke value by 2
                                  TAX           ;Get monitor command processor address from table MONTAB
                                  LDA  MONTAB,X ; using multiplied keystroke value as the index
                                  STA  COMLO    ;Store selected command processor address low byte
                                  INX
                                  LDA  MONTAB,X
                                  STA  COMHI    ;Store selected command processor address hi byte
                                  PLA           ;Restore keystroke from STACK: some command processors send keystroke to terminal
                                  JSR  DOCOM    ;Call selected monitor command processor as a subroutine
                                  JMP  NMON     ;LOOP back to NMON: command has been processed, go wait for next command
DOCOM:
	JMP  (COMLO)  ;Go process command then RETURN
                                  .pend

;
;
;******************************
;* Monitor command jump table *
;******************************
;
;List of monitor command processor addresses. These are indexed by ASCII keystroke values
; which have been filtered (lower case Alpha. converted to upper case) then multiplied by 2
;        command:     keystroke: Keystroke value:  Monitor command function:
MONTAB:
        .word  ASSEM    ;[CTRL-A]             $01  Call Sub-Assembler utility
        .word  ERR      ;[CTRL-B]             $02
        .word  ERR      ;[CTRL-C]             $03
        .word  DOWNLOAD ;[CTRL-D]             $04  Download data/program file (MS HYPERTERM use: paste-to-host)
        .word  ERR      ;[CTRL-E]             $05
        .word  ERR      ;[CTRL-F]             $06
        .word  ERR      ;[CTRL-G]             $07
        .word  ERR      ;[CTRL-H],[BACKSPACE] $08
        .word  ERR      ;[CTRL-I],[TAB]       $09
        .word  ERR      ;[CTRL-J],[LINEFEED]  $0A
        .word  ERR      ;[CTRL-K]             $0B
        .word  LISTER   ;[CTRL-L]             $0C  Disassemble from specified address
        .word  ERR      ;[CTRL-M],[RETURN]    $0D
        .word  ERR      ;[CTRL-N]             $0E
        .word  ERR      ;[CTRL-O]             $0F
        .word  ERR      ;[CTRL-P]             $10
        .word  ERR      ;[CTRL-Q]             $11
        .word  COLDSTART ;[CTRL-R]             $12  Restart same as power-up or RESET
        .word  ERR      ;[CTRL-S]             $13
        .word  ERR      ;[CTRL-T]             $14
        .word  ERR      ;[CTRL-V]             $16
        .word  WIPE     ;[CTRL-W]             $17  Clear memory ($0000-$7FFF) then restart same as power-up or COLDSTART
        .word  ERR      ;[CTRL-X]             $18
        .word  ERR      ;[CTRL-Y]             $19
        .word  ERR      ;[CTRL-Z]             $1A
        .word  ERR      ;[CTRL-[],[ESCAPE]    $1B
        .word  ERR      ;[CTRL-\]             $1C
        .word  ERR      ;[CTRL-]]             $1D
        .word  ERR      ;                     $1E
        .word  ERR      ;                     $1F
        .word  SPC2     ;[SPACE]              $20  Send [SPACE] to terminal (test for response, do nothing else)
        .word  ERR      ; !                   $21
        .word  ERR      ; "                   $22
        .word  ERR      ; #                   $23
        .word  ERR      ; $                   $24
        .word  ERR      ; %                   $25
        .word  ERR      ; &                   $26
        .word  ERR      ; '                   $27
        .word  ERR      ; *                   $2A
        .word  ERR      ; +                   $2B
        .word  ERR      ; -                   $2D
        .word  ERR      ; /                   $2F
        .word  ERR      ; 0                   $30
        .word  ERR      ; 1                   $31
        .word  ERR      ; 2                   $32
        .word  ERR      ; 3                   $33
        .word  ERR      ; 4                   $34
        .word  ERR      ; 5                   $35
        .word  ERR      ; 6                   $36
        .word  ERR      ; 7                   $37
        .word  ERR      ; 8                   $38
        .word  ERR      ; 9                   $39
        .word  ERR      ; :                   $3A
        .word  ERR      ; ;                   $3B
        .word  ERR      ; <                   $3C
        .word  ERR      ; =                   $3D
        .word  ERR      ; >                   $3E
        .word  ERR      ; ?                   $3F
        .word  ERR      ; @                   $40
        .word  MFILL    ; F                   $46  Fill a specified memory range with a specified value
        .word  MOVER    ; M                   $4D  Copy a specified memory range to a specified target address
        .word  ERR      ; N                   $4E  (Reserved: NEXT/NOTHING command)
        .word  QUERY    ; Q                   $51  Display list of useful system subroutines
        .word  SRG      ; S                   $53  Examine/change STACK POINTER preset/result
        .word  UPLOAD   ; U                   $55  Upload data/program file
        .word  WATCH    ; W                   $57  Monitor a specified memory location's contents until a key is struck
        .word  ERR      ; [                   $5B
        .word  ERR      ; \                   $5C
        .word  ERR      ; ]                   $5D
        .word  ERR      ; ^                   $5E
        .word  ERR      ; _                   $5F
        .word  ERR      ; `                   $60
;
;
;*************************************
;* IRQ/BRK Interrupt service routine *
;*************************************
;
INTERUPT:
	STA  AINTSAV  ;Save ACCUMULATOR
                                  STX  XINTSAV  ;Save X-REGISTER
                                  STY  YINTSAV  ;Save Y-REGISTER
                                  LDA  SIOSTAT  ;Read 6551 ACIA status register
                                  AND  #$88     ;Isolate bits. bit 7: Interrupt has occured and bit 3: receive data register full
                                  EOR  #$88     ;Invert state of both bits
                                  BNE  BRKINSTR ;GOTO BRKINSTR IF bit 7 = 1 OR bit 3 = 1: no valid data in receive data register
                                  LDA  SIODAT   ; ELSE, read 6551 ACIA receive data register
                                  BEQ  BREAKEY  ;GOTO BREAKEY IF received byte = $00
                                  LDX  INCNT    ; ELSE, Store keystroke in keystroke buffer address
                                  STA  KEYBUFF,X ;  indexed by INCNT: keystroke buffer input counter
                                  INC  INCNT    ;Increment keystroke buffer input counter
ENDIRQ:
	LDA  AINTSAV  ;Restore ACCUMULATOR
                                  LDX  XINTSAV  ;Restore X-REGISTER
                                  LDY  YINTSAV  ;Restore Y-REGISTER
                                  RTI           ;Done INTERUPT (IRQ) service, RETURN FROM INTERRUPT

;
BRKINSTR:
	PLA           ;Read PROCESSOR STATUS REGISTER from STACK
                                  PHA
                                  AND  #$10     ;Isolate BREAK bit
                                  BEQ  ENDIRQ   ;GOTO ENDIRQ IF bit = 0
                                  LDA  AINTSAV  ; ELSE, restore ACCUMULATOR to pre-interrupt condition
                                  STA  ACCUM    ;Save in ACCUMULATOR preset/result
                                  PLA           ;Pull PROCESSOR STATUS REGISTER from STACK
                                  STA  PREG     ;Save in PROCESSOR STATUS preset/result
                                  STX  XREG     ;Save X-REGISTER
                                  STY  YREG     ;Save Y-REGISTER
                                  TSX
                                  STX  SREG     ;Save STACK POINTER
                                  JSR  CROUT    ;Send CR,LF to terminal
                                  PLA           ;Pull RETURN address from STACK then save it in INDEX
                                  STA  INDEX    ; Low byte
                                  PLA
                                  STA  INDEXH   ;  High byte
                                  JSR  CROUT    ;Send CR,LF to terminal
                                  JSR  CROUT    ;Send CR,LF to terminal
                                  JSR  DISLINE  ;Disassemble then display instruction at address pointed to by INDEX
                                  LDA  #$00     ;Clear all PROCESSOR STATUS REGISTER bits
                                  PHA
                                  PLP
BREAKEY:
	LDX  #$FF     ;Set STACK POINTER to $FF
                                  TXS
                                  LDA  #$7F     ;Set STACK POINTER preset/result to $7F
                                  STA  SREG
                                  LDA  INCNT    ;Remove keystrokes from keystroke input buffer
                                  STA  OUTCNT
                                  JMP  MONITOR.NMON     ;Done interrupt service process, re-enter monitor

;
;
;***********************
;* S/O/S Sub-Assembler *
;*        v3.6         *
;* (c)1990 By B.Phelps *
;***********************
;
;Sub-assembler main loop
;
ASSEM                             .proc
	JSR  CR2      ;Send 2 CR,LF to terminal
	JSR  ASMPROHILO ;Point to prompt strings (assembler strings)
                                  LDA  #$12     ;Send "S/O/S sub-assembler v3.6" to terminal
                                  JSR  PROMPT
                                  JSR  CR2      ;Send 2 CR,LF to terminal
                                  JSR  REORIG   ;Request origin address input from terminal (working address)
NEWLIN:
	JSR  CROUT    ;Send CR,LF to terminal
NLIN:
	JSR  DOLLAR   ;Send "$" to terminal
                                  JSR  PRINDX   ;Display current working address
                                  LDA  #$2D     ;Send "-" to terminal
                                  JSR  COUT
                                  JSR  SPC2     ;Send 2 [SPACE] to terminal
REENTR:
	LDX  #$03     ;Initialize mnemonic keystroke counter
ENTER:
	JSR  RDCHAR   ;Request a keystroke, convert lower-case Alpha. to upper-case
                                  CMP  #$1B     ;GOTO ANOTESC IF keytroke <> [ESCAPE]
                                  BNE  ANOTESC
                                  JMP  MONITOR.NMON     ;Done ASSEM, GOTO NMON: go back to monitor
ANOTESC:
	CMP  #$20     ;GOTO NOTSPC IF keytroke <> [SPACE]
                                  BNE  NOTSPC
                                  JSR  SAVLST   ; ELSE, save current working address
                                  LDA  #$0D     ;Send [RETURN] to terminal
                                  JSR  COUT
                                  JSR  DISLINE  ;Disassemble byte(s) found at working address, calculate next working address
                                  JMP  NLIN     ;LOOP back to NLIN
NOTSPC:
	CMP  #$2E     ;GOTO DIRECTV IF keystroke = "."
                                  BEQ  DIRECTV
NEM:
	CMP  #$5B     ; ELSE, GOTO TOOHI IF keystroke >= ("Z"+1)
                                  BCS  TOOHI
                                  CMP  #$41     ; ELSE, GOTO NOTLESS IF keystroke >= "A"
                                  BCS  NOTLESS
TOOHI:
	JSR  BEEP     ; ELSE, send [BELL] to terminal
                                  JMP  ENTER    ;LOOP back to ENTER
NOTLESS:
	STA  INBUFF-1,X ;Store keystroke in INBUFF indexed by mnemonic keystroke counter
                                  JSR  COUT     ;Send keystroke to terminal
                                  DEX           ;Decrement mnemonic keystroke counter
                                  BNE  ENTER    ;LOOP back to ENTER IF mnemonic keystroke counter <> 0
                                  LDY  #$01     ; ELSE, initialize mnemonic counter
RDLOOP2:
	LDA  MTAB,X   ;GOTO SKIP3 IF indexed character in MTAB <> keystroke in INBUFF+2
                                  CMP  INBUFF+2
                                  BNE  SKIP3
                                  INX           ; ELSE, increment mnemonic table index
                                  LDA  MTAB,X   ;GOTO SKIP2 IF indexed character in MTAB <> keystroke in INBUFF+1
                                  CMP  INBUFF+1
                                  BNE  SKIP2
                                  INX           ; ELSE, increment mnemonic table index
                                  LDA  MTAB,X   ;GOTO SKIP1 IF indexed character in MTAB <> keystroke in INBUFF
                                  CMP  INBUFF
                                  BNE  SKIP1
                                  TYA           ; ELSE, multiply mnemonic counter by 2: mnemonic handler jump table index
                                  CLC
                                  ASL
                                  TAX
                                  LDA  JTAB,X   ;Read indexed mnemonic handler address from jump table,
                                  STA  COMLO    ; store address at COMLO,COMHI
                                  LDA  JTAB+1,X
                                  STA  COMHI
                                  JSR  SAVLST   ;Save current working address
                                  JMP  (COMLO)  ;GOTO mnemonic handler
;Abort compare against current indexed mnemonic, point to next mnemonic in mnemonic table
SKIP3:
	INX           ;Increment mnemonic table index
SKIP2:
	INX           ;Increment mnemonic table index
SKIP1:
	INX           ;Increment mnemonic table index
                                  INY           ;Increment mnemonic counter
                                  CPY  #$46     ;LOOP back to RDLOOP2 IF mnemonic counter <> $46 (end of mnemonic table)
                                  BNE  RDLOOP2
                                  JSR  BEEP     ; ELSE, send [BELL] to terminal: user entered an invalid mnemonic
                                  LDA  #$08     ;Send 3 [BACKSPACE] to terminal
                                  JSR  COUT3
                                  JMP  REENTR   ;LOOP back to REENTER
;Process directives
DIRECTV:
	JSR  COUT     ;Send last keystroke (".") to terminal
                                  JSR  RDCHAR   ;Request a keystroke, convert lower-case Alpha. to upper-case
                                  LDX  #$00     ;Initialize directive table index
DIRTST:
	CMP  DIRTAB,X ;GOTO DIROK IF keystroke = indexed directive from DIRTAB
                                  BEQ  DIROK
                                  INX           ; ELSE, increment directive table index
                                  CPX  #$0F     ;LOOP back to DIRTST IF directive table index <> $0F (end of directive table)
                                  BNE  DIRTST
                                  JSR  BEEP     ; ELSE, send [BELL] to terminal: user entered an invalid directive
                                  JMP  NEWLIN   ;LOOP back to NEWLIN
DIROK:
	CLC           ;multiply directive table index by 2: directive handler jump table index
                                  TXA
                                  ASL
                                  TAX
                                  LDA  DJTAB,X  ;Read indexed directive handler address from jump table,
                                  STA  COMLO    ; store address at COMLO,COMHI
                                  LDA  DJTAB+1,X
                                  STA  COMHI
                                  JSR  DODIR    ;Call directive handler as a subroutine
                                  JMP  NEWLIN   ;LOOP back to NEWLIN
DODIR:
	JMP  (COMLO)  ;GOTO directive handler
                                  .pend

;
;Assembler directive handlers:
;
;
;[.B] BYTE directive subroutine: Request HEX byte(s) input from terminal, store byte(s) in working memory.
; This loops until [RETURN] is struck when no HEX digits have been entered
ABYTE                             .proc
	JSR  SAVLST   ;Save current working address
                                  LDA  #$0F     ;Send "Byte: " to terminal
                                  JSR  PROMPT
BYLOOP:
	JSR  SPC2     ;Send 2 [SPACE] to terminal
                                  JSR  HEXIN2   ;Request 1 or 2 HEX digit (data byte) input from terminal
                                  LDX  SCNT     ;GOTO BYOK IF any digits were entered
                                  BNE  BYOK
                                  RTS           ; ELSE, done ABYTE directive, RETURN
BYOK:
	LDX  #$00     ;Store entered byte at current working address
                                  STA  (INDEX,X)
                                  JSR  INCNDX   ;Increment working address
                                  JMP  BYLOOP   ;LOOP back to BYLOOP
                                  .pend

;
;
;[.I] KEYCONV directive subroutine: display HEX equivalent of a keystroke to terminal
KEYCONV:
	JSR  CHIN     ;Request a keystroke from terminal
                                  PHA           ;Save keystroke on STACK
                                  JSR  PRASC    ;Send keystroke to terminal IF printable ASCII, ELSE send "."
                                  LDA  #$3D     ;Send "=" to terminal
                                  JSR  COUT
                                  JSR  DOLLAR   ;Send "$" to terminal
                                  PLA           ;Restore keystroke value from STACK
                                  JMP  PRBYTE   ;Send ASCII HEX representation of keystroke to terminal then done, RETURN
;
;[.L] LIST directive subroutine: list (disassemble) 21 instructions
LIST:
	LDA  #$14     ;Send "List: " to terminal
                                  JSR  PROMPT
                                  JSR  SAVLST   ;Save current working address
                                  JSR  HEXIN4   ;Request 1 to 4 HEX digit address input from terminal
                                  JSR  CROUT    ;Send CR,LF to terminal
                                  LDA  SCNT     ;GOTO LSTNEW IF any digits were entered
                                  BNE  LSTNEW
                                  LDA  TEMP2    ; ELSE, make working address = last specified origin address:
                                  STA  INDEX    ;  list from last specified origin address
                                  LDA  TEMP2H
                                  STA  INDEXH
LSTNEW:
	LDA  #$15     ;Initialize instruction count: number of instructions to list = 21 ($15)
                                  STA  TEMP
DISLOOP:
	JSR  DISLINE  ;List (disassemble) one instruction
                                  DEC  TEMP     ;Decrement instruction count
                                  BNE  DISLOOP  ;LOOP back to DISLOOP IF instruction count <> 0
MORLOOP:
	JSR  CHIN     ; ELSE, request a keystroke from terminal
                                  CMP  #$0D     ;GOTO MORDIS IF keystroke <> [RETURN]
                                  BNE  MORDIS
                                  LDA  IDX      ; ELSE, make working address = saved working address:
                                  STA  INDEX    ;  restore working address to pre-LIST directive condition
                                  LDA  IDY
                                  STA  INDEXH
                                  RTS           ;Done LIST directive, RETURN
MORDIS:
	CMP  #$20     ;LOOP back to LSTNEW IF keystroke <> [SPACE]
                                  BNE  LSTNEW
                                  JSR  DISLINE  ;List (disassemble) one instruction
                                  JMP  MORLOOP  ;LOOP back to MORLOOP
;
;[.O] REORIGIN directive subroutine: Request new working address input from terminal
REORIG:
	LDA  #$11     ;Send "Origin: " to terminal
        JSR  PROMPT
        JSR  HEXIN4   ;Request 1 to 4 HEX digit address input from terminal: enter new working address
        LDA  INDEX    ;Make origin address = new working address
        STA  TEMP2
        LDA  INDEXH
        STA  TEMP2H
        JMP  SAVLST   ;Make last working address = new working address
;
;
;[.Q] AQUERY directive subroutine: display the system subroutine list
AQUERY:
	LDA  INDEX    ;Save current working address on STACK
        PHA
        LDA  INDEXH
        PHA
        LDA  #$51     ;Read "Q" (monitor command handler QUERY sends this to terminal)
        JSR  QUERY    ;Display the system subroutine list
        JSR  CROUT    ;Send CR/LF to terminal
        PLA           ;Restore working address from STACK
        STA  INDEXH
        PLA
        STA  INDEX
        RTS           ;Done AQUERY directive, RETURN
;
;
;
;
;[.U] RECODE directive subroutine: edit last entered or disassembled instruction
RECODE:
	LDA  IDX      ;Make working address = previous (saved) assembled/disassembled instruction address
        STA  INDEX
        LDA  IDY
        STA  INDEXH
        LDA  #$13     ;Send "Recode" to terminal then RETURN: done RECODE directive
        JMP  PROMPT
;
;[.W] WORD directive subroutine: Request HEX word(s) input from terminal, store word(s) in working memory.
; This loops until [RETURN] is struck when no HEX digits have been entered. Words are stored low byte first
WORD:
	JSR  SAVLST   ;Save current working address
        LDA  #$10     ;Send "Word: " to terminal
        JSR  PROMPT
WDLOOP:
	JSR  SPC2     ;Send 2 [SPACE] to terminal
        LDA  INDEX    ;Save current working address on STACK
        PHA
        LDA  INDEXH
        PHA
        JSR  HEXIN4   ;Request 1 to 4 HEX digit (data word) input from terminal
        LDX  SCNT     ;GOTO WDOK IF any digits were entered
        BNE  WDOK
        PLA           ; ELSE, restore working address from STACK
        STA  INDEXH
        PLA
        STA  INDEX
        RTS           ;Done WORD directive, RETURN
WDOK:
	LDA  INDEX    ;Save entered data word in OPLO,OPHI
        STA  OPLO
        LDA  INDEXH
        STA  OPHI
        PLA           ;Restore working address from STACK
        STA  INDEXH
        PLA
        STA  INDEX
        LDX  #$00     ;Initialize working memory index (always = 0)
        LDA  OPLO     ;Store low byte of data word in working memory
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        LDA  OPHI     ;Store high byte of data word in working memory
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        JMP  WDLOOP   ;LOOP back to WDLOOP
;
;
;
;Assembler/disassembler subroutines:
;DISLINE subroutine: disassemble (list) 1 instruction from working address
DISLINE:
	JSR  DOLLAR   ;Send "$" to terminal
        JSR  PRINDX   ;Display working address
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        LDY  #$00     ;Read opcode byte from working memory
        LDA  (INDEX),Y
        STA  SCNT     ;Save opcode byte (some handler subroutines need the opcode byte)
        JSR  PRBYTE   ;display opcode byte
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        TAX           ;Use opcode byte to index handler pointer table
        LDA  HPTAB,X  ;Read indexed handler pointer
        TAX           ;Use handler pointer to index handler table
        LDA  HTAB,X   ;Read indexed handler address
        STA  COMLO    ; store handler address in COMLO,COMHI
        LDA  HTAB+1,X
        STA  COMHI
        JSR  ASSEM.DODIR    ;Call disassembler handler
        JSR  CROUT    ;Send CR,LF to terminal
        JSR  INCNDX   ;Increment working address pointer
        RTS           ;Done DISLINE subroutine, RETURN
;
;CHEXIN2,AHEXIN2 subroutines: request byte value input from terminal,
; returns with result in OPLO
CHEXIN2:
	JSR  COUT     ;Send character in ACCUMULATOR to terminal
AHEXIN2:
	TYA           ;Save Y-REGISTER on STACK
        PHA
H2LOOP:
	JSR  HEXIN2   ;Request 1 to 2 HEX digit input from terminal
        LDX  SCNT     ;GOTO H2OK IF any digits were entered
        BNE  H2OK
        JSR  ERRBS    ; ELSE, send [BELL],[BACKSPACE] to terminal
        JMP  H2LOOP   ;LOOP back to H2LOOP
H2OK:
	STA  OPLO     ;Store inputted byte in OPLO
        PLA           ;Restore Y-REGISTER from STACK
        TAY
        RTS           ;Done CHEXIN2 or AHEXIN2 subroutine, RETURN
;
;SHEXIN4,AHEXIN4 subroutines: request word value input from terminal,
; returns with result in OPLO,OPHI
SHEXIN4:
	JSR  SPC2     ;Send 2 [SPACE] to terminal
AHEXIN4:
	TYA           ;Save Y-REGISTER on STACK
        PHA
        LDA  INDEX    ;Save working address on STACK
        PHA
        LDA  INDEXH
        PHA
H4LOOP:
	JSR  HEXIN4   ;Request 1 to 4 HEX digit input from terminal
        LDA  SCNT     ;GOTO H4OK IF any digits were entered
        BNE  H4OK
        JSR  ERRBS    ; ELSE, send [BELL],[BACKSPACE] to terminal
        JMP  H4LOOP   ;LOOP back to H4LOOP
H4OK:
	CMP  #$03     ;Set CARRY IF > 2 digits were entered, ELSE, clear it
        LDA  INDEX    ;Store inputted word in OPLO,OPHI
        STA  OPLO
        LDA  INDEXH
        STA  OPHI
        PLA           ;Restore working address pointer from STACK
        STA  INDEXH
        PLA
        STA  INDEX
        PLA           ;Restore Y-REGISTER from STACK
        TAY
        RTS           ;Done SHEXIN4 or AHEXIN4 subroutine, RETURN
;
;BITSEL subroutine: request bit number (0 to 7) input from terminal,
; multiply bit number value by $10
BITSEL:
	JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$38     ;GOTO NOTZ2S IF keystroke = OR > "8"
        BCS  NOTZ2S
        CMP  #$30     ; ELSE, GOTO Z2SOK IF keystroke = OR > "0"
        BCS  Z2SOK    ; ELSE,
NOTZ2S:
	JSR  BEEP     ;  send [BELL] to terminal
        JMP  BITSEL   ;LOOP back to BITSEL
Z2SOK:
	JSR  COUT     ;Send inputted digit ("0" to "7") to terminal
        ASL        ;Convert ASCII digit to HEX, multiply result times $10
        ASL
        ASL
        ASL
        RTS           ;Done BITSEL subroutine, RETURN
;
;ERRBS subroutine: send [BELL],[BACKSPACE] to terminal
ERRBS:
	JSR  BEEP     ;Send [BELL] to terminal
        JMP  BSOUT    ;Send [BACKSPACE] to terminal then done ERRBS subroutine, RETURN
;
;INCNDX subroutine: increment working address pointer then read from working address
;RDNDX subroutine: read from working address
INCNDX:
	JSR  INCINDEX ;Increment working address pointer
RDNDX:
	LDX  #$00     ;Read from working address
        LDA  (INDEX,X)
        RTS           ;Done INCNDX or RDNDX subroutine, RETURN
;
;PRMNEM subroutine: send 3 character mnemonic to terminal. Mnemonic string is
; indexed by opcode byte. Sends "***" if byte is not a valid opcode
PRMNEM:
	LDX  SCNT     ;Retrieve opcode byte saved during DISLINE subroutine process
        LDA  MPTAB,X  ;Use opcode byte to index mnemonic pointer table
        TAX
        LDY  #$03     ;Initialize mnemonic character counter
PRML:
	LDA  DMTAB,X  ;Read indexed character from disassembler mnemonic table
        JSR  COUT     ;Send character to terminal
        INX           ;Increment mnemonic table index
        DEY           ;Decrement mnemonic character counter
        BNE  PRML     ;LOOP back to PRML IF counter <> 0
        JMP  SPC2     ; ELSE, send 2 [SPACE] to terminal then done PRMNEM subroutine, RETURN
;
;GETNXT subroutine: increment working address pointer, read from working address,
; display byte, send 2 [SPACE] to terminal. This displays operand byte(s)
GETNXT:
	JSR  INCNDX   ;Increment working address pointer, read from working address
        JSR  PRBYTE   ;Display byte
        JMP  SPC2     ;Send 2 [SPACE] to terminal then done GETNXT subroutine, RETURN
;
;TWOBYT subroutine: display operand byte then mnemonic of a two-byte instruction
TWOBYT:
	JSR  GETNXT   ;Read, display operand byte
        STA  OPLO     ;Save operand byte in OPLO
        LDA  #$06     ;Send 6 [SPACE] to terminal
        JSR  MSPC
        JMP  PRMNEM   ;Display mnemonic then done TWOBYT subroutine, RETURN
;
;TRIBYT subroutine: display operand bytes then mnemonic of a three-byte instruction
TRIBYT:
	JSR  GETNXT   ;Read, display operand low byte
        STA  OPLO     ;Save operand low byte in OPLO
        JSR  GETNXT   ;Read, display operand high byte
        STA  OPHI     ;Save operand high byte in OPLO
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JMP  PRMNEM   ;Display mnemonic then done TRIBYT subroutine, RETURN
;
;PR1 subroutine: display operand byte of a two-byte instruction (this follows mnemonic)
PR1:
	JSR  DOLLAR   ;Send "$" to terminal
        LDA  OPLO     ;Display operand byte
        JMP  PRBYTE
;
;PR2 subroutine: display operand bytes of a three-byte instruction (this follows mnemonic)
PR2:
	JSR  DOLLAR   ;Send "$" to terminal
        LDA  OPHI     ;Display operand high byte
        JSR  PRBYTE
        LDA  OPLO     ;Display operand low byte
        JMP  PRBYTE   ; then done PR2 subroutine, RETURN
;
;SRMB2 subroutine: display 2 operand bytes, mnemonic, isolate bit selector from opcode
;SRMB subroutine: display 1 operand byte, mnemonic, isolate bit selector from opcode
SRMB2:
	JSR  RDNDX    ;Read from working address
        PHA           ;Save byte on STACK
        JSR  TRIBYT   ;Display operand bytes and mnemonic
        JMP  SRM      ;GOTO SRM
SRMB:
	JSR  RDNDX    ;Read from working address
        PHA           ;Save byte on STACK
        JSR  TWOBYT   ;Display operand byte and mnemonic
SRM:
	LDA  #$08     ;Send 2 [BACKSPACE] to terminal
        JSR  COUT2
        PLA           ;Restore byte from STACK
        LSR        ;Move high nybble to low nybble position,
        LSR        ; zero high nybble (bit selector)
        LSR
        LSR
        RTS           ;Done SRMB2 or SRMB subroutine, RETURN
;
;LSPRD subroutine: read indexed byte from opcode pointer table, then,
;SPCRD subroutine: send 2 [SPACE] to terminal, then,
;CLKRD subroutine: send "?" to terminal, request keystroke, erase "?" from terminal after keystroke
; returns with converted keystroke in ACCUMULATOR (LSPRD returns also with Y-REGISTER = opcode pointer)
LSPRD:
	LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        TAY           ;Transfer byte (opcode pointer) to Y-REGISTER
SPCRD:
	JSR  SPC2     ;Send 2 [SPACE] to terminal
CLKRD:
	LDA  #$3F     ;Send "?" to terminal
        JSR  COUT
        JSR  RDCHAR   ;Request keystroke from terminal, convert alpha. to upper-case
        PHA           ;Save keystroke on STACK
        JSR  BSOUT    ;Send [BACKSPACE] to terminal
        JSR  SPC      ;Send [SPACE] to terminal
        JSR  BSOUT    ;Send [BACKSPACE] to terminal
        PLA           ;Restore keystroke from STACK
        RTS           ;Done LSPRD,SPCRD or CLKRD subroutine, RETURN
;
;SAVLST subroutine: save a copy of the current working address
SAVLST:
	LDA  INDEX
        STA  IDX
        LDA  INDEXH
        STA  IDY
        RTS           ;Done SAVLST subroutine, RETURN
;
;COMX subroutine: send ",X" to terminal
COMX:
	LDA  #$2C     ;","
        JSR  COUT
        LDA  #$58     ;"X"
        JMP  COUT
;
;COMY subroutine: send ",Y" to terminal
COMY:
	LDA  #$2C     ;","
        JSR  COUT
        LDA  #$59     ;"Y"
        JMP  COUT
;
;RBR subroutine: send ")" to terminal
RBR:
	LDA  #$29     ;")"
        JMP  COUT
;
;LBR subroutine: send "(" to terminal
LBR:
	LDA  #$28     ;"("
        JMP  COUT
;
;MSPC subroutine: send [SPACE] to terminal (n) times where
; (n) = value in ACCUMULATOR
MSPC:
	JSR  SAVREGS  ;Save ACCUMULATOR, X,Y REGISTERS on STACK
        TAX           ;Initialize counter from ACCUMULATOR
        LDA  #$20     ;Read [SPACE]
SLOOP:
	JSR  COUT     ;Send it to terminal
        DEX           ;Decrement counter
        BNE  SLOOP    ;LOOP back to SLOOP IF counter <> 0
        JSR  RESREGS  ; ELSE, restore ACCUMULATOR, X,Y REGISTERS from STACK
        RTS           ;Done MSPC subroutine, RETURN
;
;BROFFSET subroutine: calculate branch offset from base address to target address.
; Use low byte of target address (entered value) IF it is out of branch range:
;  Subtract target address from base address, store 1's compliment of result, add 1 to stored result
BROFFSET:
	SEC           ;Clear borrow flag
        LDA  COMLO    ;Read base address low byte
        SBC  OPLO     ;Subtract target address low byte
        EOR  #$FF     ;Store 1's complement of
        STA  TEMP3    ; result low byte
        LDA  COMHI    ;Read base address high byte
        SBC  OPHI     ;Subtract target address high byte (with borrow)
        EOR  #$FF     ;Store 1's complement of
        STA  TEMP3H   ; result high byte
        INC  TEMP3    ;Increment result low byte (MPU CARRY flag not affected here)
        BNE  WITCHWAY ;GOTO WITCHWAY IF result low byte <> 0: no carry produced
        INC  TEMP3H   ; ELSE, increment result high byte: add carry to high byte
WITCHWAY:
	BCC  BRFORWD  ;GOTO BRFORWD IF CARRY clear: base address < target address
                       ; ELSE,
; Determine if branch backward is within range:
;  TRAP EXCEPTION 1: branch FFhh to 00hh OR base address = target address
        LDA  TEMP3H   ;GOTO EXCEPTN1 IF offset high byte = $00
        BEQ  EXCEPTN1
        CMP  #$FF     ; ELSE, GOTO TOOFAR IF offset high byte = $FF
        BNE  TOOFAR
EXCEPTN2:
	LDA  TEMP3    ; ELSE, GOTO TOOFAR IF offset low byte < $80
        BPL  TOOFAR
BRANCHOK:
	LDA  TEMP3    ;This holds the valid branch offset value
        STA  OPLO
        RTS           ;Done BROFFSET subroutine, RETURN
;Determine if branch forward is within range:
; TRAP EXCEPTION 2: branch 00hh to FFhh
BRFORWD:
	LDA  OPHI     ;GOTO NORMLFWD IF target address high byte <> $FF
        CMP  #$FF
        BNE  NORMLFWD
        LDA  COMHI    ; ELSE, GOTO EXCEPTN2 IF base address high byte = $00
        BEQ  EXCEPTN2
NORMLFWD:
	LDA  TEMP3H   ; ELSE, GOTO TOOFAR IF offset high byte <> $00
        BNE  TOOFAR
EXCEPTN1:
	LDA  TEMP3    ; ELSE, GOTO BRANCHOK IF offset low byte < $80
        BPL  BRANCHOK
TOOFAR:
	LDA  #$15     ; ELSE, send "<- Offset = low byte" prompt to terminal,
        JMP  PROMPT   ;  then done BROFFSET subroutine, RETURN
;
;
;
;Disassembler handlers:
;
;SIN disassembler handler: single byte instructions: implied mode
; (note: ACCC handler calls this handler)
SIN:
	LDA  #$0A     ;Send 10 [SPACE] to terminal
        JSR  MSPC
        JMP  PRMNEM   ;Display mnemonic then done SIN handler, RETURN
;
;ACCC disassembler handler: single byte instructions that modify ACCUMULATOR: implied mode
ACCC:
	JSR  SIN      ;Send 10 [SPACE] to terminal then display mnemonic
        LDA  #$41     ;Send "A" to terminal
        JMP  COUT     ; then done ACCC handler, RETURN
;
;DABS disassembler handler: three byte instructions: absolute mode
DABS:
	JSR  TRIBYT   ;Display operand bytes, then mnemonic
        JMP  PR2      ;Display operand bytes again then done DABS handler, RETURN
;
;ZEROABS disassembler handler: two byte instructions: zero-page absolute
; (note: DZX,DZY handlers call this handler)
ZEROABS:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
        JMP  PR1      ;Display operand byte again then done ZEROABS handler, RETURN
;
;IME disassembler handler: two byte instructions: zero-page immediate mode
IME:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
        LDA  #$23     ;Send "#" to terminal
        JSR  COUT
        JMP  PR1      ;Display operand byte again then done IME handler, RETURN
;
;DIND disassembler handler: three byte instruction: JMP (INDIRECT) 16 bit indirect mode
DIND:
	JSR  TRIBYT   ;Display operand bytes, then mnemonic
        JSR  LBR      ;Send "(" to terminal
        JSR  PR2      ;Display operand bytes again
        JMP  RBR      ;Send ")" to terminal then done DIND handler, RETURN
;
;ZPDIND disassembler handler: two or three byte instructions: indirect modes
ZPDIND:
	LDA  SCNT     ;Read saved opcode byte
        CMP  #$6C     ;GOTO ZPIND IF opcode byte <> $6C JMP(INDIRECT)
        BNE  ZPIND
        JMP  DIND     ; ELSE, GOTO DIND
; this is for a two byte instruction: zero page indirect mode
ZPIND:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
        JSR  LBR      ;Send "(" to terminal
        JSR  PR1      ;Display operand byte again
        JMP  RBR      ;Send ")" to terminal then done ZPDIND handler, RETURN
;
;DZX disassembler handler: two byte instructions: zero-page absolute indexed by X mode
DZX:
	JSR  ZEROABS  ;Display operand byte, then mnemonic, then operand byte again
        JMP  COMX     ;Send ",X" to terminal then done DZX handler, RETURN
;
;DZY disassembler handler: two byte instructions: zero-page absolute indexed by Y mode
DZY:
	JSR  ZEROABS  ;Display operand byte, then mnemonic, then operand byte again
        JMP  COMY     ;Send ",Y" to terminal then done DZY handler, RETURN
;
;DAX disassembler handler: three byte instructions: absolute indexed by X mode
DAX:
	JSR  TRIBYT   ;Display operand bytes, then mnemonic
        JSR  PR2      ;Display operand bytes again
        JMP  COMX     ;Send ",X" to terminal then done DAX handler, RETURN
;
;DAY disassembler handler: three byte instructions: absolute indexed by Y mode
DAY:
	JSR  TRIBYT   ;Display operand bytes, then mnemonic
        JSR  PR2      ;Display operand bytes again
        JMP  COMY     ;Send ",Y" to terminal then done DAY handler, RETURN
;
;THX disassembler handler: two byte instructions: zero-page indirect pre-indexed by X mode
THX:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
        JSR  LBR      ;Send "(" to terminal
        JSR  PR1      ;Display operand byte again
        JSR  COMX     ;Send ",X" to terminal
        JMP  RBR      ;Send ")" to terminal then done THX handler, RETURN
;
;THY disassembler handler: two byte instructions: zero-page indirect post-indexed by Y mode
THY:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
        JSR  LBR      ;Send "(" to terminal
        JSR  PR1      ;Display operand byte again
        JSR  RBR      ;Send ")" to terminal
        JMP  COMY     ;Send ",Y" to terminal then done THY handler, RETURN
;
;INDABSX disassembler handler: three byte instruction: JMP (INDIRECT,X) 16 bit indirect
; pre-indexed by X mode
INDABSX:
	JSR  TRIBYT   ;Display operand bytes, then mnemonic
        JSR  LBR      ;Send "(" to terminal
        JSR  PR2      ;Display operand bytes again
        JSR  COMX     ;Send ",X" to terminal
        JMP  RBR      ;Send ")" to terminal then done INDABSX handler, RETURN
;
;DRMB disassembler handler: two byte instructions: zero page clear memory bits mode
; (note: DSMB,DBBR handlers call this handler at SRBIT)
DRMB:
	JSR  SRMB     ;Display operand byte, mnemonic, isolate bit selector from opcode
SRBIT:
	CLC           ;Convert bit selector value to an ASCII decimal digit
        ADC  #$30     ; (add "0" to bit selector value)
        JSR  COUT     ;Send digit to terminal
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JMP  PR1      ;Display operand byte again then done DRMB or SRBIT handler, RETURN
;
;DSMB disassembler handler: two byte instructions: zero page set memory bits mode
DSMB:
	JSR  SRMB     ;Display operand byte, mnemonic, isolate bit selector from opcode
        SEC           ;Clear M/S bit of selector low nybble: convert $08-$0F to $00-$07
        SBC  #$08     ; (subtract 8 from bit selector value)
        JMP  SRBIT    ;GOTO SRBIT
;
;DBBR disassembler handler: three byte instruction: branch on zero-page bit clear mode
DBBR:
	JSR  SRMB2    ;Display operand bytes, mnemonic, isolate bit selector from opcode
SRBIT2:
	JSR  SRBIT    ;Convert and display bit selector digit, then display first operand byte again: ZP address
        LDA  OPHI     ;Move second operand to first operand position:
        STA  OPLO     ; OPLO = branch offset
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JMP  BBREL    ;Display branch target address then done DBBR or DBBS handler, RETURN
;
;DBBS disassembler handler: three byte instruction: branch on zero page bit set mode
DBBS:
	JSR  SRMB2    ;Display operand bytes, mnemonic, isolate bit selector from opcode
        SEC           ;Clear M/S bit of selector low nybble: convert $08-$0F to $00-$07
        SBC  #$08     ; (subtract 8 from bit selector value)
        JMP  SRBIT2   ;GOTO SRBIT2
;
;RELATIVE disassembler handler: two byte relative branch mode
;BBREL disassembler handler: three byte relative branch mode (called by DBBR,DBBS handlers)
; both calculate then display relative branch target address
RELATIVE:
	JSR  TWOBYT   ;Display operand byte, then mnemonic
BBREL:
	JSR  DOLLAR   ;Send "$" to terminal
        JSR  INCINDEX ;Increment working address: point to base (branch offset = 0) address
        LDA  OPLO     ;GOTO SUBTRACT IF offset > $7F
        BMI  SUBTRACT
        CLC           ; ELSE, add offset to base address: target address
        ADC  INDEX
        STA  COMLO
        LDA  INDEXH
        ADC  #$00
RELLOOP:
	JSR  PRBYTE   ;Send target address high byte to terminal
        LDA  COMLO    ;Send target address low byte to terminal
        JSR  PRBYTE
        JMP  DECINDEX ;Decrement (restore) working address then done RELATIVE handler, RETURN
SUBTRACT:
	EOR  #$FF     ;Get 1's complement of offset
        STA  COMLO    ;Save result
        INC  COMLO    ;Increment result: value to subtract from base address
        SEC           ;Subtract adjusted offset from base address
        LDA  INDEX
        SBC  COMLO
        STA  COMLO
        LDA  INDEXH
        SBC  #$00
        JMP  RELLOOP  ;LOOP back to LELLOOP
;
;
;
;Assembler handlers:
;
;STOR assembler handler: write single byte instructions to working memory
;STOR2,CSTOR2,LSTOR2 assembler handlers: write 2 byte instructions to working memory
;STOR3,CSTOR3,LSTOR3 assembler handlers: write 3 byte instructions to working memory
; all of these jump back to the main assembler loop when done
CSTOR2:
	JSR  COUT     ;Send character in ACCUMULATOR to terminal
LSTOR2:
	LDA  OCTAB,Y  ;Read indexed opcode from opcode table
STOR2:
	LDX  #$00     ;Write opcode to working address
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        LDA  OPLO     ;Read operand byte
        JMP  STOR     ;GOTO STOR (write operand byte to working memory)
CSTOR3:
	JSR  COUT     ;Send character in ACCUMULATOR to terminal
LSTOR3:
	LDA  OCTAB,Y  ;Read indexed opcode from opcode table
STOR3:
	LDX  #$00     ;Write opcode to working address
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        LDA  OPLO     ;Read operand low byte
        STA  (INDEX,X);Write operand low byte to working address
        JSR  INCNDX   ;Increment working address pointer
        LDA  OPHI     ;Read operand high byte
STOR:
	LDX  #$00     ;Write operand high byte to working address
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        JMP  ASSEM.NEWLIN   ;Done STOR assembler handler, GOTO NEWLIN
;
;LDACC assembler handler:
LDACC:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        CMP  #$23     ;GOTO NOTIMED IF modifier <> "#"
        BNE  NOTIMED
        JSR  CHEXIN2  ; ELSE, send modifier to terminal, request operand byte input from terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
NOTIMED:
	INY           ;Increment opcode table index
STAIN:
	CMP  #$28     ;GOTO NOTIND IF modifier <> "("
        BNE  NOTIND
        JSR  COUT     ; ELSE, send modifier to terminal
        JSR  AHEXIN4  ;Request operand word input from terminal
        BCC  NOIND    ;GOTO NOIND IF < 3 digits were entered
        LDA  #$29     ; ELSE, send ")" to terminal
        JSR  COUT
        LDA  OCTAB,Y  ;Read indexed opcode from opcode table
        AND  #$0F     ;GOTO BFIXBR1 IF low digit of opcode = 2: not JMP ($nnnn) instruction
        CMP  #$02     ; This allows MMM ($nnnx), encodes as: MMM ($nn)
        BEQ  BFIXBR1  ;  unless it is a JMP ($nnnx) instruction
        JMP  LSTOR3   ;   ELSE, write 3 byte instruction to working memory then GOTO NEWLIN
;
BFIXBR1:
	LDA  OCTAB,Y  ;Read indexed opcode byte from opcode table
        LDX  #$00     ;Write opcode byte to working memory
        STA  (INDEX,X)
        JSR  INCNDX   ;Increment working address pointer
        LDA  OPLO     ;READ operand byte
        STA  (INDEX,X);Write operand byte to working address
        JSR  INCNDX   ;Increment working address pointer
        JMP  ASSEM.NEWLIN   ;Done LDACC handler, GOTO NEWLIN
;
NOIND:
	INY           ;Increment opcode table index
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$29     ;GOTO INDX IF keystroke <> ")"
        BNE  INDX
        JSR  COUT     ; ELSE, send keystroke to terminal
        JSR  COMY     ;Send ",Y" to terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
INDX:
	INY           ;Increment opcode table index
        JSR  COMX     ;Send ",X" to terminal
        LDA  #$29     ;Read ")": this will be sent to terminal by CSTOR2
        JMP  CSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
NOTIND:
	INY           ;Add 3 to opcode table index
        INY
        INY
        JSR  AHEXIN4  ;Request operand word input from terminal
        BCS  LDAABS   ;GOTO LDAABS IF > 2 digits were entered
        JMP  LDAZX    ; ELSE, GOTO LDAZX
LDAABS:
	INY           ;Add 2 to opcode table index
        INY
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO NOTIXY IF keystroke <> ","
        BNE  NOTIXY
        JSR  COUT     ; ELSE, send keystroke to terminal
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$59     ;GOTO LDIX IF keystroke <> "Y"
        BNE  LDIX
        JMP  CSTOR3   ; ELSE, Write 3 byte instruction to working memory then GOTO NEWLIN
;
LDIX:
	INY           ;Increment opcode table index
        LDA  #$58     ;Read "X": this will be sent to terminal by CSTOR3
        JMP  CSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
NOTIXY:
	INY           ;Add 2 to opcode table index
        INY
        JMP  LSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
BITS:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        CMP  #$23     ;GOTO NOTA IF keystroke <> "#"
        BNE  NOTA
        JSR  CHEXIN2  ; ELSE, send modifier to terminal, request operand byte input from terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
SHRO:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        CMP  #$41     ;GOTO NOTA IF keystroke <> "A"
        BNE  NOTA
        JSR  COUT     ; ELSE, send keystroke to terminal
        LDA  OCTAB,Y  ;Read indexed opcode from opcode table
        JMP  STOR     ;Write 1 byte instruction to working memory then GOTO NEWLIN
;
NOTA:
	INY           ;Increment opcode table index
NEVERA:
	JSR  AHEXIN4  ;Request operand word input from terminal
        BCS  SHROAB   ;GOTO SHROAB IF > 2 digits were entered
LDAZX:
	JSR  CLKRD    ; ELSE, send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO SHROZP IF keystroke <> ","
        BNE  SHROZP
        JSR  COMX     ; ELSE, send ",X" to terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
SHROZP:
	INY           ;Increment opcode table index
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
SHROAB:
	INY           ;Add 2 to opcode table index
        INY
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO SRAB IF keystroke <> ","
        BNE  SRAB
        JSR  COMX     ; ELSE, send ",X" to terminal
        JMP  LSTOR3   ;write 3 byte instruction to working memory then GOTO NEWLIN
;
SRAB:
	INY           ;Increment opcode table index
        JMP  LSTOR3   ;write 3 byte instruction to working memory then GOTO NEWLIN
;
LDXY:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        CMP  #$23     ;GOTO LDNIM IF keystroke <> "#"
        BNE  LDNIM
        JSR  CHEXIN2  ; ELSE, send modifier to terminal, request operand byte input from terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
LDNIM:
	INY           ;Increment opcode table index
        JSR  AHEXIN4  ;Request operand word input from terminal
        BCS  LDAB     ;GOTO LDAB IF > 2 digits were entered
        JSR  CLKRD    ; ELSE, send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO LDZP IF keystroke <> ","
        BNE  LDZP
        JSR  COUT     ; ELSE, send keystroke to terminal
        LDA  OCTAB,Y  ;Read indexed opcode from opcode table
        INY           ;Increment opcode table index
        JMP  CSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
LDZP:
	INY           ;Add 2 to opcode table index
        INY
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
LDAB:
	INY           ;Add 3 to opcode table index
        INY
        INY
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO LDABS IF keystroke <> ","
        BNE  LDABS
        JSR  COUT     ; ELSE, send keystroke to terminal
        LDA  OCTAB,Y  ;Read indexed CHARACTER from opcode table: this is an ASCII "Y"
        JSR  COUT     ;Send character to terminal
        INY           ;Increment opcode table index
        JMP  LSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
LDABS:
	INY           ;Add 2 to opcode table index
        INY
        JMP  LSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
STXY:
	LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        TAY
        JSR  SHEXIN4  ;Request word value input from terminal, returns with result in OPLO,OPHI
        BCS  STAB     ;GOTO STAB IF > 2 digits were entered
        JSR  CLKRD    ; ELSE, send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO STZP IF keystroke <> ","
        BNE  STZP
        JSR  COUT     ; ELSE, send keystroke to terminal
        LDA  OCTAB,Y  ;Read indexed CHARACTER from opcode table: this is an ASCII "X"
        JSR  COUT     ;Send character to terminal
        INY           ;Increment opcode table index
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
STZP:
	INY           ;Add 2 to opcode table index
        INY
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
STAB:
	INY           ;Add 3 to opcode table index
        INY
        INY
        JMP  LSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
TSRB:
	LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        TAY
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JMP  TSRBIN   ;GOTO TSRBIN
;
CPXY:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        CMP  #$23     ;GOTO XYNOIM IF keystroke <> "#"
        BNE  XYNOIM
        JSR  CHEXIN2  ; ELSE, send modifier to terminal, request operand byte input from terminal
        JMP  LSTOR2   ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
XYNOIM:
	INY           ;Increment opcode table index
TSRBIN:
	JSR  AHEXIN4  ;Request operand word input from terminal
        BCS  CPXYAB   ;GOTO CPXYAB IF > 2 digits were entered
        JMP  LSTOR2   ; ELSE, write 2 byte instruction to working memory then GOTO NEWLIN
;
CPXYAB:
	INY           ;Increment opcode table index
        JMP  LSTOR3   ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
JUMPS:
	JSR  SPCRD    ;Send 2 [SPACE] then "?" to terminal, request keystroke from terminal
        CMP  #$28     ;GOTO INDJ IF keystroke = "("
        BEQ  INDJ
        JSR  AHEXIN4  ; ELSE, request operand word input from terminal
        LDA  #$4C     ;Read JMP $nnnn JMP ABSOLUTE opcode
        JMP  STOR3    ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
INDJ:
	JSR  COUT     ;Send keystroke to terminal
        JSR  AHEXIN4  ;Request operand word input from terminal
        JSR  CLKRD    ;Send "?" to terminal, request keystroke from terminal
        CMP  #$2C     ;GOTO NOABINX IF keystroke <> ","
        BNE  NOABINX
        JSR  COMX     ;Send ",X" to terminal
        JSR  RBR      ;Send ")" to terminal
        LDA  #$7C     ;Read JMP ($nnnn,X) JMP INDIRECT PRE-INDEXED BY X opcode
        JMP  STOR3    ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
NOABINX:
	JSR  RBR      ;send ")" to terminal
        LDA  #$6C     ;Read JMP ($nnnn) JMP INDIRECT opcode
        JMP  STOR3    ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
JSUB:
	JSR  SHEXIN4  ;Request word value input from terminal, returns with result in OPLO,OPHI
        LDA  #$20     ;Read JSR $nnnn JSR ABSOLUTE opcode
        JMP  STOR3    ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
RMBM:
	JSR  BITSEL   ;Request bit number (0 to 7) input from terminal
        JMP  BITPOST  ;GOTO BITPOST
SMBM:
	JSR  BITSEL   ;Request bit number (0 to 7) input from terminal
        CLC           ;Add $80 to bit selector
        ADC  #$80
BITPOST:
	ORA  OPTAB,Y  ;Logical OR with the indexed opcode pointer table
        STA  OPHI     ;Save opcode table pointer
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JSR  AHEXIN2  ;Request operand byte input from terminal
        LDA  OPHI     ;Restore opcode table pointer
        JMP  STOR2    ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
STOZ:
	LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        TAY           ;Make this the OCTAB index (opcode table index)
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JMP  NEVERA   ;GOTO NEVERA
;
REL:
	JSR  SHEXIN4   ;Request word value input from terminal, returns with result in OPLO,OPHI: target address
        CLC            ;Calculate base address: base address = working address + 2,
        LDA  INDEX     ; store result in COMLO,COMHI
        ADC  #$02
        STA  COMLO
        LDA  INDEXH
        ADC  #$00
        STA  COMHI
        JSR  BROFFSET ;Calculate branch offset from base address to target address
        LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        JMP  STOR2    ;Write 2 byte instruction to working memory then GOTO NEWLIN
;
IMP:
	LDA  OPTAB,Y  ;Read indexed byte from OPTAB (opcode pointer table)
        JMP  STOR     ;Write 1 byte instruction to working memory then GOTO NEWLIN
;
STACC:
	JSR  LSPRD    ;Read opcode pointer and request opcode modifier keystroke
        JMP  STAIN    ;GOTO STAIN
;
BBRM:
	JSR  BITSEL   ;Request bit number (0 to 7) input from terminal
        JMP  BBRS     ;GOTO BBRS
BBSM:
	JSR  BITSEL   ;Request bit number (0 to 7) input from terminal
        CLC           ;Add $80 to bit selector: convert 0-7 to 8-F
        ADC  #$80
BBRS:
	ORA  OPTAB,Y  ;Logical OR with the indexed opcode pointer table
        PHA           ;Save opcode table pointer on STACK
        JSR  SPC2     ;Send 2 [SPACE] to terminal
        JSR  AHEXIN2  ;Request operand byte input from terminal
        LDA  OPLO     ;Save operand low byte on STACK: zero-page address
        PHA
        JSR  SHEXIN4  ;Request word value input from terminal, returns with result in OPLO,OPHI: target address
        CLC           ;Calculate base address: base address = working address + 3,
        LDA  INDEX    ; store result in COMLO,COMHI
        ADC  #$03
        STA  COMLO
        LDA  INDEXH
        ADC  #$00
        STA  COMHI
        JSR  BROFFSET ;Calculate branch offset from base address to target address
        LDA  OPLO     ;Move branch offset to operand high byte position: branch offset
        STA  OPHI
        PLA           ;Restore operand low byte from STACK: zero-page address
        STA  OPLO
        PLA           ;Restore opcode table pointer from STACK
        JMP  STOR3    ;Write 3 byte instruction to working memory then GOTO NEWLIN
;
;Assembler/disassembler tables:
;
;Disassembler mnemonic pointer table. This is indexed by the instruction OPCODE value.
; The byte elements in this table point to the proper MNEMONIC STRING for the OPCODE being disassembled:
MPTAB:
	.byte  $03,$A2,$00,$00,$C6,$A2,$6C,$B7,$24,$A2,$6C,$00,$C6,$A2,$6C,$BD
        .byte  $5D,$A2,$A2,$00,$C3,$A2,$6C,$B7,$06,$A2,$84,$00,$C3,$A2,$6C,$BD
        .byte  $69,$96,$00,$00,$78,$96,$72,$B7,$2A,$96,$72,$00,$78,$96,$72,$BD
        .byte  $57,$96,$96,$00,$78,$96,$72,$B7,$33,$96,$81,$00,$78,$96,$72,$BD
        .byte  $2D,$9C,$00,$00,$00,$9C,$6F,$B7,$21,$9C,$6F,$00,$66,$9C,$6F,$BD
        .byte  $60,$9C,$9C,$00,$00,$9C,$6F,$B7,$0C,$9C,$AE,$00,$00,$9C,$6F,$BD
        .byte  $30,$93,$00,$00,$C9,$93,$75,$B7,$27,$93,$75,$00,$66,$93,$75,$BD
        .byte  $63,$93,$93,$00,$C9,$93,$75,$B7,$39,$93,$B4,$00,$66,$93,$75,$BD
        .byte  $CC,$A8,$00,$00,$90,$A8,$8D,$BA,$15,$78,$45,$00,$90,$A8,$8D,$C0
        .byte  $4E,$A8,$A8,$00,$90,$A8,$8D,$BA,$4B,$A8,$48,$00,$C9,$A8,$C9,$C0
        .byte  $8A,$9F,$87,$00,$8A,$9F,$87,$BA,$3F,$9F,$3C,$00,$8A,$9F,$87,$C0
        .byte  $51,$9F,$9F,$00,$8A,$9F,$87,$BA,$0F,$9F,$42,$00,$8A,$9F,$87,$C0
        .byte  $7E,$99,$00,$00,$7E,$99,$81,$BA,$1B,$99,$12,$00,$7E,$99,$81,$C0
        .byte  $5A,$99,$99,$00,$00,$99,$81,$BA,$09,$99,$AB,$00,$00,$99,$81,$C0
        .byte  $7B,$A5,$00,$00,$7B,$A5,$84,$BA,$18,$A5,$1E,$00,$7B,$A5,$84,$C0
        .byte  $54,$A5,$A5,$00,$00,$A5,$84,$BA,$36,$A5,$B1,$00,$00,$A5,$84,$C0
;
;Disassembler handler pointer table. This is indexed by the instruction OPCODE value.
; The byte elements in this table point to the proper HANDLER for the OPCODE being disassembled:
HPTAB:
	.byte  $00,$0C,$00,$00,$06,$06,$06,$1C,$00,$04,$02,$00,$10,$10,$10,$20
        .byte  $18,$0E,$16,$00,$06,$08,$08,$1C,$00,$14,$02,$00,$10,$12,$12,$20
        .byte  $10,$0C,$00,$00,$06,$06,$06,$1C,$00,$04,$02,$00,$10,$10,$10,$20
        .byte  $18,$0E,$16,$00,$08,$08,$08,$1C,$00,$14,$02,$00,$12,$12,$12,$20
        .byte  $00,$0C,$00,$00,$00,$06,$06,$1C,$00,$04,$02,$00,$10,$10,$10,$20
        .byte  $18,$0E,$16,$00,$00,$08,$08,$1C,$00,$14,$00,$00,$00,$12,$12,$20
        .byte  $00,$0C,$00,$00,$06,$06,$06,$1C,$00,$04,$02,$00,$16,$10,$10,$20
        .byte  $18,$0E,$16,$00,$08,$08,$08,$1C,$00,$14,$00,$00,$1A,$12,$12,$20
        .byte  $18,$0C,$00,$00,$06,$06,$06,$1E,$00,$04,$00,$00,$10,$10,$10,$22
        .byte  $18,$0E,$16,$00,$08,$08,$0A,$1E,$00,$14,$00,$00,$10,$12,$12,$22
        .byte  $04,$0C,$04,$00,$06,$06,$06,$1E,$00,$04,$00,$00,$10,$10,$10,$22
        .byte  $18,$0E,$16,$00,$08,$08,$0A,$1E,$00,$14,$00,$00,$12,$12,$14,$22
        .byte  $04,$0C,$00,$00,$06,$06,$06,$1E,$00,$04,$00,$00,$10,$10,$10,$22
        .byte  $18,$0E,$16,$00,$00,$08,$08,$1E,$00,$14,$00,$00,$00,$12,$12,$22
        .byte  $04,$0C,$00,$00,$06,$06,$06,$1E,$00,$04,$00,$00,$10,$10,$10,$22
        .byte  $18,$0E,$16,$00,$00,$08,$08,$1E,$00,$14,$00,$00,$00,$12,$12,$22
;
;Disassembler handler table:
;   Handler address:   Handler address index: (referenced in table HPTAB)
HTAB:
	.word  SIN           ;$00
        .word  ACCC          ;$02
        .word  IME           ;$04
        .word  ZEROABS       ;$06
        .word  DZX           ;$08
        .word  DZY           ;$0A
        .word  THX           ;$0C
        .word  THY           ;$0E
        .word  DABS          ;$10
        .word  DAX           ;$12
        .word  DAY           ;$14
        .word  ZPDIND        ;$16
        .word  RELATIVE      ;$18
        .word  INDABSX       ;$1A
        .word  DRMB          ;$1C
        .word  DSMB          ;$1E
        .word  DBBR          ;$20
        .word  DBBS          ;$22
;
;DMTAB: disassembler mnemonic table,
;MTAB: assembler mnemonic table:
;     mnemonic string:
DMTAB:
	.text  "***"
MTAB:
	.text  "BRK"
        .text  "CLC"
        .text  "CLD"
        .text  "CLI"
        .text  "CLV"
        .text  "DEX"
        .text  "DEY"
        .text  "INX"
        .text  "INY"
        .text  "NOP"
        .text  "PHA"
        .text  "PHP"
        .text  "PLA"
        .text  "PLP"
        .text  "RTI"
        .text  "RTS"
        .text  "SEC"
        .text  "SED"
        .text  "SEI"
        .text  "TAX"
        .text  "TAY"
        .text  "TSX"
        .text  "TXA"
        .text  "TXS"
        .text  "TYA"
        .text  "BCC"
        .text  "BCS"
        .text  "BEQ"
        .text  "BMI"
        .text  "BNE"
        .text  "BPL"
        .text  "BVC"
        .text  "BVS"
        .text  "JMP"
        .text  "JSR"
        .text  "ASL"
        .text  "LSR"
        .text  "ROL"
        .text  "ROR"
        .text  "BIT"
        .text  "CPX"
        .text  "CPY"
        .text  "DEC"
        .text  "INC"
        .text  "LDX"
        .text  "LDY"
        .text  "STX"
        .text  "STY"
        .text  "ADC"
        .text  "AND"
        .text  "CMP"
        .text  "EOR"
        .text  "LDA"
        .text  "ORA"
        .text  "SBC"
        .text  "STA"
        .text  "PHX"
        .text  "PHY"
        .text  "PLX"
        .text  "PLY"
        .text  "RMB"
        .text  "SMB"
        .text  "BBR"
        .text  "BBS"
        .text  "TRB"
        .text  "TSB"
        .text  "STZ"
        .text  "BRA"
;
;Assembler handler jump table:
JTAB:
	.word  $FFFF
        .word  IMP,IMP,IMP,IMP,IMP,IMP,IMP,IMP
        .word  IMP,IMP,IMP,IMP,IMP,IMP,IMP,IMP
        .word  IMP,IMP,IMP,IMP,IMP,IMP,IMP,IMP
        .word  IMP,REL,REL,REL,REL,REL,REL,REL
        .word  REL,JUMPS,JSUB,SHRO,SHRO,SHRO,SHRO,BITS
        .word  CPXY,CPXY,SHRO,SHRO,LDXY,LDXY,STXY,STXY
        .word  LDACC,LDACC,LDACC,LDACC,LDACC,LDACC,LDACC,STACC
        .word  IMP,IMP,IMP,IMP,RMBM,SMBM,BBRM,BBSM
        .word  TSRB,TSRB,STOZ,REL
;
;Assembler opcode pointer table:
OPTAB:
	.byte  $FF,$00,$18,$D8,$58,$B8,$CA,$88,$E8,$C8,$EA,$48,$08,$68,$28,$40
        .byte  $60,$38,$F8,$78,$AA,$A8,$BA,$8A,$9A,$98,$90,$B0,$F0,$30,$D0,$10
        .byte  $50,$70,$FF,$FF,$10,$15,$1A,$1F,$81,$00,$03,$06,$0B,$24,$2B,$32
        .byte  $36,$3A,$43,$4C,$55,$5E,$67,$70,$79,$DA,$5A,$FA,$7A,$07,$07,$0F
        .byte  $0F,$8A,$8C,$86,$80
;
;Assembler opcode table:
OCTAB:
	.byte  $E0,$E4,$EC,$C0,$C4,$CC,$3A,$D6,$C6,$DE,$CE,$1A,$F6,$E6,$FE,$EE
        .byte  $0A,$16,$06,$1E,$0E,$4A,$56,$46,$5E,$4E,$2A,$36,$26,$3E,$2E,$6A
        .byte  $76,$66,$7E,$6E,$A2,$59,$B6,$A6,$59,$BE,$AE,$A0,$58,$B4,$A4,$58
        .byte  $BC,$AC,$59,$96,$86,$8E,$58,$94,$84,$8C,$69,$72,$71,$61,$75,$65
        .byte  $79,$7D,$6D,$29,$32,$31,$21,$35,$25,$39,$3D,$2D,$C9,$D2,$D1,$C1
        .byte  $D5,$C5,$D9,$DD,$CD,$49,$52,$51,$41,$55,$45,$59,$5D,$4D,$A9,$B2
        .byte  $B1,$A1,$B5,$A5,$B9,$BD,$AD,$09,$12,$11,$01,$15,$05,$19,$1D,$0D
        .byte  $E9,$F2,$F1,$E1,$F5,$E5,$F9,$FD,$ED,$92,$91,$81,$95,$85,$99,$9D
        .byte  $8D,$89,$34,$24,$3C,$2C,$74,$64,$9E,$9C,$14,$1C,$04,$0C
;
;Directive table:
DIRTAB:
	.text "ABGILOPQRSTUWXY"
;
;Directive jump table
DJTAB:
	
        .word  ABYTE

        .word  KEYCONV
        .word  LIST
        .word  REORIG

        .word  AQUERY


        .word  RECODE
        .word  WORD
;
;END OF ASSEMBLER
;
;QUERY command:
;NOTE: prompt string pointers here
QUERY:
	JSR SAVREGS
	JSR CROUT
	LDA #<NEWQUERYADRS
	STA TEMP2
	LDA #>NEWQUERYADRS
	STA TEMP2H
	LDA #<NEWQUERYSTRS
	STA TEMP3
	LDA #>NEWQUERYSTRS
	STA TEMP3H

;;; PRINT THE HEX ADDRESS TO SUBROUTINE
NEWQUERYAGAIN:
	JSR DOLLAR
	LDY #0
	LDA (TEMP2),Y
	STA INDEX
	INY
	LDA (TEMP2),Y
	STA INDEXH
	JSR PRINDX
	LDX #2
INC:
	INC TEMP2
	BNE NQDONE
	INC TEMP2H
NQDONE:
	DEX
	BNE INC

;;; PRINT THE NAME OF THE LABEL TO THE SUBROUTINE
	LDA TEMP3
	STA INDEX
	LDA TEMP3H
	STA INDEXH
	JSR PROMPT2		; INDEX WILL POINT TO THE TERMINATING 0 OF THE STRING
	JSR INCINDEX		; INCREASE THE STRING INDEX POINTER
	LDA (INDEX),Y		; Y HAS BEEN SET TO 0 BY PROMPT2 SO (INDEX),Y WILL POINT TO NEXT STRING OR TERMINATING 0
	BEQ NEWQUERYDONE	; TWO ZEROES IN A ROW MEANS WE ARE DONE
	LDA INDEX		;  ELSE SAVE INDEX IN TEMP3
	STA TEMP3
	LDA INDEXH
	STA TEMP3H
	BRA NEWQUERYAGAIN	; NEXT QUERY STRING

NEWQUERYDONE:
	JSR RESREGS
	RTS

NEWQUERYADRS:
	.word CHIN
	.word COUT
	.WORD COUT2
	.WORD CROUT
	.WORD CR2
	.WORD SPC2
	.WORD SPC4
	.WORD PRASC
	.WORD DOLLAR
	.WORD PRBYTE
	.WORD PRINDX
	.WORD PROMPT
	.WORD BEEP
	.WORD DELAY1
	.WORD DELAY1.DELAY2
	.WORD SET
	.WORD SET.TIMER
	.WORD RDLINE
	.WORD BN2ASC
	.WORD ASC2BN
	.WORD HEXIN
	.WORD SAVREGS
	.WORD RESREGS
	.WORD INCINDEX
	.WORD PROMPT2
	.WORD HEXIN2
	.WORD HEXIN4
	.WORD MONITOR.NMON
	.WORD COLDSTART
	.WORD SIODAT
	.WORD 0

NEWQUERYSTRS:
	.text  " CHIN    ",0
        .text  " COUT",$0D,$0A,0
        .text  " COUT2   ",0
        .text  " CROUT",$0D,$0A,0
        .text  " CR2     ",0
        .text  " SPC2",$0D,$0A,0
        .text  " SPC4    ",0
        .text  " PRASC",$0D,$0A,0
        .text  " DOLLAR  ",0
        .text  " PRBYTE",$0D,$0A,0
	.TEXT  " PRINDX  ",0
	.TEXT  " PROMPT",$0D,$0A,0
        .text  " BEEP    ",0
        .text  " DELAY1",$0D,$0A,0
        .text  " DELAY2  ",0
        .text  " SET",$0D,$0A,0
        .text  " TIMER   ",0
        .text  " RDLINE",$0D,$0A,0
        .text  " BN2ASC  ",0
        .text  " ASC2BN",$0D,$0A,0
        .text  " HEXIN   ",0
        .text  " SAVREGS",$0D,$0A,0
        .text  " RESREGS ",0
        .text  " INCINDEX",$0D,$0A,0
        .text  " DECIN   ",0
        .text  " PROMPT2",$0D,$0A,0
        .text  " HEXIN2  ",0
        .text  " HEXIN4",$0D,$0A,0
        .text  " NMON    ",0
        .text  " COLDSTART",$0D,$0A,0
        .text  " 6551 ",0
        .byte  $00
;
;STORLF subroutine: This is a patch that is part of the "Z" (text editor) command;
; it stores a [LINEFEED] after [RETURN] when [RETURN] is struck.
STORLF:
	JSR  COUT      ;Send [RETURN] to terminal
        JSR  INCINDEX  ;Increment edit memory address pointer
        LDA  #$0A
        STA  (INDEX),Y ;Store [LINEFEED] in indexed edit memory
        JSR  COUT      ;Send [LINEFEED] to terminal
        RTS            ;Done STORLF subroutine (patch), RETURN

;Setup prompt high and low byte for commands
ASMPROHILO:
	JSR SAVREGS
	LDA #>CMDPROMPTS
	STA PROHI
	LDA #<CMDPROMPTS
	STA PROLO
	JSR RESREGS
	RTS

MONPROHILO:
	JSR SAVREGS
	LDA #>MONPROMPT
	STA PROHI
	LDA #<MONPROMPT
	STA PROLO
	JSR RESREGS
	RTS
;
;
;Prompt strings for [F]MFILL, [M]MOVER, [K]LOCATE_BYTE_STRING, [L]LOCATE_TEXT_STRING, [CNTL-W]WIPE commands and SUB-ASSEMBLER:
;String:                   String number:
CMDPROMPTS:
        .byte $00
        .byte $0D, $0A               ;$01
        .text "[ESC] key exits,"
        .text " any other to"
        .text " proceed"
        .byte $00
        .byte $0D, $0A               ;$02
        .text "fill start: "
        .byte $00
        .byte $0D, $0A               ;$03
        .text "length: "
        .byte $00
        .byte $0D, $0A               ;$04
        .text "value: "
        .byte $00
        .byte $0D, $0A               ;$05
        .text "move source: "
        .byte $00
        .byte $0D, $0A               ;$06
        .text "destination: "
        .byte $00
        .byte $0D, $0A               ;$07
        .text "Find "
        .byte $00
        .text "text: "               ;$08
        .byte $00
        .text "bytes: "              ;$09
        .byte $00
        .text "found "               ;$0A
        .byte $00
        .text "not "                 ;$0B
        .byte $00
        .text "at: $"                ;$0C
        .byte $00
        .byte $0D, $0A               ;$0D
        .text "Searching.."
        .byte $00
        .byte $0D, $0A               ;$0E
        .text "N=Next? "
        .byte $00
        .text "Byte: "               ;$0F
        .byte $00
        .text "Word: "               ;$10
        .byte $00
        .text "Origin: "             ;$11
        .byte $00
        .text "Assembler:"           ;$12
        .byte $00
        .text "Recode"               ;$13
        .byte $00
        .text "List: "               ;$14
        .byte $00
        .text " <-Offset = low byte" ;$15
        .byte $00
;
;Monitor prompt strings:

         ;String:                   String number:
MONPROMPT:
        .byte $00
        .text "Version 06.07.07"     ;$01
        .byte $00
        .text "[CNTL-A] runs "       ;$02
        .text "assembler"
        .byte $00
;RED
;
;ORANGE
;
;YELLOW
;
;GREEN
;
;BLUE
;
;INDIGO
;
;VIOLET
;Black       0;30     Dark Gray     1;30
;Blue        0;34     Light Blue    1;34
;Green       0;32     Light Green   1;32
;Cyan        0;36     Light Cyan    1;36
;Red         0;31     Light Red     1;31
;Purple      0;35     Light Purple  1;35
;Brown       0;33     Yellow        1;33
;Light Gray  0;37     White         1;37
	 .byte $1B
	 .text "[32m"
	 .text "PPPPPP  LL      UU   UU TTTTTTT  OOOOO"
	 .byte $0D, $0A
	 .text "PP   PP LL      UU   UU   TTT   OO   OO"
	 .byte $0D, $0A
	 .text "PPPPPP  LL      UU   UU   TTT   OO   OO"
	 .byte $0D, $0A
	 .text "PP      LL      UU   UU   TTT   OO   OO"
	 .byte $0D, $0A
	 .text "PP      LLLLLLL  UUUUU    TTT    OOOO0"
	 .byte $1B
	 .text "[0m"
         .byte $0D, $0A
	 .text "S/O/S SyMon "         ;$03
         .text "(c)1990 B.Phelps"
         .byte $00
         .text " "                    ;$04 (placeholder)
         .byte $00
         .text "Areg:$"               ;$05
         .byte $00
         .byte $0D, $0A               ;$06
         .text "HEX: $"
         .byte $00
         .text " "                    ;$07 (placeholder)
         .byte $00
         .text "DEC: "                ;$08
         .byte $00
         .byte $0D, $0A               ;$09
         .text "Begin XMODEM/CRC downnload "
         .byte $00
         .text "Xreg:$"               ;$0A
         .byte $00
         .text "SyMon III"            ;$0B
         .byte $00
         .text "Monitor:"             ;$0C
         .byte $00
         .text "adrs+"                ;$0D
         .byte $00
         .text "Yreg:$"               ;$0E
         .byte $00
         .byte $0D, $0A               ;$0F
         .text "Begin XMODEM/CRC upload "
         .byte $00
         .text "Stack pointer:$"      ;$10
         .byte $00
         .text "Address: "            ;$11
         .byte $00
         .text "Length: "             ;$12
         .byte $00
         .byte $0D, $0A               ;$13
         .text "10 Seconds"
         .byte $00
         .text "Processor status:$"   ;$14
         .byte $00
         .text "Wipe RAM?"            ;$15
         .byte $00
;
;6502 Vectors:
         * =  $FFFA
         .word $0300    	;NMI
         .word COLDSTART	;RESET
         .word INTERUPT 	;IRQ

         .end
