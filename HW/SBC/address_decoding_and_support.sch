EESchema Schematic File Version 2
LIBS:pluto-rescue
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
Sheet 5 8
Title "Clock, pullups and decoding logic"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 "The decoding logic is a slightly modied version of Daryl Rictor's SBC-2 v2.5"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74HCT00 U8
U 1 1 58D59B66
P 5450 2150
F 0 "U8" H 5450 2200 50  0000 C CNN
F 1 "74HCT00" H 5450 2050 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 5450 2150 50  0001 C CNN
F 3 "" H 5450 2150 50  0001 C CNN
	1    5450 2150
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U8
U 4 1 58D59B7D
P 8150 2600
F 0 "U8" H 8150 2650 50  0000 C CNN
F 1 "74HCT00" H 8150 2500 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 8150 2600 50  0001 C CNN
F 3 "" H 8150 2600 50  0001 C CNN
	4    8150 2600
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U8
U 2 1 58D59C3A
P 6250 1200
F 0 "U8" H 6250 1250 50  0000 C CNN
F 1 "74HCT00" H 6250 1100 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6250 1200 50  0001 C CNN
F 3 "" H 6250 1200 50  0001 C CNN
	2    6250 1200
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U8
U 3 1 58D59CAD
P 7800 1675
F 0 "U8" H 7800 1725 50  0000 C CNN
F 1 "74HCT00" H 7800 1575 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 7800 1675 50  0001 C CNN
F 3 "" H 7800 1675 50  0001 C CNN
	3    7800 1675
	1    0    0    -1  
$EndComp
$Comp
L 74LS30 U9
U 1 1 58D59CF0
P 6950 3075
F 0 "U9" H 6950 3175 50  0000 C CNN
F 1 "74LS30" H 6950 2975 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6950 3075 50  0001 C CNN
F 3 "" H 6950 3075 50  0001 C CNN
	1    6950 3075
	1    0    0    -1  
$EndComp
$Comp
L 74LS138 U10
U 1 1 58D59D0F
P 7925 4575
F 0 "U10" H 7725 5075 50  0000 C CNN
F 1 "74LS138" H 8075 4026 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 7925 4575 50  0001 C CNN
F 3 "" H 7925 4575 50  0001 C CNN
	1    7925 4575
	1    0    0    -1  
$EndComp
$Comp
L R_Network07 RN1
U 1 1 58D6C524
P 1975 1475
F 0 "RN1" V 1575 1475 50  0000 C CNN
F 1 "3.3 kOhm" V 2375 1475 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" V 2450 1475 50  0001 C CNN
F 3 "" H 1975 1475 50  0001 C CNN
	1    1975 1475
	1    0    0    -1  
$EndComp
$Comp
L CXO_DIP8 X1
U 1 1 58D6C921
P 4350 6450
F 0 "X1" H 4150 6700 50  0000 L CNN
F 1 "8 MHz" H 4400 6200 50  0000 L CNN
F 2 "Housings_DIP:DIP-8_W7.62mm_Socket" H 4800 6100 50  0001 C CNN
F 3 "" H 4250 6450 50  0001 C CNN
	1    4350 6450
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR38
U 1 1 58D6CEDE
P 4350 6050
F 0 "#PWR38" H 4350 5900 50  0001 C CNN
F 1 "VCC" H 4350 6200 50  0000 C CNN
F 2 "" H 4350 6050 50  0001 C CNN
F 3 "" H 4350 6050 50  0001 C CNN
	1    4350 6050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR39
U 1 1 58D6CF02
P 4350 6925
F 0 "#PWR39" H 4350 6675 50  0001 C CNN
F 1 "GND" H 4350 6775 50  0000 C CNN
F 2 "" H 4350 6925 50  0001 C CNN
F 3 "" H 4350 6925 50  0001 C CNN
	1    4350 6925
	1    0    0    -1  
$EndComp
$Comp
L Q_NPN_EBC Q1
U 1 1 58D6D190
P 1775 3250
F 0 "Q1" H 1675 3075 50  0000 L CNN
F 1 "DS1813" H 1450 3425 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Narrow_Oval" H 1975 3350 50  0001 C CNN
F 3 "" H 1775 3250 50  0001 C CNN
	1    1775 3250
	-1   0    0    1   
