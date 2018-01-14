;;;
;; Initialise the monitor.
;;;
monitor_initialiser: .proc
        nop
        .pend

;;;
;; Monitor main loop
;;;
monitor_main_loop: .proc
        nop
        .pend

dump_memory: .proc
        jsr prout
        nop
        rts
        .pend

;;;
;; Table of all commands
;;;
command_table:
        .text "D"


;;;
;; Help text for all the monitor commands.
;;;
help_text:
        .null "D Dump memory"

;;;
;; Pointers to monitor commands
;;;
command_pointers:
        .word dump_memory
