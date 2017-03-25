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
LIBS:pluto-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 6
Title "ACIA, MAX232 and serial port connector"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 "The ACIA is hardwired to use RTS/CTS hardware handshake"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 6551 U5
U 1 1 58D6F1F8
P 7975 3150
F 0 "U5" H 7750 4475 60  0000 C CNN
F 1 "6551" V 7975 3150 60  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm" H 8025 2475 60  0001 C CNN
F 3 "" H 8025 2475 60  0001 C CNN
	1    7975 3150
	1    0    0    -1  
$EndComp
$Comp
L MAX232 U4
U 1 1 58D6F2A1
P 4500 3150
F 0 "U4" H 4950 2075 50  0000 R CNN
F 1 "MAX232" H 4400 4200 50  0000 R CNN
F 2 "Housings_DIP:DIP-16_W7.62mm" H 4550 2100 50  0001 L CNN
F 3 "" H 4500 3250 50  0001 C CNN
	1    4500 3150
	-1   0    0    1   
$EndComp
Text GLabel 9150 1950 2    60   Input ~ 0
D0
Text GLabel 9150 2075 2    60   Input ~ 0
D1
Text GLabel 9150 2200 2    60   Input ~ 0
D2
Text GLabel 9150 2325 2    60   Input ~ 0
D3
Text GLabel 9150 2450 2    60   Input ~ 0
D4
Text GLabel 9150 2575 2    60   Input ~ 0
D5
Text GLabel 9150 2700 2    60   Input ~ 0
D6
Text GLabel 9150 2825 2    60   Input ~ 0
D7
Text GLabel 9150 3100 2    60   Input ~ 0
A0
Text GLabel 9150 3225 2    60   Input ~ 0
A1
$Comp
L VCC #PWR01
U 1 1 58D6F59A
P 9500 3475
F 0 "#PWR01" H 9500 3325 50  0001 C CNN
F 1 "VCC" H 9500 3625 50  0000 C CNN
F 2 "" H 9500 3475 50  0001 C CNN
F 3 "" H 9500 3475 50  0001 C CNN
	1    9500 3475
	1    0    0    -1  
$EndComp
Text GLabel 9150 3600 2    60   Input ~ 0
~7FEX
Text GLabel 9150 3725 2    60   Input ~ 0
R/~W
$Comp
L CRYSTAL XTAL1
U 1 1 58D70208
P 6925 2050
F 0 "XTAL1" V 6900 2250 60  0000 C CNN
F 1 "1.8432 MHz" V 6750 2050 60  0000 C CNN
F 2 "Crystals:Resonator-2pin_w10.0mm_h5.0mm" H 6825 2050 60  0001 C CNN
F 3 "" H 6925 2150 60  0001 C CNN
	1    6925 2050
	0    1    1    0   
$EndComp
$Comp
L C_Small C6
U 1 1 58D702B2
P 6450 2050
F 0 "C6" H 6550 2100 50  0000 L CNN
F 1 "22pF" H 6200 2125 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 6450 2050 50  0001 C CNN
F 3 "" H 6450 2050 50  0001 C CNN
	1    6450 2050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 58D7044A
P 6450 2150
F 0 "#PWR02" H 6450 1900 50  0001 C CNN
F 1 "GND" H 6450 2000 50  0000 C CNN
F 2 "" H 6450 2150 50  0001 C CNN
F 3 "" H 6450 2150 50  0001 C CNN
	1    6450 2150
	1    0    0    -1  
$EndComp
Text GLabel 9150 3925 2    60   Input ~ 0
~RES
Text GLabel 9150 4050 2    60   Input ~ 0
~IRQ
Text GLabel 9150 4175 2    60   Input ~ 0
CLK
$Comp
L CP1_Small C3
U 1 1 58D70A7A
P 3575 3950
F 0 "C3" H 3650 3900 50  0000 L CNN
F 1 "4.7uF" H 3650 4050 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.50mm" H 3575 3950 50  0001 C CNN
F 3 "" H 3575 3950 50  0001 C CNN
	1    3575 3950
	-1   0    0    1   
$EndComp
$Comp
L CP1_Small C2
U 1 1 58D70B45
P 3475 3550
F 0 "C2" V 3425 3375 50  0000 L CNN
F 1 "10uF" V 3600 3325 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.50mm" H 3475 3550 50  0001 C CNN
F 3 "" H 3475 3550 50  0001 C CNN
	1    3475 3550
	0    1    1    0   
