;Prototype driver for IDE/ATA interface board
;65C02 assembly (using Procode)
;ATA PIO mode 1 protocol
;(c) 2001 stephane.guillard@steria.com
;Release 0.0.2 May-03-2001

;############## Constant values
base	equ	$7f40     ;Base address for slot I/O 16 bytes (slot 7)
datmsb	equ	base+0	;Read / write latch MSB
altern	equ	base+6	;Alternate status byte (R)
devctrl	equ	base+6	;Device control reg (W)
drivad	equ	base+7	;Device selection (Master / Slave)
datlsb	equ	base+8
error	equ	base+9	;Error code
feature	equ	base+9
seccnt	equ	base+10
secnr	equ	base+11
cyllow	equ	base+12
cylhig	equ	base+13
drhead	equ	base+14
status	equ	base+15	;Status (R)
command	equ	base+15	;Commande (W)

;############## Screen holes used as RAM parameters for syscalls
ph	equ	$47E	;Head parameter
ps	equ	$4FE	; Sector parameter
pcl	equ	$57E	;Cyl (lsb) parameter
pch	equ	$5FE	;Cyl (msb) parameter

;############## Apple ROM useful routines
home	equ	$FC58	;Clear screen
crout	equ	$FD8B	;Outputs a CR/LF
cout	equ	$FDED	;Outputs reg. A as char
strout	equ	$DB3A	;Outputs AY-pointed null-terminated string
prax	equ	$F941	;Outputs AX as 4 hex digits
pra	equ	$FDDA	;Outputs A as 2 hex digits
prspc	equ	$DB57	;Outputs 1 space char

;############## Macros
do	0	;No code generation

pr	mac		;Outputs string without CR/LF
phy
pha
ldy	#>.0
lda	#<.0
jsr	strout
pla
ply
eom

prln	mac		;Outputs string with CR/LF
pr	.0
jsr	crout
eom

fin		;Revert to normal code generation

;############## Start of code
org	$4000

init0	jmp	init
;############## Text messages
secbuf	ds	512	;RAM sector buffer (1 sector = 512 bytes in ATA world)
m_hello	asc	"A2IDE 2001 stephane.guillard@steria.com"
dfb	0
m_done	asc	"ok"
dfb	0
m_yes	asc	"yes"
dfb	0
m_no	asc	"no"
dfb	0
m_hd	asc	"Non-packet IDE HD signature..."
dfb	0
m_reset	asc	"Init HD… "
dfb	0
m_qry	asc	"Get HD info..."
dfb	0
m_name	asc	"Name.....:"
dfb	0
m_firm	asc	"Firmware.:"
dfb	0
m_ser	asc	"Serial #.:"
dfb	0
m_cyl	asc	"Cylinders:&H"
dfb	0
m_head	asc	"Heads....:&H"
dfb	0
m_sec	asc	"Sectors..:&H"
dfb	0
m_lba	asc	"Lba......:"
dfb	0
m_mbr	asc	"Read MBR..."
dfb	0
m_chk	asc	"MBR signature..."
dfb	0
m_part	asc	"Partition #"
dfb	0
m_undef	asc	"undef'd"
dfb	0
m_act	asc	">Active:"
dfb	0
m_start	asc	">CHS start:"
dfb	0
m_end	asc	", end :"
dfb	0
m_type	asc	", type "
dfb	0
m_res	asc	">Resvd secs:"
dfb	0
m_seccnt	asc	">Total secs:"
dfb	0
m_rdy	asc	"Boot sector in secbuf at $"
dfb	0
m_rdsect	asc	"RDSect() syscall at $"
dfb	0

;############## init() : main init routine
init	jsr	home	;Clear screen
prln	m_hello
jsr	hdinit	;Reset HD
bcs	done
jsr	hdqry	;Query and display HD info
bcs	done
jsr	hdmbr	;Analyze MBR and find 1st partition boot sector (leave CHS in RAM parameters)
bcs	done
jsr	rdsect	;Read 1st partition boot sector into RAM sector D42buffer
bcs	done
pr	m_rdy	;Print sector buffer address (for later use in other sw)
ldx	#<secbuf
lda	#>secbuf
jsr	prax
jsr	crout
pr	m_rdsect	;Print RDSect() syscall address (for later use in other sw)
ldx	#<rdsect
lda	#>rdsect
jsr	prax
jsr	crout
done	clc
rts		;End

