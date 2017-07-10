;;; via1 device addresses:
        via1base = $7fc0 ;write output register b, read input register b
        via1rb   = via1base+0     ; write output register b, read input register b
        via1ra   = via1base+1     ; write output register a, read input register a
        via1ddrb = via1base+2     ; data direction register b
        via1ddra = via1base+3     ; data direction register a
        via1t1cl = via1base+4     ; write t1 low-order latches, read t1 low-order counter
        via1t1ch = via1base+5     ; t1 high-order counter
        via1t1ll = via1base+6     ; t1 low-order latches
        via1t1lh = via1base+7     ; t1 high-order latches
        via1t2cl = via1base+8     ; write t2 low-order latches, read t2 low-order counter
        via1t2ch = via1base+9     ; t2 high-order counter
        via1sr   = via1base+$a    ; shift register
        via1acr  = via1base+$b    ; auxiliary control register
        via1pcr  = via1base+$c    ; peripheral control register
        via1ifr  = via1base+$d    ; interrupt flag register
        via1ier  = via1base+$e    ; interrupt enable register
        via1ranh = via1base+$f    ; same as reg a except no "handshake"

        via1ifrirq = 7
        via1timer1mask = 6
        via1timer2mask = 5

        via_timer2_irq_mask = %00100000

via1_init_table
        .byte   $00     ; PRB
        .byte   $00     ; PRA
        .byte   $00     ; DDRB
        .byte   $00     ; DDRA
        .byte   $00     ; T1CL
        .byte   $00     ; T1CH
        .byte   $00     ; T1LL
        .byte   $00     ; T1LH
        .byte   $00     ; T2CL
        .byte   $00     ; T2CH
        .byte   $00     ; SR
        .byte   $00     ; ACR
        .byte   $00     ; PCR
        .byte   $7F     ; IFR
        .byte   $7F     ; IER
n_via1_registers=*-via1_init_table-1

;;; via2 device addresses:
        via2base = $7fa0 ;write output register b, read input register b
        via2rb   = via2base+0     ; write output register b, read input register b
        via2ra   = via2base+1     ; write output register a, read input register a
        via2ddrb = via2base+2     ; data direction register b
        via2ddra = via2base+3     ; data direction register a
        via2t1cl = via2base+4     ; write t1 low-order latches, read t1 low-order counter
        via2t1ch = via2base+5     ; t1 high-order counter
        via2t1ll = via2base+6     ; t1 low-order latches
        via2t1lh = via2base+7     ; t1 high-order latches
        via2t2cl = via2base+8     ; write t2 low-order latches, read t2 low-order counter
        via2t2ch = via2base+9     ; t2 high-order counter
        via2sr   = via2base+$a    ; shift register
        via2acr  = via2base+$b    ; auxiliary control register
        via2pcr  = via2base+$c    ; peripheral control register
        via2ifr  = via2base+$d    ; interrupt flag register
        via2ier  = via2base+$e    ; interrupt enable register
        via2ranh = via2base+$f    ; same as reg a except no "handshake"

        via2ifrirq = 7
        via2timer1mask = 6
        via2timer2mask = 5

via2_init_table
        .byte   $00     ; PRB
        .byte   $00     ; PRA
        .byte   $00     ; DDRB
        .byte   $00     ; DDRA
        .byte   $00     ; T1CL
        .byte   $00     ; T1CH
        .byte   $00     ; T1LL
        .byte   $00     ; T1LH
        .byte   $00     ; T2CL
        .byte   $00     ; T2CH
        .byte   $00     ; SR
        .byte   $00     ; ACR
        .byte   $00     ; PCR
        .byte   $7F     ; IFR
        .byte   $7F     ; IER
n_via2_registers=*-via2_init_table-1
