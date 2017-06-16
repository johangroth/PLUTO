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
; +--------+----------------------------------------------+-----------------------------------------------+
; | $0020  |                                                                                              |
; +--------+			Global disklabel padded with $20 if shorter 			 	  |
; | $0028  |                                                                                              |
; +--------+----------------------------------------------------------------------------------------------+


; If there's a PC BIOS style partition table in the rest of the sector, then one of the partitions must
; cover all the C64 partitions. In this case use $CF as partition type.

; Pointers (@...) usually have the following structure:
; +============+===+=====+===+===+====================+===+===+===+
; | Byte / Bit | 7 |  6  | 5 | 4 |         3          | 2 | 1 | 0 |
; +============+===+=====+===+===+====================+===+===+===+
; | Byte 0     | 0 | LBA | 0 | 0 | HEAD / LBA HIGHEST             |
; +------------+---+-----+---+---+--------------------------------+
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

; The attributes field:
; All entries have an 1 byte attribute field (AT) at the same position, which specifies flags and filetype.
; +============+========+============+==========+===========+=============+==========+===+===+
; | Byte / Bit |   7    |     6      |    5     |     4     |      3      |    2     | 1 | 0 |
; +============+========+============+==========+===========+=============+==========+===+===+
; | Byte 0     | CLOSED | DELETEABLE | READABLE | WRITEABLE | EXECUTEABLE | FILETYPE         |
; +------------+--------+------------+----------+-----------+-------------+------------------+
; Behaviour of flags:
; If CLOSED=0 then this file cannot be accessed, because it wasn't closed (yet).
; If DELETEABLE=0 then this file cannot be deleted.
; If READABLE=0 then this file cannot be opened for reading. (might be still loadable)
; If WRITEABLE=0 then this file is readonly.
; If EXECUTEABLE=0 then this file cannot be loaded. (file is skipped for load)