$EndComp
$Comp
L VCC #PWR36
U 1 1 58D6D2F3
P 1975 3250
F 0 "#PWR36" H 1975 3100 50  0001 C CNN
F 1 "VCC" H 1975 3400 50  0000 C CNN
F 2 "" H 1975 3250 50  0001 C CNN
F 3 "" H 1975 3250 50  0001 C CNN
	1    1975 3250
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW1
U 1 1 58D6D3A4
P 1025 3050
F 0 "SW1" H 950 2950 50  0000 L CNN
F 1 "RESET" H 1025 3225 50  0000 C CNN
F 2 "Buttons_Switches_ThroughHole:SW_PUSH_6mm_h4.3mm" H 1025 3250 50  0001 C CNN
F 3 "" H 1025 3250 50  0001 C CNN
	1    1025 3050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR34
U 1 1 58D6D657
P 1675 3625
F 0 "#PWR34" H 1675 3375 50  0001 C CNN
F 1 "GND" H 1675 3475 50  0000 C CNN
F 2 "" H 1675 3625 50  0001 C CNN
F 3 "" H 1675 3625 50  0001 C CNN
	1    1675 3625
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR40
U 1 1 58D83088
P 6700 4725
F 0 "#PWR40" H 6700 4575 50  0001 C CNN
F 1 "VCC" H 6700 4875 50  0000 C CNN
F 2 "" H 6700 4725 50  0001 C CNN
F 3 "" H 6700 4725 50  0001 C CNN
	1    6700 4725
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR41
U 1 1 58D830F6
P 6700 4900
F 0 "#PWR41" H 6700 4650 50  0001 C CNN
F 1 "GND" H 6700 4750 50  0000 C CNN
F 2 "" H 6700 4900 50  0001 C CNN
F 3 "" H 6700 4900 50  0001 C CNN
	1    6700 4900
	0    1    1    0   
$EndComp
$Comp
L 74LS74 U15
U 1 1 593140EB
P 5500 6450
F 0 "U15" H 5650 6750 50  0000 C CNN
F 1 "74LS74" H 5800 6155 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 5500 6450 50  0001 C CNN
F 3 "" H 5500 6450 50  0001 C CNN
	1    5500 6450
	1    0    0    -1  
$EndComp
Text Label 6450 6250 2    60   ~ 0
CLK
Text HLabel 6475 6250 2    60   Output ~ 0
CLK
Text Label 4575 2625 0    60   ~ 0
A8
Text Label 4575 2800 0    60   ~ 0
A9
Text Label 4575 3000 0    60   ~ 0
A10
Text Label 4575 3200 0    60   ~ 0
A11
Text Label 4575 3400 0    60   ~ 0
A12
Text Label 4575 3600 0    60   ~ 0
A13
Text Label 4575 3800 0    60   ~ 0
A14
Text Label 4575 2250 0    60   ~ 0
A15
Entry Wire Line
	4475 2350 4575 2250
Entry Wire Line
	4475 2725 4575 2625
Entry Wire Line
	4475 2900 4575 2800
Entry Wire Line
	4475 3100 4575 3000
Entry Wire Line
	4475 3300 4575 3200
Entry Wire Line
	4475 3500 4575 3400
Entry Wire Line
	4475 3700 4575 3600
Entry Wire Line
	4475 3900 4575 3800
Text Label 3975 2350 0    60   ~ 0
A[0..15]
Text HLabel 3975 2350 0    60   Input ~ 0
A[0..15]
Text HLabel 9075 1200 2    60   Output ~ 0
~MRD
Text HLabel 9075 1675 2    60   Output ~ 0
~MWR
Text HLabel 9075 2150 2    60   Output ~ 0
~ROMSEL
Text HLabel 9075 2600 2    60   Output ~ 0
~RAMSEL
Text Label 8975 3075 2    60   ~ 0
~IOSEL
Text Label 6700 5100 0    60   ~ 0
~IOSEL
Text Label 6700 4175 0    60   ~ 0
A5
Text Label 6700 4325 0    60   ~ 0
A6
Text Label 6700 4475 0    60   ~ 0
A7
Entry Wire Line
	6600 4275 6700 4175
Entry Wire Line
	6600 4425 6700 4325
Entry Wire Line
	6600 4575 6700 4475
