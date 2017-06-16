;
;******************************************************************************
;	65C02 Mini BIOS version 1.0 (c) K. E. Maier 2013,2014
;
;	Compact BIOS for a 65C02 based system with the following:
;	- 65C02 CPU running at 2MHz or better
;	- 32KB of RAM from $0000 - $7FFF
;	- 256 bytes for hardware and divided into I/O selects ($FE00 default)
;	- 32KB EEPROM from $8000 - $FFFF (sans I/O hole which can be relocated)
;	- 6551/65C51 used for console with RTS/CTS handshaking
;	- 6522/65C22 used for RTC, Delay routines and basic Port I/O
;******************************************************************************
					.org	$FC00	;Last 1KB used for BIOS and I/O device selects
;******************************************************************************
;START OF BIOS CODE
;******************************************************************************
; Contains the base BIOS routines in top 1KB of EEPROM
;	Source code layout is as follows:
;	- $FC00 - $FDBF is for BIOS routines
;	- $FDC0 - $FDFF is for Vector and HW config default data
; - $FE00 - $FEFF is reserved for HW devices (8-I/O devices, 32 bytes wide)
; - $FF00 - $FFFF is for JMP table, CPU startup, low memory init, etc.
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
;	$FF66 INITVEC (initialize soft vectors at $0300 from ROM $FDC0)
;	$FF69 INITCFG (initialize soft config values at $0320 from ROM $FDE0)
;	$FF6C INITCON (initialize 6551 console 19.2K, 8-N-1 RTS/CTS)
;	$FF6F INITVIA (initialize 6522 default port, timers and interrupts)
;	$FF72 MONWARM (warm start Monitor - jumps to page $03)
;	$FF75 MONCOLD (cold start Monitor - jumps to page $03)
;******************************************************************************
;
;*************************
;* Page Zero definitions *
;*************************
;Note that locations $00 and $01 are used by Panic to save $0000 - $03FF
;	- $0400 - $07FF is reserved - Panic saves the first 1KB here
;
PGZERO8_ST	.EQU	$80	;8-bit start of Page Zero usage
PGZERO16_ST	.EQU	$0080	;16-bit start of Page Zero usage
;
;	BIOS variables, pointers, flags located at top of Page Zero.
BIOS_PG0	.EQU	PGZERO8_ST+96	;Start of BIOS page zero use
;	- BRK handler routine
PCL				.EQU	BIOS_PG0+0	;Program Counter Low index
PCH				.EQU	BIOS_PG0+1	;Program Counter High index
ACCUM			.EQU	BIOS_PG0+2	;Temp A reg
XREG			.EQU	BIOS_PG0+3	;Temp X reg
YREG			.EQU	BIOS_PG0+4	;Temp Y reg
SREG			.EQU	BIOS_PG0+5	;Temp Stack pointer
PREG			.EQU	BIOS_PG0+6	;Temp Status reg
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
DAYSL			.EQU	BIOS_PG0+18	;Days: (2 bytes) 0-65535 >179 tears
DAYSH			.EQU	BIOS_PG0+19	;High order byte
;
;	- Delay Timer variables
MSDELAY		.EQU	BIOS_PG0+20	;Timer delay countdown byte
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
6551_LOAD	.EQU	SOFTCFG	;6551 SOFT config data start
CMDVAL		.EQU	SOFTCFG	;6551 SOFT COMMAND VALUE
CTLVAL		.EQU	SOFTCFG+1	;6551 SOFT CONTROL VALUE
;
6522_LOAD	.EQU	SOFTCFG+2	;6522 SOFT config data start
;
;Defaults for RTC ticks - number of IRQs for 1 second
DF_TICKS	.EQU	#250	;clock timer set for 40 microseconds, so 25 x 4ms = 0.1 second
;
;******************************************************************************
;I/O Page Base Address
IOPAGE		.EQU	$FE00
;
;ACIA device address:
SIOBase		.EQU	IOPAGE+$20	;6551 Base HW address
SIODAT		.EQU	IOPAGE+$20	;6551 ACIA base address here
SIOSTAT		.EQU	SIODAT+1	;ACIA status REGISTER
SIOCOM		.EQU	SIODAT+2 ;ACIA command REGISTER
SIOCON		.EQU	SIODAT+3 ;ACIA control REGISTER
;
;VIA device address:
Via1Base	.EQU	IOPAGE	;65C22 VIA base address here
Via1PRB		.EQU  Via1Base
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
;
;******************************************************************************
; Character In and Out routines for Console I/O buffer
;******************************************************************************
;
;CHOUT subroutine: takes the character in the ACCUMULATOR and places it in the xmit buffer
; and checks to see if XMIT interrupt is enabled (page $00 flag), if not it enables the chip
; and sets the flag to show it's on. The character sent in the A reg is preserved on exit
;	transmit is IRQ driven / buffered with a fixed size of 128 bytes
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
;CHIN subroutine: Wait for a keystroke from input buffer, return with keystroke in A Reg
;	receive is IRQ driven and buffered with a fixed size of 128 bytes
;
CHIN			LDA	ICNT	;Get character count	(3)
					BEQ	CHIN	;If zero (no character, loop back)	(2/3)
