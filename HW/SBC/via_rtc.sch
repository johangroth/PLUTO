EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:65xx
LIBS:4000-ic
LIBS:7400-ic
LIBS:analog-ic
LIBS:avr-mcu
LIBS:bluegiga
LIBS:connector
LIBS:diode-inc-ic
LIBS:freescale-ic
LIBS:ftdi-ic
LIBS:led
LIBS:maxim-ic
LIBS:micrel-ic
LIBS:microchip-ic
LIBS:nxp-ic
LIBS:on-semi-ic
LIBS:regulator
LIBS:rohm
LIBS:sharp-relay
LIBS:sparkfun
LIBS:standard
LIBS:stmicro-mcu
LIBS:ti-ic
LIBS:transistor
LIBS:uln-ic
LIBS:IDE_interface
LIBS:+1.8V
LIBS:+3.3V
LIBS:+5V
LIBS:+9V
LIBS:25AA02EXXX-XOT
LIBS:74LVC8T245
LIBS:4021
LIBS:7408
LIBS:74125
LIBS:74138
LIBS:74148
LIBS:74151
LIBS:74157
LIBS:74541
LIBS:ANT
LIBS:AP6502
LIBS:AUDIO-JACK-3
LIBS:AUDIO-JACK-6
LIBS:BATTERY
LIBS:BELFUSE-08B0-1X1T-06-F
LIBS:C
LIBS:CP
LIBS:CRYSTAL
LIBS:CRYSTAL-14
LIBS:CVAR
LIBS:DIODE
LIBS:DIODES-AP3211
LIBS:DIODESCH
LIBS:DIODEZENER
LIBS:DMMT5401
LIBS:EDISON-BULB-E10
LIBS:EDISON-SOCKET-E10
LIBS:ENC28J60
LIBS:FTDI-PLUG
LIBS:GNDPWR
LIBS:~GNDPWR
LIBS:INDUCTOR
LIBS:INTEL-EDISON-COMPUTE-MODULE
LIBS:IS31AP4066D
LIBS:JTAG
LIBS:JTAG10
LIBS:LATTICE-LC4256
LIBS:LED
LIBS:LED-BI
LIBS:LED-BI-COMMON-CATHODE
LIBS:LM324
LIBS:LM1875
LIBS:MAX3221
LIBS:MC33926
LIBS:MC34063A
LIBS:MCP49X1
LIBS:MCP3204
LIBS:MECH
LIBS:MIC2039
LIBS:MIC2288
LIBS:MICROSD-AMPHENOL-114-00841-68
LIBS:MOSFET-N
LIBS:MOSFET-N-123
LIBS:MOSFET-N-134
LIBS:MOSFET-P
LIBS:NPN
LIBS:nRF8001
LIBS:NXPUDA1334ATS
LIBS:OPAMP-DUAL
LIBS:P01
LIBS:P02
LIBS:P03
LIBS:P05
LIBS:P06
LIBS:P06-MOTOR
LIBS:P08
LIBS:P10
LIBS:P22
LIBS:P24
LIBS:PHOTO_TRANSISTOR
LIBS:PIEZO
LIBS:PNP
LIBS:POLYFUSE
LIBS:POT
LIBS:PWR_FLAG
LIBS:QRE1113
LIBS:R
LIBS:RASPBERRYPI
LIBS:RASPBERRYPI2
LIBS:RBUS8
LIBS:RN4020
LIBS:ROBOT-P10-IO
LIBS:RS-232-DB-9-DTE
LIBS:SEN-SHT3x-DIS
LIBS:SERVO
LIBS:SI4737-C40-GM
LIBS:SI4737-GU
LIBS:SKYWORKS-AAT1217-3.3
LIBS:SPDT
LIBS:SPST
LIBS:SPST-4PIN
LIBS:SST25VF032B-S2A
LIBS:SST26VF032B
LIBS:ST-LIS3MDL
LIBS:STM32-32PIN
LIBS:STM32-48PIN
LIBS:STM32-64PIN
LIBS:STM32SWDUART
LIBS:ST-SWD
LIBS:ST-TDA7266
LIBS:SWD
LIBS:TCS3472
LIBS:TI-ADS7866
LIBS:TICC3000
LIBS:TIREF30XX
LIBS:TP
LIBS:TS5A623157
LIBS:TSV631
LIBS:TVS-DIODE
LIBS:TXB0108-PW
LIBS:USBAB
LIBS:Vcc
LIBS:Vdd
LIBS:VIN
LIBS:VREG
LIBS:VREG_VOUTCENTER
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:allegro
LIBS:Altera
LIBS:analog_devices
LIBS:battery_management
LIBS:bbd
LIBS:bosch
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:intersil
LIBS:ir
LIBS:Lattice
LIBS:leds
LIBS:LEM
LIBS:logo
LIBS:maxim
LIBS:mechanical
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic24mcu
LIBS:microchip_pic32mcu
LIBS:modules
LIBS:motor_drivers
LIBS:motors
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:powerint
LIBS:Power_Management
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:RFSolutions
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:triac_thyristor
LIBS:ttl_ieee
LIBS:video
LIBS:wiznet
LIBS:Worldsemi
LIBS:Xicor
LIBS:zetex
LIBS:Zilog
LIBS:pluto
LIBS:pluto-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 8
Title "VIA and RTC"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L WD65C22 U6
U 1 1 58D61E90
P 2900 2225
F 0 "U6" H 2650 3275 60  0000 C CNN
F 1 "WD65C22" V 2900 2125 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 2400 2425 60  0001 C CNN
F 3 "" H 2400 2425 60  0000 C CNN
	1    2900 2225
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X07 J2
U 1 1 58D65CA0
P 1125 1800
F 0 "J2" H 1125 2200 50  0000 C CNN
F 1 "VIA1PA" V 1125 1800 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_14pins" H 1125 600 50  0001 C CNN
F 3 "" H 1125 600 50  0001 C CNN
	1    1125 1800
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X07 J3
U 1 1 58D65CF3
P 1125 3325
F 0 "J3" H 1125 3725 50  0000 C CNN
F 1 "VIA1PB" V 1125 3325 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_14pins" H 1125 2125 50  0001 C CNN
F 3 "" H 1125 2125 50  0001 C CNN
	1    1125 3325
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR22
U 1 1 58D69383
P 700 3725
F 0 "#PWR22" H 700 3575 50  0001 C CNN
F 1 "VCC" H 700 3875 50  0000 C CNN
F 2 "" H 700 3725 50  0001 C CNN
F 3 "" H 700 3725 50  0001 C CNN
	1    700  3725
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR21
U 1 1 58D6939F
P 700 2825
F 0 "#PWR21" H 700 2575 50  0001 C CNN
F 1 "GND" H 700 2675 50  0000 C CNN
F 2 "" H 700 2825 50  0001 C CNN
F 3 "" H 700 2825 50  0001 C CNN
	1    700  2825
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR19
U 1 1 58D6973D
P 700 1325
F 0 "#PWR19" H 700 1075 50  0001 C CNN
F 1 "GND" H 700 1175 50  0000 C CNN
F 2 "" H 700 1325 50  0001 C CNN
F 3 "" H 700 1325 50  0001 C CNN
	1    700  1325
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR20
U 1 1 58D69759
P 700 2200
F 0 "#PWR20" H 700 2050 50  0001 C CNN
F 1 "VCC" H 700 2350 50  0000 C CNN
F 2 "" H 700 2200 50  0001 C CNN
F 3 "" H 700 2200 50  0001 C CNN
	1    700  2200
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR27
U 1 1 58D6982A
P 3850 2925
F 0 "#PWR27" H 3850 2775 50  0001 C CNN
F 1 "VCC" H 3850 3075 50  0000 C CNN
F 2 "" H 3850 2925 50  0001 C CNN
F 3 "" H 3850 2925 50  0001 C CNN
	1    3850 2925
	1    0    0    -1  
