        .include "inc/duart_sc28l92.inc"

;;;
;; Initialise DUART
;;  Initialises the DUART.
;;  Communication will be set to 115kBAUD, no parity, 8 bits, 1 stop bit.
;;  FIFO and transmit and receive interrupt are enabled.
;;
;;   Preparatory Ops: none
;;
;;   Returned Values: a: destroyed
;;;
duart_init: .proc
        rts
        .pend


;;;
;;  duart_irq: DUART ISR
;;   This block is responsible for receving and transmitting characters using
;;   two fixed 128 byte buffers.
;;   The block is part of the ISR (interrupt service routine) so no registers are preserved here.
;;   They have already been pushed to the stack by the main ISR.
;;
;;   Returned Values: none
;;
;;;
duart_irq: .block
        rts
        .bend