;
					PHY	;Save Y reg	(3)
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
;	- 11 clock cycles to start T2, 11 clock cycles to return after MATCH cleared
;	- starting T2 first to help normalize overall delay time
;	- total of 33 clock cycles overhead in this routine
;
EXE_MSDLY	LDA	6522_LOAD+$07	;Get T2H value (4)
					STA	Via1T2CH	;Reload T2 and enable interrupt (4)
					DEC	MATCH	;Set MATCH flag (5)
					LDA	SETIM	;Get delay seed value (3)
					STA	MSDELAY	;Set MS delay value (3)
;
MATCH_LP	LDA	MATCH	;Read MATCH flag (3)
					BNE	MATCH_LP	;If still set, loop back (2/3)
					RTS	;Return to caller (6)
;
;EXE LONG Delay routine
;	This routine is the 16-bit multiplier for the MS DELAY routine
;	It loads the 16-bit count from DELLO/DELHI, then loops the MSDELAY
;	routine until the 16-bit count is decremented to zero
;
EXE_LGDLY	LDX	DELHI	;Get high byte count
					INX	;Increment by one (checks for $00 vs $FF)
					LDY	DELLO	;Get low byte count
					BEQ	SKP_DLL	;If zero, skip to high count
DO_DLL		JSR	EXE_MSDLY	;Call millisecond delay
					DEY	;Decrement low count
					BNE	DO_DLL	;Branch back until done
;
SKP_DLL		DEX	;Decrement high byte index
					BNE	DO_DLL	;Loop back to DLL (will run 256 times)
					RTS	;Return to caller
;
;EXE EXTRA LONG Delay routine
;	This routine uses XDL variable as an 8-bit count
;	and calls the EXE LONG Delay routine XDL times
;	- On entry, XDL contains the number of interations
;
EXE_XLDLY	JSR	EXE_LGDLY	;Call the Long Delay routine
					DEC	XDL	;Decrement count
					BNE	EXE_XLDLY	;Loop back until X reg times out
					RTS	;Done, return to caller