$EndComp
$Comp
L D_Small D1
U 1 1 58D69B92
P 3850 3850
F 0 "D1" H 3900 3775 50  0000 L CNN
F 1 "D" H 3725 3750 50  0000 C BNN
F 2 "Diodes_ThroughHole:D_DO-35_SOD27_P7.62mm_Horizontal" V 3850 3850 50  0001 C CNN
F 3 "" V 3850 3850 50  0001 C CNN
	1    3850 3850
	1    0    0    -1  
$EndComp
NoConn ~ 3450 6600
$Comp
L C C13
U 1 1 5907389E
P 3400 4200
F 0 "C13" V 3575 4175 50  0000 L CNN
F 1 "0.1uF" V 3250 4125 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3438 4050 50  0001 C CNN
F 3 "" H 3400 4200 50  0001 C CNN
	1    3400 4200
	0    1    1    0   
$EndComp
$Comp
L C C14
U 1 1 59074B76
P 3900 7100
F 0 "C14" V 4075 7050 50  0000 L CNN
F 1 "0.1uF" V 3750 7000 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3938 6950 50  0001 C CNN
F 3 "" H 3900 7100 50  0001 C CNN
	1    3900 7100
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR25
U 1 1 5924C298
P 2975 925
F 0 "#PWR25" H 2975 775 50  0001 C CNN
F 1 "VCC" H 2975 1075 50  0000 C CNN
F 2 "" H 2975 925 50  0001 C CNN
F 3 "" H 2975 925 50  0001 C CNN
	1    2975 925 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR26