Text Label 6225 4275 0    60   ~ 0
A[0..15]
Text HLabel 6225 4275 0    60   Input ~ 0
A[0..15]
Text HLabel 4575 1775 0    60   Input ~ 0
CLK
Text HLabel 4575 1100 0    60   Input ~ 0
R/~W
Text HLabel 2600 1875 2    60   BiDi ~ 0
~IRQ
Text HLabel 2600 2050 2    60   BiDi ~ 0
~NMI
Text HLabel 2600 2200 2    60   Output ~ 0
BE
Text HLabel 2600 2350 2    60   Output ~ 0
~PWR
Text HLabel 2600 2500 2    60   Output ~ 0
RDY
Text HLabel 2600 2800 2    60   Output ~ 0
~RES
Text HLabel 9125 4425 2    60   Output ~ 0
~7F6X
Text HLabel 9125 4600 2    60   Output ~ 0
~7F8X
Text HLabel 9125 4775 2    60   Output ~ 0
~7FAX
Text HLabel 9125 4950 2    60   Output ~ 0
~7FCX
Text HLabel 9125 5125 2    60   Output ~ 0
~7FEX
Text Label 4625 1775 0    60   ~ 0
CLK
NoConn ~ 8525 4425
NoConn ~ 8525 4325
NoConn ~ 8525 4225
$Comp
L 74LS74 U15
U 2 1 5948E1C2
P 3250 6350
F 0 "U15" H 3400 6650 50  0000 C CNN
F 1 "74LS74" H 3550 6055 50  0000 C CNN
F 2 "" H 3250 6350 50  0001 C CNN
F 3 "" H 3250 6350 50  0001 C CNN
	2    3250 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 2150 9075 2150
Wire Wire Line
	4850 2050 4850 2250
Wire Wire Line
	4850 2250 4575 2250
Wire Wire Line
	6350 2725 6350 2150
Wire Wire Line
	5650 1100 4575 1100
Wire Wire Line
	6975 1575 7200 1575
Wire Wire Line
	7200 1775 4575 1775
Wire Wire Line
	5650 1300 5650 1100
Wire Wire Line
	6850 1200 9075 1200
Wire Wire Line
	6975 1200 6975 1575
Connection ~ 6975 1200
Wire Wire Line
	8400 1675 9075 1675
Wire Wire Line
	7550 2500 7550 2150
Connection ~ 7550 2150
Wire Wire Line
	7550 3075 8975 3075
Wire Wire Line
	7550 3075 7550 2700
Wire Wire Line
	8750 2600 9075 2600
Connection ~ 6350 2150
Wire Wire Line
	6350 2825 5725 2825
Wire Wire Line
	5725 2825 5725 2625
Wire Wire Line
	5725 2625 4575 2625
Wire Wire Line
	6350 2925 5625 2925
Wire Wire Line
	5625 2925 5625 2800
Wire Wire Line
	5625 2800 4575 2800
Wire Wire Line
	6350 3025 5625 3025
Wire Wire Line
	5625 3025 5625 3000
Wire Wire Line
	5625 3000 4575 3000
Wire Wire Line
	6350 3125 5625 3125
Wire Wire Line
	5625 3125 5625 3200
Wire Wire Line
	5625 3200 4575 3200
Wire Wire Line
	6350 3225 5725 3225
Wire Wire Line
	5725 3225 5725 3400
Wire Wire Line
	5725 3400 4575 3400
Wire Wire Line
	6350 3325 5800 3325
Wire Wire Line
	5800 3325 5800 3600
Wire Wire Line
	5800 3600 4575 3600
Wire Wire Line
	6350 3425 5875 3425
Wire Wire Line
	5875 3425 5875 3800
Wire Wire Line
	5875 3800 4575 3800
Wire Wire Line
	6875 4225 7325 4225
Wire Wire Line
	6700 4325 7325 4325
Wire Wire Line
	6875 4425 7325 4425
Wire Wire Line
	6700 4725 7325 4725
Wire Wire Line
	6900 4825 7325 4825
Wire Wire Line
	7325 4925 7025 4925
Wire Wire Line
	8525 4525 8825 4525
Wire Wire Line
	8825 4525 8825 4425
Wire Wire Line
	8825 4425 9125 4425
Wire Wire Line
	8525 4625 8875 4625
Wire Wire Line
	8875 4625 8875 4600
Wire Wire Line
	8875 4600 9125 4600
Wire Wire Line
	8525 4725 8650 4725
Wire Wire Line
	8650 4725 8650 4775
Wire Wire Line
	8650 4775 9125 4775
Wire Wire Line
	8525 4825 8700 4825
Wire Wire Line
	8700 4825 8700 4950
Wire Wire Line
	8700 4950 9125 4950
Wire Wire Line
	8525 4925 8650 4925
Wire Wire Line
	8650 4925 8650 5125
Wire Wire Line
	8650 5125 9125 5125
Wire Wire Line
	7025 4925 7025 5100
Wire Wire Line
	7025 5100 6700 5100
Wire Wire Line
	6900 4825 6900 4900
Wire Wire Line
	6900 4900 6700 4900
Wire Wire Line
	6875 4425 6875 4475
Wire Wire Line
	6875 4475 6700 4475
Wire Wire Line
	6875 4225 6875 4175
Wire Wire Line
	6875 4175 6700 4175
