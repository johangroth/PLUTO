        * = $500
        LDA #$41
        LDX #$20
L1      JSR $C8E7
        DEX
        BNE L1
        RTS