;############## hdinit() : check IDE HDD signature and reset disk
signok	prln	m_no
sec
rts
hdinit	pha		;Init master IDE peripheral
stz	datmsb	;Clear interface MSB register (we are going to make a few 8 bit transfers)
stz	drhead	;Select master

pr	m_hd	;Check IDE non packet signature : seccnt=secnr=1,
lda	#$1	;cyllow=cylhig=0
cmp	seccnt	;If signature is different then peripheral may be an ATAPI (ATA w/packet
bne	signok	;interface, like CD) or nothing
cmp	secnr
bne	signok
lda	#$0
cmp	cyllow
bne	signok
cmp	cylhig
bne	signok
prln	m_yes

pr	m_reset
lda	#$06	;Start reset, no interrupts
sta	devctrl
lda	#$02	;Stop reset, no interrupts
sta	devctrl
jsr	waitBSY	;Wait for BUSY bit to go away
prln	m_done
pla
clc
rts

;############## hdmbr() ; read disk Master Boot Record, check it and analyze partition entries
hdmbr	pha		;Analyze MBR and find 1st partition boot sector (leave CHS in RAM parameters)
phx
phy

pr	m_mbr	;MBR = sector C=0, H=0, S=1
lda	#$1
sta	ps
stz	ph
stz	pcl
stz	pch
jsr	rdsect	;Read sector
prln	m_done

pr	m_chk	;Check signature MBR : offset 1FE=$55AA
lda	secbuf+$1FE
cmp	#$55
beq	]55ok
jmp	]signok
]55ok	lda	secbuf+$1FF
cmp	#$AA
beq	]AAok
]signok	prln	m_no
sec
rts
]AAok	prln	m_done

;Scan the 4 partition entries of MBR (starts at secbuf+446)
ldy	#$0	;Y=offset beginning part from (secbuf + 446) (Y may be 0, 16, 32, 48)
]nextprt	pr	m_part	;Loop for 4 partition entries
tya		;Store A in Y, and then A <- D272A/16
phy
lsr
lsr
lsr
lsr
jsr	pra	;Output current partition number (may be 0, 1, 2, 3)

pr	m_type	;Output partition type (as hex)
ply
phy
lda	secbuf+446+4,y
bne	]defined	;If partition type is null then partition is not defined
prln	m_undef
jmp	]undef
]defined	jsr	pra
jsr	crout

pr	m_act	;Output partition active flag Y/N
ply
phy
lda	secbuf+446+0,y
cmp	#$80
beq	]active
prln	m_no
jmp	]chs
]active	prln	m_yes

]chs	pr	m_start	;Output start / End CHS (note that start CHS is the boot sector of the partition)
ply
phy
lda	secbuf+446+2+1,y	;A - Extract cyl# (10 bit) into AX
and	#$C0	;A1 - Extract cyl# MSB which is in the 2 upper bits of sector#, into A
lsr
lsr
lsr
lsr
lsr
lsr
ldx	secbuf+446+2,y	;A2 - Extract cyl# LSB into X
sta	pch	;Store cyl# in RAM parameters for later RDSect() call by init() (to read in boot sector)
stx	pcl
jsr	prax
jsr	prspc
ply
phy
lda	secbuf+446+1,y	;B - Extract head#
sta	ph	;Store head# in RAM parameters for later RDSect() call by init() (to read in boot sector)
jsr	pra
jsr	prspc
ply
phy
lda	secbuf+446+2+1,y	;C - Extract sector# (and mask out the 2 upper bits which are part of cyl#, see A above)
and	#$3F
sta	ps	;Store sector# in RAM parameters for later RDSect() call by init() (to read in boot sector)
jsr	pra
pr	m_end	;Do the same for partition end CHS
ply
phy
lda	secbuf+446+6+1,y	;MSB C
and	#$C0
lsr
lsr
lsr
lsr
lsr
lsr
ldx	secbuf+446+6,y	;LSB C
jsr	prax
jsr	prspc
ply
phy
lda	secbuf+446+5,y	;H
jsr	pra
jsr	prspc
ply
phy
lda	secbuf+446+6+1,y	;S
and	#$3F
jsr	pra
jsr	crout

pr	m_res	;Reserved sectors (not implemented yet)
jsr	crout

pr	m_seccnt	;Total sectors (not implemented yet)
jsr	crout

]undef	ply		;Next partition : Y <- Y + 16
tya
clc
adc	#16
tay
cmp	#64
beq	]done
jmp	]nextprt

]done	ply
plx
pla
clc
rts

