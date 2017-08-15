      	* = $8000
via1 = $7fc0
via2 = $7fa0
ram = $0400

start 	ldx #$ff
      	txs		; initialise stack pointer
      	lda #$ff	; set via ports to output
      	sta via1+2
      	sta via1+3
        sta via2+2
        sta via2+3

; check RAM decoding works as it should
	    ;ldx #00

; fill a page with $55
;	    lda #$55
;l1	    sta ram,x
;	    dex
;	    bne l1

; check page is filled with $55
;l2	    lda ram,x
;	    cmp #$55
;	    bne l3 		; no, decoding failed at offset x
;	    dex		; yepp, still $55
;	    beq l2		; try next memory position
;	    bra again	; put $55 on out port of the via1

; if not, indicate this with another pattern.
l3	    lda #%10101010
again 	; output A to the via1 ports
      	jsr via1out
        jsr via2out
        jsr delay
        lda #%01010101
        jsr via1out
        jsr via2out
        jsr delay
        ;lda #%11001100
        ;jsr via1out
        ;jsr delay
        ;lda #%00110011
        ;jsr via1out
        ;jsr delay
        bra l3

delay
        ldx #$ff
inner   ldy #$00
loop    dey
        bne loop
        dex
        bne inner
        rts

via1out
        sta via1
        sta via1+1
        rts

via2out
        sta via2
        rts

      	* = $fffa
      	.word start
      	.word start
      	.word start

      	.end
