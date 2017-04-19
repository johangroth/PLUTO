;
;***************************************************
;*  C02Monitor 1.0 (c)2013,2015 by Kevin E. Maier  *
;*    Extendable BIOS and Monitor for 65C02 CPU    *
;*                                                 *
;* Basic functions include:                        *
;*  - Byte/Text memory search                      *
;*  - CPU register display/modify                  *
;*  - Memory fill, move, compare, examine/edit     *
;*  - Xmodem/CRC Loader with S-Record support      *
;*  - Input buffer Macro utility up to 127 bytes   *
;*  - EEPROM Program utility (Atmel Byte-write)    *
;*  - RTC via 65C22 showing time since boot        *
;*  - 1ms timer delay via 65C22                    *
;*                                                 *
;*                  11/21/15 KM                    *
;*   Uses <4KB EEPROM - JMP table page at $FF00    *
;*     Uses one page for I/O: default at $FE00     *
;*         Default assembly start at $F000:        *
;*                                                 *
;*  C02BIOS 1.2 (c)2013, 2015 by Kevin E. Maier    *
;*  - BIOS in pages $FC, $FD, $FF                  *
;*  - Full duplex interrupt-driven/buffered I/O    *
;*  - extendable BIOS structure with soft vectors  *
;*  - soft config parameters for all I/O devices   *
;*  - monitor cold/warm start soft vectored        *
;*  - fully relocatable code (sans page $FF)       *
;*  - precision timer services 1ms accuracy        *
;*  - delays from 1ms to 49.71 days                *
;*  - basic port services for 6522 VIA             *
;*                                                 * 
;*   Note default HW system memory map as:         *
;*         RAM - $0000 - $7FFF                     *
;*         ROM - $8000 - $FDFF                     *
;*         I/O - $FE00 - $FEFF                     *
;*         ROM - $FF00 - $FFFF                     *
;*                                                 *
;***************************************************
;
	PL	66	;Page Length
	PW	132	;Page Width (# of char/line)
;
;******************************************************************************
;*************************
;* Page Zero definitions *
;*************************
;Reserved from $00 to $7F for user routines
;Note: locations $00 and $01 are used to zero RAM (calls CPU reset)
;NOTE: EEPROM Byte Write routine loaded into Page Zero at $00
;
PGZERO8_ST	.EQU	$80	;8-bit start of Page Zero usage
PGZERO16_ST	.EQU	$0080	;16-bit start of Page Zero usage
;
;16-bit variables:
;HEXDATA MUST be located immediately below the HEXDATAH variable
HEXDATA		.EQU PGZERO16_ST+15
HEXDATAH	.EQU PGZERO8_ST+16
HEXDATAL	.EQU PGZERO8_ST+17
;
BUFADRL		.EQU	PGZERO8_ST+18	;Input address
BUFADRH		.EQU	PGZERO8_ST+19
COMLO			.EQU	PGZERO8_ST+20	;User command address
COMHI			.EQU	PGZERO8_ST+21
INDEXL		.EQU	PGZERO8_ST+22	;Index for address
INDEXH		.EQU	PGZERO8_ST+23
TEMP1L		.EQU	PGZERO8_ST+24	;Index for word temp value used by Memdump
TEMP1H		.EQU	PGZERO8_ST+25
PROMPTL		.EQU	PGZERO8_ST+26	;Prompt string address
PROMPTH		.EQU	PGZERO8_ST+27
BINVALL		.EQU	PGZERO8_ST+28	;Binary Value for HEX2ASC
BINVALH		.EQU	PGZERO8_ST+29
MOD10L		.EQU	PGZERO8_ST+30	;Modulus Value for HEX2ASC
MOD10H		.EQU	PGZERO8_ST+31
SRCL			.EQU	PGZERO8_ST+32	;Source address for memory operations
SRCH			.EQU	PGZERO8_ST+33
TGTL			.EQU	PGZERO8_ST+34	;Target address for memory operations
TGTH			.EQU	PGZERO8_ST+35
LENL			.EQU	PGZERO8_ST+36	;Length address for memory operations
LENH			.EQU	PGZERO8_ST+37
CMPL			.EQU	PGZERO8_ST+38	;Compare address for memory operations
CMPH			.EQU	PGZERO8_ST+39
;
;8-bit variables and constants:
BUFIDX		.EQU	PGZERO8_ST+40	;Buffer index
BUFLEN		.EQU	PGZERO8_ST+41	;Buffer length
SCNT			.EQU	PGZERO8_ST+42	;Input character count for HEXINPUT
STMP			.EQU	PGZERO8_ST+43	;Temp for HEXINPUT routine
IDX				.EQU	PGZERO8_ST+44	;Indexing for Memory Dump
IDY				.EQU	PGZERO8_ST+45	;Indexing for Search Memory
LOKOUT		.EQU	PGZERO8_ST+46	;Lokout flag for RDLINE routine
POINTER		.EQU	PGZERO8_ST+47	;Stack Pointer for Go routine
TEMP1			.EQU	PGZERO8_ST+48	;Temp value - Math routines
TEMP2			.EQU	PGZERO8_ST+49	;Temp value - 16-bit Word convert
TEMP3			.EQU	PGZERO8_ST+50	;Temp value - Fill/Move/Compare/Program routines
TEMP4			.EQU	PGZERO8_ST+51	;Temp value - Program EEPROM routine
;
;Xmodem transfer variables
VALUE			.EQU	PGZERO8_ST+52	;Data value for CRC calculation
CRCHI			.EQU	PGZERO8_ST+53	;CRC lo byte  (two byte variable)
CRCLO			.EQU	PGZERO8_ST+54	;CRC hi byte
CRCCNT		.EQU	PGZERO8_ST+55	;CRC retry count
;
PTRL			.EQU	PGZERO8_ST+56	;Data pointer lo byte (two byte variable)
PTRH			.EQU	PGZERO8_ST+57	;Data pointer hi byte
BLKNO			.EQU	PGZERO8_ST+58	;Block number
RETRY			.EQU	PGZERO8_ST+59	;Retry counter 
;
;	Buffers used by the default Monitor code
BUFF_PG0	.EQU	PGZERO8_ST+60	;Default Page zero location for Monitor buffers
; - 6 byte ASCII output buffer
ASCBUF		.EQU	BUFF_PG0+0	;6 bytes ($BC-$C1)
;	- 14 byte input buffer
INBUFF		.EQU	BUFF_PG0+6	;14 bytes ($C2-$CF)
;	- 16 byte buffer (notice that this variable MUST be expressed as
;a 16 bit address even though it references a zero-page address)
SRCHBUFF	.EQU	BUFF_PG0+20	;16 bytes ($D0-$DF)
;
;	BIOS variables, pointers, flags located at top of Page Zero.
BIOS_PG0	.EQU	PGZERO8_ST+96	;Start of BIOS page zero use ($E0-$FF)
;	- BRK handler routine
PCL				.EQU	BIOS_PG0+0	;Program Counter Low index
PCH				.EQU	BIOS_PG0+1	;Program Counter High index
PREG			.EQU	BIOS_PG0+2	;Temp Status reg
SREG			.EQU	BIOS_PG0+3	;Temp Stack ptr
YREG			.EQU	BIOS_PG0+4	;Temp Y reg
XREG			.EQU	BIOS_PG0+5	;Temp X reg
AREG			.EQU	BIOS_PG0+6	;Temp A reg
;
;	- 6551 IRQ handler pointers and status
ICNT			.EQU	BIOS_PG0+7	;Input buffer count
IHEAD			.EQU	BIOS_PG0+8	;Input buffer head pointer
ITAIL			.EQU	BIOS_PG0+9	;Input buffer tail pointer
OCNT			.EQU	BIOS_PG0+10	;Output buffer count
OHEAD			.EQU	BIOS_PG0+11	;Output buffer head pointer
OTAIL			.EQU	BIOS_PG0+12	;Output buffer tail pointer
STTVAL		.EQU	BIOS_PG0+13	;6551 BIOS status byte
;
;	- Real-Time Clock variables
TICKS			.EQU	BIOS_PG0+14	;# timer countdowns for 1 second (250)
SECS			.EQU	BIOS_PG0+15	;Seconds: 0-59
MINS			.EQU	BIOS_PG0+16	;Minutes: 0-59
HOURS			.EQU	BIOS_PG0+17	;Hours: 0-23
DAYSL			.EQU	BIOS_PG0+18	;Days: (2 bytes) 0-65535 >179 years
DAYSH			.EQU	BIOS_PG0+19	;High order byte
;
;	- Delay Timer variables
MSDELAY		.EQU	BIOS_PG0+20	;Timer delay countdown byte (255 > 0)
MATCH			.EQU	BIOS_PG0+21	;Delay Match flag, $FF is set, $00 is cleared
SETIM			.EQU	BIOS_PG0+22	;Set timeout for delay routines - BIOS use only
DELLO			.EQU	BIOS_PG0+23	;Delay value	BIOS use only
DELHI			.EQU	BIOS_PG0+24	;	BIOS use only
XDL				.EQU	BIOS_PG0+25	;XL Delay count
STVVAL		.EQU	BIOS_PG0+26	;Status for VIA IRQ flags
;
;	- I/O port variables
IO_DIR		.EQU	BIOS_PG0+27	;I/O port direction temp
IO_IN			.EQU	BIOS_PG0+28	;I/O port Input temp
IO_OUT		.EQU	BIOS_PG0+29	;I/O port Output temp
;
; - Xmodem variables
XMFLAG		.EQU	BIOS_PG0+30	;Xmodem transfer active flag
S19FLAG		.EQU	BIOS_PG0+31	;S-record transfer active flag
;
;******************************************************************************
;Character input buffer address: $0200-$027F - 128 bytes
;Character output buffer address: $0280-$02FF - 128 bytes
;Managed by full-duplex IRQ service routine.
;
IBUF			.EQU	$0200	;INPUT BUFFER  128 BYTES - BIOS use only
OBUF			.EQU	$0280	;OUTPUT BUFFER 128 BYTES - BIOS use only
;
;******************************************************************************
SOFTVEC		.EQU	$0300	;Start of soft vectors
;
;The Interrupt structure is vector based. During startup, Page $03 is loaded from ROM.
; The soft vectors are structured to allow inserting additional routines either before
; or after the core routines. This allows flexibility and changing of routine priority.
;
;The main set of vectors occupy the first 16 bytes of Page $03. The ROM handler for
; NMI, BRK and IRQ jump to the first 3 vectors. The following 3 vectors are loaded with
; returns to the ROM handler for each. The following 2 vectors are the cold and warm
; entry points for the Monitor. After the basic initialization, the monitor is entered.
;
;The following vector set allows inserts for any of the above vectors.
; there are a total of 8 Inserts which occupy 16 bytes.
; They can be used as required, note that the first is used for the 6522 timer routine
;
NMIVEC0		.EQU	SOFTVEC	;NMI Interrupt Vector 0
BRKVEC0		.EQU	SOFTVEC+2	;BRK Interrupt Vector 0
IRQVEC0		.EQU	SOFTVEC+4	;INTERRUPT VECTOR 0
;
NMIRTVEC0	.EQU	SOFTVEC+6	;NMI Return Handler 0
BRKRTVEC0	.EQU	SOFTVEC+8	;BRK Return Handler 0
IRQRTVEC0	.EQU	SOFTVEC+10	;IRQ Return Handler 0
;
CLDMNVEC0	.EQU	SOFTVEC+12	;Cold Monitor Entry Vector 0
WRMMNVEC0	.EQU	SOFTVEC+14	;Warm Monitor Entry Vector 0
;
VECINSRT0	.EQU	SOFTVEC+16	;1st Vector Insert
VECINSRT1	.EQU	SOFTVEC+18	;1st Vector Insert
VECINSRT2	.EQU	SOFTVEC+20	;1st Vector Insert
VECINSRT3	.EQU	SOFTVEC+22	;1st Vector Insert
VECINSRT4	.EQU	SOFTVEC+24	;1st Vector Insert
VECINSRT5	.EQU	SOFTVEC+26	;1st Vector Insert
VECINSRT6	.EQU	SOFTVEC+28	;1st Vector Insert
VECINSRT7	.EQU	SOFTVEC+30	;1st Vector Insert
;
;******************************************************************************
SOFTCFG		.EQU SOFTVEC+32	;Start of hardware config parameters
;
;Soft Config values below are loaded from ROM and are the default I/O setup
;configuration data that the INIT_65xx routines use. As a result, you can write a
;routine to change the I/O configuration data and use the standard ROM routine
;to initialize the I/O without restarting or changing ROM. A Reset (cold or coded)
;will reinitialize the I/O with the ROM default I/O configuration.
;
;There are a total of 32 Bytes configuration data reserved starting at $0320
;
LOAD_6551	.EQU	SOFTCFG	;6551 SOFT config data start
LOAD_6522	.EQU	SOFTCFG+2	;6522 SOFT config data start
;
;Defaults for RTC ticks - number of IRQs for 1 second
DF_TICKS	.EQU	#250	;clock timer set for 4 milliseconds, so 250 x 4ms = 1 second
;
; Xmodem/CRC Loader also provides Motorola S19 Record sense and load
; Designed to handle the S19 records from the WDC Assembler/Linker package
; This requires a 44 byte buffer to parse each valid S1 record.
; Located just before the 132 Byte Xmodem frame buffer.
; There are a total of 176 bytes of Buffer associated with the Xmodem/CRC Loader
;
; Valid S-record headers are "S1" and "S9".
; For S1, the maximum length is "19" hex. The last S1 record can be less.
; S9 record is always the last record with no data
; WDC Linker also appends a CR/LF to the end of each record for a total 44 bytes
;
SRBUFF		.EQU	$0350	;Start of Motorola S-record buffer, 44 bytes in length
;
; Xmodem frame buffer. The entire Xmodem frame is buffered here and then checked
; for proper header and frame number, CRC-16 on the data, then moved to user RAM.
;
RBUFF			.EQU	$037C	;Xmodem temp 132 byte receive buffer
;
;Additional Xmodem variables, etc.
;
; XMODEM Control Character Constants
SOH				.EQU	$01	;Start of Block Header
EOT				.EQU	$04	;End of Text marker
ACK				.EQU	$06	;Good Block Acknowledge
NAK				.EQU	$15	;Bad Block acknowledged
CAN				.EQU	$18	;Cancel character
;
;******************************************************************************
;
BURN_BYTE	.EQU	$0000	;Location in RAM for BYTE write routine
;
;******************************************************************************
;I/O Page Base Address
IOPAGE		.EQU	$FE00  
;
;ACIA device address:
SIOBase		.EQU	IOPAGE+$20	;6551 Base HW address
SIODAT		.EQU	SIOBase+0	;ACIA data register
SIOSTAT		.EQU	SIOBase+1	;ACIA status register
SIOCOM		.EQU	SIOBase+2 ;ACIA command register
SIOCON		.EQU	SIOBase+3 ;ACIA control register
;
;VIA device address:
Via1Base	.EQU	IOPAGE	;65C22 VIA base address here
Via1PRB		.EQU  Via1Base+0
Via1PRA		.EQU  Via1Base+1
Via1DDRB	.EQU  Via1Base+2
Via1DDRA  .EQU  Via1Base+3
Via1T1CL  .EQU  Via1Base+4
Via1T1CH  .EQU  Via1Base+5
Via1T1LL  .EQU  Via1Base+6
Via1TALH  .EQU  Via1Base+7
Via1T2CL  .EQU  Via1Base+8
Via1T2CH  .EQU  Via1Base+9
Via1SR    .EQU  Via1Base+10
Via1ACR   .EQU  Via1Base+11
Via1PCR   .EQU  Via1Base+12
Via1IFR   .EQU  Via1Base+13
Via1IER   .EQU  Via1Base+14
Via1PRA1  .EQU  Via1Base+15
;******************************************************************************
	.ORG $F000    ;Target address range $F000 through $FDFF will be used
;******************************************************************************
;START OF MONITOR CODE
;
;***********************************************
;* Basic Subroutines used by multiple routines *
;***********************************************
;
;ASC2BIN subroutine: Convert 2 ASCII HEX digits to a binary (byte) value.
;Routine optimized for execution speed over size (2 bytes larger)
;Enter: A register = high digit, Y register = low digit
;Return: A register = binary value 
ASC2BIN		SEC	;Set carry for subtraction
					SBC	#$30	;Subtract $30 from ASCII Hex digit
					CMP	#$0A	;Check for result < 10
					BCC	HD_BNOK	;Branch if 0-9
					SBC	#$07	;Else, subtract 7 for A-F
HD_BNOK		ASL	A	;Shift to high nibble
					ASL	A
					ASL	A
					ASL	A
					STA	TEMP1	;Store it in temp area
					TYA	;Get Low digit
					SEC	;Set carry for subtraction
					SBC	#$30	;Subtract $30 from ASCII Hex digit
					CMP	#$0A	;Check for result < 10
					BCC	LD_BNOK	;Branch if 0-9
					SBC	#$07	;Else, subtract 7 for A-F
LD_BNOK		ORA	TEMP1	;OR in the high nibble
					RTS	;And return to caller
;
;BIN2ASC subroutine: Convert byte in A register to two ASCII HEX digits.
;Routine optimized for execution speed over size (6 bytes larger)
;Return: A register = high digit, Y register = low digit
BIN2ASC		PHA	;Save character to stack
					AND	#$0F	;Mask off high nibble
					CMP	#$0A	;Check for 10 or less
					BCC	ASCLOK	;Branch if less than 10
					CLC	;Clear carry for addition
					ADC	#$07	;Add $07 for A-F
ASCLOK		ADC	#$30	;Add $30 for ASCII
					TAY	;Xfer to Y register
					PLA	;Get character back from stack
					LSR	A	;Shift high nibble to lower 4 bits
					LSR	A
					LSR	A
					LSR	A
					CMP	#$0A	;Check for 10 or less
					BCC	ASCHOK	;Branch if less than 10
					CLC	;Clear carry for addition
					ADC	#$07	;Add $07 for A-F
ASCHOK		ADC	#$30	;Add $30 for ASCII
					RTS	;And return to caller
;
;HEX2ASC - Accepts 16-bit Hexadecimal value and converts to an ASCII decimal string
;Input is via the A and X registers and output is up to 5 ASCII digits in ASCBUF
;The High Byte is the A register and Low Byte is in the X register
;Output data is placed in variable ASCBUF and terminated with an null character
;PROMPTR routine is used to print the ASCII decimal value.
HEX2ASC		STX	BINVALL	;Save Low byte
					STA	BINVALH	;Save High byte
					LDX	#5	;Get ASCII buffer offset
					STX	TEMP2	;And save it
;
					STZ	ASCBUF,X	;Zero last buffer byte for null end
CNVERT		STZ	MOD10L	;Clear 16-bit work area low byte
					STZ	MOD10H	;And high byte 
;
					LDX	#16	;Set count for 16-bits
					CLC	;Clear Carry flag for rotate
DVLOOP		ROL	BINVALL	;Shift carry into dividend
					ROL	BINVALH	;Which will be quotient
					ROL	MOD10L	;And shift dividend
					ROL	MOD10H	;At the same time
;A,Y = DIVIDEND - DIVISOR
					SEC	;Set Carry for subtraction
					LDA	MOD10L	;Get low byte modulus 
					SBC	#10	;And divide by ten
					TAY	;Save the Low byte in Y register
					LDA	MOD10H	;Get the High byte
					SBC	#0	;Subtract the Carry flag
					BCC	DECCNT	;Branch if Dividend if less than Divisor
					STY	MOD10L	;Else,
					STA	MOD10H	;Next bit to Quotient is one and set Dividend
DECCNT		DEX	;Decrement the count
					BNE	DVLOOP	;Branch back for all 16 bytes
					ROL	BINVALL	;Shift last bit into carry
					ROL	BINVALH	;And shift for 16-bit
;CONCATENATE NEXT CHARACTER
					LDA	MOD10L	;Get modulus low byte
					CLC	;Clear carry flag for addition
					ADC	#'0'	;Add an ASCII zero
					DEC	TEMP2	;Decrement buffer address
					LDY	TEMP2	;Get current buffer position
					STA	ASCBUF,Y	;Store value into buffer
;IF VAL < > 0 THEN CONTINUE
					LDA	BINVALL	;Get the Low byte
					ORA	BINVALH	;Then OR in the High byte
					BNE	CNVERT	;Branch back until done
;
;Conversion is complete, get the string address,
;add offset, then call prompt routine and return
;
					LDA	#<ASCBUF	;Get Low byte Address
					ADC	TEMP2	;Add in start index (no leading zeros)
					LDY	#>ASCBUF	;Get High byte address
					JMP	PROMPTR	;Send to terminal and return
;
;SETUP subroutine: Request HEX address input from terminal
SETUP			JSR	CHOUT	;Send command keystroke to terminal
					JSR	SPC	;Send [SPACE] to terminal
					BRA	HEXIN4	;Request a 0-4 digit HEX address input from terminal
;
;HEX input subroutines:
;Request 1 to 4 ASCII HEX digits from terminal, then convert digits into a binary value
;HEXIN2 - returns value in A reg and Y reg only (Y reg always $00)
;HEXIN4 - returns values in A reg, Y reg and INDEXL/INDEXH
;For 1 to 4 digits entered, HEXDATAH and HEXDATAL contain the output
;Variable SCNT will contain the number of digits entered
;HEX2 - Prints MSG# in A reg then calls HEXIN2
;HEX4 - Prints MSG# in A reg then calls HEXIN4
;
HEX4			JSR	PROMPT	;Print MSG # from A reg
HEXIN4		LDX	#$04	;Set for number of characters allowed
					JSR	HEXINPUT	;Convert digits
					STY	INDEXH	;Store to INDEXH
					STA	INDEXL	;Store to INDEXL
					RTS	;Return to caller
;
HEX2			JSR	PROMPT	;Print MSG # from A reg
HEXIN2		LDX	#$02	;Set for number of characters allowed
;
;HEXINPUT subroutine: request 1 to 4 HEX digits from terminal,
;then convert ASCII HEX to HEX
;Setup RDLINE subroutine parameters:
HEXINPUT	JSR	DOLLAR	;Send "$" to console
					LDA	#$80	;Allow only valid ASCII HEX digits to be entered
					STA	LOKOUT	;Set lokout flag
					JSR	RDLINE	;Request ASCII HEX input from terminal
					STX	SCNT	;Save character count
					CPX	#$00	;Check for no input
					BEQ	HINEXIT	;Exit if no input
;Convert ASCII HEX digits to HEX
ASCTOHEX	STZ	HEXDATAH	;Clear MS HEX digits
					STZ	HEXDATAL	;Clear LS HEX digits
					LDY	#$02	;Init HEX buffer index for 2 bytes
ASCLOOP		STY	STMP	;Save HEX input buffer index
					LDA	INBUFF-1,X	;Read indexed ASCII HEX digit from buffer
					TAY	;Copy digit to Y Reg: least significant digit
					LDA	#$30	;Make A reg = ASCII "0": MS digit 
					JSR	ASC2BIN	;Convert ASCII digits to binary value
					LDY	STMP	;Read saved HEX input buffer index
					STA	HEXDATA,Y	;Write byte to indexed HEX input buffer location
					DEX	;Decrement ASCII digit count
					BEQ	HINDONE	;GOTO HINDONE IF no ASCII digits are left to process
					LDY	#$30	;Else, make Y Reg = ASCII "0": LS digit
					LDA	INBUFF-1,X	;Read indexed ASCII HEX digit from buffer: MS digit
					JSR	ASC2BIN	;Convert ASCII digits to binary value
					LDY	STMP	;Read saved HEX input buffer index
					ORA	HEXDATA,Y	;OR high digit with low digit
					STA	HEXDATA,Y	;Write byte to indexed HEX input buffer location
					DEX	;Decrement ASCII digit count
					BEQ	HINDONE	;Branch to HINDONE if no ASCII digits left
					DEY	;ELSE, decrement HEX input buffer index
					BNE	ASCLOOP	;Loop back to ASCLOOP IF HEX input buffer is full
HINDONE		LDX	SCNT	;Get entered count before exit
					LDY	HEXDATAH	;Get High Byte
					LDA	HEXDATAL	;Get Low Byte
HINEXIT		RTS	;And return to caller
;
;PRASC subroutine: Print A-reg as ASCII, else print "."
;Printable ASCII byte values = $20 through $7E
PRASC			CMP	#$7F	;Check for first 128
					BCS	PERIOD	;If = or higher, branch
					CMP	#$20	;Check for control characters
					BCS	ASCOUT	;If space or higher, branch and print
PERIOD		LDA	#$2E	;Else, print a "."
ASCOUT		BRA	BRCHOUT	;Send byte in A-Reg, then return
;
;BSOUT subroutine: send a Backspace to terminal
BSOUT			LDA	#$08	;Get ASCII backspace
					JSR	CHOUT	;Send to terminal
					JSR	SPC	;Send space to clear out character
BSOUT2		LDA	#$08	;Send another Backspace to return
BRCHOUT		JMP	CHOUT	;then done BSOUT subroutine, RETURN
;
BSOUT3T		JSR	BSOUT2	;Send a Backspace 3 times
BSOUT2T		JSR	BSOUT2	;Send a Backspace 2 times
					BRA	BSOUT2	;Send a Backspace and return
;
;SPC subroutines: Send a Space to terminal 1,2 or 4 times
SPC4			JSR	SPC2	;Send 4 Spaces to terminal
SPC2			JSR	SPC	;Send 2 Spaces to terminal
SPC				PHA	;Save character in A reg
					LDA	#$20	;Get ASCII Space
					BRA	SENDIT	;Branch to send
;
;DOLLAR subroutine: Send "$" to terminal
;CROUT subroutines: Send CR,LF to terminal (1 or 2 times)
DOLLAR		PHA	;Save A reg on STACK
					LDA	#$24	;Send "$" to terminal
					BRA	SENDIT	;Branch to send
;
;Send CR,LF to terminal
CROUT			PHA	;Save A reg
					LDA	#$0D	;Get ASCII Return
					JSR	CHOUT	;Send to terminal
					LDA	#$0A	;Get ASCII Linefeed
SENDIT		JSR	CHOUT	;Send to terminal
					PLA	;Restore A reg
					RTS	;Done CROUT/DOLLAR subroutine, Return
;
;GLINE subroutine: Send a horizontal line to terminal
GLINE			LDX	#$4F	;Load index for 79 decimal
					LDA	#$7E	;Get "~" character
GLINEL		JSR	CHOUT	;Send to terminal (draw a line)
					DEX	;Decrement count
					BNE	GLINEL	;Branch back until done
					RTS	;Return to caller
;
COMPERR		PHY	;Push index to stack
					LDA	TGTH	;Get Last address compared
					STA	CMPH	;Store at compare value
					LDA	TGTL	;Get low order byte
					STA	CMPL	;Store at compare value
					TYA	;Xfer index to A reg
					CLC	;Clear carry for add
					ADC	CMPL	;Add to address
					STA	CMPL	;Save it
					BCC	NOINCR	;Branch if no carry set
					INC	CMPH	;Otherwise increment high page by one
NOINCR		JSR	SPC2	;Send 2 spaces
					JSR	DOLLAR	;Print $ sign
					LDA	CMPH	;Get high byte of address
					LDY	CMPL	;Get Low byte of address
					JSR	PRWORD	;Print word
					JSR	SPC	;Add a space for formatting
					PLY	;Restore Index to Y reg
					RTS	;Return to caller
;
;PRBYTE subroutine:
; Converts a single Byte to 2 HEX ASCII characters and sends to console
; on entry, A reg contains the Byte to convert/send
; Register contents are preserved on entry/exit
PRBYTE		PHA	;Save A register
					PHY	;Save Y register
PRBYT2		JSR	BIN2ASC	;Convert A reg to 2 ASCII Hex characters
					JSR	CHOUT	;Print high nibble from A reg
					TYA	;Transfer low nibble to A reg
					JSR	CHOUT	;Print low nibble from A reg
					PLY	;Restore Y Register
					PLA	;Restore A Register
					RTS	;And return to caller
;
;PRWORD	subroutine:
;	Converts a 16-bit word to 4 HEX ASCII characters and sends to console
; on entry, A reg contains High Byte, Y reg contains Low Byte
; Register contents are preserved on entry/exit
PRWORD		PHA	;Save A register
					PHY	;Save Y register
					JSR	PRBYTE	;Convert and print one HEX character (00-FF)
					TYA	;Get Low byte value
					BRA	PRBYT2	;Finish up Low Byte and exit
;
;RDCHAR subroutine: Waits for a keystroke to be entered.
; if keystroke is a lower-case alphabetical, convert it to upper-case
RDCHAR		JSR	CHIN	;Request keystroke input from terminal
					CMP	#$61	;Check for lower case value range
					BCC	AOK	;Branch if keystroke value < $61, control code, upper-case or numeric
					SBC	#$20	;Subtract $20 to convert to upper case
AOK				RTS	;Character received, return to caller
;
;RDLINE subroutine: Setup a keystroke input buffer then store keystrokes in buffer
;until [RETURN] key it struck. Lower-case alphabeticals are converted to upper-case.
;Call with:
;A Register = buffer address high byte
;Y Register  = buffer address low byte
;X Register  = buffer length
;IF variable LOKOUT = $00 then allow all keystrokes.
;IF variable LOKOUT = $FF then allow only ASCII DECIMAL numeral input: 0123456789
;IF variable LOKOUT = $01 through $FE then allow only valid ASCII HEX numeral input: (0-9,A-F)
;[BACKSPACE] key removes keystrokes from buffer.
;[ESCAPE] key aborts then re-enters monitor. 
RDLINE		STX	BUFLEN	;Store buffer length   
					STZ	BUFIDX	;Zero buffer index
RDLOOP		JSR	RDCHAR	;Get keystroke input from terminal, convert LC2UC
					CMP	#$1B	;Check for ESC key
					BNE	NOTESC ;Branch if NOT ESC
					JMP	(WRMMNVEC0)	;Else, quit and enter monitor warm vector
NOTESC		CMP	#$0D	;Check for C/R
					BEQ	EXITRD	;Exit is yes
					CMP	#$08	;Check for Backspace
					BEQ	BACK	;Branch if yes
					LDX	LOKOUT	;Check Lokout flag 
					BEQ	FULTST	;Branch is 00 (all characters)
					CMP	#$30	;Else, filter enabled
					BCC	INERR	;Branch to error
					CMP	#$47	;Check for filter emnabled HEX input
					BCS	INERR	;Branch to error
					CMP	#$41	;Else, check for decimal filter
					BCC	DECTEST	;Branch if set
DECONLY		CPX	#$FF	;Check for filter enabled for ASCII decimal
					BNE	FULTST	;Continue if filter disabled
DECTEST		CMP	#$3A	;Check for decimal filter
					BCS	INERR	;Branch to error
FULTST		LDY	BUFIDX	;Get the current buffer index
					CPY	BUFLEN	;Compare to length for space
					BCC	STRCH	;Branch to store in buffer
INERR			JSR	BEEP	;Else, error, send Bell to terminal
					BRA	RDLOOP	;Branch back to RDLOOP
STRCH			STA	INBUFF,Y	;Store keystroke in buffer
					JSR	CHOUT	;Send keystroke to terminal
					INC	BUFIDX	;Increment buffer index
					BRA	RDLOOP	;Branch back to RDLOOP
EXITRD		LDX	BUFIDX	;Get keystroke count
					RTS	;Done, return to caller
;Perform a destructive Backspace
BACK			LDA	BUFIDX	;Check if buffer is empty
					BEQ	INERR	;Branch if yes
					DEC	BUFIDX	;Else, decrement buffer index
					JSR	BSOUT	;Send Backspace to terminal
					BRA	RDLOOP	;Loop back and continue
;
CONTINUE	LDA	#$00	;Get msg cont? (Y/N) to terminal
					BRA	SH_CONT	;Branch down
CONTINUE2	LDA	#$01	;Get short msg (Y/N) only
SH_CONT		JSR	PROMPT	;Send to terminal
TRY_AGN		JSR	RDCHAR	;Get keystroke from terminal
					CMP	#$59	;"Y" key?
					BEQ	DOCONT	;if yes, continue/exit
					CMP	#$4E	;if "N", quit/exit
					BEQ	DONTCNT	;Return if not ESC
					JSR	BEEP	;Send Beep to console
					BRA	TRY_AGN	;Loop back, try again
DONTCNT		PLA	;Else remove return address
					PLA	;and discard, then return
DOCONT		RTS	;Return
;					
;******************************
;* Monitor command processors *
;******************************
;
;[)] RUNMACRO command: Run monitor command macro. This will indicate that there
;are 128 keystrokes in the keystroke input buffer. The monitor will process these
;as if they were received from the terminal (typed-in by the user). Because the
;last keystroke stored in the keystroke buffer was ")", this will loop continuously.
;Use [BREAK] to exit loop  
RUNMACRO	LDA	#$7F	;Set keystroke buffer tail pointer to $7F
					STA	ITAIL	;Push tail pointer to end
					INC	A	;Increment to $80 for buffer count (full)
					STA	ICNT	;Make count show as full
					STZ	IHEAD	;Reset buffer head to zero
					RTS	;Return to caller