Wire Wire Line
	2275 1675 2275 1875
Wire Wire Line
	2275 1875 2600 1875
Wire Wire Line
	2175 1675 2175 2050
Wire Wire Line
	2175 2050 2600 2050
Wire Wire Line
	2075 1675 2075 2200
Wire Wire Line
	2075 2200 2600 2200
Wire Wire Line
	1975 1675 1975 2350
Wire Wire Line
	1975 2350 2600 2350
Wire Wire Line
	1875 1675 1875 2500
Wire Wire Line
	1875 2500 2600 2500
Wire Wire Line
	1675 1275 1675 1100
Wire Wire Line
	1675 1675 1675 3050
Wire Wire Line
	4650 6450 4900 6450
Wire Wire Line
	1675 3450 1675 3625
Wire Wire Line
	1675 3625 825  3625
Wire Wire Line
	825  3625 825  3050
Wire Wire Line
	1675 3050 1225 3050
Wire Wire Line
	4350 6750 4350 6925
Wire Wire Line
	4350 6150 4350 6050
Wire Wire Line
	4750 7000 5500 7000
Wire Wire Line
	4750 5900 4750 7000
Wire Wire Line
	4750 6150 4350 6150
Wire Wire Line
	5500 5900 4750 5900
Connection ~ 4750 6150
Wire Wire Line
	4900 6250 4900 5800
Wire Wire Line
	4900 5800 6200 5800
Wire Wire Line
	6200 5800 6200 6650
Wire Wire Line
	6200 6650 6100 6650
Wire Wire Line
	6100 6250 6475 6250
Wire Bus Line
	4475 2350 4475 3900
Wire Bus Line
	4475 2350 3975 2350
Wire Bus Line
	6600 4275 6600 4575
Wire Bus Line
	6600 4275 6225 4275
Wire Wire Line
	3250 5800 2650 5800
Wire Wire Line
	2650 5800 2650 7025
Connection ~ 2650 6150
Connection ~ 2650 6350
Wire Wire Line
	3250 6900 2650 6900
Connection ~ 2650 6900
$Comp
L GND #PWR37
U 1 1 5948F014
P 3375 6200
F 0 "#PWR37" H 3375 5950 50  0001 C CNN
F 1 "GND" H 3375 6050 50  0000 C CNN
F 2 "" H 3375 6200 50  0001 C CNN
F 3 "" H 3375 6200 50  0001 C CNN
	1    3375 6200
	1    0    0    -1  
$EndComp
Text HLabel 2600 2650 2    60   Output ~ 0
~KS
Wire Wire Line
	1775 1675 1775 2650
Wire Wire Line
	1775 2650 2600 2650
Wire Wire Line
	2600 2800 1675 2800
Connection ~ 1675 2800
$Comp
L R_Network07 RN2
U 1 1 594C05A8
P 1975 4625
F 0 "RN2" V 1575 4625 50  0000 C CNN
F 1 "3.3 kOhm" V 2375 4625 50  0000 C CNN
F 2 "Resistors_THT:R_Array_SIP8" V 2450 4625 50  0001 C CNN
F 3 "" H 1975 4625 50  0001 C CNN
	1    1975 4625
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR35
U 1 1 594C0808
P 1675 4425
F 0 "#PWR35" H 1675 4275 50  0001 C CNN
F 1 "VCC" H 1675 4575 50  0000 C CNN
F 2 "" H 1675 4425 50  0001 C CNN
F 3 "" H 1675 4425 50  0001 C CNN
	1    1675 4425
	1    0    0    -1  
$EndComp
Text HLabel 2600 5025 2    60   Output ~ 0
~SO
Wire Wire Line
	2275 4825 2275 5025
Wire Wire Line
	2275 5025 2600 5025
$Comp
L VCC #PWR?
U 1 1 594C1459
P 1675 1100
F 0 "#PWR?" H 1675 950 50  0001 C CNN
F 1 "VCC" H 1675 1250 50  0000 C CNN
F 2 "" H 1675 1100 50  0001 C CNN
F 3 "" H 1675 1100 50  0001 C CNN
	1    1675 1100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 595DE156
P 2650 7025
F 0 "#PWR?" H 2650 6775 50  0001 C CNN
F 1 "GND" H 2650 6875 50  0000 C CNN
F 2 "" H 2650 7025 50  0001 C CNN
F 3 "" H 2650 7025 50  0001 C CNN
	1    2650 7025
	1    0    0    -1  
$EndComp
NoConn ~ 3850 6150
NoConn ~ 3850 6550
NoConn ~ 4050 6450
$EndSCHEMATC