$EndComp
$Comp
L CP1_Small C1
U 1 1 58D70BD2
P 3475 3250
F 0 "C1" V 3550 3325 50  0000 L CNN
F 1 "10uF" V 3350 3275 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.50mm" H 3475 3250 50  0001 C CNN
F 3 "" H 3475 3250 50  0001 C CNN
	1    3475 3250
	0    -1   -1   0   
$EndComp
$Comp
L CP1_Small C4
U 1 1 58D70C29
P 4925 4600
F 0 "C4" H 4935 4670 50  0000 L CNN
F 1 "10uF" H 4935 4520 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.50mm" H 4925 4600 50  0001 C CNN
F 3 "" H 4925 4600 50  0001 C CNN
	1    4925 4600
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C5
U 1 1 58D70C4E
P 5425 3950
F 0 "C5" H 5275 3875 50  0000 L CNN
F 1 "4.7uF" H 5150 4025 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.50mm" H 5425 3950 50  0001 C CNN
F 3 "" H 5425 3950 50  0001 C CNN
	1    5425 3950
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR03
U 1 1 58D716F3
P 3050 3250
F 0 "#PWR03" H 3050 3000 50  0001 C CNN
F 1 "GND" H 3050 3100 50  0000 C CNN
F 2 "" H 3050 3250 50  0001 C CNN
F 3 "" H 3050 3250 50  0001 C CNN
	1    3050 3250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR04
U 1 1 58D7177E
P 4500 4625
F 0 "#PWR04" H 4500 4475 50  0001 C CNN
F 1 "VCC" H 4500 4775 50  0000 C CNN
F 2 "" H 4500 4625 50  0001 C CNN
F 3 "" H 4500 4625 50  0001 C CNN
	1    4500 4625
	-1   0    0    1   
$EndComp
$Comp
L CONN_02X05 J1
U 1 1 58D71D6B
P 2075 2650
F 0 "J1" H 2075 2950 50  0000 C CNN
F 1 "Serial Port" H 2075 2350 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x05_Pitch2.54mm" H 2075 1450 50  0001 C CNN
F 3 "" H 2075 1450 50  0001 C CNN
	1    2075 2650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 58D71F12
P 1650 3150
F 0 "#PWR05" H 1650 2900 50  0001 C CNN
F 1 "GND" H 1650 3000 50  0000 C CNN
F 2 "" H 1650 3150 50  0001 C CNN
F 3 "" H 1650 3150 50  0001 C CNN
	1    1650 3150
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole_PAD Pad1
U 1 1 58D7281F
P 1475 3200
F 0 "Pad1" H 1475 3450 50  0000 C CNN
F 1 "RI" H 1475 3375 50  0000 C CNN
F 2 "Wire_Pads:SolderWirePad_single_0-8mmDrill" H 1475 3200 50  0001 C CNN
F 3 "" H 1475 3200 50  0001 C CNN
	1    1475 3200
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR06
U 1 1 58D72DB3
P 4925 4700
F 0 "#PWR06" H 4925 4450 50  0001 C CNN
F 1 "GND" H 4925 4550 50  0000 C CNN
F 2 "" H 4925 4700 50  0001 C CNN
F 3 "" H 4925 4700 50  0001 C CNN
	1    4925 4700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 58D73252
P 4500 1950
F 0 "#PWR07" H 4500 1700 50  0001 C CNN
F 1 "GND" H 4500 1800 50  0000 C CNN
F 2 "" H 4500 1950 50  0001 C CNN
F 3 "" H 4500 1950 50  0001 C CNN
	1    4500 1950
	-1   0    0    1   
$EndComp
Wire Wire Line
	8675 1950 9150 1950
Wire Wire Line
	8675 2075 9150 2075
Wire Wire Line
	8675 2200 9150 2200
Wire Wire Line
	8675 2325 9150 2325
Wire Wire Line
	8675 2450 9150 2450
Wire Wire Line
	8675 2575 9150 2575
Wire Wire Line
	8675 2700 9150 2700
Wire Wire Line
	8675 2825 9150 2825
Wire Wire Line
	8675 3100 9150 3100
Wire Wire Line
	8675 3225 9150 3225
Wire Wire Line
	8675 3475 9500 3475
Wire Wire Line
	8675 3600 9150 3600
