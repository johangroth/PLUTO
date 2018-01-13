;;;
;; Initialise the monitor.
;;;
monitor_initialise: .proc
        nop
        .pend

;;;
;; Monitor main loop
;;;
monitor_main_loop: .proc
        nop
        .pend

;;;
;; Table of all commands
;;;
dump_memory: .proc
        jsr prout
        nop
        rts
        .pend

command_table:
        .text "D"

help_text:
        .null "Dump memory"

command_pointers:
        .word dump_memory
