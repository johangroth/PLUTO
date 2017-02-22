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

; First byte of @Start of partition has additional fields:
; +------------+-------+-----+--------+-----------+-------------------+---+---+---+
; | Byte / Bit |   7   |  6  |   5    |     4     |         3         | 2 | 1 | 0 |
; +------------+-------+-----+--------+-----------+-------------------+---+---+---+
; | Byte 0     | VALID | LBA | HIDDEN | WRITEABLE | HEAD / LBAHIGHEST             |
; +------------+-------+-----+--------+-----------+-------------------+---+---+---+
; If VALID=1 then this partition is valid.
; If HIDDEN=1 then this partition won't show up in partition listing.
; If WRITEABLE=0 then this partition is read only.

; First byte of @End of partition has additional fields:
; +------------+------+-----+------+-------+-----+-----+-----+-----+
; | Byte / Bit |  7   |  6  |  5   |  4    |  3  |  2  |  1  |  0  |
; +------------+------+-----+------+-------+-----+-----+-----+-----+
; | Byte 0     | TYPE | LBA | TYPE         |  HEAD / LBAHIGHEST    |
; +------------+------+-----+--------------+-----------------------+
; TYPE is 4 bit number extracted by clearing the LBA bit, so 8 combinations are possible.
; If TYPE=%0000 then partition is unformatted.
; If TYPE=%0001 then filesystem is CFS.
; If TYPE=%0010 then disk space is used by GEOS (will not be used by Pluto/OS)
; TYPE values of %0011-%1011 are reserved.

; Additional info layout for CFS:
; +--------+---+---+---+-----------------------+-----------------+---+---+---+
; | OFFSET | 0 | 1 | 2 |           3           |        4        | 5 | 6 | 7 |
; +--------+---+---+---+-----------------------+-----------------+---+---+---+
; | $0018  |                @Deleted directory | @Root directory             |
; +--------+---+---+---+-----------------------+-----------------+---+---+---+

; First byte of @Deleted directory has no additional fields:
; +------------+--------------+-----+--------------+---+-----------+---+---+---+
; | Byte / Bit |      7       |  6  |      5       | 4 |     3     | 2 | 1 | 0 |
; +------------+--------------+-----+--------------+---+-----------+---+---+---+
; | Byte 0     | reserved (0) | LBA | reserved (0)     | HEAD / LBAHIGHEST     |
; +------------+--------------+-----+--------------+---+-----------+---+---+---+

; First byte of @Root directory has additional fields:
; +------------+--------+-----+--------------+---+---+--------------------+---+---+
; | Byte / Bit |   7    |  6  |      5       | 4 | 3 |         2          | 1 | 0 |
; +------------+--------+-----+--------------+---+---+--------------------+---+---+
; | Byte 0     | BITMAP | LBA | reserved (0)     |      HEAD / LBAHIGHEST         |
; +------------+--------+-----+--------------+---+---+--------------------+---+---+
; If BITMAP=0 then this CFS partition uses the #1 usage bitmap, otherwise the #2.

; A CFS partition layout:
; +----------------------------+---+
; | 1st usage bitmap sector #1 |   |
; +----------------------------+ 4 |
; | 1st usage bitmap sector #2 | 0 |
; +----------------------------+ 9 |
; | 4094 data sectors          | 6 |
; +----------------------------+---|
; | 2nd usage bitmap sector #1 |   |
; +----------------------------+ 4 |
; | 2nd usage bitmap sector #2 | 0 |
; +----------------------------+ 9 |
; | 4094 data sectors          | 6 |
; +----------------------------+---|
; |       ...etc...            | . |
; +----------------------------+---|

; A usage bitmap sector:
; +============+=====+=====+=====+=====+=====+===+===+===+
; | Byte / Bit |  7  |  6  |  5  |  4  |  3  | 2 | 1 | 0 |
; +============+=====+=====+=====+=====+=====+===+===+===+
; | Byte 0     | 0   |  0  | 1st-6th data sectors useage |
; +------------+-----------------------------------------+
; | Byte 1     | 7th-14th data sectors useage            |
; +------------+-----------------------------------------+
; | ...        | ...etc...                               |
; +------------+-----------------------------------------+
; | Byte 511   | 4087th-4094th data sectors useage       |
; +------------+-----------------------------------------+
; Each bit represents a free data sector (1) or used data sector (0).
; If there aren't 4094 data sectors at the end of partition, all sectors not part of this partition
; must be marked as used.

;CFS Directory sectors
;A directory sector holds 16 file entrys and a pointer to @Next directory sector.
;Filesize range is from 0 to 4294967295 bytes, for relative files max. 16711425 bytes.
;"Empty entry / Directory separator" type
