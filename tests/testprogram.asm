      	* = $8000
via = $7fc0
ram = $0400

start 	ldx #$ff
      	txs		; initialise stack pointer
      	lda #$ff	; set VIA ports to output
      	sta via+2
      	sta via+3

; check RAM decoding works as it should
	    ldx #00

; fill a page with $55
	    lda #$55
l1	    sta ram,x
	    dex
	    bne l1

; check page is filled with $55
l2	    lda ram,x
	    cmp #$55
	    bne l3 		; no, decoding failed at offset x
	    dex		; yepp, still $55
	    beq l2		; try next memory position
	    bra again	; put $55 on out port of the VIA

; if not, indicate this with another pattern.
l3	    lda #%10101010
again 	; output A to the VIA ports
      	jsr viaout
        jsr delay
        lda #%01010101
        jsr viaout
        jsr delay
        lda #%11001100
        jsr viaout
        jsr delay
        lda #%00110011
        jsr viaout
        jsr delay
        bra l3

delay
        ldx #$ff
inner   ldy #$00
loop    dey
        bne loop
        dex
        bne inner
        rts        
        
viaout  sta via
        sta via+1
        rts

      	* = $fffa
      	.word start
      	.word start
      	.word start

      	.end
