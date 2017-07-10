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
Sheet 7 8
Title "Audio"
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L AY-3-8912 U14
U 1 1 59307D4F
P 4950 3675
F 0 "U14" H 4775 4375 60  0000 C CNN
F 1 "AY-3-8912" V 4975 3675 60  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 4850 3900 60  0001 C CNN
F 3 "" H 4850 3900 60  0001 C CNN
	1    4950 3675
	1    0    0    -1  
$EndComp
$Comp
L LM386 U13
U 1 1 59307E3E
P 3350 1575
F 0 "U13" H 3400 1875 50  0000 L CNN
F 1 "LM386" H 3400 1775 50  0000 L CNN
F 2 "Housings_DIP:DIP-8_W7.62mm_Socket" H 3450 1675 50  0001 C CNN
F 3 "" H 3550 1775 50  0001 C CNN
	1    3350 1575
	1    0    0    -1  
$EndComp
$Comp
L Speaker LS1
U 1 1 59307E57
P 4875 1575
F 0 "LS1" H 4925 1800 50  0000 R CNN
F 1 "Speaker" H 4925 1725 50  0000 R CNN
F 2 "Connect:PJ311_3.5mm_Jack" H 4875 1375 50  0001 C CNN
F 3 "" H 4865 1525 50  0001 C CNN
	1    4875 1575
	1    0    0    -1  
$EndComp
$Comp
L C_Small C19
U 1 1 59307E90
P 2950 3825
F 0 "C19" H 3025 3825 50  0000 L CNN
F 1 "10nF" H 2675 3825 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2950 3825 50  0001 C CNN
F 3 "" H 2950 3825 50  0001 C CNN
	1    2950 3825
	1    0    0    -1  
$EndComp
$Comp
L C_Small C16
U 1 1 59307ED1
P 2750 3475
F 0 "C16" V 2900 3450 50  0000 L CNN
F 1 "2.2nF" V 2575 3425 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2750 3475 50  0001 C CNN
F 3 "" H 2750 3475 50  0001 C CNN
	1    2750 3475
	0    1    1    0   
$EndComp
$Comp
L C_Small C18
U 1 1 59307F3A
P 2800 1125
F 0 "C18" V 2675 1075 50  0000 L CNN
F 1 "10uF" V 2925 1025 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2800 1125 50  0001 C CNN
F 3 "" H 2800 1125 50  0001 C CNN
	1    2800 1125
	0    1    1    0   
$EndComp
$Comp
L C_Small C20
U 1 1 59307F57
P 3900 1775
F 0 "C20" H 3725 1700 50  0000 L CNN
F 1 "47nF" H 3910 1695 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3900 1775 50  0001 C CNN
F 3 "" H 3900 1775 50  0001 C CNN
	1    3900 1775
	1    0    0    -1  
$EndComp
$Comp
L R_Small R3
U 1 1 59307F78
P 3500 3475
F 0 "R3" V 3575 3450 50  0000 L CNN
F 1 "4.7k" V 3400 3450 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" H 3500 3475 50  0001 C CNN
F 3 "" H 3500 3475 50  0001 C CNN
	1    3500 3475
	0    1    1    0   
$EndComp
$Comp
L R_Small R4
U 1 1 59307FB1
P 3725 3825
F 0 "R4" H 3755 3845 50  0000 L CNN
F 1 "1k" H 3755 3785 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" H 3725 3825 50  0001 C CNN
F 3 "" H 3725 3825 50  0001 C CNN
	1    3725 3825
	1    0    0    -1  
$EndComp
$Comp
L R_Small R5
U 1 1 59308016
P 3900 2075
F 0 "R5" V 3825 2025 50  0000 L CNN
F 1 "10" V 3975 2025 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" H 3900 2075 50  0001 C CNN
F 3 "" H 3900 2075 50  0001 C CNN
	1    3900 2075
	1    0    0    -1  
$EndComp
$Comp
L R_Small R2
U 1 1 5930803D
P 3225 3825
F 0 "R2" H 3275 3850 50  0000 L CNN
F 1 "470" H 3275 3775 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" H 3225 3825 50  0001 C CNN
F 3 "" H 3225 3825 50  0001 C CNN
	1    3225 3825
	1    0    0    -1  
