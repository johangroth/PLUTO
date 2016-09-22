      	* = $8000

start 	ldx #$ff
      	txs		; initialise stack pointer
      	lda #$ff	; set VIA ports to output
      	sta $7f52
      	sta $7f53

; check RAM decoding works as it should
	ldx #00

; fill a page with $55
	lda #$55
l1	sta $0400,x
	dex
	bne l1

;check page is $55
l2	lda $0400,x
	cmp #$55
	bne l3 		; no, decoding failed at offset x
	dex		; yepp, still $55
	beq l2		; try next memory position
	bra again

; if not, indicate this with another pattern.
l3	lda #$aa
again 	sta $7f50	; output A to the VIA ports
      	sta $7f51
      	jmp again	; loop for all eternity

      	* = $fffa
      	.word start
      	.word start
      	.word start

      	.end
