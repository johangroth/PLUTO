        brk_irq_mask = %00010000
        soft_vector_table = $300
        brk_soft_vector = soft_vector_table
        rtc_soft_vector = soft_vector_table + $2
        via1_soft_vector = soft_vector_table + $4
        via2_soft_vector = soft_vector_table + $6
        acia_soft_vector = soft_vector_table + $8
        monitor_soft_vector = soft_vector_table + $a

initial_soft_vectors:
        .word   brk_irq
        .word   rtc_irq
        .word   via1_irq
        .word   via2_irq
        .word   acia_irq
        n_soft_vectors = *-initial_soft_vectors

        in_buffer = $200
        out_buffer = $280

        extended_ascii_mask = %01111111