;
;[(] INIMACRO command: Initialize keystroke input buffer: Fill buffer with $00,
;initializes buffer head/tail pointers and resets buffer count to zero. This erases
;all previous monitor command keystrokes from the keystroke input buffer in
; preparation for entering a monitor command macro.
INIMACRO	LDA	#$02	;Make memory fill start address = $0200
					STA	TGTH	;Store High byte start pointer
					STZ	TGTL	;Zero Low byte start pointer
					STZ	LENH	;Zero high byte pointer
					LDA	#$80	;Set length = $0080
					STA	LENL	;Store in low byte pointer
;
					STZ	IHEAD	;Reset buffer head to zero
					STZ	ITAIL	;Reset buffer tail to zero
					STZ	ICNT	;Zero input count
					ASL	A	;Shift left (zero A reg for fill byte)
;
;Memory fill routine: parameter gathered below with Move/Fill, then a jump to here
;
USERFILL	LDX	LENH	;Get current length hi byte
					BEQ	FILEFT	;Branch if zero (no pages to fill)
					LDY	#$00	;Else, reset page byte address index
PGFILL		STA	(TGTL),Y	;Store fill value at current page address
					INY	;Increment page address index 
					BNE	PGFILL	;Loop back to fille the page
					INC	TGTH	;Increment page address high byte 
					DEX	;Decrement page counter
					BNE	PGFILL	;Loop back to fill all pages 
FILEFT		LDX	LENL	;Get current length lo byte
					BEQ	DONEFILL	;Exit if no partial pages to fill
					LDY	#$00	;Initialize page byte address index
FILAST		STA	(TGTL),Y	;Store fill value at current page address
					INY	;Increment page address index
					DEX	;Decrement byte counter
					BNE	FILAST	;Loop back to fill remaining
DONEFILL	RTS	;Return to caller
;
;[E] Examine/Edit command: Display in HEX then change the contents of a specified memory address
CHANGE		JSR	SETUP	;Request HEX address input from terminal
					JSR	SPC2	;Send 2 spaces
CHANGEL		LDA	(INDEXL)	;Read specified address
					JSR	PRBYTE	;Display HEX value read
					JSR	BSOUT3T ;Send 3 Backspaces
					JSR	HEXIN2	;result in A reg, X-reg and variable SCNT = # digits entered
					LDY	SCNT	;Check for digits entered
					BEQ	DONEFILL	;Exit if none
					STA	(INDEXL)	;Else, store entered value at current Index pointer
					CMP	(INDEXL)	;Compare to ensure a match
					BEQ	CHOK	;Branch if compare is good
					LDA	#$3C	;Else, get "<" character
					JSR	CHOUT	;Send to terminal
					LDA	#$3F	;Send "?" to terminal
					JSR	CHOUT	;Send to terminal
CHOK			INC	INDEXL	;Increment INDEX address
					BNE	PRNXT	;Branch is no wraparound
					INC	INDEXH	;Increment hi byte
PRNXT			JSR	SPC2	;Send 2 Spaces to terminal
					BRA	CHANGEL	;Loop to continue command
;
;[D] HEX/TEXT DUMP command:
; Display in HEX followed by TEXT the contents of 256 consecutive memory addresses
;
MDUMP			JSR	SETUP	;Request HEX address input from terminal
					JSR	DMPGR	;Send address offsets to terminal 
					JSR	GLINE	;Send horizontal line to terminal
					JSR	CROUT	;Send CR,LF to terminal
					LDA	SCNT	;Check for new address entered
					BNE	DLINE	;Branch if new address entered
					LDA	TEMP1L	;ELSE, point to next consecutive memory page
					STA	INDEXL	;address saved during last memory dump
					LDA	TEMP1H	;xfer high byte of address
					STA	INDEXH	;save in pointer
DLINE			JSR	SPC4	;Send 4 Spaces to terminal
					JSR	DOLLAR	;Send "$" to terminal
					LDA	INDEXH	;Get Index hi
					LDY	INDEXL	;Get Index lo
					JSR	PRWORD	;Print it as a hex word
					JSR	SPC2	;Send 2 [SPACE] to terminal
					LDY	#$00	;Initialize line byte counter
GETBYT		LDA	(INDEXL),Y	;Read indexed byte
					JSR	PRBYTE	;Display byte as a HEX value
					JSR	SPC	;Send [SPACE] to terminal
					INY	;Increment index
					CPY	#$10	;Check for all 16
					BNE	GETBYT	;loop back until 16 bytes have been displayed
					JSR	SPC	;Send a space
					LDY	#$00	;Zero count
GETBYT2		LDA	(INDEXL),Y	;Read indexed byte
					JSR	PRASC	;Print ASCII character
					INY	;Increment index
					CPY	#$10	;Check for all 16
					BNE	GETBYT2	;loop back until 16 bytes have been displayed					
					JSR	CROUT	;else, send CR,LF to terminal
					CLC	;Add $10 to line base address, save result in
					LDA	INDEXL	;Get index lo
					ADC	#$10	;Add in 16
					STA	INDEXL	;Update index lo
					STA	TEMP1L	;and save it to 16-bit temp
					BCC	ENDUMP	;Branch if no carry
					INC	INDEXH	;Else, increment high byte
					LDA	INDEXH	;Get the updated count
					STA	TEMP1H	;and save it to 16-bit temp
ENDUMP		INC	IDX	;Increment line counter
					LDX	IDX	;Get the line count value
					CPX	#$10	;Check for all 16 lines
					BNE	DLINE	;Branch back until all 16 done
					JSR	GLINE	;Send horizontal line to terminal
;DMPGR subroutine: Send address offsets to terminal
DMPGR			LDA	#$02	;Get msg for "addr:" to terminal
					JSR	PROMPT	;Send to terminal
					JSR	SPC2	;Add two additional spaces
					STZ	IDX	;Reset the index pointer
					LDX	#$00	;Zero index count
MDLOOP		TXA	;Send "00" thru "0F", separated by 1 Space, to terminal
					JSR	PRBYTE	;Print byte value
					JSR	SPC	;Add a space
					INX	;Increment the count
					CPX	#$10	;Check for 16
					BNE	MDLOOP	;Loop back until done
;
;	Print the ASCII text header "0123456789ABCDEF"
;
					JSR	SPC	;Send a space
					LDX	#$00	;Zero X reg for "0"
MTLOOP		TXA	;Xfer to A reg
					JSR	BIN2ASC	;Convert Byte to two ASCII digits
					TYA	;Xfer the low nibble character to A reg
					JSR	CHOUT	;Send least significant HEX to terminal
					INX	;Increment to next HEX character
					CPX	#$10	;Reach $10 yet
					BNE	MTLOOP	:branch back till done
					JMP	CROUT	;Do a CR/LF and return
;
;[G] GO command: Begin executing program code at a specified address
GO				JSR	SETUP	;Get HEX address input (Areg/Yreg contains 16-bit value)
					STA	COMLO	;Save it to command pointer low byte
					STY	COMHI	;Save it to command pointer hi byte
					TSX	;Get current stack pointer
					STX	POINTER	;And save it in temp location
;Preload all 65C02 MPU registers from monitor's preset/result variables
					LDX	SREG	;Load STACK POINTER preset
					TXS	;Transfer to Stack pointer
					LDA	PREG	;Load processot status register preset
					PHA	;Push it to the stack
					LDA	AREG	;Load A-Reg preset
					LDX	XREG	;Load X-Reg preset
					LDY	YREG	;Load Y-Reg preset
					PLP	;Pull the processor status register
;Call user program code as a subroutine
					JSR	DOCOM	;Execute code at specified address
;Store all 65C02 MPU registers to monitor's preset/result variables: store results
					PHP	;Save the processor status register to the stack
					STA	AREG	;Store A-Reg result
					STX	XREG	;Store X-Reg result
					STY	YREG	;Store Y-Reg result
					PLA	;Get the processor status register
					STA	PREG	;Store the result
					TSX	;Xfer stack pointer to X-reg
					STX	SREG	;Store the result
					LDX	POINTER	;Get the initial stack pointer
					TXS	;And restore it
					CLD	;Clear BCD mode in case of sloppy user code ;-)
					RTS	;Return to caller