$EndComp
$Comp
L R_Small R1
U 1 1 5930808C
P 2700 1675
F 0 "R1" V 2625 1650 50  0000 L CNN
F 1 "22k" V 2775 1625 50  0000 L CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" H 2700 1675 50  0001 C CNN
F 3 "" H 2700 1675 50  0001 C CNN
	1    2700 1675
	0    1    1    0   
$EndComp
$Comp
L CP1_Small C21
U 1 1 593080B7
P 4275 1575
F 0 "C21" V 4400 1525 50  0000 L CNN
F 1 "220uF 10V" V 4150 1400 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D6.3mm_P2.50mm" H 4275 1575 50  0001 C CNN
F 3 "" H 4275 1575 50  0001 C CNN
	1    4275 1575
	0    -1   -1   0   
$EndComp
NoConn ~ 3350 1875
NoConn ~ 3450 1875
NoConn ~ 3350 1275
$Comp
L GND #PWR50
U 1 1 59309AB4
P 3250 2500
F 0 "#PWR50" H 3250 2250 50  0001 C CNN
F 1 "GND" H 3250 2350 50  0000 C CNN
F 2 "" H 3250 2500 50  0001 C CNN
F 3 "" H 3250 2500 50  0001 C CNN
	1    3250 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR48
U 1 1 5930A8FE
P 2525 1125
F 0 "#PWR48" H 2525 875 50  0001 C CNN
F 1 "GND" H 2525 975 50  0000 C CNN
F 2 "" H 2525 1125 50  0001 C CNN
F 3 "" H 2525 1125 50  0001 C CNN
	1    2525 1125
	0    1    1    0   
$EndComp
$Comp
L GND #PWR45
U 1 1 5930AC61
P 2300 4100
F 0 "#PWR45" H 2300 3850 50  0001 C CNN
F 1 "GND" H 2300 3950 50  0000 C CNN
F 2 "" H 2300 4100 50  0001 C CNN
F 3 "" H 2300 4100 50  0001 C CNN
	1    2300 4100
	0    1    1    0   
$EndComp
NoConn ~ 4450 3075
$Comp
L VCC #PWR51
U 1 1 5930B1EC
P 4950 2725
F 0 "#PWR51" H 4950 2575 50  0001 C CNN
F 1 "VCC" H 4950 2875 50  0000 C CNN
F 2 "" H 4950 2725 50  0001 C CNN
F 3 "" H 4950 2725 50  0001 C CNN
	1    4950 2725
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR49
U 1 1 5930B242
P 3250 1075
F 0 "#PWR49" H 3250 925 50  0001 C CNN
F 1 "VCC" H 3250 1225 50  0000 C CNN
F 2 "" H 3250 1075 50  0001 C CNN
F 3 "" H 3250 1075 50  0001 C CNN
	1    3250 1075
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR52
U 1 1 5930BB05
P 4950 4750
F 0 "#PWR52" H 4950 4500 50  0001 C CNN
F 1 "GND" H 4950 4600 50  0000 C CNN
F 2 "" H 4950 4750 50  0001 C CNN
F 3 "" H 4950 4750 50  0001 C CNN
	1    4950 4750
	1    0    0    -1  
$EndComp
Text Label 5725 3075 2    60   ~ 0
V2PA0
Text Label 5725 3175 2    60   ~ 0
V2PA1
Text Label 5725 3275 2    60   ~ 0
V2PA2
Text Label 5725 3375 2    60   ~ 0
V2PA3
Text Label 5725 3475 2    60   ~ 0
V2PA4
Text Label 5725 3575 2    60   ~ 0
V2PA5
Text Label 5725 3675 2    60   ~ 0
V2PA6
Text Label 5725 3775 2    60   ~ 0
V2PA7
Entry Wire Line
	5725 3075 5825 2975
Entry Wire Line
	5725 3175 5825 3075
Entry Wire Line
	5725 3275 5825 3175
Entry Wire Line
	5725 3375 5825 3275
Entry Wire Line
	5725 3475 5825 3375
Entry Wire Line
	5725 3575 5825 3475
Entry Wire Line
	5725 3675 5825 3575
Entry Wire Line
	5725 3775 5825 3675
Wire Wire Line
	3650 1575 4175 1575
Wire Wire Line
	4375 1575 4675 1575
Wire Wire Line
	4675 1675 4550 1675
Wire Wire Line
	4550 1675 4550 2250
Wire Wire Line
	3050 1675 3050 2250
Wire Wire Line
	3050 2250 4550 2250