U 1 1 5924C3BB
P 2975 4200
F 0 "#PWR26" H 2975 3950 50  0001 C CNN
F 1 "GND" H 2975 4050 50  0000 C CNN
F 2 "" H 2975 4200 50  0001 C CNN
F 3 "" H 2975 4200 50  0001 C CNN
	1    2975 4200
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR24
U 1 1 5924C55A
P 2900 5225
F 0 "#PWR24" H 2900 5075 50  0001 C CNN
F 1 "VCC" V 2975 5325 50  0000 C CNN
F 2 "" H 2900 5225 50  0001 C CNN
F 3 "" H 2900 5225 50  0001 C CNN
	1    2900 5225
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR23
U 1 1 5924C775
P 2825 7100
F 0 "#PWR23" H 2825 6850 50  0001 C CNN
F 1 "GND" H 2825 6950 50  0000 C CNN
F 2 "" H 2825 7100 50  0001 C CNN
F 3 "" H 2825 7100 50  0001 C CNN
	1    2825 7100
	1    0    0    -1  
$EndComp
$Comp
L WD65C22 U12
U 1 1 59306341
P 7450 2225
F 0 "U12" H 7200 3275 60  0000 C CNN
F 1 "WD65C22" V 7450 2125 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 6950 2425 60  0001 C CNN
F 3 "" H 6950 2425 60  0000 C CNN
	1    7450 2225
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X07 J7
U 1 1 59306359
P 5675 3325
F 0 "J7" H 5675 3725 50  0000 C CNN
F 1 "VIA2PB" V 5675 3325 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_14pins" H 5675 2125 50  0001 C CNN
F 3 "" H 5675 2125 50  0001 C CNN
	1    5675 3325
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR29
U 1 1 5930635F
P 5250 3725
F 0 "#PWR29" H 5250 3575 50  0001 C CNN
F 1 "VCC" H 5250 3875 50  0000 C CNN
F 2 "" H 5250 3725 50  0001 C CNN
F 3 "" H 5250 3725 50  0001 C CNN
	1    5250 3725
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR28
U 1 1 59306365
P 5250 2825
F 0 "#PWR28" H 5250 2575 50  0001 C CNN
F 1 "GND" H 5250 2675 50  0000 C CNN
F 2 "" H 5250 2825 50  0001 C CNN
F 3 "" H 5250 2825 50  0001 C CNN
	1    5250 2825
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR32
U 1 1 59306377
P 8400 2925
F 0 "#PWR32" H 8400 2775 50  0001 C CNN
F 1 "VCC" H 8400 3075 50  0000 C CNN
F 2 "" H 8400 2925 50  0001 C CNN
F 3 "" H 8400 2925 50  0001 C CNN
	1    8400 2925
	1    0    0    -1  
$EndComp
$Comp
L D_Small D2
U 1 1 59306381
P 8400 3850
F 0 "D2" H 8425 3725 50  0000 L CNN
F 1 "D" H 8275 3700 50  0000 C BNN
F 2 "Diodes_ThroughHole:D_DO-35_SOD27_P7.62mm_Horizontal" V 8400 3850 50  0001 C CNN
F 3 "" V 8400 3850 50  0001 C CNN
	1    8400 3850
	1    0    0    -1  
$EndComp
$Comp
L C C15
U 1 1 59306388
P 7950 4200
F 0 "C15" V 8125 4175 50  0000 L CNN
F 1 "0.1uF" V 7800 4125 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7988 4050 50  0001 C CNN
F 3 "" H 7950 4200 50  0001 C CNN
	1    7950 4200
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR30
U 1 1 593063DC
P 7525 925
F 0 "#PWR30" H 7525 775 50  0001 C CNN
F 1 "VCC" H 7525 1075 50  0000 C CNN
F 2 "" H 7525 925 50  0001 C CNN
F 3 "" H 7525 925 50  0001 C CNN
	1    7525 925 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR31