DOCOM			JMP	(COMLO)	;Execute the command
;
;[T] LOCATE TEXT STRING command: search memory for an entered text string.
;Memory range scanned is $0800 through $FFFF (specified in SENGINE subroutine).
;STXTSTR subroutine: request 1 - 16 character text string from terminal, followed by [RETURN].
;[ESCAPE] aborts, [BACKSPACE] erases last keystroke. String will be stored in SRCHBUFF.
;This is used by monitor text/byte string search commands.
SRCHTXT		LDA	#$08	;Get msg " find text:"
					JSR	PROMPT	;Send to terminal
STXTSTR		LDY	#$00	;Initialize index/byte counter
STLOOP		JSR	CHIN	;Get input from terminal
					CMP	#$0D	;Check for C/R
					BEQ	STBR1	;Branch to search engine if yes
					CMP	#$1B	;Check for ESC
					BNE	STBR2	;If not, branch for B/S check
					LDY	#$00	;Else, zero count, no keystrokes to process
STBR1			BRA	SRCHRDY	;Branch for cleanup/exit
STBR2			CMP	#$08	;Check for B/S
					BNE	STBR3	;If not, store character into buffer
					TYA	;Xfer count to A reg
					BEQ	STLOOP	;Branch to input if zero
					JSR	BSOUT	;Else, send B/S to terminal
					DEY	;Decrement index/byte counter
					BRA	STLOOP	;Branch back and continue
STBR3			STA	SRCHBUFF,Y	;Store character in buffer location
					JSR	CHOUT	;Send character to terminal
					INY	;Increment counter
					CPY	#$10	;Check count for 16
					BNE	STLOOP	;Loop back for another character
					BRA	SRCHRDY	;Branch to search engine
;
;[H] LOCATE BYTE STRING command: search memory for an entered byte string.
;Memory range scanned is $0800 through $FFFF (specified in SENGINE subroutine).
;SBYTSTR subroutine: request 0 - 16 byte string from terminal, each byte followed by [RETURN].
;[ESCAPE] aborts. HEX data will be stored in SRCHBUFF.
;This is used by monitor text/byte string search commands.
SRCHBYT		LDA	#$09	;Get msg " find bin:"
					JSR	PROMPT	;Send to terminal
SBYTSTR		LDY	#$00	;Initialize index
SBLOOP		STY	IDY	;Save index 
					JSR	HEXIN2	;Request HEX byte
					JSR	SPC	;Send space to terminal
					LDY	IDY	;Restore index/byte counter
					LDX	SCNT	;Get # of characters entered 
					BEQ	SRCHRDY ;Branch if no characters
					STA	SRCHBUFF,Y ;Else, store in buffer
					INY	;Increment index
					CPY	#$10	;Check for 16 (max)
					BNE	SBLOOP	;Loop back until done/full
SRCHRDY		STY	IDY	;Save input character count
					CPY	#$00	;Check buffer count
					BEQ	SINCEXT	;Exit if no bytes in buffer
					LDA	#$0D	;Else, get msg "Searching.."
					JSR	PROMPT	;Send to terminal
;
;SENGINE subroutine: Scan memory range $0800 through $FFFF for exact match to string
;contained in buffer SRCHBUFF (1 to 16 bytes/characters). Display address of first
;byte/character of each match found until the end of memory is reached.
;This is used by monitor text/byte string search commands
SENGINE		LDA	#$08	;Initialize address to $0800: skip over $0000 through $07FF
					STA	INDEXH	;Store high byte
					STZ	INDEXL ;Zero low byte
SENGBR2		LDX	#$00	;Initialize buffer index
SENGBR3		LDA	(INDEXL)	;Read current memory location
					CMP	SRCHBUFF,X	;Compare to search buffer
					BEQ	SENGBR1	;Branch for a match
					JSR	SINCPTR	;Else, increment address pointer, test for end of memory
					BRA	SENGBR2	;Loop back to continue
SENGBR1		JSR	SINCPTR	;Increment address pointer, test for end of memory
					INX	;Increment buffer index
					CPX	IDY	;Compare buffer index to address index
					BNE	SENGBR3	;Loop back until done
					SEC	;Subtract buffer index from memory address pointer: Set carry
					LDA	INDEXL	;Get current address for match lo byte
					SBC	IDY	;Subtract from buffer index
					STA	INDEXL	;Save it back to lo address pointer
					LDA	INDEXH	;Get current address for match hi byte
					SBC	#$00	;Subtract carry flag
					STA	INDEXH	;Save it back to hi address pointer
					LDA	#$0B	;Get msg "found"
					JSR	PROMPT	;Send to terminal
					LDA	#$0C	;Get msg ":$"
					JSR	PROMPT	;Send to terminal
					LDA	INDEXH	;Get Hi Byte
					LDY	INDEXL	;Get Lo Byte
					JSR	PRWORD	;Print Word
					LDA	#$0E	;Get msg "(n)ext? "
					JSR	PROMPT	;Send to terminal
					JSR	RDCHAR	;Get input from terminal
					CMP	#$4E	;Check for "(n)ext"
					BNE	SINCEXT	;Exit if not requesting next
					JSR	SINCPTR	;Increment address pointer, test for end of memory
					BRA	SENGBR2	;Branch back and continue till done
;
;Increment memory address pointer. If pointer high byte = 00 (end of searchable ROM memory),
;send "not found" to terminal then return to monitor 
SINCPTR		CLC	;Clear carry for addition
					LDA	INDEXL	;Get Index low byte
					ADC	#$01	;Increment by one
					STA	INDEXL	;Save it to variable
					LDA	INDEXH	;Get Index high byte
					ADC	#$00	;Add carry to it
					STA	INDEXH	;Save it to variable
					CMP	#$00	;Check for wrap to $0000
					BNE	SINCEXT	;If not, continue
					PLA	;Else, Pull return address from stack
					PLA	;and exit with msg
					LDA	#$0A	;Get msg "not found"
					JMP	PROMPT	;Send msg to terminal and exit
SINCEXT		RTS	;Exit
;
;[C] Compare one memory range to another and display any addresses which do not match
; Uses source, target and length input parameters. errors in compare are shown in target space
;[M] Move routine also starts here for parameter input, then branches to MOVER below
;[F] Fill routine uses this section as well for parameter input but requires a fill byte value
;[CTRL-P] Program EEPROM also uses a partial section of this routine to write the EEPROM
; the input parameters are identical for all three commands.
;
MFILL
COMPARE		STA	TEMP3	;Save command character
					JSR	CHOUT	;Print command character (C/M/F)
					CMP	#$46	;Check for F - fill memory
					BNE	PRGE_E	;If not continue normal parameter input
					LDA	#$03	;Get msg " addr:"
					BRA	F_INPUT	;Branch to handle parameter input
