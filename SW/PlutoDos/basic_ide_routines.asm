;-------------------------------------------------------------------------------
;- IDE sector access routines v4.20 - By Phil Ruston ---------------------------
;-------------------------------------------------------------------------------
;
;-------------------------------------------------------------------------------
;- Converted to 65C02 assembler by Johan Groth
;
; Note this code uses big-endian words purely so that the ASCII characters from
; the GET_ID command appear in the correct sequence. If using this code to
; read data sectors from existing file-systems (EG: FAT), the byte pairs will
; appear to be switched around.
;
;
; Core routines:
; --------------
; ide_get_id #
; ide_read_sector #*
; ide_write_sector #*
;
; (* Set LBA address bytes before calling)
; (# Set Drive select before calling)
;
; On return, carry flag = 1 if operation sucessful
;            else A = IDE error flags (or if $00, operation timed out)
;
; Variables required:
; -------------------
;
; "sector_buffer_ptr" - ZP pointer to 512 byte array
;
; "ide_lba0" - LBA of desired sector LSB
; "ide_lba1"
; "ide_lba2"
; "ide_lba3" - LBA of desired sector MSB
;
; "ide_status" - set bit 0 : User selects master (0) or slave (1) drive
;                    bit 1 : Flag 0 = master not previously accessed
;                    bit 2 : Flag 0 = slave not previously accessed
;
;-----------------------------------------------------------------------------

ide_register0 = $7f80		; PLUTO IN/OUT addresses for IDE port
ide_register1 = $7f81
ide_register2 = $7f82
ide_register3 = $7f83
ide_register4 = $7f84
ide_register5 = $7f85
ide_register6 = $7f86
ide_register7 = $7f87
ide_high_byte = $7f88

ide_read_sector_cmd = $20
ide_write_sector_cmd = $30

sector_buffer_ptr = $50

ide_lba0 = $52			; LBA of desired sector LSB
ide_lba1 = ide_lba0 + 1
ide_lba2 = ide_lba1 + 1
ide_lba3 = ide_lba2 + 1 	; - LBA of desired sector MSB

ide_status = $58
ide_id_drive_cmd = $ec

tmp = $70
tmp1 = tmp+1
tmp2 = tmp+2
tmp3 = tmp+3

;;; --------------------------------------------------------------------------
;;; Initialise ide
ide_init_devices .proc
		lda #$00
		sta sector_buffer_ptr
		lda #$04
		sta sector_buffer_ptr+1
		.pend

;-----------------------------------------------------------------------------

ide_init_status .proc
		stz ide_status
		rts
		.pend

;-----------------------------------------------------------------------------

ide_read_sector .proc
		jsr ide_setup_lba		;tell ide what drive/sector is required
		jsr ide_wait_busy_ready		;make sure drive is ready to proceed
		bcc error 			;no carry means error
		lda #ide_read_sector_cmd
	  	sta ide_register7

ide_srex
	  	jsr ide_wait_busy_ready		;make sure drive is ready to proceed
		bcc error
		jsr ide_test_error		;ensure no error was reported
		bcc error
		jsr ide_wait_buffer		;wait for full buffer signal from drive
		bcc error
		jsr ide_read_buffer		;grab the 256 words from the buffer
		sec				;carry set on return = operation ok
error
		rts
		.pend

;-----------------------------------------------------------------------------

ide_write_sector .proc

	  	jsr ide_setup_lba		;tell ide what drive/sector is required
	  	jsr ide_wait_busy_ready		;make sure drive is ready to proceed
	  	bcc error
	  	lda #ide_write_sector_cmd
	  	sta ide_register7		;write $30 "write sector" command to reg 7
	  	jsr ide_wait_busy_ready
	  	bcc error
	  	jsr ide_test_error		;ensure no error was reported
	  	bcc error
	  	jsr ide_wait_buffer		;wait for buffer ready signal from drive
	  	bcc error
	  	jsr ide_write_buffer		;send 256 words to drive's buffer
	  	jsr ide_wait_busy_ready		;make sure drive is ready to proceed
	  	bcc error
	  	jsr ide_test_error		;ensure no error was reported
error
  		rts 				;carry set on return = operation ok
		.pend

;-----------------------------------------------------------------------------

ide_get_id	.proc
	  	lda #%10100000
	  	jsr master_slave_select
	  	sta ide_register6		;select device
	  	jsr ide_wait_busy_ready
	  	bcc error
	  	lda #ide_id_drive_cmd		;$ec = ide 'id drive' command
	  	sta ide_register7
	  	bra ide_srex
error
    	rts
		.pend

;--------------------------------------------------------------------------------
; IDE internal subroutines
;--------------------------------------------------------------------------------

master_slave=$81
delay_counter=$82

ide_wait_busy_ready	.proc
    	lda ide_status		;choose bit 1 or bit 2 to test for previous
    	and #1		      	;access depending on master or slave drive
    	inc a		        ;selection
    	asl a
		sta master_slave
    	stz delay_counter
		stz delay_counter+1
ide_wbsy
		ldy #50			;ide times out after ~5 seconds if disk(s) not
    	lda ide_status		;spun up (first time access). ~1 second otherwise
    	and master_slave
    	beq ide_dlp
    	ldy #10
ide_dlp
		dey
      	bne ide_dlp
    	inc delay_counter
    	bne done
    	inc delay_counter+1
   		beq ide_time_out
done   	lda ide_register7	;get status in A
    	and #%11000000		;mask off busy and rdy bits
    	eor #%01000000		;we want busy(7) to be 0 and rdy(6) to be 1
    	bne ide_wbsy
    	lda ide_status		;from first time a disk is ready, timeout is reduced
    	ora master_slave	;as spin-up is main reason for 5 second allowance
    	sta ide_status
    	sec			;carry 1 = ok
    	rts
ide_time_out
      	clc			;carry 0 = timed out
    	rts
		.pend

;----------------------------------------------------------------------------

ide_test_error	.proc
    	sec			;carry set = all OK
    	lda ide_register7	;get status in A
		sta tmp ; ZP tmp
		bbr 0,tmp,ok		;test error bit
		bbs 5,tmp,ide_err	;test write error bit
		lda ide_register1	;read error report register
ide_err
		clc			;make carry flag zero = error!
ok
		rts			;if a = 0, ide busy timed out
		.pend

;-----------------------------------------------------------------------------
;
ide_wait_buffer .proc
    	stz tmp
		stz tmp1
ide_wdrq
		ldx #50			; wait 5 seconds approx TODO: the coefficient is wrong
; 50 is not the right value for a 5 sec time out.
; TODO: count the amount of cycles it takes to execute the loop and calculate the delay coefficient
; given the clock speed is 4 MHz
ide_blp
		dex
		bne ide_blp
    	inc tmp
		bne notdone
    	inc tmp1
done
		beq ide_to2
notdone
      	lda ide_register7
		sta tmp2
		bbr 3,tmp2,ide_wdrq
    	;and #%100			;to fill (or ready to fill)
    	;beq ide_wdrq
    	sec			;carry 1 = ok
    	rts
ide_to2
		clc			;carry 0 = timed out
    	rts
		.pend

;------------------------------------------------------------------------------

ide_read_buffer	.proc
		stz sector_buffer_ptr
		lda #$7d
		sta sector_buffer_ptr+1	;read 256 words (512 bytes per sector)
		ldy #0
		ldx #2
idebufrd
		lda ide_register0	;get low byte of ide data word first
		sta (sector_buffer_ptr),y
		lda ide_high_byte	;get high byte of ide data word from latch
		iny
		sta (sector_buffer_ptr),y
		bne idebufrd
		inc sector_buffer_ptr+1
		dex
		bne idebufrd
		rts
		.pend

;-----------------------------------------------------------------------------

ide_write_buffer	.proc
		stz sector_buffer_ptr
		lda #$7d
		sta sector_buffer_ptr+1	;write 256 words (512 bytes per sector)
		ldy #0
		ldx #2
idebufwt
		lda (sector_buffer_ptr),y
    	sta ide_high_byte	;send high byte to latch
    	iny
    	lda (sector_buffer_ptr),y
    	sta ide_register0 	;send low byte to output entire word
    	cpy #0
		bne idebufwt
    	inc sector_buffer_ptr+1
		dex
		bne idebufwt
    	rts
		.pend

;-----------------------------------------------------------------------------

ide_setup_lba	.proc

    	lda #1
    	sta ide_register2	;set sector count to 1
    	lda ide_lba0
    	sta ide_register3	;set lba 0:7
    	lda ide_lba1
    	sta ide_register4	;set lba 8:15
    	lda ide_lba2
    	sta ide_register5 	;set lba 16:23
    	lda ide_lba3
    	and #%00001111		;lowest 4 bits used only
    	ora #%11100000		;to enable lba mode
    	jsr master_slave_select	;set bit 4 accordingly
    	sta ide_register6	;set lba 24:27 + bits 5:7=111
    	rts
		.pend

;----------------------------------------------------------------------------------------

master_slave_select .proc

		lda ide_status
		bbr 0, ide_status, ide_mast
		ora #16
ide_mast
		rts
		.pend

;----------------------------------------------------------------------------------------
; END OF IDE Routines
;----------------------------------------------------------------------------------------