U 1 1 593063E2
P 7525 4200
F 0 "#PWR31" H 7525 3950 50  0001 C CNN
F 1 "GND" H 7525 4050 50  0000 C CNN
F 2 "" H 7525 4200 50  0001 C CNN
F 3 "" H 7525 4200 50  0001 C CNN
	1    7525 4200
	1    0    0    -1  
$EndComp
Text Label 6375 1275 0    60   ~ 0
V2PA0
Text Label 6375 1400 0    60   ~ 0
V2PA1
Text Label 6375 1525 0    60   ~ 0
V2PA2
Text Label 6375 1650 0    60   ~ 0
V2PA3
Text Label 6375 1775 0    60   ~ 0
V2PA4
Text Label 6375 1900 0    60   ~ 0
V2PA5
Text Label 6375 2025 0    60   ~ 0
V2PA6
Text Label 6375 2150 0    60   ~ 0
V2PA7
Entry Wire Line
	6275 1375 6375 1275
Entry Wire Line
	6275 1500 6375 1400
Entry Wire Line
	6275 1625 6375 1525
Entry Wire Line
	6275 1750 6375 1650
Entry Wire Line
	6275 1875 6375 1775
Entry Wire Line
	6275 2000 6375 1900
Entry Wire Line
	6275 2125 6375 2025
Entry Wire Line
	6275 2250 6375 2150
Text Label 5775 2250 0    60   ~ 0
V2PA[0..7]
Text HLabel 5725 2250 0    60   BiDi ~ 0
V2PA[0..7]
Text Label 8500 1275 2    60   ~ 0
D0
Text Label 8500 1400 2    60   ~ 0
D1
Text Label 8500 1525 2    60   ~ 0
D2
Text Label 8500 1650 2    60   ~ 0
D3
Text Label 8500 1775 2    60   ~ 0
D4
Text Label 8500 1900 2    60   ~ 0
D5
Text Label 8500 2025 2    60   ~ 0
D6
Text Label 8500 2150 2    60   ~ 0
D7
Entry Wire Line
	8500 1275 8600 1175
Entry Wire Line
	8500 1400 8600 1300
Entry Wire Line
	8500 1525 8600 1425
Entry Wire Line
	8500 1650 8600 1550
Entry Wire Line
	8500 1775 8600 1675
Entry Wire Line
	8500 1900 8600 1800
Entry Wire Line
	8500 2025 8600 1925
Entry Wire Line
	8500 2150 8600 2050
Text Label 3950 1275 2    60   ~ 0
D0
Text Label 3950 1400 2    60   ~ 0
D1
Text Label 3950 1525 2    60   ~ 0
D2
Text Label 3950 1650 2    60   ~ 0
D3
Text Label 3950 1775 2    60   ~ 0
D4
Text Label 3950 1900 2    60   ~ 0
D5
Text Label 3950 2025 2    60   ~ 0
D6
Text Label 3950 2150 2    60   ~ 0
D7
Entry Wire Line
	3950 1275 4050 1175
Entry Wire Line
	3950 1400 4050 1300
Entry Wire Line
	3950 1525 4050 1425
Entry Wire Line
	3950 1650 4050 1550
Entry Wire Line
	3950 1775 4050 1675
Entry Wire Line
	3950 1900 4050 1800
Entry Wire Line
	3950 2025 4050 1925
Entry Wire Line
	3950 2150 4050 2050
Text Label 6050 650  0    60   ~ 0
D[0..7]
Text HLabel 3750 650  0    60   BiDi ~ 0
D[0..7]
Text Label 3950 2350 2    60   ~ 0
A0
Text Label 3950 2475 2    60   ~ 0
A1
Text Label 3950 2600 2    60   ~ 0
A2
Text Label 3950 2725 2    60   ~ 0
A3
Text HLabel 3950 3050 2    60   Input ~ 0
~7FCX
Text Label 8500 2350 2    60   ~ 0
A0
Text Label 8500 2475 2    60   ~ 0
A1
Text Label 8500 2600 2    60   ~ 0
A2
Text Label 8500 2725 2    60   ~ 0
A3
Entry Wire Line
	4675 2350 4775 2450