;############## hdqry() : inquiry disk properties and display them
hdqry	pha
phx
pr	m_qry
stz	datmsb
lda	#$EC	;Send ATA Inquiry command
sta	command
jsr	waitBSY
jsr	waitDATA
jsr	rd512byt
prln	m_done
pr	m_name	;Output disk name
ldx	#54
]nextc	lda	secbuf,x
jsr	cout
inx
cpx	#94
bne	]nextc
jsr	crout
pr	m_firm	;Output disk firmware rev.
ldx	#46
]nextf	lda	secbuf,x
jsr	cout
inx
cpx	#54
bne	]nextf
jsr	crout
pr	m_ser	;Output disk serial #
ldx	#20
]nexts	lda	secbuf,x
jsr	cout
inx
cpx	#40
bne	]nexts
jsr	crout
pr	m_cyl	;Output cylinder count
lda	secbuf+2
ldx	secbuf+3
jsr	prax
jsr	crout
pr	m_head	;Output head count
lda	secbuf+6
ldx	secbuf+7
jsr	prax
jsr	crout
pr	m_sec	;Output sector per track count
lda	secbuf+12
ldx	secbuf+13
jsr	prax
jsr	crout
pr	m_lba	;Output LBA accepted flag (yes / no)
lda	secbuf+98
bit	#8
beq	]nolba
prln	m_yes
jmp	]done
]nolba	prln	m_no
]done	plx
pla
clc
rts

;############## rdsect() : read a sector pointed by pch/pcl, ph, ps into secbuf
rdsect	pha
lda	#$1
sta	seccnt	;We want to read 1 sector (multiple sector transfer is also possible)
lda	ps
sta	secnr	;Sector # in track
lda	pcl
sta	cyllow	;Cylinder # LSB
lda	pch
sta	cylhig	;Cylinder # MSB
lda	ph
sta	drhead	;Head #
stz	datmsb
lda	#$20
sta	command	;Send ATA Read Sector command
jsr	waitBSY	;Wait for BUSY to go away
jsr	waitDATA	;Wait for DRQ to come (DRQ is Data ReQuest)
jsr	rd256wrd	;Read 256 16 bit words into RAM sector buffer
pla
clc
rts

;############## rd256wrd() : read 256 16 bit words into RAM sector buffer
rd256wrd	phx		;The trick is simple : we read the interface LSB first.
pha		;This latches the drive's MSB at the same time into the interface MSB latch.
ldx	#$0	;Then we read the interface's MSB latch and we have read the full 16 bits from the drive.
]next1	lda	datlsb
sta	secbuf,X
lda	datmsb
sta	secbuf+1,X
inx
inx
bne	]next1
]next2	lda	datlsb
sta	secbuf+$100,X
lda	datmsb
sta	secbuf+$101,X
inx
inx
bne	]next2
pla
plx
rts

;############## rd512byt() : read 512 8 bit words into RAM sector buffer
rd512byt	phx		;Same as above. But as this is a 8 bit transfer, the order of the bytes come reversed.
pha
ldx	#$0
]next1	lda	datlsb
sta	secbuf+1,X
lda	datmsb
sta	secbuf,X
inx
inx
bne	]next1
]next2	lda	datlsb
sta	secbuf+$101,X
lda	datmsb
sta	secbuf+$100,X
inx
inx
bne	]next2
pla
plx
rts

;############## waitDATA() : wait for DRQ bit to come
waitDATA	pha
]wait	lda	status
bit	#$8	;Loop until DRQ == 1
beq	]wait
pla
rts

;############## waitBSY() : wait for BUSY bit to go
waitBSY	pha
]wait	lda	status
bit	#$80	;Loop until BUSY == 0
bne	]wait
pla
rts

;############## dumpsec() : dump current sector in secbuf to screen (first as chars then as hex)
dumpsec	pha
phx
phy

ldx	#$0
]next1	lda	secbuf,x
cmp	#$20
bmi	]notasc1
cmp	#$7E
bmi	]done1
]notasc1	lda	#32
]done1	jsr	cout
inx
bne	]next1

]next2	lda	secbuf+$100,x
cmp	#$20
bmi	]notasc2
cmp	#$7E
bmi	]done2
]notasc2	lda	#32
]done2	jsr	cout
inx
bne	]next2

jsr	crout

ldy	#0
]next3	lda	secbuf+1,y
tax
lda	secbuf,y
phy
jsr	prax
ply
iny
iny
bne	]next3

]next4	lda	secbuf+$101,y
tax
lda	secbuf+$100,y
phy
jsr	prax
ply
iny
iny
bne	]next4

jsr	crout

ply
plx
pla
rts
