        .include "include/screen.inc"

dc_bg   #bg

clear   .proc
        ldx #<dc_bg
        ldy #>dc_bg
        .pend