;
;******************************************************************************
; I/O PORT routines for 6522
;	- Allows data to be read from Port A or B
;	- Allows data to be written to Port A or B
;	- Routines are Non-buffered and no HW handshaking
;	- Page zero variables are used: IO_IN, IO_OUT
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
PORT_OK		CLC	;Clear Carry Flag for no error
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
;**************************************
;* BRK/IRQ Interrupt service routines *
;**************************************
;
;The pre-process routines located in page $FF soft-vector to here:
;	The following routines handle BRK, IRQ and NMI.
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
;	- Timer2 is used for a 1ms delay with scaling for accurate delays
;	- Each timer has it's own exit vector as an insert
;	- recommended CPU clock rate is 2MHz minimum
;
BREAKEY		CLI	;Enable IRQ (2)
;
BRKINSTR0	PLY	;Restore Y reg
					PLX	;Restore X Reg
					PLA	;Restore A Reg
					STA	ACCUM	;Save A Reg
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
; The following 3 subroutines are contained in the base Monitor and S/O/S code
;	- if replaced with new code, either replace or remove these routines
;
					JSR	DECINDEX	;Decrement index to show BRK flag byte in Register display
					JSR	PRSTAT1	;Display contents of all preset/result memory locations
					JSR	DISLINE	;Disassemble then display instruction at address pointed to by INDEX
;
DO_NULL		LDA	#$00	;Clear all PROCESSOR STATUS REGISTER bits
					PHA
					PLP
BREAKEY2	STZ	ITAIL	;Zero out input buffer / reset pointers
					STZ	IHEAD
					STZ	ICNT
					JMP	(WRMMNVEC0)	;Done BRK service process, re-enter monitor
;
;Full duplex IRQ handler (54 clock cycles overhead to this point - includes return)
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
					BEQ	BREAKEY	;If Break character, branch to Break Key process	 (2/3)
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
;	timing values should not be changed, but Timer2 can be provided the user
; track it's use versus the standard delay routines which also use Timer2.
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
RESET_T2	LDA	6522_LOAD+$07	;Get T2H value (4)
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
; Restart the Monitor via cold start vector
; No memory is cleared except the required pointers to restore the system
;	- suggest invoking the Register command afterwards to get the details saved.
;
NMI_VECTOR	;This is the ROM start for NMI Panic handler
					SEI	;Disable interrupts
					STA	ACCUM	;Save A Reg
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
					JSR	INIT_VEC	;Xfer default Vectors to $0300
					JSR	INIT_CFG	;Xfer default HW config data to $0320
					JSR	INIT_6551	;Init the default console
					JSR	INIT_6522	;Init timer and port control
;
					JMP	(WRMMNVEC0)	;Jump to monitor warm start
;
;BIOS init message - sent before jumping to the monitor coldstart vector
BIOS_MSG	.DB	$0D,$0A
					.DB	" 4MHz BIOS 1.0"
					.DB	$00
;
;END OF BIOS CODE
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
;There are two routines in page $FF, one to move vectors and one to move parameters
; the start of this data is located in upper ROM just below the I/O page of $FE00
; the start address is $FDC0 and ends at FDFF
;
					.ORG	$FDC0	;Vector and HW Config data tables
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
					.DB	#$09	;Default 65C51 Command register, receiver IRQ output enabled)
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
					.DB	#$64	;T2Cl - T2 counter low count - set for 1ms (adjusted)
					.DB	#$0F	;T2CH - T2 counter high count - used for delay timer
					.DB	#$00	;SR - Shift register
					.DB	#$40	;ACR - Aux control register
					.DB	#$00	;PCR - Peripheral control register
					.DB	#$7F	;IFR - Interrupt flag register (clear all)
					.DB	#$E0	;IER - Interrupt enable register (enable T1/T2)
;
					.DB	#$00	;spare byte (16 bytes total)
;
;Reserved for additional I/O devices (16 bytes total)
					.DB	#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF
					.DB	#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF,#$FF
;
;END OF BIOS VECTOR DATA AND HARDWARE DEFAULT CONFIGURATION DATA
;******************************************************************************
;
;******************************************************************************
					.ORG	$FE00	;Reserved for I/O page - do NOT put code here
;******************************************************************************
;
;START OF TOP PAGE - DO NOT MOVE FROM THIS ADDRESS!!
;
					.ORG	$FF00	;Reserved: JMP Table, HW Vectors, Early Init and vector handlers