PRGE_E		LDA	#$06	;Send " src:" to terminal
					JSR	HEX4	;Use short cut version for print and input
					LDX	SCNT	;Check for digits entered
					BEQ	QUITCMP	;If none, quit
					STA	SRCL	;Else, store source address in variable SRCL,SRCH
					STY	SRCH	;Store high address
					LDA	#$07	;Send " tgt:" to terminal
F_INPUT		JSR	HEX4	;Use short cut version for print and input
					LDX	SCNT	;Check for digits entered
					BEQ	QUITCMP	;If none, quit
					STA	TGTL	;Else, store target address in variable TGTL,TGTH
					STY	TGTH	;Store high address
					LDA	#$04	;Send " len:" to terminal
					JSR	HEX4	;Use short cut version for print and input
					LDX	SCNT	;Check for digits entered
					BEQ	QUITCMP	;If none, quit
					STA	LENL	;ELSE, store length address in variable LENL,LENH
					STY	LENH	;Store high address
; All input parameters for (Source), Target and Length entered
					LDA	TEMP3	;Get Command character
					CMP	#$46	;Check for fill memory
					BEQ	FM_INPUT	;Handle the remaining input
					CMP	#$43	;Test for Compare
					BEQ	COMPLP	;Branch if yes
					CMP	#$4D	;Check for Move
					BEQ	MOVER	;Branch if yes
					JMP	PROG_EE	;Jump to Program EEPROM routine
;
FM_INPUT	LDA	#$05	;Send "val: " to terminal
					JSR	HEX2	;Use short cut version for print and input
					LDX	SCNT	;Get digit count entered
					BEQ	QUITCMP	;If none, quit
					STA	TEMP3	;Save fill value
					JSR	CONTINUE	;Handle continue prompt
					LDA	TEMP3	;Get fill value
					JMP	USERFILL	;Go fill memory
;
COMPLP		LDA	LENH	;Get high byte of length
					BEQ	BYTCMP	;less than a page to compare, handle and exit
					LDY	#$00	;Zero index
CMPPGLP		LDA	(SRCL),Y	;Get source data
					CMP	(TGTL),Y	;Compare to target data
					BNE	CMPERR	;Handle compare error and continue
CMPPGRT		INY	;Increment index for next data byte
					BNE	CMPPGLP	;Branch back until full page complete
					DEC	LENH	;Decrement page count length
					INC	SRCH	;Increment source page
					INC	TGTH	;Increment target page
					BRA	COMPLP	;Branch back for next page
BYTCMP		LDA	LENL	;get low byte index (last page, 1-256 bytes)
					BEQ	QUITCMP	;Exit if zero, finished
					LDY	#$00	;Zero index
BYTCMPC		LDA	(SRCL),Y	;Get source data
					CMP	(TGTL),y	;Compare against source
					BNE	CMPERR	;Handle compare error and continue
CMPBYTRT	INY	;Increment index to next source data
					DEC	LENL	;Decrement count remaining
					BNE	BYTCMPC	;Loop back until done
QUITCMP		RTS	;Finished, return
;
; Compare Error Handler
;
CMPERR		JSR	COMPERR	;Call error subroutine
					LDA	LENH	;Get high byte, check if in page routine or byte routine
					BEQ	CMPBYTRT	;Branch to byte compare, on last page
					BRA	CMPPGRT	;Else branch to Page compare and continue on
;
;Parameters for move memory entered and validated.
; now make decision on which direction to do the actual move.
; if overlapping, move from end to start, else from start to end.
MOVER			JSR	CONTINUE	;Prompt to continue move
					SEC	;Set carry flag for subtract
					LDA	TGTL	;Get target lo byte
					SBC	SRCL	;Subtract source lo byte
					TAX	;Move to X reg temporarily
					LDA	TGTH	;Get target hi byte
					SBC	SRCH	;Subtract source hi byte
					TAY	;Move to Y reg temporarily
					TXA	;Xfer lo byte difference to A reg
					CMP	LENL	;Compare to lo byte length
					TYA	;Xfer hi byte difference to A reg
					SBC	LENH	;Subtract length lo byte
					BCC	RIGHT	;If carry is clear, overwrite condition exists
;Move memory block first byte to last byte, no overwrite condition, do the move
					LDY	#$00	;Initialize the page index count
					LDX	LENH	;Load X reg with length hi byte count
					BEQ	MVREST	;Branch if no pages to move
MVPGE			LDA	(SRCL),Y	;Load source data
					STA	(TGTL),Y	;Store as target data
					INY	;Increment page byte index
					BNE	MVPGE	;Loop back until page is moved
					INC	SRCH	;Increment source page address
					INC	TGTH	;Increment target page address
					DEX	;Decrement page counter
					BNE	MVPGE	;Loop back until all pages are moved
;All full pages moved. Now move a partial page if required
MVREST		LDX	LENL	;Get length lo byte count
					BEQ	QUITMV	;If nothing to move, quit
REST			LDA	(SRCL),Y	;Load source data
					STA	(TGTL),Y	;Store to target data
					INY	;Increment byte index
					DEX	;Decrement byte count
					BNE	REST	;Loop back until remaining data is moved
QUITMV		RTS	;Return to caller
;
;Move memory block last byte to first byte
; avoids overwrite in source/target overlap
RIGHT			LDX	LENH	;Get the length hi byte count
					CLC	;Clear carry flag for add
					TXA	;Xfer High page to A reg
					ADC	SRCH	;Add in source hi byte
					STA	SRCH	;Store in source hi byte
					CLC	;Clear carry for add
					TXA	;Xfer High page to A reg 
					ADC	TGTH	;Add to target hi byte
					STA	TGTH	;Store to target hi byte
					INX	;Increment high page value for use below in loop
					LDY	LENL	;Get length lo byte
					BEQ	MVPG	;If zero no partial page to move
					DEY	;Else, decrement page byte index
					BEQ	MVPAG	;If zero, no pages to move
MVPRT			LDA	(SRCL),Y	;Load source data
					STA	(TGTL),Y	;Store to target data
					DEY	;Decrement index
					BNE  MVPRT	;Branch back until partial page moved
MVPAG			LDA	(SRCL),Y	;Load source data
					STA	(TGTL),Y	;Store to target data
MVPG			DEY	;Decrement page count
					DEC	SRCH	;Decrement source hi page
					DEC	TGTH	;Decrement target hi page
					DEX	;Decrement page count
					BNE	MVPRT	;Loop back until all pages moved
					RTS	;Return to caller
;
;[P] Processor StatusS command: Display then change PS preset/result
PRG				LDX	#$00	;Set offset for Processor Status register
					BRA	REG_UPT	;Finish register update
;
;[S] Stack Pointer command: Display then change SP preset/result
SRG				LDX	#$01	;Set offset for Stack register
					BRA	REG_UPT	;Finish Register update
;
;[Y] Y-Register command: Display then change Y-reg preset/result
YRG				LDX	#$02	;Set offset for Y Reg
					BRA	REG_UPT	;Finish register update
;
;[X] X-Register command: Display then change X-reg preset/result
XRG				LDX	#$03	;Set offset for X Reg
					BRA	REG_UPT	;Finish register update
;
;[A] A-Register command: Display in HEX then change A-reg preset/result
ARG				LDX	#$04	;Offset to Page Zero Register storage
;
REG_UPT		PHX	;Save offset to stack
					TXA	;Xfer offset to A reg
					CLC	;Clear carry for add
					ADC	#$0F	;Add in message offset
					JSR	PROMPT	;Print Register message
					LDA	PREG,X	;Read Register (A,X,Y,S,P) preset/result
					JSR	PRBYTE	;Display HEX value of register
					JSR	SPC	;Send [SPACE] to terminal
					JSR	HEXIN2	;Get up to 2 HEX characters
					PLX	;Get offset from stack
					LDY	SCNT	;Get # of digits entered
					BEQ	NCAREG	;Branch if none
					STA	PREG,X	;Else, Write to register (A,X,Y,S,P) preset/result
NCAREG		RTS	;Done ARG command, RETURN
;
;[R] REGISTERS command: Display contents of all preset/result memory locations
PRSTAT		JSR	CHOUT	;Send "R" to terminal
PRSTAT1		LDA	#$14	;Get Header msg
					JSR	PROMPT	;Send to terminal
					LDA	PCH	;Get PC high byte
					LDY	PCL	;Get PC low byte
					JSR	PRWORD	;Print 16-bit word
					JSR	SPC2	;Add 2 spaces
;
					LDX	#$04	;Set for count of 4
REGPLOOP	LDA	PREG,X	;Start with A reg variable
					JSR	PRBYTE	;Print it
					JSR	SPC2	;Send 2 spaces
					DEX	;Decrement count
					BNE	REGPLOOP	;Loop back till all 4 are sent
;
					LDA	PREG	;Get Status register preset
					LDX	#$08	;Get the index count for 8 bits
SREG_LP		LDY	#$30	;Get Ascii "zero"
					ASL	A	;Shift bit into carry
					PHA	;Save Current status
					BCC	SRB_ZERO	;If clear, print a zero
					INY	;Else increment Y reg to Ascii "one"
SRB_ZERO	TYA	;Transfer Ascii character to A reg
					JSR	CHOUT	;Print it
					PLA	;Restore current status
					DEX	;Decrement bit count
					BNE	SREG_LP	;Branch back until all bits are printed
					JMP	CROUT	;Send CR/LF and return
;
;[,] Delay Setup Routine
;	This routine gets hex input via the console
;	- first is a hex byte ($00-$FF) for the millisecond count
;	- second is a hex word ($0000-$FFFF) for the delay multiplier
;		these are stored in variables SETIM, DELLO/DELHI
;
SET_DELAY	LDA	#$18	;Get millisecond delay message
					JSR	HEX2	;Use short cut version for print and input
					CPX	#$00	;Check for no entry
					BEQ	GETMULT	;If no entry, assume no change
					STA	SETIM	;Else store millisecond count in variable
GETMULT		LDA	#$19	;Get Multiplier message
					JSR	HEX4	;Use short cut version for print and input
					CPX	#$00	;Check for no entry
					BEQ	NOMULT	;Branch if no entry
					STA	DELLO	;Store Low byte
					STY	DELHI	;Store High byte
NOMULT		RTS	;Return to caller
;
SET_XLDLY	LDA	#$1A	;Get XL Loop message
					JSR	HEX2	;Use short cut version for print and input
					CPX	#$00	;Check for no entry
					BEQ	NOMULT	;If zero, no value, exit
					STA	XDL	;Save delay value
					LDA	#$0D	;Get a carriage return
					JSR	CHOUT	;Send C/R (shows delay has been executed, no linefeed)
					JMP	EXE_XLDLY	;Execute Extra Long delay loop
;
;[CNTRL-V] Version command:
VER				LDA	#$16	;Get Intro substring (version)
					JSR	PROMPT	;Send to terminal
					LDY	#>BIOS_MSG	;Get high offset
					LDA	#<BIOS_MSG	;Get low offset
PROMPTR		STY	PROMPTH	;Store hi byte
					STA	PROMPTL	;Store lo byte
					BRA	PROMPT2	;Print message
;
;PROMPT routine: Send indexed text string to terminal. Index is A reg
;string buffer address is stored in variable PROMPTL, PROMPTH
PROMPT		ASL	A	;Multiply by two for msg table index
					TAY	;Xfer to index
					LDA	MSG_TABLE,Y	;Get low byte address
					STA	PROMPTL	;Store in Buffer pointer
					LDA	MSG_TABLE+1,Y	;Get high byte address
					STA	PROMPTH	;Store in Buffer pointer
;					
PROMPT2		LDY	#$00	;Zero index
PROMPT2L	LDA	(PROMPTL),Y	;Get string data
					BEQ	NOMULT	;If null character, exit (borrowed RTS)
					JSR	CHOUT	;Send character to terminal
					INY	;Increment pointer index
					BNE	PROMPT2L	;Loop back for next character
					INC	PROMPTH	;Increment high byte index
					BRA	PROMPT2	;Loop back and continue printing
;
;[CNTRL-P] Program EEPROM command
PROGEE		LDA	#$22	;Get PRG_EE msg
					JSR	PROMPT	;send to terminal
					STZ	TEMP3	;Clear command flag (Compare/Move)
					JMP	PRGE_E	;Get input parameters
;
PROG_EE		LDA	#$23	;Get first warning msg
					JSR	PROMPT	;Send to console
					JSR	CONTINUE2	;Prompt for y/n
;
					LDA	#$24	;Get second warning msg
					JSR	PROMPT	;send to console
					JSR	CONTINUE2	;Prompt for y/n
;
;Programming of the EEPROM is now confirmed by user
; This routine needs to copy the core move and test routine
; from ROM to RAM, then turn control over to it.
; as I/O can generate interrupts which point to ROM routines,
; all interrupts must be disabled during the sequence.
;
;Send message to console for writing EEPROM
					LDA	#$25	;Get write message
					JSR	PROMPT	;Send to console, then start writing EEPROM
OC_LOOP		LDA	OCNT	;Check output buffer count
					BNE	OC_LOOP	;Loop back until buffer sent
;
;Xfer byte write code to RAM for execution
					LDX	#BYTE_WRE-BYTE_WRS+1	;Get length of byte write code
BYTE_XFER	LDA	BYTE_WRS-1,X	;Get code
					STA	BURN_BYTE-1,X	;Write code to RAM
					DEX	;Decrement index
					BNE	BYTE_XFER	;Loop back till done
;
PROG_LP		LDA	LENH	;Get high byte of length
					BEQ	PRGBYT	;less than a page to write, handle and exit
					LDY	#$00	;Zero index
PRGPGLP		JSR	BURN_BYTE	;Write a byte to EEPROM
					LDA	(SRCL),Y	;Get source data
					CMP	(TGTL),Y	;Compare to target data
					BNE	PRGERR	;Handle compare error and continue
PRGPGRT		INY	;Increment index for next data byte
					BNE	PRGPGLP	;Branch back until full page complete
					DEC	LENH	;Decrement page count length
					INC	SRCH	;Increment source page
					INC	TGTH	;Increment target page
					BRA	PROG_LP	;Branch back for next page
;
PRGBYT		LDA	LENL	;get low byte index (last page, 1-256 bytes)
					BEQ	QUITPRG	;Exit if zero, finished
					LDY	#$00	;Zero index
BYTPRGC		JSR	BURN_BYTE	;Write a byte to EEPROM
					LDA	(SRCL),Y	;Get source data
					CMP	(TGTL),y	;Compare against source
					BNE	PRGERR	;Handle compare error and continue
PRGBYTRT	INY	;Increment index to next source data
					DEC	LENL	;Decrement count remaining
					BNE	BYTPRGC	;Loop back until done
;
QUITPRG		LDA	TEMP4	;Get Prog error flag
					BEQ	PRG_GOOD	;Branch to good program exit
					LDA	#$27	;Get Prog failed message
					BRA	BRA_PRMPT	;Branch to Prompt routine
;
PRG_GOOD	LDA	#$26	;Get completed message
					JSR	PROMPT	;Send to console and exit
					LDA	#$28	;Get warning message for RTC and Reset
BRA_PRMPT	JMP	PROMPT	;Send to console and exit
;
; Program EEPROM compare Error Handler
;
PRGERR		LDA	#$FF	;Get flag set
					STA	TEMP4	;Set compare error flag
					JSR	COMPERR	;Call error compare routine
					LDA	LENH	;Get high byte, check if in page routine or byte routine
					BEQ	PRGBYTRT	;Branch to byte compare, on last page
					BRA	PRGPGRT	;Else branch to Page compare and continue on
;
BYTE_WRS	SEI	;Disable interrupts
					LDA	(SRCL),Y	;Get source byte
					STA	(TGTL),Y	;Write to target byte
					LDA	(TGTL),Y	;Read target byte (EEPROM)
					AND	#%01000000	;Mask off bit 6 - toggle bit
