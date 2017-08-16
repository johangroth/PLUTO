
        zp_start    = $80
        ; Variables for storing MPU state after a BRK instruction
        delay_low               = zp_start
        delay_high              = zp_start + 1
        accumulator             = zp_start + 2
        x_register              = zp_start + 3
        y_register              = zp_start + 4
        mpu_status_register     = zp_start + 5
        stack_pointer           = zp_start + 6
        program_counter_low     = zp_start + 7
        program_counter_high    = zp_start + 8


        ; 65C51 IRQ handler pointers and counters
        in_buffer_counter   = zp_start + 9      ; Keeps track of how many characters in the input buffer
        in_buffer_head      = zp_start + 10     ; Keeps track of where in the input buffer an incoming char should be placed
        in_buffer_tail      = zp_start + 11     ; Keeps track of where in the input buffer an incoming char should be taken from
        out_buffer_counter  = zp_start + 12     ; Keeps track of how many characters in the output buffer
        out_buffer_head     = zp_start + 13     ; Keeps track of where in the output buffer an outgoing char should be taken from
        out_buffer_tail     = zp_start + 14     ; Keeps track of where in the output buffer an outgoing char should be placed


        index_high = zp_start + 15
        index_low = zp_start + 16

        stack_page  = $100