Entry Wire Line
	4675 2475 4775 2575
Entry Wire Line
	4675 2600 4775 2700
Entry Wire Line
	4675 2725 4775 2825
Entry Wire Line
	9375 2725 9475 2825
Entry Wire Line
	9375 2600 9475 2700
Entry Wire Line
	9375 2475 9475 2575
Entry Wire Line
	9375 2350 9475 2450
Text Label 5425 4550 0    60   ~ 0
A[0..15]
Text HLabel 9900 4550 2    60   Input ~ 0
A[0..15]
Text Label 3775 5525 2    60   ~ 0
D0
Text Label 3775 5625 2    60   ~ 0
D1
Text Label 3775 5725 2    60   ~ 0
D2
Text Label 3775 5825 2    60   ~ 0
D3
Text Label 3775 5925 2    60   ~ 0
D4
Text Label 3775 6025 2    60   ~ 0
D5
Text Label 3775 6125 2    60   ~ 0
D6
Text Label 3775 6225 2    60   ~ 0
D7
Entry Wire Line
	3775 5525 3875 5425
Entry Wire Line
	3775 5625 3875 5525
Entry Wire Line
	3775 5725 3875 5625
Entry Wire Line
	3775 5825 3875 5725
Entry Wire Line
	3775 5925 3875 5825
Entry Wire Line
	3775 6025 3875 5925
Entry Wire Line
	3775 6125 3875 6025
Entry Wire Line
	3775 6225 3875 6125
Text Label 2075 5525 0    60   ~ 0
A0
Text Label 2075 5625 0    60   ~ 0
A1
Text Label 2075 5725 0    60   ~ 0
A2
Text Label 2075 5825 0    60   ~ 0
A3
Text Label 2075 5925 0    60   ~ 0
A4
Entry Wire Line
	1975 5425 2075 5525
Entry Wire Line
	1975 5525 2075 5625
Entry Wire Line
	1975 5625 2075 5725
Entry Wire Line
	1975 5725 2075 5825
Entry Wire Line
	1975 5825 2075 5925
Text HLabel 3775 6350 2    60   Output ~ 0
~PWR
Text HLabel 2075 6700 0    60   Output ~ 0
~RES
Text HLabel 2075 6575 0    60   Output ~ 0
~IRQ
Text HLabel 2075 6375 0    60   Input ~ 0
~MWR
Text HLabel 2075 6250 0    60   Input ~ 0
~MRD
Text HLabel 2075 6125 0    60   Input ~ 0
~7F8X
Text HLabel 8500 3050 2    60   Input ~ 0
~7FAX
Text HLabel 8500 3475 2    60   Input ~ 0
R/~W
Text HLabel 8500 3600 2    60   Input ~ 0
CLK
Text HLabel 8500 3725 2    60   Input ~ 0
~RES
Text HLabel 8500 3850 2    60   Output ~ 0
~IRQ
Text HLabel 3950 3475 2    60   Input ~ 0
R/~W
Text HLabel 3950 3600 2    60   Input ~ 0
CLK
Text HLabel 3950 3725 2    60   Input ~ 0
~RES
Text HLabel 3950 3850 2    60   Output ~ 0
~IRQ
Text HLabel 6800 2275 0    60   Output ~ 0
V2CA1
Text HLabel 6800 2400 0    60   Output ~ 0
V2CA2
Wire Wire Line
	2400 5925 2075 5925
Wire Wire Line
	2400 5825 2075 5825
Wire Wire Line
	2400 5725 2075 5725
Wire Wire Line
	2400 5625 2075 5625
Wire Wire Line
	3675 2350 4675 2350
Wire Wire Line
	3675 2475 4675 2475
Wire Wire Line
	3675 2600 4675 2600
Wire Wire Line
	3675 2725 4675 2725
Wire Wire Line
	2250 1275 1375 1530
Wire Wire Line
	1375 1530 915  1530
Wire Wire Line
	915  1530 875  1600
Wire Wire Line
	2250 1525 1375 1630
Wire Wire Line
	1375 1630 915  1630
Wire Wire Line
	915  1630 875  1700
Wire Wire Line
	875  1800 915  1725
Wire Wire Line
	875  1900 915  1825
Wire Wire Line
	875  2000 915  1925
Wire Wire Line
	2250 1775 1375 1725
Wire Wire Line
	1375 1725 915  1725
Wire Wire Line
	915  1825 1375 1825