BYTE_WLP	STA	TEMP3	;Store in Temp location
					LDA	(TGTL),Y	;Read target byte again (EEPROM)
					AND	#%01000000	;Mask off bit 6 - toggle bit
					CMP	TEMP3	;Compare to last read (toggles if still in write mode)
					BNE	BYTE_WLP	;Branch back if not done
					CLI	;Re-enable interrupts
BYTE_WRE	RTS	;Return to caller
;
;[CNTL-T] UPTIME command: Sends a string to the terminal showing the uptime
; of the system since the last system reset. This routine uses the RTC values
; for Days, Hours, Minutes and seconds. It converts each to BCD and outputs
; to the terminal with text fields. The routine does not calculate months/years.
;
UPTIME		LDA	#$1B	;Get Uptime message
					JSR	PROMPT	;Send to terminal
;
					LDA	#$1C	;Get Days message
					LDX	DAYSL	;Get Days low byte
					LDY	DAYSH	;Get Days high byte
					JSR	DO16TIME	;Convert and send to terminal
;
					LDA	#$1D	;Get Hours message
					LDX	HOURS	;Get Current Hours (low byte)
					JSR	DO8TIME	;Convert and send to terminal
;
					LDA	#$1E	;Get Minutes message
					LDX	MINS	;Get Current Minutes (low byte)
					JSR	DO8TIME	;Convert and send to terminal
;
					LDA	#$1F	;Get seconds message
					LDX	SECS	;Get Current Seconds (low byte)
;
DO8TIME		LDY	#$00	;Zero high byte
DO16TIME	PHA	;Save message number
					TYA	;Xfer High byte to A reg
					JSR	HEX2ASC	;Convert and print ASCII string
					PLA	;Restore message number
					BRA	BRA_PRMPT	;Branch to Prompt
;
;[CNTRL-L] Xmodem/CRC Loader command: receives a file from console via Xmodem protocol
; no cable swapping needed, uses existing console port and buffer via the terminal program
; not a full blown Xmodem/CRC implementation, only does CRC-16 checking, no fallback
; designed specifically for direct attach to host machine via com port
; can handle full 8-bit binary transfers without error
; tested with ExtraPutty and TeraTerm
;
; Added support for Motorola S-Record formatted files automatically.
; A parameter input is used as either a Load address for any non-S-record file.
; If the received file has a valid S-Record format, the parameter is used as a
; positive address Offset applied to the specified load address in the S-record file.
; supported format is S19 as created by the WDC Tools linker.
; Note: this code supports the execution address in the final S9 record, but WDC Tools
; does not provide any ability to put this into their code build. WDC are aware of this.
;
XMODEM		LDA	#$29	;Get Xmodem intro msg
					JSR	PROMPT	;Send to console
					STZ	S19FLAG	;Clear S-Record flag
					LDA	#$01	;Set block count for start
					STA	BLKNO	;Save it for starting block #
					JSR	SETUP	;Get Hex load address / S-record Offset
					JSR	CROUT	;Send a C/R to show input entered
					LDA	SCNT	;Check for input entered (if non-zero, use new data)
					BNE	XLINE	;Branch if data entered
					LDA	#$08	;Set Index Pointer
					STA	INDEXH	;to $0800
					STZ	INDEXL	;Set low byte Index Pointer
XLINE			LDA	INDEXH	;Get new high order address
					STA	PTRH	;Store to pointer
					LDA	INDEXL	;Get new low order address
					STA	PTRL	;Store to pointer
XDEFLT		LDA	#$0A	;Retry value of 10
					STA	CRCCNT	;Set CRC retry count
					STZ	RETRY	;Zero retry counter
;
;Wait for 5 seconds for user to setup xfer from terminal
					LDA	#$02	;Load milliseconds = 2 ms
					LDX	#$0A	;Load High multipler to 10 decimal
					LDY	#$FA	;Load Low multipler to 250 decimal
					JSR	SET_DLY	;Set Delay parameters
					JSR	EXE_LGDLY	;Call long delay for 5 seconds
;
STRT_XFER	LDA	#"C"	;Send "C" character for CRC mode
					JSR	CHOUT	;Send to terminal
CHR_DLY		JSR	EXE_MSDLY	;Delay 2 milliseconds
					LDA	ICNT	;Check input buffer count
					BNE	STRT_BLK	;If a character is in, branch
					DEC	RETRY	;Else, decrement loop count
					BNE	CHR_DLY	;Branch and check again 256 times
					BRA	STRT_XFER	;Else, branch and send another "C"
;
STRT_BLK	JSR	CHIN	;Get a character
					CMP	#$1B	;Is it escape - quit?
					BNE	BYTE_RCV0	;No, continue
					RTS	;Cancelled by user, return
;
BYTE_RCV0	CMP	#SOH	;Start of header?
					BEQ	GET_BLK	;If yes, branch and receive block
					CMP	#EOT	;End of Transmission
					BEQ	XDONE	;If yes, branch and exit
					JMP	STRT_ERR	;Branch to error
;
XDONE			LDA	#ACK	;Last block, get ACK character
					JSR	CHOUT	;Send final ACK
					LDY	#$02	;Get delay count
					LDA	#$2A	;Get Good xfer message number
FLSH_DLY	STZ	ICNT	;Zero input count
					STZ	IHEAD	;Zero head pointer
					STZ	ITAIL	;Zero tail pointer
					PHA	;Save Message number
					LDA	#$FA	;Load milliseconds = 250 ms
					LDX	#$00	;Load High multipler to 0 decimal
					JSR	SET_DLY	;Set Delay parameters
					JSR	EXE_LGDLY	;Execute delay, (wait to get terminal back)
					PLA	;Get message number back
					CMP	#$2B	;Check for error msg#
					BEQ	SHRT_EXIT	;Do only one message
					PHA	;Save MSG number
					BIT	S19FLAG	;Check S-Record flag
					BEQ	END_LOAD	;If zero, just exit
					LDA	#$2C	;Get S-Record load address msg
					JSR	PROMPT	;Printer header msg
					LDA	SRCH	;Get source high byte
					LDY	SRCL	;Get source low byte
					JSR	PRWORD	;Print Hex address
					JSR	CROUT	;Print C/R and return
END_LOAD	PLA	;Get MSG #
SHRT_EXIT	JMP	PROMPT	;Print message and exit
;
GET_BLK		LDA	#$40	;Get flag setting
					STA	XMFLAG	;Set flag for active Xmodem
					LDX	#$00	;Zero index for block receive
;
GET_BLK1	JSR	CHIN	;Get a character
					STA	RBUFF,X	;Move into buffer
					INX	;Increment buffer index
					CPX	#$84	;Compare size (<01><FE><128 bytes><CRCH><CRCL>)
					BNE	GET_BLK1	;If not done, loop back and continue
					STZ	XMFLAG	;Clear Xmodem active flag (allows break to be sent)
;
					LDA	RBUFF	;Get block number from buffer
					CMP	BLKNO	;Compare to expected block number
					BNE	RESTRT	;If not correct, restart the block
					EOR	#$FF	;one's complement of block number
					CMP	RBUFF+1	;Compare with expected one's complement of block number
					BEQ	BLK_OKAY	;Branch if compare is good
;
RESTRT		LDA	#NAK	;Get NAK character
RESTRT2		JSR	CHOUT	;Send to xfer program
					BRA	STRT_BLK	;Restart block transfer
;
BLK_OKAY	STZ	CRCLO	;Reset the CRC value by (3)
					STZ	CRCHI	;putting all bits off (3)
					LDY	#$00	;Set index for data offset (2)
CALCCRC		LDA	RBUFF+2,Y	;Get first data byte (4)
					STA	VALUE	;Store it for CRC calculation (3)
GENCRC		PHP	;Save registers (3)
					PHY (3)
					LDX	#$08	;Load index for 8 bits (2)
CRCLOOP		ASL	VALUE	;Shift (next) bit to carry (5)
					ROR	A	;Get bit into bit 7 (2)
					AND	#%10000000	;Mask off other bits (2)
					EOR	CRCHI	;Exclusive OR with CRC hi (3)
					ASL	CRCLO	;Shift CRC left (5)
					ROL	A	;Then do high byte (2)
					BCC	CRCLP1	;Branch is MSB is 1 (2/3)
					TAY	;Save CRC hi in Y reg (2)
					LDA	CRCLO	;Get CRC lo (3)
					EOR	#$21	;Exclusive OR with polynomial (2)
					STA	CRCLO	;Store it (3)
					TYA	;Get CRC hi back (2)
					EOR	#$10	;Exclusive OR with polynomial (2)
CRCLP1		STA	CRCHI	;Store CRC hi (3)
					DEX	;Decrement index (2)
					BNE	CRCLOOP	;Loop back for all 8 bits (2/3)
					PLY	;Restore registers (4)
					PLP (4)
					INY	;Increment index to the next data byte (2)
					BPL	CALCCRC	;Branch back until all 128 fed to CRC routine (2/3)
					LDA	RBUFF+2,Y	;Get received CRC hi byte (4)
					CMP	CRCHI	;Compare against calculated CRC hi byte (3)
					BNE	BADCRC	;If bad CRC, handle error (2/3)
					INY	;Increment index pointer (2)
					LDA	RBUFF+2,Y	;Get CRC lo byte (4)
					CMP	CRCLO	;Compare against calculated CRC lo byte (3)
					BEQ	GOODCRC	;If good, go move good frame to memory (2/3)
; CRC was bad... need to retry and receive the last frame again
; Decrement the CRC retry count, send a NAK and try again
; Count allows up to 16 retries, then cancels the transfer
BADCRC		DEC	CRCCNT	;Decrement retry count
					BNE	CRCRTRY	;Retry again if count not zero
STRT_ERR	LDA	#CAN	;Else get Cancel code
					JSR	CHOUT	;Send it once
					JSR	CHOUT	;Send it twice (some xfer programs require twice)
					LDY	#$08	;Set delay multiplier
					LDA	#$2B	;Get message for receive error
					JMP	FLSH_DLY	;Do a flush, delay and exit
CRCRTRY		STZ	ICNT	;Zero input count
					STZ	IHEAD	;Zero head pointer
					STZ	ITAIL	;Zero tail pointer
					BRA	RESTRT	;Send NAK and retry
;
MOVE_BLK	LDX	#$00	;Set index offset to data
					LDY	#$00	;Set target offset to zero
COPYBLK		LDA	RBUFF+2,X	;Get data byte from buffer
					STA	(PTRL),Y	;Store to target address
					INC	PTRL	;Incrememnt low address byte
					BNE	COPYBLK2	;Check for hi byte loop
					INC	PTRH	;Increment hi byte address
COPYBLK2	INX	;Point to next data byte
					BPL	COPYBLK	;Loop back until done
INCBLK		INC	BLKNO	;Increment block number
					LDA	#ACK	;Get ACK character
					BRA	RESTRT2	;Send the ACK and restart
;
;Block has been received, check for S19 record transfer
GOODCRC		LDA	S19FLAG	;Get S19 record flag
					BNE	XFER_S19	;If non-zero, process as S-record
					LDA	BLKNO	;Else, check current block number
					DEC	A	;Check for block 1 only (first time thru)
					BEQ	TEST_S19	;If yes, test for S19 record
					BRA	MOVE_BLK	;Move a block of data
;
TEST_S19	LDA	RBUFF+2	;Get first character
					CMP	#"S"	;Check for S character
					BNE	MOVE_BLK	;If not equal, no S-record, move block
					LDA	RBUFF+3	;Get second character
					CMP	#"1"	;Check for 1 character
					BNE	MOVE_BLK	;If not equal, no S-record, move block
					DEC	S19FLAG	;Turn S-record flag on ($00 to $FF)
					STZ	IDY	;Zero index for SRBUFF
;
; S-record transfer routine
;	Xmodem is a 128 byte data block, S-record is variable, up to 44 byte block.
;	need to move a record at a time to the SRBUFF based on length, check as valid,
;	then calculate address and transfer to that location.
;	once the Xmodem buffer is empty, loop back to get the next frame
;	and continue processing S-records until completed.
;
; At entry here, a 128 byte block has been received and the pointer for the
; 128 bytes has been set to zero. The S-record length needs to be calculated
; then the proper count moved to the SRBUFF location and both pointers updated.
;
XFER_S19	STZ	IDX	;Zero offset to RBUFF
S19_LOOP2	LDX	IDX	;Load current offset to RBUFF
					LDY	IDY	;Get S-Record offset
S19_LOOP	LDA	RBUFF+2,X	;Get S-Record data
					STA	SRBUFF,Y	;Save it to the S-record buffer
					INX	;Increment offset to RBUFF
					CPX	#$81	;Check for end of RBUFF data
					BEQ	NXT_FRAME	;If yes, go back and get another frame
					INY	;Increment S-Rec size
					CPY	#$2C	;Check for size match
					BNE	S19_LOOP	;Branch back until done
					STX	IDX	;Update running offset to RBUFF
					STZ	IDY	;Reset SRBUFF index pointer
					JSR	SREC_PROC	;Process the S-Record and store in memory
					BRA	S19_LOOP2	;Branch back and get another record
NXT_FRAME	STY	IDY	;Save SRBUFF offset
INCBLK2		BRA	INCBLK	;Increment block and get next frame
;
SREC_PROC	LDA	SRBUFF+1	;Get the next character
					CMP	#"1"	;Check for S1 record
					BEQ	S1_PROC	;Process a S1 record
					CMP	#"9"	;Check for S9 (final) record
					BEQ	S9_PROC	;Process a S9 record
SREC_ERR	PLA	;Pull return address
					PLA	;two bytes
					BRA	STRT_ERR	;Jump to Xmodem error/exit routine
;
SR_PROC		LDY	SRBUFF+3	;Get record length LS character
					LDA	SRBUFF+2	;Get record length MS character
					JSR	ASC2BIN	;Convert to single byte for length
					INC	A	;Add one to lenghth to include checksum
					STA	TEMP4	;Save record length
;
					CMP	#20	;Check for full record count
					BEQ	SR_COMP	;If yes, continue to process normal
;
; If record length is less, than the difference needs to be subtracted from IDX
; which reflects either the last record (S9) or one of a lesser length.
;
					SEC	;Set carry for subtract
					LDA	#20	;Get default count
					SBC	TEMP4	;Subtract actual length
					ASL	A	;Multiply by two for characters pairs
					STA	TEMP3	;Save it to temp
;
					SEC	;Set carry for subtract
					LDA	IDX	;Get RBUFF index
					SBC	TEMP3	;Subtract difference
					STA	IDX	;Update IDX
;
SR_COMP		LDX	#$00	;Zero Index
					LDY	#$00	;Zero Index
SR_CMPLP	PHY	;Save Y reg index
					LDY	SRBUFF+3,X	;get LS character
					LDA	SRBUFF+2,X	;Get MS character
					JSR	ASC2BIN	;Convert two ASCII characters to HEX byte
					PLY	;Restore Y reg index
					STA	SRBUFF,Y	;Store in SRBUFF starting at front
					INX	;Increment X reg twice
					INX	;points to next character pair
					INY	;Increment Y reg once for offset to SRBUFF
					DEC	TEMP4	;Decrement character count
					BNE	SR_CMPLP	;Branch back until done
;
; SRBUFF now has the compressed HEX data, which is:
; 1 byte for length, 2 bytes for the load address,
; up to 16 bytes for data and 1 byte checksum
; Now calculate the checksum and ensure valid S-record content
;
					STZ	TEMP2	;Zero Checksum location
					LDX	SRBUFF	;Load index with record length
					LDY	#$00	;Zero index
SR_CHKSM	CLC	;Clear carry for add
					LDA	SRBUFF,Y	;Get first byte
					ADC	TEMP2	;Add in checksum Temp
					STA	TEMP2	:Update checksum Temp
					INY	;Increment offset
					DEX	;Decrement count
					BNE	SR_CHKSM	;Branch back until done