Wire Wire Line
	8675 3725 9150 3725
Wire Wire Line
	6450 1950 7275 1950
Connection ~ 6925 1950
Wire Wire Line
	7275 2075 7150 2075
Wire Wire Line
	7150 2075 6925 2150
Wire Wire Line
	8675 4050 9150 4050
Wire Wire Line
	8675 4175 9150 4175
Wire Wire Line
	8675 3925 9150 3925
Wire Wire Line
	5300 4050 5425 4050
Wire Wire Line
	5425 3850 5300 3750
Wire Wire Line
	3700 4050 3575 4050
Wire Wire Line
	3575 3850 3700 3750
Wire Wire Line
	3700 3250 3575 3250
Wire Wire Line
	3375 3250 3050 3250
Wire Wire Line
	1825 2650 1650 2650
Wire Wire Line
	1650 2650 1650 3150
Wire Wire Line
	3700 3550 3575 3550
Wire Wire Line
	1825 2850 1475 2850
Wire Wire Line
	1475 2850 1475 3100
Wire Wire Line
	4500 4350 4500 4625
Wire Wire Line
	3050 4500 4925 4500
Connection ~ 4500 4500
Wire Wire Line
	3375 3550 3050 3550
Wire Wire Line
	3050 3550 3050 4500
Wire Wire Line
	2325 2450 3700 2450
Wire Wire Line
	1825 2550 1725 2550
Wire Wire Line
	1725 2550 1725 2275
Wire Wire Line
	1725 2275 3475 2275
Wire Wire Line
	3475 2275 3475 2850
Wire Wire Line
	3475 2850 3700 2850
Wire Wire Line
	1825 2750 1750 2750
Wire Wire Line
	1750 2750 1750 3050
Wire Wire Line
	1750 3050 3700 3050
Wire Wire Line
	2325 2750 2925 2750
Wire Wire Line
	2925 2750 2925 2650
Wire Wire Line
	2925 2650 3700 2650
NoConn ~ 2325 2550
NoConn ~ 2325 2650
NoConn ~ 2325 2850
NoConn ~ 1825 2450
Wire Wire Line
	5300 2450 7275 2450
Wire Wire Line
	6650 2300 7275 2300
Wire Wire Line
	5300 3050 6850 3050
Wire Wire Line
	6850 3050 6850 2700
Wire Wire Line
	6850 2700 7275 2700
Wire Wire Line
	5300 2650 6300 2650
Wire Wire Line
	6300 2650 6300 2900
Wire Wire Line
	6300 2900 7275 2900
Wire Wire Line
	5300 2850 5925 2850
Wire Wire Line
	5925 2850 5925 2550
Wire Wire Line
	5925 2550 6650 2550
Wire Wire Line
	6650 2550 6650 2300
$Comp
L GND #PWR08
U 1 1 58D744C7
P 7275 3925
F 0 "#PWR08" H 7275 3675 50  0001 C CNN
F 1 "GND" H 7275 3775 50  0000 C CNN
F 2 "" H 7275 3925 50  0001 C CNN
F 3 "" H 7275 3925 50  0001 C CNN
	1    7275 3925
	0    1    1    0   
$EndComp
$Comp
L GND #PWR09
U 1 1 58D74507
P 7275 3500
F 0 "#PWR09" H 7275 3250 50  0001 C CNN
F 1 "GND" H 7275 3350 50  0000 C CNN
F 2 "" H 7275 3500 50  0001 C CNN
F 3 "" H 7275 3500 50  0001 C CNN
	1    7275 3500
	0    1    1    0   
$EndComp
NoConn ~ 7275 3275
NoConn ~ 7275 4175
$Comp
L GND #PWR010
U 1 1 58D84381
P 7975 4800
F 0 "#PWR010" H 7975 4550 50  0001 C CNN
F 1 "GND" H 7975 4650 50  0000 C CNN
F 2 "" H 7975 4800 50  0001 C CNN
F 3 "" H 7975 4800 50  0001 C CNN
	1    7975 4800
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR011
U 1 1 58D845E7
P 7975 1600
F 0 "#PWR011" H 7975 1450 50  0001 C CNN
F 1 "VCC" H 7975 1750 50  0000 C CNN
F 2 "" H 7975 1600 50  0001 C CNN
F 3 "" H 7975 1600 50  0001 C CNN
	1    7975 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7975 4675 7975 4800
$EndSCHEMATC