Wire Wire Line
	915  1925 1375 1925
Wire Wire Line
	1375 1825 2250 2025
Wire Wire Line
	1375 1925 2250 2275
Wire Wire Line
	2250 1400 1375 1600
Wire Wire Line
	2250 1650 1375 1700
Wire Wire Line
	2250 1900 1375 1800
Wire Wire Line
	2250 2150 1375 1900
Wire Wire Line
	2250 2400 1375 2000
Wire Wire Line
	875  3125 915  3055
Wire Wire Line
	875  3225 915  3155
Wire Wire Line
	875  3325 915  3255
Wire Wire Line
	875  3425 915  3355
Wire Wire Line
	875  3525 915  3455
Wire Wire Line
	915  3055 1375 3055
Wire Wire Line
	915  3155 1375 3155
Wire Wire Line
	915  3255 1375 3255
Wire Wire Line
	915  3355 1375 3355
Wire Wire Line
	915  3455 1375 3455
Wire Wire Line
	1375 3055 2250 2725
Wire Wire Line
	1375 3155 2250 2975
Wire Wire Line
	1375 3255 2250 3225
Wire Wire Line
	1375 3355 2250 3475
Wire Wire Line
	1375 3455 2250 3725
Wire Wire Line
	2250 2850 1375 3125
Wire Wire Line
	2250 3100 1375 3225
Wire Wire Line
	2250 3350 1375 3325
Wire Wire Line
	2250 3600 1375 3425
Wire Wire Line
	2250 3850 1375 3525
Wire Wire Line
	1375 3725 1375 3625
Wire Wire Line
	700  3725 1375 3725
Wire Wire Line
	875  3725 875  3625
Wire Wire Line
	1375 2825 1375 3025
Wire Wire Line
	700  2825 1375 2825
Wire Wire Line
	875  2825 875  3025
Connection ~ 875  3725
Connection ~ 875  2825
Wire Wire Line
	1375 2200 1375 2100
Wire Wire Line
	700  2200 1375 2200
Wire Wire Line
	875  2200 875  2100
Connection ~ 875  2200
Wire Wire Line
	1375 1325 1375 1500
Wire Wire Line
	700  1325 1375 1325
Wire Wire Line
	875  1325 875  1500
Connection ~ 875  1325
Wire Wire Line
	3675 2925 3850 2925
Wire Wire Line
	3675 3050 3950 3050
Wire Wire Line
	3675 3475 3950 3475
Wire Wire Line
	3675 3600 3950 3600
Wire Wire Line
	3675 3725 3950 3725
Wire Wire Line
	3675 3850 3750 3850
Wire Wire Line
	2075 6125 2400 6125
Wire Wire Line
	2400 6250 2075 6250
Wire Wire Line
	2400 6375 2075 6375
Wire Wire Line
	2400 6575 2075 6575
Wire Wire Line
	2400 6700 2075 6700
Wire Wire Line
	3450 6225 3775 6225
Wire Wire Line
	3450 6125 3775 6125
Wire Wire Line
	3450 6025 3775 6025
Wire Wire Line
	3450 5925 3775 5925
Wire Wire Line
	3450 5825 3775 5825
Wire Wire Line
	3450 5725 3775 5725
Wire Wire Line
	3450 5625 3775 5625
Wire Wire Line
	3450 6350 3775 6350
Wire Wire Line
	3250 4200 2975 4200
Wire Wire Line
	3550 4200 4475 4200
Wire Wire Line
	4475 4200 4475 925 
Wire Wire Line
	2900 5075 2900 5225
Wire Wire Line
	4125 7100 4050 7100
Wire Wire Line
	4125 5075 4125 7100
Wire Wire Line
	4125 5075 2900 5075
Wire Wire Line
	4475 925  2975 925 
Wire Wire Line
	8225 2350 9375 2350
Wire Wire Line
	8225 2475 9375 2475
Wire Wire Line
	8225 2600 9375 2600
Wire Wire Line
	8225 2725 9375 2725
Wire Wire Line
	8225 1275 8500 1275
Wire Wire Line
	8225 1525 8500 1525
Wire Wire Line
	8225 1650 8500 1650
Wire Wire Line
	8225 1900 8500 1900
Wire Wire Line
	8225 2025 8500 2025
Wire Wire Line
	8225 1775 8500 1775
Wire Wire Line
	8225 2150 8500 2150
Wire Wire Line
	8225 1400 8500 1400
