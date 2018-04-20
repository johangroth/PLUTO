
        * = $500
        chin = $815a
        cout = $817c
        cout2 = $8179
        crout = $819a
        cr2 = $8197
        spc2 = $83e9
        spc4 = $83e6
        prasc = $82ee
        dollar = $8192
        prbyte = $82fb
        prindx = $830c
        prompt = $8319
        beep = $8130
        delay1 = $81a7
        delay2 = $81ab
        set = $83c1
        timer = $83c3
        rdline = $8352
        bn2asc = $8138
        asc2bn = $8114
        hexin = $81bc
        savregs = $83b3
        resregs = $83ba
        incindex = $824e
        decindex = $8189
        prompt2 = $8564
        hexin2 = $81b6
        hexin4 = $81ba
        nmon = $867d
        coldstart = $8613
        interrupt = $876d
        acia6551 = $7fe0
        via6522 = $7fc0
        print_date_and_time = $801f
        get_date_and_time  = $8072
        bcdouta = $80ff


        acia = $7fe0
        via = $7fc0
        ds1511 = $7fa0
        put_date_and_time = $8095

        .include "include/zp.inc"
        ;.include "utils.asm"
        .include "include/1511.inc"


        sei
        lda  interruptvector
        sta  interruptvector+2
        lda  interruptvector+1
        sta  interruptvector+3
        lda  #<timer1_interrupt
        sta  interruptvector
        lda  #>timer1_interrupt
        sta  interruptvector+1
        cli

timer1_interrupt
        lda  viaifr
        and  viaier
        bne  viainterrupt
        jmp  (interruptvector+2)   ;execute normal isr

viainterrupt
        bit  #%00100000
        bne  decmsd
        bra  exit
decmsd

update_tod_on_console .proc
        jsr  send_escape
        lda  save_cursor_position_and_attributes
        jsr  cout
        jsr  send_escape
        lda  #'['
        jsr  cout
        lda  #'1'
        jsr  cout
        lda  #';'
        jsr  cout
        lda  #'6'
        jsr  cout
        lda  #'2'
        jsr  cout
        lda  #'H'
        jsr  cout
        jsr  send_date_and_time
        jsr  send_escape
        lda  restore_cursor_position_and_attributes
        jsr  cout
        rts
        .pend

send_escape
        lda  #27
        jmp  cout

send_date_and_time .proc
        pha
        phx
        phy
        jsr  get_date_and_time
        lda  todbuf+wr_datt
        jsr  bcdouta
        lda  #'/'
        jsr  cout
        lda  todbuf+wr_mon
        jsr  bcdouta
        lda  #'/'
        jsr  cout
        lda  todbuf+wr_yrhi
        jsr  bcdouta
        lda  todbuf+wr_yrlo
        jsr  bcdouta
        lda  #' '
        jsr  cout
        lda  todbuf+wr_hrst
        jsr  bcdouta
        lda  #':'
        jsr  cout
        lda  todbuf+wr_mint
        jsr  bcdouta
        lda  #':'
        jsr  cout
        lda  todbuf+wr_sect
        jsr  bcdouta
        jsr  crout
        ply
        plx
        pla
        rts
        .pend

clear_entire_screen .null "[2J"
move_cursor_to_screen_location_v_h  .null "[<V>;<H>H"
save_cursor_position_and_attributes .text "7"
restore_cursor_position_and_attributes .text "8"
