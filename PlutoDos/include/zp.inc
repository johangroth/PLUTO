
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
        in_buffer_counter   = zp_start + $9     ; Keeps track of how many characters there are in the input buffer
        in_buffer_head      = zp_start + $a     ; Keeps track of where in the input buffer an incoming char should be placed
        in_buffer_tail      = zp_start + $b     ; Keeps track of where in the input buffer an incoming char should be taken from
        out_buffer_counter  = zp_start + $c     ; Keeps track of how many characters there are in the output buffer
        out_buffer_head     = zp_start + $d     ; Keeps track of where in the output buffer an outgoing char should be taken from
        out_buffer_tail     = zp_start + $e     ; Keeps track of where in the output buffer an outgoing char should be placed

        ; Address pointer for various routines.
        index_low = zp_start + $f
        index_high = zp_start + $10

        ; Variables for read line subroutine. A 16 byte buffer is reserved for input of characters.
        input_buffer = zp_start + $11           ; Input buffer for read_line subroutine (16 bytes)
        buffer_address_low = zp_start + $21     ; Low address pointer to input buffer. Used by read_line.
        buffer_address_high = zp_start + $22    ; High address pointer to input buffer. Used by read_line.
        buffer_length = zp_start + $23          ; Number of characters read_line should read (max = 16)
        buffer_index = zp_start + $24           ; Pointer to current character in input buffer. Used by read_line.

        number_buffer = zp_start + $25          ; A 4 byte buffer for number conversion

        ;; This flag byte holds boolean flags for various subroutines.
        ;; bit 0 and 1    - checked by read_line
        ;;              00, hex input
        ;;              01, decimal input
        ;;              10, binary          TODO
        ;;              11, ASCII text
        ;;
        control_flags = zp_start + $29
        ;================================================================================
        ;
        ;DYNAMIC STORAGE
        ;
        bits_per_digit = zp_start + $2a ;bits per digit
        curntnum = zp_start + $2b       ;numeral being processed
        radxflag = zp_start + $2c       ;$80 = processing base-10
        ;================================================================================
        ;
        ;ZERO PAGE STORAGE
        ;
        stridx = zp_start + $2f         ;string index
        sfac = zp_start + $30           ;secondary accumulator
        wrkspc01 = sfac+s_pfac          ;conversion...
        wrkspc02 = wrkspc01+s_wrkspc    ;workspace
        radix  = wrkspc02+s_wrkspc      ;radix index
        strbuf = radix + 1              ;conversion string buffer

        temp1 = strbuf + $10
        temp2 = temp1 + $1
        temp3 = temp2 + $1
        address_low = temp2 + $1
        address_high = address_low + $1
        address = address_low

        ;===============================================================================
        ;XMODEM
        ; zero page variables (adjust these to suit your needs)
        ;
        ;
        lastblk =   address_high + $1                       ; flag for last block
        blkno  =    address_high + $2                        ; block number
        errcnt =    address_high + $3                        ; error counter 10 is the limit
        bflag  =    address_high + $4                        ; block flag

        crc    =    address_high + $5                        ; CRC lo byte  (two byte variable)
        crch   =    address_high + $6                        ; CRC hi byte

        ptr    =    address_high + $7                        ; data pointer (two byte variable)
        ptrh   =    address_high + $8                        ;   "    "

        eofp   =    address_high + $9                        ; end of file address pointer (2 bytes)
        eofph  =    address_high + $a                        ;  "    "    "    "

        retry  =    address_high + $b                        ; retry counter
        retry2 =    address_high + $c                        ; 2nd counter

        fill_length_low = retry2 + $1
        fill_length_high = fill_length_low +$1
        bcd = fill_length_high + $1
        bin = bcd + $4
        stack_page  = $100