Wire Wire Line
	3250 1875 3250 2500
Connection ~ 3250 2250
Wire Wire Line
	3900 1675 3900 1575
Connection ~ 3900 1575
Wire Wire Line
	3900 1875 3900 1975
Wire Wire Line
	3900 2175 3900 2250
Connection ~ 3900 2250
Wire Wire Line
	3250 1075 3250 1275
Wire Wire Line
	3050 1475 2300 1475
Wire Wire Line
	2300 1475 2300 3475
Wire Wire Line
	2300 3475 2650 3475
Wire Wire Line
	2850 3475 3400 3475
Wire Wire Line
	3600 3475 4450 3475
Wire Wire Line
	4950 2825 4950 2725
Wire Wire Line
	4450 3275 4275 3275
Wire Wire Line
	4275 3275 4275 3475
Connection ~ 4275 3475
Wire Wire Line
	4450 3375 4275 3375
Connection ~ 4275 3375
Wire Wire Line
	2800 1675 3050 1675
Wire Wire Line
	2600 1675 2300 1675
Connection ~ 2300 1675
Wire Wire Line
	2900 1125 3250 1125
Connection ~ 3250 1125
Wire Wire Line
	2700 1125 2525 1125
Wire Wire Line
	3725 4100 3725 3925
Wire Wire Line
	2300 4100 3725 4100
Wire Wire Line
	2950 3725 2950 3475
Connection ~ 2950 3475
Wire Wire Line
	2950 3925 2950 4100
Connection ~ 2950 4100
Wire Wire Line
	3225 3725 3225 3475
Connection ~ 3225 3475
Wire Wire Line
	3225 3925 3225 4100
Connection ~ 3225 4100
Wire Wire Line
	3725 3725 3725 3475
Connection ~ 3725 3475
Wire Wire Line
	4950 4625 4950 4750
Wire Wire Line
	5450 3075 5725 3075
Wire Wire Line
	5450 3175 5725 3175
Wire Wire Line
	5450 3275 5725 3275
Wire Wire Line
	5450 3375 5725 3375
Wire Wire Line
	5450 3475 5725 3475
Wire Wire Line
	5450 3575 5725 3575
Wire Wire Line
	5450 3675 5725 3675
Wire Wire Line
	5450 3775 5725 3775
Wire Bus Line
	5825 2725 5825 3675
Wire Bus Line
	5825 2725 6450 2725
Text Label 5975 2725 0    60   ~ 0
V2PA[0..7]
Text HLabel 6450 2725 2    60   BiDi ~ 0
V2PA[0..7]
Wire Wire Line
	4450 3675 4125 3675
Wire Wire Line
	4450 3775 4125 3775
Wire Wire Line
	4450 3875 4125 3875
Wire Wire Line
	4450 3975 4125 3975
Wire Wire Line
	4450 4075 4125 4075
Wire Wire Line
	4450 4175 4125 4175
Wire Wire Line
	4450 4275 4125 4275
Wire Wire Line
	4450 4375 4125 4375
Text Label 4125 3675 0    60   ~ 0
IO_A7
Text Label 4125 3775 0    60   ~ 0
IO_A6
Text Label 4125 3875 0    60   ~ 0
IO_A5
Text Label 4125 3975 0    60   ~ 0
IO_A4
Text Label 4125 4075 0    60   ~ 0
IO_A3
Text Label 4125 4175 0    60   ~ 0
IO_A2
Text Label 4125 4275 0    60   ~ 0
IO_A1
Text Label 4125 4375 0    60   ~ 0
IO_A0
Entry Wire Line
	4025 3775 4125 3675
Entry Wire Line
	4025 3875 4125 3775
Entry Wire Line
	4025 3975 4125 3875
Entry Wire Line
	4025 4075 4125 3975
Entry Wire Line
	4025 4175 4125 4075
Entry Wire Line
	4025 4275 4125 4175
Entry Wire Line
	4025 4375 4125 4275
Entry Wire Line
	4025 4475 4125 4375
Wire Bus Line
	4025 3775 4025 4625
Text Label 4750 6100 2    60   ~ 0
IO_A[0..7]
Wire Wire Line
	5450 3875 5900 3875
Wire Wire Line
	5450 4075 5900 4075
