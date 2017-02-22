; "Boot sector" layout
; The disk starts with a "boot sector". This contains the identification string ("C64 CFS V 0.11B "), 
; the global disklabel, a pointer to @Partition directory and it's backup, and the last sectors address. 
; The default partition number (DP) is used to select which partition will be automatically selected 
; after power on. Values of 0-15 are valid. The global disklabel is shown in partition listing. 
; The @Last disk sector points to the last accessible sector on disk. 
; If this pointer has the LBA bit set, this disk uses LBA addressing.
; +========+=====+=====+==========+=======================+=============================+=====+=====+=====+
; | OFFSET |  0  |  1  |    2     |         3             |              4              |  5  |  6  |  7  |
; +========+=====+=====+==========+=======================+=============================+=====+=====+=====+
; | $0000  |               Unused | DP                    | @Last disk sector                             |
; +--------+-----+-----+----------+-----------------------+-----------------------------+-----+-----+-----+
; | $0008  | $43 | $36 | $34      | $20                   | $43                         | $46 | $53 | $20 |
; +--------+-----+-----+----------+-----------------------+-----------------------------+-----+-----+-----+
; | $0010  | $56 | $20 | $30      | $2E                   | $31                         | $31 | $42 | $20 |
; +--------+-----+-----+----------+-----------------------+-----------------------------+-----+-----+-----+
; | $0018  |              @Partition directory            |        @Partition directory backup            |
; +--------+-----+-----+----------+-----------------------+-----------------------------+-----+-----+-----+
; | $0020  |                                                                                              |
; +--------+			Global disklabel padded with $20 if shorter 				|
; | $0028  |                                                                                              |
; +--------+-----+-----+----------+-----------------------+-----------------------------+-----+-----+-----+


; If there's a PC BIOS style partition table in the rest of the sector, then one of the partitions must 
; cover all the C64 partitions. In this case use $CF as partition type.

; Pointers (@...) usually have the following structure:
; +============+===+=====+===+===+====================+===+===+===+
; | Byte / Bit | 7 |  6  | 5 | 4 |         3          | 2 | 1 | 0 |
; +============+===+=====+===+===+====================+===+===+===+
; | Byte 0     | 0 | LBA | 0 | 0 | HEAD / LBA HIGHEST             |
; +------------+---+-----+---+---+--------------------+---+---+---+
; | Byte 1     |            CYLINDER HIGH / LBA HIGH              |
; +------------+--------------------------------------------------+
; | Byte 2     |            CYLINDER LOW / LBA LOW                |
; +------------+--------------------------------------------------+
; | Byte 3     |            CYLINDER LOWEST / LBA LOWEST          |
; +------------+--------------------------------------------------+
;
; If LBA=1 then this pointer is in LBA format.

; The partition directory & backup

; The partition directory is 1 sector long, and holds 16 entrys from the following 32 bytes long structure:

; A partition entry:

; +========+===+===+===+===================================================+===+===+===+===================+
; | OFFSET | 0 | 1 | 2 |                         3                         | 4 | 5 | 6 |         7         |
; +========+===+===+===+===================================================+===+===+===+===================+
; | $0000  |                           Partition's name padded with $00 if shorter.                        |
; +--------+                                                                                               |
; | $0008  |                                                                                               |
; +--------+---------------------------------------------------------------+-------------------------------+
; | $0010  |              @Start of partition                              |    @End of partition          |
; +--------+---------------------------------------------------------------+-------------------------------+
; | $0018  |              Additional info (filesystem specific, see below)                                 |
; +--------+-----------------------------------------------------------------------------------------------+

