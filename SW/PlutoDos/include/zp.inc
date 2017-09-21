
        .dsection zp
        zp_start    = $80
        ; Variables for storing MPU state after a BRK instruction
        delay_low               = zp_start
        delay_high              = zp_start + $1
        accumulator             = zp_start + $2
        x_register              = zp_start + $3
        y_register              = zp_start + $4
        mpu_status_register     = zp_start + $5
        stack_pointer           = zp_start + $6
        program_counter_low     = zp_start + $7
        program_counter_high    = zp_start + $8

        ; 65C51 IRQ handler buffer pointers and counters
        in_buffer_counter   = zp_start + $9      ; Keeps track of how many characters in the input buffer
        in_buffer_head      = zp_start + $a     ; Keeps track of where in the input buffer an incoming char should be placed
        in_buffer_tail      = zp_start + $b     ; Keeps track of where in the input buffer an incoming char should be taken from
        out_buffer_counter  = zp_start + $c     ; Keeps track of how many characters in the output buffer
        out_buffer_head     = zp_start + $d     ; Keeps track of where in the output buffer an outgoing char should be taken from
        out_buffer_tail     = zp_start + $e     ; Keeps track of where in the output buffer an outgoing char should be placed

        index_low = zp_start + $f
        index_high = zp_start + $10

        ; Variables for read line subroutine. A 16 byte buffer is reserved for input of characters.
        input_buffer = zp_start + $11           ; Input buffer for read_line subroutine (16 bytes)
        buffer_address_low = zp_start + $21     ; Low address pointer to input buffer. Used by read_line.
        buffer_address_high = zp_start + $22    ; High address pointer to input buffer. Used by read_line.
        buffer_length = zp_start + $23          ; Number of characters read_line should read (max = 16)
        buffer_index = zp_start + $24           ; Pointer to current character in input buffer. Used by read_line.

        ;number_buffer = zp_start + $25          ; A 4 byte buffer for number conversion
        number_buffer = $a5          ; A 4 byte buffer for number conversion

        ;; This flag byte holds boolean flags for various subroutines.
        ;; bit 0    - checked by display_hex (also hex_to_ascii which is a private proc of display_hex).
        ;;              0 indicates supression of leading zeroes
        ;;              1 indicates display hex number, ie no more leading zeroes
        ;;          - checked by read_line
        ;;              0 indicates hex input
        ;;              1 indicates decimal input
        ;; bit 1    - checked by read_line
        ;;              0 indicates bit 0 determines type of input
        ;;              1 indicates any character
        control_flags = zp_start + $29

        stack_page  = $100
