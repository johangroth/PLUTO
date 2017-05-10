        *=$500

        COUT = $830C

        LDX #0
NEXT    LDA HELLO,X
        BEQ DONE
        JSR COUT
        INX
        BRA NEXT
DONE    RTS
HELLO   .text "Hello world"
        .byte 0