; Packed Creation / Modification time bytes / bits:
; +============+============+===+===============+============+===+===+===+===+
; | Byte / Bit |     7      | 6 |       5       |     4      | 3 | 2 | 1 | 0 |
; +============+============+===+===============+============+===+===+===+===+
; | Byte 0     | Month HIGH     | Second (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 1     | Month LOW      | Minute (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 2     | Hour HIGH      | Year (0-63)                                |
; +------------+----------------+---------------+----------------------------+
; | Byte 3     | Hour LOW                       | Day (1-31)                 |
; +------------+--------------------------------+----------------------------+
; Month (1-12), Hour (0-23). Year begins from 1980, so 2001 is 21.

; CFS Directory sectors
; A directory sector holds 16 file entrys and a pointer to @Next directory sector.
; Filesize range is from 0 to 4294967295 bytes, for relative files max. 16711425 bytes.
; "Empty entry / Directory separator" type
;                                        A "DEL" entry (FILETYPE=%000):
; +========+======================================+=====+=====+=====+===============+===+===+===+
; | OFFSET |                  0                   |  1  |  2  |  3  |       4       | 5 | 6 | 7 |
; +========+======================================+=====+=====+=====+===============+===+===+===+
; | $0000  | Filename padded with $00 if shorter.                                               |
; +--------+                                                                                    |
; | $0008  |                                                                                    |
; +--------+--------------------------------------+-----+-----+-----+---------------------------+
; | $0010  | $00                                  | $00 | $00 | $00 | @reserved                 |
; +--------+--------------------------------------+-----+-----+-----+---------------------------+
; | $0018  | AT                                   | $44 | $45 | $4C | Creation time             |
; +--------+--------------------------------------+-----+-----+-----+---------------------------+

; "Normal file" type
;                                        A normal file entry (FILETYPE=%001):
; +========+=======+========+========+========+=======+======+=======+=======+
; | OFFSET |   0   |    1   |    2   |    3   |   4   |  5   |   6   |   7   |
; +========+=======+========+========+========+=======+======+=======+=======+
; | $0000  |                                                                 |
; +--------+ Filename padded with $00 if shorter.                            |
; | $0008  |                                                                 |
; +--------+----------------------------------+------------------------------+
; | $0010  | Filesize                         |     @Data tree               |
; +--------+-------+--------------------------+------------------------------+
; | $0018  | AT    | File type padded with $00| Modification time            |
; +--------+-------+--------------------------+------------------------------+
; Filetype "D"/"DEL" is not valid, because it's an alias of "DEL", and it's handled elsewere.
; Filetype "S" is not valid, because it's an alias of "SEQ".
; Filetype "P" is not valid, because it's an alias of "PRG".
; Filetype "U" is not valid, because it's an alias of "USR".
; Filetype "L"/"R"/"REL" is not valid, because it's an alias of "REL", and it's handled elsewere.
; Filetype "C"/"CBM" is not valid, because it's an alias of "CBM", and it's reserved.
; Filetype "B"/"DIR" is not valid, because it's an alias of "DIR", and it's handled elsewere.
; Filetype "J"/"LNK" is not valid, because it's an alias of "LNK", and it's handled elsewere.
; Normal file type includes "SEQ", "PRG", "USR", and user defined filetypes.
; Behaviour of flags:
; If EXECUTEABLE=1, it's possible to load this file, otherwise it's skipped when searching (might be still openable!).
; If READABLE=1, it's possible to open this file, otherwise error happens (might be still loadable!).

; "Relative file" type
;                                        A "REL" entry (FILETYPE=%010):
; +========+======================================+=====+=====+=====+===================+===+===+===+
; | OFFSET |                  0                   |  1  |  2  |  3  |         4         | 5 | 6 | 7 |
; +========+======================================+=====+=====+=====+===================+===+===+===+
; | $0000  | Filename padded with $00 if shorter.                                                   |
; +--------+                                                                                        |
; | $0008  |                                                                                        |
; +--------+--------------------------------------------------+-----+-------------------------------+
; | $0010  | Filesize                                         | RS  | @Data tree                    |
; +--------+--------------------------------------+-----+-----+-----+-------------------------------+
; | $0018  | AT                                   | $52 | $45 | $4C | Modification time             |
; +--------+--------------------------------------+-----+-----+-----+-------------------------------+
; Traditionally used for random access files in CBM DOS.
; RS is the record size, from 1 to 255. 0 is invalid.
; Should appear with filetype "REL" in directory listing.

; "Subdirectory / Directory label" type
;                                        A subdirectory entry (FILETYPE=%011):
; +========+=====================================+=====+=====+=====+================+===+===+===+
; | OFFSET |                  0                  |  1  |  2  |  3  |       4        | 5 | 6 | 7 |
; +========+=====================================+=====+=====+=====+================+===+===+===+
; | $0000  | Dirname padded with $00 if shorter.                                                |
; +--------+                                                                                    |
; | $0008  |                                                                                    |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
; | $0010  | $00                                 | $00 | $00 | $00 | @Sub directory             |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
; | $0018  | AT                                  | $44 | $49 | $52 | Creation time              |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
;
; If CLOSED=1 this entry is a regular subdirectory.
; If CLOSED=0 this is a directory label.
; The directory label must be always the first entry in the directory. It holds the @Parent directory
; and @This directory pointer. The name field will show up in directory listing as directory label.

;                                         A directory label entry (FILETYPE=%011):
; +========+=====================================+=====+=====+=====+================+===+===+===+
; | OFFSET |                  0                  |  1  |  2  |  3  |       4        | 5 | 6 | 7 |
; +========+=====================================+=====+=====+=====+================+===+===+===+
; | $0000  | Dirlabel padded with $00 if shorter.                                               |
; +--------+                                                                                    |
; | $0008  |                                                                                    |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
; | $0010  | @This directory                                       | @Parent directory          |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
; | $0018  | AT                                  | $44 | $49 | $52 | Creation time              |
; +--------+-------------------------------------+-----+-----+-----+----------------------------+
; The DELETEABLE, EXECUTEABLE, WRITEABLE, READABLE, HIDDEN flags must be the same as for the directory
; entry for this dir in the parent directory. Name is changeable by user, defaults to it's "DIR"
; entry's name.
; Behaviour of flags (for both):
; If READABLE=0 if's not possible to list this dir.
; If WRITEABLE=0 if's not possible to create/delete/rename file in dir.
; If EXECUTEABLE=0 it's not possible to change to this dir.

; "Link" type
;                                        A "LNK" entry (FILETYPE=%100):
; +========+======================================+=====+=====+=====+===================+===+===+===+
; | OFFSET |                  0                   |  1  |  2  |  3  |         4         | 5 | 6 | 7 |
; +========+======================================+=====+=====+=====+===================+===+===+===+
; | $0000  | Filename padded with $00 if shorter.                                                   |
; +--------+                                                                                        |
; | $0008  |                                                                                        |
; +--------+--------------------------------------------+-----+-----+-------------------------------+
; | $0010  | Pathlength                                 | $00 | $00 | @Link sector                  |
; +--------+--------------------------------------+-----+-----+-----+-------------------------------+
; | $0018  | AT                                   | $4C | $4E | $4B | Modification time             |
; +--------+--------------------------------------+-----+-----+-----+-------------------------------+
; The Pathlength represents the size of the string in the link sector.
; The link sector holds a string ending with $00. It is a relative path to a file from the current dir.
; File cannot be longer than 1 sector.

; "Reserved" types
; FILETYPE=%101,%110,%111 are reserved for future use.

; First byte of @file pointers (at offset $0014) have additional meaning:
; +============+========+=====+=======+===+===================+===+===+===+
; | Byte / Bit |   7    |  6  |   5   | 4 |         3         | 2 | 1 | 0 |
; +============+========+=====+=======+===+===================+===+===+===+
; | Byte 0     | HIDDEN | LBA | NEXTS |   | HEAD / LBAHIGHEST |   |   |   |
; +------------+--------+-----+-------+---+-------------------+---+---+---+
; If HIDDEN=1 this file is hidden, so it won't show up in directory listing.
; The @Next directory sector pointer is sliced in 16 parts, and the parts are in the NEXTS fields.

; @Next directory sector slicing:
; +============+===============+===+===============+===+===============+===+===============+===+
; | Byte / Bit |       7       | 6 |       5       | 4 |       3       | 2 |       1       | 0 |
; +============+===============+===+===============+===+===============+===+===============+===+
; | Byte 0     | in 13rd entry     | in 14th entry     | in 15th entry     | in 16th entry     |
; +------------+-------------------+-------------------+-------------------+-------------------+
; | Byte 1     | in 9th entry      | in 10th entry     | in 11th entry     | in 12th entry     |
; +------------+-------------------+-------------------+-------------------+-------------------+
; | Byte 2     | in 5th entry      | in 6th entry      | in 7th entry      | in 8th entry      |
; +------------+-------------------+-------------------+-------------------+-------------------+
; | Byte 3     | in 1st entry      | in 2nd entry      | in 3rd entry      | in 4th entry      |
; +------------+-------------------+-------------------+-------------------+-------------------+
;
; If all 4 bytes of @Next directory sector pointer are zeroes we reached end of directory.

; Deleted directory sector

; It holds the last 15 deleted files, and is usually placed in first data sector of partition.
; It has the same structure as a normal directory, but is only 1 sector long, so the NEXTS field is
; now called AGE, and it contain the age of entries instead of next directory sector pointer's slices.
; Same filenames with same type are eliminated by replacing the first character of an older file's
; name with a character from "A" to "N". It's directory label is "%DELETED  FILES%", directory label
; flags: CLOSED=0, DELETEABLE=0, EXECUTEABLE=1, WRITEABLE=0, READABLE=1, HIDDEN=1,

; Root directory
; It's like any other normal directory, but this is the starting point of directory stucture. It's
; usually begins in the second data sector (after the deleted directory sector). The root directory
; label is usually the same as the partition's name, but is changeable. Directory label flags:
; CLOSED=0, DELETEABLE=0, EXECUTEABLE=1, WRITEABLE=1, READABLE=1, HIDDEN=0,
; After the label there's usually a "%DELETED  FILES%" directory entry with flags CLOSED=1,
; DELETEABLE=0, EXECUTEABLE=1, WRITEABLE=0, READABLE=1, HIDDEN=1, it's pointer points to deleted
; directory sector.

; Data tree sectors
; Data sector pointers are organised in balanced tree for fast seeking. Here's a table about the numbers
; of sectors to read to search to a position in file:
; +============+=================+===================+
; | Tree depth |    Position     | Sector(s) to read |
; +============+=================+===================+
; |          1 | 0 b - 64 Kb     | 1+1               |
; +------------+-----------------+-------------------+
; |          2 | 64 Kb - 576 Kb  | 2+1               |
; +------------+-----------------+-------------------+
; |          3 | 576 Kb - 4.5 Mb | 3+1               |
; +------------+-----------------+-------------------+
; |          4 | 4.5 Mb - 36 Mb  | 4+1               |
; +------------+-----------------+-------------------+
; |          5 | 36 Mb - 292 Mb  | 5+1               |
; +------------+-----------------+-------------------+
; |          6 | 292 Mb - 2.2 Gb | 6+1               |
; +------------+-----------------+-------------------+
; |          7 | 2.2 Gb - 4 Gb   | 7+1               |
; +------------+-----------------+-------------------+

; Tree sector layout
; +========+===================+===+===+===+===================+===+===+===+
; | OFFSET |         0         | 1 | 2 | 3 |         4         | 5 | 6 | 7 |
; +========+===================+===+===+===+===================+===+===+===+
; | $0000  | @Data sector #1               | @Data sector #2               |
; +--------+---------------------------------------------------------------+
; | ...    | ...etc...                                                     |
; +--------+---------------------------------------------------------------+
; | $01F8  | @Data sector #127             | @Data sector #128             |
; +--------+-------------------------------+-------------------------------+
; Each node is 1 sector, and holds 8 @Next tree pointers, and 128 @Data sector pointers.

; First byte of pointers have additional meaning:
; +============+==============+=====+=======+===+===================+===+===+===+
; | Byte / Bit |      7       |  6  |   5   | 4 |         3         | 2 | 1 | 0 |
; +============+==============+=====+=======+===+===================+===+===+===+
; | Byte 0     | reserved (0) | LBA | SLICE     | HEAD / LBAHIGHEST             |
; +------------+--------------+-----+-----------+-------------------+---+---+---+
; @Next tree sector pointers 1-8 are sliced and are in 2 bit pieces (SLICE) in @Data sector pointers.
; (#1 in 1-16, #2 in 17-32 ...) Same slicing method is used as for @Next directory sector.

; The following special @Data sector or @Next tree pointer is used to indicate a hole in file or tree:
; +============+==============+===+=======+===+===+===+===+===+
; | Byte / Bit |      7       | 6 |   5   | 4 | 3 | 2 | 1 | 0 |
; +============+==============+===+=======+===+===+===+===+===+
; | Byte 0     | reserved (0) | 0 | SLICE     | 0 | 0 | 0 | 0 |
; +------------+--------------+---+-------+---+---+---+---+---+
; | Byte 1     | 0            | 0 | 0     | 0 | 0 | 0 | 0 | 0 |
; +------------+--------------+---+-------+---+---+---+---+---+
; | Byte 2     | 0            | 0 | 0     | 0 | 0 | 0 | 0 | 0 |
; +------------+--------------+---+-------+---+---+---+---+---+
; | Byte 3     | 0            | 0 | 0     | 0 | 0 | 0 | 0 | 0 |
; +------------+--------------+---+-------+---+---+---+---+---+
; Holes are sectors filled with $00, or for relative files $FF at record beginnings and $00
; everywhere else. This way unused parts of relative/normal files do not eat up disk space.

FIND_BOOT_SECTOR 	.PROC
			STZ IDE_LBA0
			STZ IDE_LBA1
			STZ IDE_LBA2
			STZ IDE_LBA3
			JSR IDE_READ_SECTOR
DONE			RTS
			.PEND

; Packed Creation / Modification time bytes / bits:
; +============+============+===+===============+============+===+===+===+===+
; | Byte / Bit |     7      | 6 |       5       |     4      | 3 | 2 | 1 | 0 |
; +============+============+===+===============+============+===+===+===+===+
; | Byte 0     | Month HIGH     | Second (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 1     | Month LOW      | Minute (0-59)                              |
; +------------+----------------+--------------------------------------------+
; | Byte 2     | Hour HIGH      | Year (0-63)                                |
; +------------+----------------+---------------+----------------------------+
; | Byte 3     | Hour LOW                       | Day (1-31)                 |
; +------------+--------------------------------+----------------------------+
; Month (1-12), Hour (0-23). Year begins from 1980, so 2001 is 21.
;
; 
; Convert TODBUF to compressed binary format 
COMPRESS    .PROC
        LDA  TODBUF+WR_SECT     ;Get seconds
		STZ  BCDNUM
        STA  BCDNUML
        JSR  BCD2BIN            ;Result in BINOUT
        LDA  BINOUTL
        STA  TOD
        LDA  TODBUF+WR_MON      ;Get month
        STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        PHA                     ;Preserve original value
        AND  #%00001100         ;Month high
        ASL                     ;Move month high to bit 6 and 7
        ASL
        ASL
        ASL
        ORA  TOD                ;Merge seconds and month high
        STA  TOD                ;Store month high and second (0-59)
        LDA  TODBUF+WR_MINT     ;Load minute
        STA  BCDNUML
        JSR  BCD2BIN            ;Convert to binary, result is in BINOUT
        LDA  BINOUTL
        STA  TOD+1
        PLA                     ;Restore month value
        AND  #%00000011         ;Remove everything but the low byte (the AND might be redunant).
        ASL                     ;Move month low to bit 6 and 7
        ASL
        ASL
        ASL
        ASL
        ASL
        ORA  TOD+1              ;Merge minutes and month low
        STA  TOD+1              ;Store month low and minute (0-59)

        ;Convert year bcd digits to binary and substract 1980
        LDA  TODBUF+WR_YRLO
        STA  BCDNUML
        LDA  TODBUF+WR_YRHI
        STA  BCDNUM
        JSR  BCD2BIN
        SEC
        LDA  BINOUTL            ;Time starts at 1980 ($7BC) so substract that from year
        SBC  #$BC
        STA  TOD+2
        LDA  TODBUF+WR_HRST
	    STZ  BCDNUM
	    STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        PHA
        AND  #%00011000         ;Hour high
        ASL                     ;Move hour high to bit 6 and 7
        ASL
        ASL
        ORA  TOD+2              ;Merge year and hour high
        STA  TOD+2              ;Store year and hour high
        LDA  TODBUF+WR_DATT     ;Load date (1-31)
        STZ  BCDNUM
        STA  BCDNUML
        JSR  BCD2BIN
        LDA  BINOUTL
        STA  TOD+3
        PLA
        AND  #%00000111         ;Keep three lower bits of month
        ASL
        ASL
        ASL
        ASL
        ASL
        ORA  TOD+3              ;Merge date and month low
        STA  TOD+3              ;Store date and month low
        RTS
        .PEND


