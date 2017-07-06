
;-------------------------------------------------------------------------------
;- IDE sector access routines v4.20 - By Phil Ruston ---------------------------
;-------------------------------------------------------------------------------
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
; "sector_buffer" - 512 byte array
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

ide_register0 equ $40		; Z80 IN/OUT addresses for IDE port
ide_register1 equ $41
ide_register2 equ $42
ide_register3 equ $43
ide_register4 equ $44
ide_register5 equ $45
ide_register6 equ $46
ide_register7 equ $47
ide_high_byte equ $48

;-----------------------------------------------------------------------------
		
ide_read_sector

	call ide_setup_lba		;tell ide what drive/sector is required
	call ide_wait_busy_ready	;make sure drive is ready to proceed
	ret nc
	ld a,$20
	out (ide_register7),a	;write $20 "read sector" command to reg 7
ide_srex	call ide_wait_busy_ready	;make sure drive is ready to proceed
	ret nc
	call ide_test_error		;ensure no error was reported
	ret nc
	call ide_wait_buffer	;wait for full buffer signal from drive
	ret nc
	call ide_read_buffer	;grab the 256 words from the buffer
	scf			;carry set on return = operation ok
	ret
		
;-----------------------------------------------------------------------------


ide_write_sector

	call ide_setup_lba		;tell ide what drive/sector is required
	call ide_wait_busy_ready	;make sure drive is ready to proceed
	ret nc
	ld a,$30
	out (ide_register7),a	;write $30 "write sector" command to reg 7		
	call ide_wait_busy_ready
	ret nc
	call ide_test_error		;ensure no error was reported
	ret nc
	call ide_wait_buffer	;wait for buffer ready signal from drive
	ret nc
	call ide_write_buffer	;send 256 words to drive's buffer
	call ide_wait_busy_ready	;make sure drive is ready to proceed
	ret nc
	call ide_test_error		;ensure no error was reported
	ret 			;carry set on return = operation ok

;-----------------------------------------------------------------------------


ide_get_id

	ld a,%10100000
	call master_slave_select	
	out (ide_register6),a	;select device
	call ide_wait_busy_ready
	ret nc
	ld a,$ec			;$ec = ide 'id drive' command 
	out (ide_register7),a
	jr ide_srex
	

;--------------------------------------------------------------------------------
; IDE internal subroutines 
;--------------------------------------------------------------------------------

	
ide_wait_busy_ready

	ld a,(ide_status)		;choose bit 1 or bit 2 to test for previous 
	and 1			;access depending on master or slave drive
	inc a			;selection
	sla a
	ld c,a
	ld de,0
ide_wbsy	ld b,50			;ide times out after ~5 seconds if disk(s) not
	ld a,(ide_status)		;spun up (first time access). ~1 second otherwise
	and c
	jr z,ide_dlp
	ld b,10
ide_dlp	djnz ide_dlp
	inc de
	ld a,d
	or e
	jr z,ide_to
	in a,(ide_register7)	;get status in A
	and %11000000		;mask off busy and rdy bits
	xor %01000000		;we want busy(7) to be 0 and rdy(6) to be 1
	jr nz,ide_wbsy
	ld a,(ide_status)		;from first time a disk is ready, timeout is reduced
	or c			;as spin-up is main reason for 5 second allowance
	ld (ide_status),a
	scf			;carry 1 = ok
	ret
ide_to	xor a			;carry 0 = timed out
	ret
	
;----------------------------------------------------------------------------

ide_test_error
	
	scf			;carry set = all OK
	in a,(ide_register7)	;get status in A
	bit 0,a			;test error bit
	ret z			
	bit 5,a
	jr nz,ide_err		;test write error bit
	in a,(ide_register1)	;read error report register
ide_err	or a			;make carry flag zero = error!
	ret			;if a = 0, ide busy timed out

;-----------------------------------------------------------------------------
	
ide_wait_buffer
	
	ld de,0
ide_wdrq	ld b,50			;wait 5 seconds approx
ide_blp	djnz ide_blp
	inc de
	ld a,d
	or e
	jr z,ide_to2
	in a,(ide_register7)
	bit 3,a			;to fill (or ready to fill)
	jr z,ide_wdrq
	scf			;carry 1 = ok
	ret
ide_to2	xor a			;carry 0 = timed out
	ret

;------------------------------------------------------------------------------

ide_read_buffer

	ld hl,sector_buffer
	ld b,0			;read 256 words (512 bytes per sector)
idebufrd	in a,(ide_register0)	;get low byte of ide data word first	
	ld c,a
	in a,(ide_high_byte)	;get high byte of ide data word from latch
	ld (hl),a
	inc hl
	ld (hl),c
	inc hl
	djnz idebufrd
	ret
	
;-----------------------------------------------------------------------------

ide_write_buffer
	
	ld hl,sector_buffer
	ld b,0			;write 256 words (512 bytes per sector)
idebufwt	ld a,(hl)			
	out (ide_high_byte),a	;send high byte to latch
	inc hl
	ld a,(hl)
	out (ide_register0),a	;send low byte to output entire word
	inc hl
	djnz idebufwt
	ret
	
;-----------------------------------------------------------------------------
	

ide_setup_lba
	
	ld a,1
	out (ide_register2),a	;set sector count to 1
	ld hl,ide_lba0
	ld a,(hl)
	out (ide_register3),a	;set lba 0:7
	inc hl
	ld a,(hl)
	out (ide_register4),a	;set lba 8:15
	inc hl
	ld a,(hl)
	out (ide_register5),a	;set lba 16:23
	inc hl
	ld a,(hl)
	and %00001111		;lowest 4 bits used only
	or  %11100000		;to enable lba mode
	call master_slave_select	;set bit 4 accordingly
	out (ide_register6),a	;set lba 24:27 + bits 5:7=111
	ret

;----------------------------------------------------------------------------------------

master_slave_select

	push hl
	ld hl,ide_status
	bit 0,(hl)
	jr z,ide_mast
	or 16
ide_mast:	pop hl
	ret
	
;----------------------------------------------------------------------------------------
; END OF IDE Routines
;----------------------------------------------------------------------------------------