;
					LDA	#$FF	;Get all bits on
					EOR	TEMP2	;Exclusive OR TEMP for one's complement
					CMP	SRBUFF,Y	;Compare to last byte (which is checksum)
					BNE	SREC_ERR	;If bad, exit out
					RTS	;Return to caller
;
S9_PROC		JSR	SR_PROC	;Process the S-Record and checksum
					LDA	SRBUFF+1	;Get MS load address
					STA	COMHI	;Store to execution pointer
					LDA	SRBUFF+2	;Get LS load address
					STA	COMLO	;Store to execution pointer
					PLA	;Pull return address
					PLA	;second byte
					BRA	INCBLK2	;Branch back to close out transfer
;
S1_PROC		JSR	SR_PROC	;Process the S-Record and checksum
;
; Valid binary S-Record decoded at SRBUFF
; Calculate offset from input, add to specified load address
; and store into memory, then loop back until done
;
; Offset is stored in PTR L/H from initial input.
; if no input entered, SCNT is zero and PTR L/H is preset to $0800
; so checking for SCNT being zero bypasses adding the offset,
; if SCNT is non zero, then PTR L/H contains the offset address
; which is added to TGT L/H moving the S-record data to memory
;
					LDA	SRBUFF+1	;Get MS load address
					STA	TGTH	;Store to target pointer
					LDA	SRBUFF+2	;Get LS load address
					STA	TGTL	;Store to target pointer
					LDA	SCNT	;Check input count for offset required
					BEQ	NO_OFFSET	;If Zero, no offset was entered
;
; Add in offset contained at PTR L/H to TGT L/H
;
					CLC	;Clear carry for add
					LDA	PTRL	;Get LS offset
					ADC	TGTL	;Add to TGTL address
					BCC	SKIP_HB	;Skip increment HB is no carry
					INC	TGTH	;Else increment TGTH by one
SKIP_HB		STA	TGTL	;Save TGTL
					LDA	PTRH	;Get MS offset
					ADC	TGTH	;Add to TGTH
					STA	TGTH	;Save it
;
; Check for first Block and load SRC H/L with load address
;
NO_OFFSET	LDA	BLKNO	;Get Block number
					DEC	A	;Decrement to test for block one
					BNE	NO_OFFST2	;If not first block, skip around
					LDA	IDX	;Get running count for first block
					CMP	#$2C	;First S-record?
					BNE	NO_OFFST2	;If yes, setup load address pointer
					LDA	TGTL	;Get starting address Lo byte
					STA	SRCL	;Save it as Source Lo byte
					LDA	TGTH	;Get starting address Hi byte
					STA	SRCH	;Save it as Source Hi byte
;
NO_OFFST2	LDX	SRBUFF	;Get record length
					DEX	;Decrement by 3
					DEX	; to only transfer the data
					DEX	; and not the count and load address
					LDY	#$00	;Zero index
MVE_SREC	LDA	SRBUFF+3,Y	;Get offset to data in record
					STA	(TGTL),Y	;Store it to memory
					INY	;Increment index
					DEX	;Decrement record count
					BNE	MVE_SREC	;Branch back until done
					RTS	;Return to caller
;
;[CNTL-R]	Reset System command: Resets system by calling Coldstart routine
;	Page zero is cleared, vectors and config data re-initialized from ROM
;	All I/O devices reset from initial ROM parameters, Monitor cold start entered.
;
SYS_RST		LDA	#$21	;Get msg "Reset System"
					JSR	PROMPT	;Send to terminal
					JSR	CONTINUE	;Prompt to continue
					BRA	DO_COLD	;Branch to coldstart JMP below
;
;[CNTL-Z] Zero command: zero RAM from $0100-$7FFF and Reset
ZERO			LDA	#$20	;Get msg "Zero RAM/Reset System"
					JSR	PROMPT	;Send to terminal
					JSR	CONTINUE	;Prompt for Continue
					SEI	;Disable IRQs
					LDA	#$01	;Initialize address pointer to $0100
					STA	$01	;Store to pointer
					DEC	A	;LDA #$00
					STA	$00	;Store to pointer
ZEROLOOP	STA	($00)	;Write $00 to current address
					INC	$00	;Increment address pointer
					BNE	ZEROLOOP
					INC	$01
					BPL	ZEROLOOP	;LOOP back IF address pointer < $8000
DO_COLD		JMP	COLDSTRT	;Jump to coldstart vector
;
;*******************************************
;*                C02 Monitor              *
;*******************************************
;*  This is the Monitor Cold start vector  *
;*******************************************
MONITOR		LDA	#$7F	;Get user stack value
					STA	SREG	;Store in stack preset/result value
					STZ	LOKOUT	;Disable ASCII filter
					LDA	#$15	;Get intro msg
					JSR	PROMPT	;Send to terminal
					JSR	BEEP	;Send [BELL] to terminal
;
;*******************************************
;*           Command input loop            *
;*******************************************
;*  This in the Monitor Warm start vector  *
;*******************************************
NMON			LDX	#$FF	;Initialize Stack pointer
					TXS	;Xfer to stack
					LDA	#$17	;Get prompt msg
					JSR	PROMPT	;Send to terminal
;
CMON			JSR	RDCHAR	;Wait for keystroke (RDCHAR converts to upper-case)
					LDX	#MONTAB-MONCMD-1	;Get command list count
CMD_LP		CMP	MONCMD,X	;Compare to command list
					BNE	CMD_DEC	;Check for next command and loop
					PHA	;Save keystroke
					TXA	;Xfer Command index to A reg
					ASL	A	;Multiply keystroke value by 2
					TAX	;Get monitor command processor address from table MONTAB
					PLA	;Restore keystroke (some commands send keystroke to terminal)
					JSR	DOCMD	;Call selected monitor command processor as a subroutine
					BRA	NMON	;Command processed, branch and wait for next command
DOCMD			JMP	(MONTAB,X)	;Execute CMD from Table
;
CMD_DEC		DEX	;Decrement index count
					BPL	CMD_LP	;If more to check, loop back
					JSR	BEEP	;Beep for error,
					BRA	CMON	;re-enter monitor
;
;END OF MONITOR CODE
;******************************************************************************
;
;******************************************************************************
;START OF MONITOR DATA
;******************************************************************************
;
;* Monitor command & jump table *
;
;There are two parts to the monitor command and jump table;
; first is the list of commands, which are one byte each. Alpha command characters are upper case
; second is the 16-bit address table that correspond to the command routines for each command character
;
MONCMD		.DB	$0C	;[CNTRL-L]	Xmodem/CRC Loader
					.DB	$10	;[CNTRL-P]	Program EEPROM
					.DB	$12	;[CNTRL-R]	Reset - same as power up
					.DB	$14	;[CNTRL-T]	Uptime display since reset
					.DB	$16	;[CNTRL-V]	Display Monitor Version
					.DB	$1A	;[CNTRL-Z]	Zero Memory - calls reset
					.DB	$28	;(	Init Macro
					.DB	$29	;)	Run Macro
					.DB	$2C	;,	Setup Delay parameters	
					.DB	$2E	;.	Execute Millisecond Delay
					.DB	$2F	;/	Execute Long Delay
					.DB	$5C	;\	Load and Go Extra Long Delay
					.DB	$41	;A	Display/Edit A register
					.DB	$43	;C	Compare memory block
					.DB	$44	;D	Display Memory contents in HEX/TEXT
					.DB	$45	;E	Examine/Edit memory
					.DB	$46	;F	Fill memory block
					.DB	$47	;G	Go execute to <addr>
					.DB	$48	;H	Hex byte string search
					.DB	$4D	;M	Move memory block
					.DB	$50	;P	Display/Edit CPU status reg
					.DB	$52	;R	Display Registers
					.DB	$53	;S	Display/Edit stack pointer
					.DB	$54	;T	Text character string search
					.DB	$58	;X	Display/Edit X register
					.DB	$59	;Y	Display/Edit Y register
;
MONTAB		.DW	XMODEM	;[CNTL-L]	$0C	Xmodem download, use send from terminal program
					.DW	PROGEE ;[CNTL-P]	$10	Program the EEPROM
					.DW	SYS_RST	;[CNTL-R]	$12	Reset CO2Monitor
					.DW	UPTIME	;[CNTL-T]	$14	System uptime from Reset - sec/min/hr/days
					.DW	VER	;[CNTL-V]	$16	Display Monitor Version level
					.DW	ZERO	;[CNTL-Z]	$1A	Zero memory ($0100-$7FFF) then Reset
					.DW	INIMACRO	; (	$28	Clear keystroke input buffer, reset buffer pointer
					.DW	RUNMACRO	; )	$29	Run keystroke macro from start of keystroke buffer
					.DW	SET_DELAY	; .	$2C	Setup Delay Parameters
					.DW	EXE_MSDLY	; ,	$2E	Perform Millisecond Delay
					.DW	EXE_LGDLY	;	/	$2F Execute Long Delay
					.DW	SET_XLDLY	;	\	$5C Load and Go Extra Long Delay
					.DW	ARG	; A	$41	Examine/change ACCUMULATOR preset/result
					.DW	COMPARE	; C	$43	Compare command - new
					.DW	MDUMP	; D	$44	HEX/TEXT dump from specified memory address
					.DW	CHANGE	; E	$45	Examine/change a memory location's contents
					.DW	MFILL	; F	$46	Fill a specified memory range with a specified value
					.DW	GO	; G	$47	Begin program code execution at a specified address
					.DW	SRCHBYT	; H	$48	Search memory for a specified byte string
					.DW	COMPARE	; M	$4D	Copy a specified memory range to a specified target address
					.DW	PRG	; P	$50	Examine/change PROCESSOR STATUS REGISTER preset/result
					.DW	PRSTAT	; R	$52	Display all preset/result contents
					.DW	SRG	; S	$53	Examine/change STACK POINTER preset/result
					.DW	SRCHTXT	; T	$54	Search memory for a specified text string
					.DW	XRG	; X	$58	Examine/change X-REGISTER preset/result
					.DW	YRG	; Y	$59	Examine/change Y-REGISTER preset/result
;
;******************************************************************************
;C02Monitor message strings used with PROMPT routine, terminated with $00
;
MSG_00		.DB " cont?"
MSG_01		.DB	"(y/n)"
					.DB $00
MSG_02		.DB $0D,$0A
					.DB	"   "
MSG_03		.DB	" addr:"
					.DB $00
MSG_04		.DB " len:"
					.DB $00
MSG_05		.DB " val:"
					.DB $00
MSG_06		.DB " src:"
					.DB $00
MSG_07		.DB " tgt:"
					.DB $00
MSG_08		.DB " find txt:"
					.DB $00
MSG_09		.DB " find bin:"
					.DB $00
MSG_0A		.DB "not "
MSG_0B		.DB "found"
					.DB $00
MSG_0C		.DB ":$"
					.DB $00
MSG_0D		.DB $0D,$0A
					.DB "search- "
					.DB $00
MSG_0E		.DB $0D,$0A
					.DB "(n)ext? "
					.DB $00
MSG_0F		.DB "SP:$"
					.DB $00
MSG_10		.DB "SR:$"
					.DB $00
MSG_11		.DB "YR:$"
					.DB $00
MSG_12		.DB "XR:$"
					.DB $00
MSG_13		.DB "AC:$"
					.DB $00
MSG_14		.DB	#$0D,#$0A
					.DB "   PC   AC  XR  YR  SP  NV-BDIZC",$0D,$0A
					.DB "; "
					.DB $00
MSG_15		.DB $0D,$0A,$0A
					.DB "C02Monitor (c)2015 K.E. Maier"
					.DB $0D,$0A
MSG_16		.DB "Version 1.0"
					.DB $00
MSG_17		.DB $0D,$0A
					.DB ";-"
					.DB $00
MSG_18		.DB	" delay ms:"
					.DB	$00
MSG_19		.DB	" mult:"
					.DB	$00
MSG_1A		.DB	" delay xl:"
					.DB	$00
MSG_1B		.DB	"Uptime: "
					.DB	$00
MSG_1C		.DB	" Days, "
					.DB	$00
MSG_1D		.DB	" Hours, "
					.DB	$00
MSG_1E		.DB	" Minutes, "
					.DB	$00
MSG_1F		.DB	" Seconds"
					.DB	$00
MSG_20		.DB "Zero RAM/"
MSG_21		.DB	"Reset System,"
					.DB	$00
MSG_22		.DB	"Program EEPROM",$0D,$0A
					.DB	$00
MSG_23		.DB	$0D,$0A
					.DB	"Are you sure? "
					.DB	$00
MSG_24		.DB	$0D,$0A
					.DB	"Are you really sure? "
					.DB	$00
MSG_25		.DB	$0D,$0A
					.DB	"Writing EEPROM... wait"
					.DB	$00
MSG_26		.DB	$0D,$0A
					.DB	"EEPROM Write Complete!"
					.DB	$00
MSG_27		.DB	$0D,$0A
					.DB	"EEPROM Write Failed!",$0D,$0A
					.DB	"Check Hardware or EEPROM problem!"
MSG_28		.DB	$0D,$0A
					.DB	"RTC may lose time, check/reset!"
					.DB	$00
MSG_29		.DB	"XMODEM Loader, <Esc> to abort, or",$0D,$0A
					.DB	"Load address/S-Record Offset:"
					.DB	$00
MSG_2A		.DB	$0D,$0A
					.DB	"Download Complete!",$0D,$0A
					.DB	$00
MSG_2B		.DB	$0D,$0A
					.DB	"Download Error!",$0D,$0A
					.DB	$00
MSG_2C		.DB $0D,$0A
					.DB "S-Record load at:$"
					.DB $00
;
MSG_TABLE	;Message table - contains addresses as words of each message sent via the PROMPT routine
					.DW MSG_00
					.DW	MSG_01
					.DW	MSG_02
					.DW	MSG_03
					.DW	MSG_04
					.DW	MSG_05
					.DW	MSG_06
					.DW	MSG_07
					.DW	MSG_08
					.DW	MSG_09
					.DW	MSG_0A
					.DW	MSG_0B
					.DW	MSG_0C
					.DW	MSG_0D
					.DW	MSG_0E
					.DW	MSG_0F
					.DW	MSG_10
					.DW	MSG_11
					.DW	MSG_12
					.DW	MSG_13
					.DW	MSG_14
					.DW	MSG_15
					.DW	MSG_16
					.DW	MSG_17
					.DW	MSG_18
					.DW	MSG_19
					.DW	MSG_1A
					.DW	MSG_1B
					.DW	MSG_1C
					.DW	MSG_1D
					.DW	MSG_1E
					.DW	MSG_1F
					.DW	MSG_20
					.DW	MSG_21
					.DW	MSG_22
					.DW	MSG_23
					.DW	MSG_24
					.DW	MSG_25
					.DW	MSG_26
					.DW	MSG_27
					.DW	MSG_28
					.DW	MSG_29					
					.DW	MSG_2A
					.DW	MSG_2B
					.DW	MSG_2C
;
;******************************************************************************
;END OF MONITOR DATA
;******************************************************************************
;
;******************************************************************************
					.org	$FC00	;Last 1KB used for BIOS and I/O device selects