;
;JUMP Table starts here:
;	- BIOS calls are from the top down - total of 16
;	- Monitor calls are from the bottom up
;	- Reserved calls are in the shrinking middle
;
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
COLDSTRT	CLD	;Clear decimal mode in case of software call
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
					JSR	INIT_VEC	;Xfer default Vectors to $0300
					JSR	INIT_CFG	;Xfer default HW config data to $0320
					JSR	INIT_6551	;Init the default console
					JSR	INIT_6522	;Init timer and port control
;
; Send BIOS init msg to console
;	- note: X reg is zero on return from INIT_6522
BMSG_LP		LDA	BIOS_MSG,X	;Get BIOS init msg
					BEQ	CMBV	;If zero, msg, done, goto cold start monitor
					JSR	CHOUT	;Send to console
					INX	;Increment Index
					BRA	BMSG_LP	;Loop back until done
;
INIT_VEC	;Xfer the vector table data from ROM to $0300
					SEI	;Disable Interrupts, can be called via JMP table
					LDX	#$20	;Set for 32 bytes
INITVEC_LP
					LDA	VEC_TABLE-1,X	;Get Vector table data
					STA	SOFTVEC-1,X	;Store in Soft Vector JMP location
					DEX	;Decrement index
					BNE	INITVEC_LP	;Loop back till done
					CLI	;re-enable interupts
RET				RTS	;Return to caller
;
INIT_CFG	;Xfer the HW config data to $0320
					LDX	#$20	;Set for 32 bytes
INITCFG_LP
					LDA	CFG_TABLE-1,X	;Get Config Data
					STA	SOFTCFG-1,X	;Store in Soft Parm table
					DEX	;Decrement index
					BNE	INITCFG_LP	;Loop back till done
					RTS	;Return to caller
;
INIT_6551
;Init the 65C51
					SEI	;Disable Interrupts
					STZ	SIOSTAT	;write to status reg, reset 6551
					STZ	STTVAL	;zero status pointer
					LDX	#$02	;Get count of 2
INIT_6551L
					LDA	6551_LOAD-1,X	 ;Get Current config parameters for 6551
					STA	SIOBase+1,X	;Write to the 6551
					DEX	;Decrement count
					BNE	INIT_6551L	;Loop back until done
					CLI	;Re-enable Interrupts
					RTS	;Return to caller
;
INIT_6522
;Init the 65C22
					SEI	;Disable Interrupts
					LDX  #$0D	;Get Count of 13
INIT_6522L
					LDA	6522_LOAD-1,X	;Get soft parameters
					STA	Via1Base+1,X	;Load into 6522 chip
					DEX	;Decrement to next parameter
					BNE	INIT_6522L	;Branch back till all are loaded
					CLI	;Re-enable IRQ
					RTS	;Return to caller
;
;	6522 Port Config routine
;	- Allows Port A or B to be configured for input or output
;	- On entry, X reg contains port number (1=A, 0=B)
;	- A reg contains config mask; bit=0 for Input, bit=1 for Output
;	- on exit, A reg contain Port DDR value, X reg contains port #
;	- Carry set if error, cleared if OK
;	- Page zero variable used: IO_DIR
;
SET_PORT	STA	Via1DDRB,X	;Store config Mask to the correct port
					STA	IO_DIR	;Save Mask for compare
					LDA	Via1DDRB,X	;Load config Mask back from port
					CMP	IO_DIR	;Compare to config MASK
					BCS	STPRT_OK	;Branch if same
					SEC	;Set Carry for bad compare
					RTS	;Return to caller
STPRT_OK	CLC	;Clear Carry flag for no error
					RTS	;Return to caller
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
;65C02 Vectors:
					.ORG	$FFFA
					.DW	NMIVEC0	;NMI
					.DW	COLDSTRT	;RESET
					.DW	IRQ_VECTOR	;IRQ
					.END
