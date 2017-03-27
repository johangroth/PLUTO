      	* = $8000

start 	ldx #$ff
      	txs		; initialise stack pointer
      	lda #$ff	; set VIA ports to output
      	sta $7fc2
      	sta $7fc3

; check RAM decoding works as it should
	ldx #00

; fill a page with $55
	lda #$55
l1	sta $0400,x
	dex
	bne l1

; check page is filled with $55
l2	lda $0400,x
	cmp #$55
	bne l3 		; no, decoding failed at offset x
	dex		; yepp, still $55
	beq l2		; try next memory position
	bra again	; put $55 on out port of the VIA

; if not, indicate this with another pattern.
l3	lda #$aa
again 	sta $7fc0	; output A to the VIA ports
      	sta $7fc1
      	jmp again	; loop for all eternity

      	* = $fffa
      	.word start
      	.word start
      	.word start

      	.end