;******************************************************************************
;START OF BIOS CODE
;******************************************************************************
; C02BIOS version used here is 1.2
;
; Contains the base BIOS routines in top 1KB of EEPROM
; - Pages $FC/$FD 512 bytes for BIOS (65C51/65C22), NMI Panic routine
; - Page $FE reserved for HW (8-I/O devices, 32 bytes wide)
; - Page ($FF) JMP table, CPU startup, 64 bytes Soft Vectors and HW Config data
;		- does I/O init and handles NMI/BRK/IRQ pre-/post-processing routines.
;		- sends BIOS message string to console
;	- Additional code added to handle XMODEM transfers
;		- allows a null character to be received into the buffer
;		- CRC bytes can be zero, original code would invoke BRK routine
;		- Uses the XMCHECK flag which is set/cleared during Xmodem xfers
;******************************************************************************
;	The following 16 functions are provided by BIOS and available via the JMP
;	Table as the last 16 entries from $FF48 - $FF75 as:
;	$FF48 BEEP (send audible beep to console)
;	$FF4B CHRIN (character input from console)
;	$FF4E CHROUT (character output to console)
;	$FF51 SETDLY (set delay value for milliseconds and 16-bit counter)
;	$FF54 MSDELAY (execute millisecond delay 1-256 milliseconds)
;	$FF57 LGDELAY (execute long delay; millisecond delay * 16-bit count)
;	$FF5A XLDELAY (execute extra long delay; 8-bit count * long delay)
;	$FF5D SETPORT (set VIA port A or B for input or output)
;	$FF60 RDPORT (read from VIA port A or B)
;	$FF63 WRPORT (write to VIA port A or B)
;	$FF66 INITVEC (initialize soft vectors at $0300 from ROM)
;	$FF69 INITCFG (initialize soft config values at $0320 from ROM)
;	$FF6C INITCON (initialize 65C51 console 19.2K, 8-N-1 RTS/CTS)
;	$FF6F INITVIA (initialize 65C22 default port, timers and interrupts)
;	$FF72 MONWARM (warm start Monitor - jumps to page $03)
;	$FF75 MONCOLD (cold start Monitor - jumps to page $03)
;******************************************************************************
; Character In and Out routines for Console I/O buffer
;******************************************************************************
;
;CHOUT subroutine: takes the character in the ACCUMULATOR and places it in the xmit buffer
; and checks to see if XMIT interrupt is enabled (page $00 flag), if not it enables the chip
; and sets the flag to show it's on. The character sent in the A reg is preserved on exit
;	transmit is IRQ driven / buffered with a fixed size of 128 bytes
;	- BEEP is handled here for convienience.
;
;	- 8/10/2014 - modified this routine to always set the Xmit interrupt active with each
;	character placed into the output buffer. There appears to be a highly intermittant bug
;	in both the 6551 and 65C51 where the Xmit interrupt turns itself off, the code itself
;	is not doing it as the OIE flag was never reset and the two only happen in the IRQ routine.
;	The I/O and service routines now appear to work in a stable manner on all 6551 and 65C51.
;
;BEEP subroutine: Send ASCII [BELL] to terminal
BEEP			LDA	#$07	;Send ASCII [BELL] to terminal
;
CHOUT			PHY	;save Y reg	(3)
OUTCH			LDY	OCNT	;get character output count in buffer	(3)
					BMI	OUTCH	;check against limit, loop back if full	(2/3)
;
					PHP	;Save CPU state	(3)
					LDY	OTAIL	;Get index to next spot	(3)
					STA	OBUF,Y	;and place in buffer	(5)
					INY	;Increment index	(2)
					BPL	OUTC1	;Check for wrap-around ($80), branch if not	(2/3)
					LDY	#$00	;Yes, zero pointer	(2)
;
OUTC1			STY	OTAIL	;Update pointer	(3)
					INC	OCNT	;Increment character count	(5)
;
					LDY	#$05	;Get mask for xmit on	(2)
					STY	SIOCOM	;Turn on xmit irq	(4)
;
OUTC2			PLP	;Restore CPU state (4)
					PLY	;Restore Y reg	(4)
					RTS	;Return	(6)
;
;CHIN No Waiting subroutine: Check for a character, if none exists, set carry and exit.
; else get character to A reg and return
;CHIN_NW	LDA	ICNT	;Get character count	(3)
;					BNE	GET_CH	;Get the character and return
;					SEC	;else set carry flag
;					RTS	;and return to caller
;CHIN subroutine: Wait for a keystroke from input buffer, return with keystroke in A Reg
;	receive is IRQ driven and buffered with a fixed size of 128 bytes
;
CHIN			LDA	ICNT	;Get character count	(3)
					BEQ	CHIN	;If zero (no character, loop back)	(2/3)
;
GET_CH		PHY	;Save Y reg	(3)
					PHP	;Save CPU state	(3)
					LDY	IHEAD	;Get the buffer head pointer	(3)
					LDA	IBUF,Y	;Get the character from the buffer	(4)
					INY	;Increment the buffer index	(2)
					BPL	CHIN1	;Check for wraparound ($80), branch if not	(2/3)
					LDY	#$00	;Reset the buffer pointer	(2)
CHIN1			STY	IHEAD	;Update buffer pointer	(3)
					DEC	ICNT	;Decrement the buffer count	(5)
					PLP	;Restore CPU state (4)
					PLY	;Restore Y Reg	(4)
					RTS	;Return to caller with character in A reg	(6)
;
;******************************************************************************
;SET DELAY routine
; This routine sets up the MSDELAY values and can also set the Long Delay variable.
; On entry, A reg = millisecond count, X reg = High multipler, Y reg = Low multipler
;	these values are used by the EXE_MSDLY and EXE_LGDLY routines
;	values for MSDELAY are $00-$FF ($00 = 256 times)
;	values for Long Delay are $0000-$FFFF (0-65535 times)
;	longest delay is 65,536*256*1ms = 16,777,216 * 0.01 = 167,772.16 seconds
;
SET_DLY		STA	SETIM	;Save millisecond count
					STY	DELLO	;Save Low multipler
					STX	DELHI	;Save High Multipler
					RTS	;Return to caller
;
;EXE MSDELAY routine
;	This routine is the core delay routine
;	It sets the count value from SETIM variable, enables the MATCH flag, then starts
;	Timer 2 and waits for the IRQ routine to decrement to zero and clear the MATCH flag
;	note: 3 clock cycles (JMP table) to get here on a standard call
;	- 14 clock cycles to start T2, 15 clock cycles to return after MATCH cleared
;	- starting T2 first to help normalize overall delay time
;	- total of 40 clock cycles overhead in this routine
;
EXE_MSDLY	PHA	;Save A Reg (3)
					LDA	LOAD_6522+$07	;Get T2H value (4)
					STA	Via1T2CH	;Reload T2 and enable interrupt (4)
					DEC	MATCH	;Set MATCH flag (5)
					LDA	SETIM	;Get delay seed value (3)
					STA	MSDELAY	;Set MS delay value (3)
;
MATCH_LP	LDA	MATCH	;Read MATCH flag (3)
					BNE	MATCH_LP	;If still set, loop back (2/3)
					PLA	;Restore A Reg (4)
					RTS	;Return to caller (6)
;
;EXE LONG Delay routine
;	This routine is the 16-bit multiplier for the MS DELAY routine
;	It loads the 16-bit count from DELLO/DELHI, then loops the MSDELAY
;	routine until the 16-bit count is decremented to zero
;
EXE_LGDLY	PHX	;Save X Reg
					PHY	;Save Y Reg
					LDX	DELHI	;Get high byte count
					INX	;Increment by one (checks for $00 vs $FF)
					LDY	DELLO	;Get low byte count
					BEQ	SKP_DLL	;If zero, skip to high count
DO_DLL		JSR	EXE_MSDLY	;Call millisecond delay
					DEY	;Decrement low count
					BNE	DO_DLL	;Branch back until done
;
SKP_DLL		DEX	;Decrement high byte index
					BNE	DO_DLL	;Loop back to DLL (will run 256 times)
					PLY	;Restore Y Reg
					PLX	;Restore X Reg
					RTS	;Return to caller
;
;EXE EXTRA LONG Delay routine
;	This routine uses XDL variable as an 8-bit count
;	and calls the EXE LONG Delay routine XDL times
;	- On entry, XDL contains the number of interations
EXE_XLDLY	JSR	EXE_LGDLY	;Call the Long Delay routine
					DEC	XDL	;Decrement count
					BNE	EXE_XLDLY	;Loop back until X reg times out
					RTS	;Done, return to caller
;	
;******************************************************************************
; I/O PORT routines for 6522
;	- Allows port A or B setup for input or output
;	- Allows data to be read from Port A or B
;	- Allows data to be written to Port A or B
;	- Routines are Non-buffered and no HW handshaking
;	- Page zero variables are used: IO_DIR, IO_IN, IO_OUT
;
;	6522 Port Config routine
;	- Allows Port A or B to be configured for input or output
;	- On entry, X reg contains port number (1=A, 0=B)
;	- A reg contains config mask; bit=0 for Input, bit=1 for Output
;	- on exit, A reg contain Port DDR value, X reg contains port #
;	- Carry set if error, cleared if OK
;
SET_PORT	STA	Via1DDRB,X	;Store config Mask to the correct port
					STA	IO_DIR	;Save Mask for compare
					LDA	Via1DDRB,X	;Load config Mask back from port
					CMP	IO_DIR	;Compare to config MASK
					BCS	PORT_OK	;Branch if same
					SEC	;Set Carry for bad compare
					RTS	;Return to caller
PORT_OK		CLC	;Clear Carry flag for no error
					RTS	;Return to caller
;
;	Port Input routine
;	- On entry, X reg contains port number (1=A, 0=B)
;	- On exit, A reg contains read data, X reg contains port #
;	- Carry set if error on read, cleared if OK
;	- Requested Port is read twice and compared for error,
;	- this implies port data input does not change too quickly
;
IN_PORT		LDA	Via1PRB,X	;Read Port data
					STA	IO_IN	;Save Read data
					LDA	Via1PRB,X	;Read Port a second time
					CMP	IO_IN	;Compare against previous read
					BCS	PORT_OK	;Branch if same
					SEC	;Set Carry for bad compare
					RTS	;Return to caller
;
;	Port Output routine
;	- On entry, X reg contains port number (1=A, 0=B)
;	- A reg contain data to write to port
;	- On exit, A reg contains Port data, X reg contains port #
;	- Carry set if error on write, cleared if OK
;
OUT_PORT	STA	Via1PRB,X	;Write Port data
					STA	IO_OUT	;Save data to output to port
					LDA	Via1PRB,X	;Read Port data back
					CMP	IO_OUT	;Compare against previous read
					BCS	PORT_OK	;Branch if same
					SEC	;Set Carry for bad compare
					RTS	;Return to caller
;
;******************************************************************************
;
;START OF PANIC ROUTINE
; The Panic routine is for debug of system problems, i.e., a crash
; The basic idea is to have an NMI trigger button which is manually operated
; when the system crashes or malfunctions, press the NMI (panic) button
; The NMI vectored routine will perform the following tasks:
; 1- Save registers in page $00
; 2- Save pages $00, $01, $02 and $03 at location $0400-$07FF
; 3- Overlay the I/O page ($FE) at location $0780
; 4- Zero I/O buffer pointers
; Call the ROM routines to init the vectors and config data (page $03)
; Call ROM routines to init the 6551 and 6522 devices
; Restart the Monitor via warm start vector
; No memory is cleared except the required pointers to restore the system
;	- suggest invoking the Register command afterwards to get the details saved.
;
NMI_VECTOR	;This is the ROM start for NMI Panic handler
					SEI	;Disable interrupts
					STA	AREG	;Save A Reg
					STX	XREG	;Save X Reg
					STY	YREG	;Save Y Reg
					PLA	;Get Processor Status 	        
					STA	PREG	;Save in PROCESSOR STATUS preset/result
					TSX	;Get Stack pointer
					STX	SREG	;Save STACK POINTER
					PLA	;Pull RETURN address from STACK
					STA	PCL	;Store Low byte
					PLA	;Pull high byte
					STA	PCH	;Store High byte
;
					LDY	#$00	;Zero Y reg
					LDX	#$04	;Set index to 4 pages
					STX	$03	;Set to high order
					STZ	$02	;Zero remaining pointers
					STZ	$01
					STZ	$00

PLP0			LDA	($00),Y	;get byte
					STA	($02),Y	;store byte
					DEY	;Decrement index
					BNE	PLP0	;Loop back till done
;
					INC	$03	;Increment page address
					INC	$01	;Increment page address
					DEX	;Decrement page index
					BNE	PLP0	;Branch back and do next page