$Comp
L VCC #PWR53
U 1 1 5933EB38
P 5450 3975
F 0 "#PWR53" H 5450 3825 50  0001 C CNN
F 1 "VCC" H 5450 4125 50  0000 C CNN
F 2 "" H 5450 3975 50  0001 C CNN
F 3 "" H 5450 3975 50  0001 C CNN
	1    5450 3975
	0    1    1    0   
$EndComp
Text HLabel 5900 3875 2    60   Input ~ 0
V2CA2
Text HLabel 5900 4075 2    60   Input ~ 0
V2CA1
NoConn ~ 5450 4175
Wire Wire Line
	5450 4275 5900 4275
Wire Wire Line
	5450 4375 5900 4375
Text HLabel 5900 4275 2    60   Input ~ 0
~RES
Text HLabel 5900 4375 2    60   Input ~ 0
CLK
$Comp
L VCC #PWR47
U 1 1 593F1705
P 2475 5775
F 0 "#PWR47" H 2475 5625 50  0001 C CNN
F 1 "VCC" H 2475 5925 50  0000 C CNN
F 2 "" H 2475 5775 50  0001 C CNN
F 3 "" H 2475 5775 50  0001 C CNN
	1    2475 5775
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR46
U 1 1 593F170B
P 2475 4875
F 0 "#PWR46" H 2475 4625 50  0001 C CNN
F 1 "GND" H 2475 4725 50  0000 C CNN
F 2 "" H 2475 4875 50  0001 C CNN
F 3 "" H 2475 4875 50  0001 C CNN
	1    2475 4875
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 5275 2690 5205
Wire Wire Line
	2650 5375 2690 5305
Wire Wire Line
	2650 5475 2690 5405
Wire Wire Line
	2650 5575 2690 5505
Wire Wire Line
	2690 5205 3150 5205
Wire Wire Line
	2690 5305 3150 5305
Wire Wire Line
	2690 5405 3150 5405
Wire Wire Line
	2690 5505 3150 5505
Wire Wire Line
	3150 5205 4025 5025
Wire Wire Line
	3150 5305 4025 5275
Wire Wire Line
	3150 5405 4025 5525
Wire Wire Line
	3150 5505 4025 5775
Wire Wire Line
	4025 5150 3150 5275
Wire Wire Line
	4025 5400 3150 5375
Wire Wire Line
	4025 5650 3150 5475
Wire Wire Line
	4025 5900 3150 5575
Wire Wire Line
	3150 5775 3150 5675
Wire Wire Line
	2475 5775 3150 5775
Wire Wire Line
	2650 5775 2650 5675
Wire Wire Line
	3150 4875 3150 5075
Wire Wire Line
	2475 4875 3150 4875
Wire Wire Line
	2650 4875 2650 5075
Connection ~ 2650 5775
Connection ~ 2650 4875
Text Label 4025 5025 2    60   ~ 0
IO_A0
Text Label 4025 5150 2    60   ~ 0
IO_A1
Text Label 4025 5275 2    60   ~ 0
IO_A2
Text Label 4025 5400 2    60   ~ 0
IO_A3
Text Label 4025 5525 2    60   ~ 0
IO_A4
Text Label 4025 5650 2    60   ~ 0
IO_A5
Text Label 4025 5775 2    60   ~ 0
IO_A6
Text Label 4025 5900 2    60   ~ 0
IO_A7
$Comp
L CONN_02X07 J6
U 1 1 593F16FE
P 2900 5375
F 0 "J6" H 2900 5775 50  0000 C CNN
F 1 "AY-IO" V 2900 5375 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_14pins" H 2900 4175 50  0001 C CNN
F 3 "" H 2900 4175 50  0001 C CNN
	1    2900 5375
	1    0    0    -1  
$EndComp
NoConn ~ 3150 5175
NoConn ~ 2650 5175
Wire Bus Line
	4025 4600 4025 6100
Wire Bus Line
	4025 6100 4750 6100
$Comp
L C C22
U 1 1 593A070B
P 5100 4625
F 0 "C22" H 5125 4725 50  0000 L CNN
F 1 "C" H 5125 4525 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 5138 4475 50  0001 C CNN
F 3 "" H 5100 4625 50  0001 C CNN
	1    5100 4625
	0    1    1    0   
$EndComp
Wire Wire Line
	5250 4625 7125 4625
Wire Wire Line
	7125 4625 7125 2825
Wire Wire Line
	7125 2825 4950 2825
$EndSCHEMATC