Wire Wire Line
	5425 3125 5465 3055
Wire Wire Line
	5425 3225 5465 3155
Wire Wire Line
	5425 3325 5465 3255
Wire Wire Line
	5425 3425 5465 3355
Wire Wire Line
	5425 3525 5465 3455
Wire Wire Line
	5465 3055 5925 3055
Wire Wire Line
	5465 3155 5925 3155
Wire Wire Line
	5465 3255 5925 3255
Wire Wire Line
	5465 3355 5925 3355
Wire Wire Line
	5465 3455 5925 3455
Wire Wire Line
	5925 3055 6800 2725
Wire Wire Line
	5925 3155 6800 2975
Wire Wire Line
	5925 3255 6800 3225
Wire Wire Line
	5925 3355 6800 3475
Wire Wire Line
	5925 3455 6800 3725
Wire Wire Line
	6800 2850 5925 3125
Wire Wire Line
	6800 3100 5925 3225
Wire Wire Line
	6800 3350 5925 3325
Wire Wire Line
	6800 3600 5925 3425
Wire Wire Line
	6800 3850 5925 3525
Wire Wire Line
	5925 3725 5925 3625
Wire Wire Line
	5250 3725 5925 3725
Wire Wire Line
	5425 3725 5425 3625
Wire Wire Line
	5925 2825 5925 3025
Wire Wire Line
	5250 2825 5925 2825
Wire Wire Line
	5425 2825 5425 3025
Connection ~ 5425 3725
Connection ~ 5425 2825
Wire Wire Line
	8225 2925 8400 2925
Wire Wire Line
	8225 3050 8500 3050
Wire Wire Line
	8225 3475 8500 3475
Wire Wire Line
	8225 3600 8500 3600
Wire Wire Line
	8225 3725 8500 3725
Wire Wire Line
	8225 3850 8300 3850
Wire Wire Line
	7800 4200 7525 4200
Wire Wire Line
	8100 4200 9025 4200
Wire Wire Line
	9025 4200 9025 925 
Wire Wire Line
	9025 925  7525 925 
Wire Wire Line
	6800 1275 6375 1275
Wire Wire Line
	6800 1400 6375 1400
Wire Wire Line
	6800 1525 6375 1525
Wire Wire Line
	6800 1650 6375 1650
Wire Wire Line
	6800 1775 6375 1775
Wire Wire Line
	6800 1900 6375 1900
Wire Wire Line
	6800 2025 6375 2025
Wire Wire Line
	6800 2150 6375 2150
Wire Bus Line
	6275 1375 6275 2250
Wire Bus Line
	6275 2250 5725 2250
Wire Wire Line
	3675 1275 3950 1275
Wire Wire Line
	3675 1525 3950 1525
Wire Wire Line
	3675 1650 3950 1650
Wire Wire Line
	3675 1900 3950 1900
Wire Wire Line
	3675 2025 3950 2025
Wire Wire Line
	3675 1775 3950 1775
Wire Wire Line
	3675 2150 3950 2150
Wire Wire Line
	3675 1400 3950 1400
Wire Bus Line
	4050 650  4050 2050
Wire Bus Line
	3750 650  10525 650 
Wire Bus Line
	8600 650  8600 2050
Wire Bus Line
	9475 2450 9475 4550
Wire Bus Line
	1975 4550 9900 4550
Wire Bus Line
	4775 2450 4775 4550
Wire Wire Line
	3450 5525 3775 5525
Wire Bus Line
	10525 650  10525 5425
Wire Bus Line
	10525 5425 3875 5425
Wire Bus Line
	3875 5425 3875 6125
Wire Wire Line
	2400 5525 2075 5525
Wire Bus Line
	1975 4550 1975 5825
$Comp
L DS1511Y+ U7
U 1 1 58D61FB4
P 2875 6100
F 0 "U7" H 2700 6825 60  0000 C CNN
F 1 "DS1511Y+" V 2925 6100 60  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 2625 6550 60  0001 C CNN
F 3 "" H 2625 6550 60  0001 C CNN
	1    2875 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 6475 3775 6475
Wire Wire Line
	3450 6725 3575 6725
Wire Wire Line
	2825 7100 3750 7100
Connection ~ 2950 7100
Text HLabel 3775 6475 2    60   Input ~ 0
~KS
Wire Wire Line
	3575 6725 3575 7100
Connection ~ 3575 7100
$EndSCHEMATC