;					
IO_LOOP		LDA	$FE00,X	;Get I/O Page (X reg already at #$00)
					STA	$0780,X	;Overlay I/O page to Vector Save
					INX	;Increment index
					BPL	IO_LOOP	;Loop back until done (128 bytes)
;
					LDX	#$06	;Get count of 6
PAN_LP1		STZ	ICNT-1,X	;Zero out console I/O pointers
					DEX	;Decrement index
					BNE	PAN_LP1	;Branch back till done
;
					JSR	INIT_PG03	;Xfer default Vectors/HW Config to $0300
					JSR	INIT_IO	;Init I/O - Console, Timers, Ports
;
					BRA	WARMVEC	;Jump to Monitor Warm Start Vector
;
;*************************************
;* BRK/IRQ Interrupt service routine *
;*************************************
;
;The pre-process routine located in page $FF soft-vector to here:
;	The following routines handle BRK and IRQ.
;	The BRK handler save CPU details for register display
;	- also provides a disassembly of the last executed instruction
;	- An ASCII null character ($00) is also handled here.
;
;6551 handler
;	The 6551 IRQ routine handles both transmit and receive via IRQ
;	- each has it's own 128 circular buffer
;	- Xmit IRQ is controlled by the handler and the CHROUT routine
;
;6522 handler
; The 6522 IRQ routine handles Timer1 interrupts used for a RTC.
;	- resolution is set for 4ms (250 interrupts per second)
;	- recommended CPU clock rate is 2MHz minimum
;	- timer service and match routine also inserted into the RTC routine
;
BREAKEY		CLI	;Enable IRQ (2)
;
BRKINSTR0	PLY	;Restore Y reg
					PLX	;Restore X Reg
					PLA	;Restore A Reg
					STA	AREG	;Save A Reg
					STX	XREG	;Save X Reg
					STY	YREG	;Save Y Reg
					PLA	;Get Processor Status 	        
					STA	PREG	;Save in PROCESSOR STATUS preset/result
					TSX	;Xfrer STACK pointer to X reg
					STX	SREG	;Save STACK pointer
;
					PLX	;Pull Low RETURN address from STACK then save it
					STX	PCL	;Store program counter Low byte
					STX	INDEXL	;Seed for DISLINE
					PLY	;Pull High RETURN address from STACK then save it
					STY	PCH	;Store program counter High byte
					STY	INDEXH	;Seed for DISLINE
					AND	#$10	;Mask for BRK bit set (vs null character)
					BEQ	DO_NULL	;Bypass some stuff for null character
;
; The following subroutine is contained in the base Monitor code
; This call does a register display. Other code can be added if required
;	- if replaced with new code, either replace or remove this routine
;
					JSR	PRSTAT1	;Display CPU status
;
DO_NULL		LDA	#$00	;Clear all PROCESSOR STATUS REGISTER bits
					PHA
					PLP
BREAKEY2	STZ	ITAIL	;Zero out input buffer / reset pointers
					STZ	IHEAD
					STZ	ICNT
WARMVEC		JMP	(WRMMNVEC0)	;Done BRK service process, re-enter monitor
;
;new full duplex IRQ handler (54 clock cycles overhead to this point - includes return)
;
INTERUPT0	LDA	SIOSTAT	;Get status register, xfer irq bit to n flag (4)
					BPL	REGEXT	;if clear no 6551 irq, exit, else (2/3) (7 clock cycles to exit - take branch)
;
ASYNC			BIT #%00001000	;check receive bit (2)
					BNE RCVCHR	;get received character (2/3) (11 clock cycles to jump to RCV)
					BIT #%00010000	;check xmit bit (2)
					BNE XMTCHR	;send xmit character (2/3) (15 clock cycles to jump to XMIT)
;no bits on means CTS went high
					ORA #%00010000 ;add CTS high mask to current status (2)
IRQEXT		STA STTVAL ;update status value (3) (19 clock cycles to here for CTS fallout)
;
REGEXT		JMP	(IRQRTVEC0) ;handle next irq (5)
;
BUFFUL		LDA #%00001100 ;buffer overflow flag (2)
					BRA IRQEXT ;branch to exit (3)
;
RCVCHR		LDA SIODAT	;get character from 6551 (4)
					BNE	RCV0	;If not a null character, handle as usual and put into buffer	(2/3)
					BIT	XMFLAG	;Check Xmodem active flag	(3)
					BVC	BREAKEY	;Handle normal BRK character if not active	(2/3)
;
RCV0			LDY ICNT	;get buffer counter (3)
					BMI	BUFFUL	;check against limit, branch if full (2/3)
;
					LDY ITAIL ;room in buffer (3)
					STA IBUF,Y ;store into buffer (5)
					INY ;increment tail pointer (2)
					BPL	RCV1	;check for wraparound ($80), branch if not (2/3)
					LDY #$00 ;else, reset pointer (2)
RCV1			STY ITAIL ;update buffer tail pointer (3)
					INC ICNT ;increment character count (5)
;	
					LDA SIOSTAT ;get 6551 status reg (4)
					AND #%00010000 ;check for xmit (2)
					BEQ REGEXT	;exit (2/3) (40 if exit, else 39 and drop to XMT)
;
XMTCHR		LDA OCNT ;any characters to xmit? (3)
					BEQ NODATA ;no, turn off xmit (2/3)
;
OUTDAT		LDY OHEAD ;get pointer to buffer (3)
					LDA OBUF,Y ;get the next character (4)
					STA SIODAT ;send the data (4)
					INY ;increment index (2)
					BPL	OUTD1	;check for wraparound ($80), branch if not (2/3)
					LDY #$00 ;else, reset pointer (2)
;
OUTD1			STY OHEAD ;save new head index (3)
					DEC OCNT ;decrement counter (5)
					BNE	REGEXT	;If not zero, exit and continue normal stuff (2/3) (31 if branch, 30 if continue)
;
NODATA		LDY	#$09	;get mask for xmit off / rcv on (2)
					STY SIOCOM ;turn off xmit irq bits (5)
					BRA REGEXT ;exit (3) (13 clock cycles added for turning off xmt)
;
;******************************************************************************
;
;Start of the 6522 BIOS code. Supports basic timer function.
; A time of day clock is implemented with a resolution of 4ms
; Timer ticks is set at 250 ticks per second. Page zero holds
; all variables for ticks, seconds, minutes, hours, days.
; To keep things simple, days is two bytes so can handle 0-65535 days,
; which is about 179 years. Additional calculations can be made if
; required for a particular application.
;
;	Timer Delay Match routine:
;	This provides an accurate and consistent time delay
; using Timer 2 of the 6522. It is configured as a one-shot timer
;	set for 1 millisecond based on clock rate (see config table).
;	It uses an 8-bit value for countdown to reset a MATCH flag on timeout.
;	Value can be 1-256 milliseconds ($00 = 256).
;	This routine must also reset the counter if MSDELAY has not decremented
;	to zero, which completes the timer delay.
; The delay routine sets the MSDELAY value and MATCH flag to $FF,
; then monitors the MATCH flag which is cleared after the delay.
;
;	Note that each Timer has it's own exit vector. By default they point to the
;	following IRQ vector (6551 service routine). This allows either timer to be
;	used as a refresh routine by inserting addition code in either loop. The RTC
;	should not be changed, but Timer2 can be provided the user track it's use versus
;	the standard delay routines which also use Timer2.
;	NOTE: 24 clock cycles via IRQ vector to get here.
;
;Basic use of timer services includes:
;		RTC - time (relative timestamp)
;		Internal delay and timing routines
;		Background refresh tasks
;
INTERUPT1	LDA	Via1IFR	;Get IRQ flag register, xfer irq bit to n flag (4)
					BPL	REGEXT1	;if set, 6522 caused irq,(do not branch) (2/3) (7 clock cycles to exit - take branch)
;
					BIT	#%00100000	;check T2 interrupt bit (2)
					BNE	DECMSD	;If active, handle T2 timer (MS delay) (2/3)
;
					BIT #%01000000	;check T1 interrupt bit (2)
					BNE	INCRTC	;If active, handle T1 timer (RTC) (2/3)
;
					STA	STVVAL	;Save in status before exit (3)
					BRA REGEXT1	;branch to next IRQ source, exit (3)
;
DECMSD		BIT	Via1T2CL	;Clear interrupt for T2 (4)
					DEC	MSDELAY	;Decrement 1ms millisecond delay count (5)
					BNE	RESET_T2	;If not zero, re-enable T2 and exit (2/3)
					STZ	MATCH	;Else, clear match flag (3) (25 clock cycles to clear MATCH)
					BRA	REGEXT2	;Done with timer handler, exit (3)
;
RESET_T2	LDA	LOAD_6522+$07	;Get T2H value (4)
					STA	Via1T2CH	;Reload T2 and re-enable interrupt (4) (31 clock cycles to restart T2)
REGEXT2		JMP	(VECINSRT1)	;Done with timer handler, exit (5)
;
INCRTC		BIT	Via1T1CL	;Clear interrupt for T1 (4)
					DEC	TICKS	;Decrement RTC tick count (5)
					BNE	REGEXT1	;Exit if not zero (2/3)
					LDA	#DF_TICKS ;Get default tick count (2)
					STA	TICKS	;Reset Tick count (3)
;
					INC	SECS	;Increment seconds (5)
					LDA	SECS	;Load it to Areg (3)
					CMP	#60	;Check for 60 seconds (2)
					BCC	REGEXT1	;If not, exit (2/3)
					STZ	SECS	;Else, reset seconds, inc Minutes (3)
;
					INC	MINS	;Increment Minutes (5)
					LDA	MINS	;Load it to Areg (3)
					CMP	#60	;Check for 60 minutes (2)
					BCC	REGEXT1	;If not, exit (2/3)
					STZ	MINS	;Else, reset Minutes, inc Hours (3)
;
					INC	HOURS	;Increment Hours (5)
					LDA	HOURS	;Get it to Areg (3)
					CMP	#24	;Check for 24 hours (2)
					BCC	REGEXT1	;If not, exit (2/3)
					STZ	HOURS	;Else, reset hours, inc Days (3)
;
					INC	DAYSL	;Increment low-order Days (5)
					BNE	REGEXT1	;If not zero, exit (2/3)
					INC	DAYSH	;Else increment high-order Days (5)
;
REGEXT1		JMP	(VECINSRT0) ;handle next irq (5)
;
INIT_PG03	JSR	INIT_VEC	;Init the Vectors first
;
INIT_CFG	LDY	#$40	;Get offset to data
					BRA	DATA_XFER	;Go move the data to page $03
INIT_VEC	LDY	#$20	;Get offset to data
;
DATA_XFER	SEI	;Disable Interrupts, can be called via JMP table
					LDX	#$20	;Set count for 32 bytes
DATA_XFLP
					LDA	VEC_TABLE-1,Y	;Get ROM table data
					STA	SOFTVEC-1,Y	;Store in Soft table location
					DEY	;Decrement index
					DEX	;Decrement count
					BNE	DATA_XFLP	;Loop back till done
					CLI	;re-enable interupts
					RTS	;Return to caller
;
INIT_6551
;Init the 65C51
					SEI	;Disable Interrupts
					STZ	SIOSTAT	;write to status reg, reset 6551
					STZ	STTVAL	;zero status pointer
					LDX	#$02	;Get count of 2
INIT_6551L
					LDA	LOAD_6551-1,X	 ;Get Current config parameters for 6551
					STA	SIOBase+1,X	;Write to the 6551
					DEX	;Decrement count
					BNE	INIT_6551L	;Loop back until done
					CLI	;Re-enable Interrupts
					RTS	;Return to caller
;
INIT_IO		JSR	INIT_6551	;Init the Console first
;
INIT_6522
;Init the 65C22
					SEI	;Disable Interrupts
					STZ	STVVAL	;zero status pointer
					LDX  #$0D	;Get Count of 13
INIT_6522L
					LDA	LOAD_6522-1,X	;Get soft parameters
					STA	Via1Base+1,X	;Load into 6522 chip
					DEX	;Decrement to next parameter
					BNE	INIT_6522L	;Branch back till all are loaded
					CLI	;Re-enable IRQ
RET				RTS	;Return to caller
;
;END OF BIOS CODE
;
;******************************************************************************
					.ORG	$FE00	;Reserved for I/O page - do NOT put code here
;******************************************************************************
;
;START OF TOP PAGE - DO NOT MOVE FROM THIS ADDRESS!!
; 
					.ORG	$FF00	;JMP Table, HW Vectors, Cold Init and Vector handlers
;
;JUMP Table starts here:
;	- BIOS calls are from the top down - total of 16
;	- Monitor calls are from the bottom up
;	- Reserved calls are in the shrinking middle
;
					JMP	RDLINE
					JMP	HEXIN2
					JMP	HEXIN4
					JMP	HEX2ASC
					JMP	BIN2ASC
					JMP	ASC2BIN
					JMP	DOLLAR
					JMP	PRBYTE
					JMP	PRWORD
					JMP	PRASC
					JMP	PROMPT
					JMP	PROMPTR
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	RET
					JMP	BEEP
					JMP	CHIN
					JMP	CHOUT
					JMP	SET_DLY
					JMP	EXE_MSDLY
					JMP	EXE_LGDLY
					JMP	EXE_XLDLY
					JMP	SET_PORT
					JMP	IN_PORT
					JMP	OUT_PORT
					JMP	INIT_VEC
					JMP	INIT_CFG
					JMP	INIT_6551
					JMP	INIT_6522
					JMP	(WRMMNVEC0)
CMBV			JMP	(CLDMNVEC0)
;
COLDSTRT	CLD	;Clear decimal mode in case of software call (Zero Ram calls this)
					SEI	;Disable Interrupt for same reason as above
;
					LDX	#$00	;Index for length of page
PAGE0_LP	STZ	$00,X	;Zero out Page Zero
					DEX	;Decrement index
					BNE	PAGE0_LP	;Loop back till done
;
					DEX	;LDX #$FF ;-)
					TXS	;Set Stack Pointer
;
					JSR	INIT_PG03	;Xfer default Vectors/HW Config to $0300
					JSR	INIT_IO	;Init I/O - Console, Timers, Ports
;
; Send BIOS init msg to console
;	- note: X reg is zero on return from INIT_IO
BMSG_LP		LDA	BIOS_MSG,X	;Get BIOS init msg
					BEQ	CMBV	;If zero, msg done, goto cold start monitor
					JSR	CHOUT	;Send to console
					INX	;Increment Index
					BRA	BMSG_LP	;Loop back until done
;
IRQ_VECTOR	;This is the ROM start for the BRK/IRQ handler
					PHA	;Save A Reg (3)
					PHX	;Save X Reg (3)
					PHY	;Save Y Reg (3)
					TSX	;Get Stack pointer (2)
					LDA	$0100+4,X	;Get Status Register (4)
					AND	#$10	;Mask for BRK bit set (2)
					BNE	DO_BRK	;If set, handle BRK (2/3)
					JMP	(IRQVEC0)	;Jump to Soft vectored IRQ Handler (5) (24 clock cycles to vector routine)
DO_BRK		JMP	(BRKVEC0)	;Jump to Soft vectored BRK Handler (5) (25 clock cycles to vector routine)
;
IRQ_EXIT0	;This is the standard return for the IRQ/BRK handler routines
					PLY	;Restore Y Reg (4)
					PLX	;Restore X Reg (4)
					PLA	;Restore A Reg (4)
NMIHNDLR0	RTI	;Return from IRQ/BRK routine (6) (18 clock cycles from vector jump to IRQ end)
;
;******************************************************************************
;START OF BIOS DEFAULT VECTOR DATA AND HARDWARE CONFIGURATION DATA
;
;The default location for the NMI/BRK/IRQ Vector data is at location $0300
; details of the layout are listed at the top of the source file
;	there are 8 main vectors and 8 vector inserts, one is used for the 6522
;
;The default location for the hardware configuration data is at location $0320
; it is mostly a freeform table which gets copied from ROM to page $03
; the default size for the config table is 32 bytes, 17 bytes are free
;
VEC_TABLE	;Vector table data for default ROM handlers
;Vector set 0
					.DW	NMI_VECTOR	;NMI Location in ROM
					.DW	BRKINSTR0	;BRK Location in ROM
					.DW	INTERUPT1	;IRQ Location in ROM
;
					.DW	NMIHNDLR0	;NMI return handler in ROM
					.DW	IRQ_EXIT0	;BRK return handler in ROM
					.DW	IRQ_EXIT0	;IRQ return handler in ROM
;
					.DW	MONITOR	;Monitor Cold start
					.DW	NMON	;Monitor Warm start
;
;Vector Inserts (total of 8)
; these can be used as required, one is used by default for the 6522
; as NMI/BRK/IRQ and the Monitor are vectored, all can be extended
; by using these reserved vectors. 
					.DW	INTERUPT0	;Insert 0 Location - for 6522 timer1
					.DW	INTERUPT0	;Insert 1 Location - for 6522 timer2
					.DW	$FFFF	;Insert 2 Location
					.DW	$FFFF	;Insert 3 Location
					.DW	$FFFF	;Insert 4 Location
					.DW	$FFFF	;Insert 5 Location
					.DW	$FFFF	;Insert 6 Location
					.DW	$FFFF	;Insert 7 Location
;
CFG_TABLE	;Configuration table for hardware devices
;
CFG_6551	;2 bytes required for 6551
					.DB	#$09	;Default 65C51 Command register, transmit/receiver IRQ output enabled)
					.DB	#$1F	;Default 65C51 Control register, (19.2K,no parity,8 data bits,1 stop bit)
;
CFG_6522	;13 bytes required for 6522
;Timer 1 load value is based on CPU clock frequency for 4 milliseconds - RTC use
; 16MHz = 64000, 10MHz = 40000, 8MHz, count = 32000, 6MHz = 24000, 5MHz = 20000, 4MHz = 16000, 2MHz = 8000
; 16MHz = $FA00, 10MHz = $9C40,8MHz, count = $7D00, 6MHz = $5DC0, 5MHz = $4E20, 4MHz = $3E80, 2MHz = $1F40
;
;Timer 2 load value is based on CPU clock frequency for 1 millisecond - delay use
;	- Timer 2 value needs to be adjusted to compensate for the time to respond to the interrupt
;	- and reset the timer for another 1ms countdown, which is approximately 55 clock cycles.
;	- As Timer 2 counts clock cycles, each of the values should be adjusted by subtracting 60.
;	16MHz = 15940, 10MHz = 9940, 8MHz, count = 7940, 6MHz = 5940, 5MHz = 4940, 4MHz = 3940, 2MHz = 1940
; 16MHz = $3E44, 10MHz = $26D4, 8MHz, count = $1F04, 6MHz = $1734, 5MHz = $134C, 4MHz = $0F64, 2MHz = $0794
;
; only the ports that are needed for config are shown below:
;
					.DB	#$00	;Data Direction register Port B
					.DB	#$00	;Data Direction register Port A
					.DB	#$80	;T1CL - set for CPU clock as above - $04
					.DB	#$3E	;T1CH - to 4ms (250 interupts per second) - $05
					.DB	#$00	;T1LL - T1 counter latch low
					.DB	#$00	;T1LH - T1 counter latch high
					.DB	#$64	;T2CL - T2 counter low count - set for 1ms (adjusted)
					.DB	#$0F	;T2CH - T2 counter high count - used for delay timer
					.DB	#$00	;SR - Shift register
					.DB	#$40	;ACR - Aux control register
					.DB	#$00	;PCR - Peripheral control register
					.DB	#$7F	;IFR - Interrupt flag register (clear all)
					.DB	#$E0	;IER - Interrupt enable register (enable T1/T2)
					.DB	#$00	;Free filler byte
;
;Reserved for additional I/O devices (16 bytes total)
					.DB	#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF
					.DB	#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF
;
;END OF BIOS VECTOR DATA AND HARDWARE DEFAULT CONFIGURATION DATA
;******************************************************************************
;BIOS init message - sent before jumping to the monitor coldstart vector
BIOS_MSG	.DB	$0D,$0A
					.DB	"BIOS 1.2 "
					.DB	"4MHz"
					.DB	#$00	;Terminate string
;
;65C02 Vectors:
					.ORG	$FFFA
					.DW	NMIVEC0	;NMI
					.DW	COLDSTRT	;RESET
					.DW	IRQ_VECTOR	;IRQ
					.END