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
Sheet 6 8
Title "Power supply and mounting holes"
Date "2017-06-07"
Rev "0.1"
Comp "Linux Grotto"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Mounting_Hole MK3
U 1 1 59149E60
P 1825 3025
F 0 "MK3" H 1825 3225 50  0000 C CNN
F 1 "Mounting_Hole" H 1825 3150 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 1825 3025 50  0001 C CNN
F 3 "" H 1825 3025 50  0001 C CNN
	1    1825 3025
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK4
U 1 1 59149E83
P 1825 3450
F 0 "MK4" H 1825 3650 50  0000 C CNN
F 1 "Mounting_Hole" H 1825 3575 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 1825 3450 50  0001 C CNN
F 3 "" H 1825 3450 50  0001 C CNN
	1    1825 3450
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK5
U 1 1 5932DD04
P 1125 3950
F 0 "MK5" H 1125 4150 50  0000 C CNN
F 1 "Mounting_Hole" H 1125 4075 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 1125 3950 50  0001 C CNN
F 3 "" H 1125 3950 50  0001 C CNN
	1    1125 3950
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK6
U 1 1 5932DD62
P 1825 3950
F 0 "MK6" H 1825 4150 50  0000 C CNN
F 1 "Mounting_Hole" H 1825 4075 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 1825 3950 50  0001 C CNN
F 3 "" H 1825 3950 50  0001 C CNN
	1    1825 3950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR43
U 1 1 5938552A
P 3225 2275
F 0 "#PWR43" H 3225 2025 50  0001 C CNN
F 1 "GND" H 3225 2125 50  0000 C CNN
F 2 "" H 3225 2275 50  0001 C CNN
F 3 "" H 3225 2275 50  0001 C CNN
	1    3225 2275
	1    0    0    -1  
$EndComp
$Comp
L BARREL_JACK J4
U 1 1 5930508B
P 1050 2000
F 0 "J4" H 1050 2195 50  0000 C CNN
F 1 "BARREL_JACK" H 1050 1800 50  0000 C CNN
F 2 "Connect:BARREL_JACK" H 1050 2000 50  0001 C CNN
F 3 "" H 1050 2000 50  0001 C CNN
	1    1050 2000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR44
U 1 1 58D5EE10
P 3600 1650
F 0 "#PWR44" H 3600 1500 50  0001 C CNN
F 1 "VCC" H 3600 1800 50  0000 C CNN
F 2 "" H 3600 1650 50  0001 C CNN
F 3 "" H 3600 1650 50  0001 C CNN
	1    3600 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 2275 3225 2275
Wire Wire Line
	2425 1650 1900 1650
Wire Wire Line
	1350 1900 1900 1900
Wire Wire Line
	1900 1900 1900 1650
Wire Wire Line
	1350 2100 1900 2100
Wire Wire Line
	1900 2100 1900 2275
Wire Wire Line
	3225 1650 3600 1650
Wire Wire Line
	2825 2275 2825 1950
Connection ~ 2825 2275
Connection ~ 2425 2275
Wire Wire Line
	3225 2275 3225 2125
Wire Wire Line
	3225 1650 3225 1925
Wire Wire Line
	2425 1900 2425 1650
Wire Wire Line
	2425 2100 2425 2275
$Comp
L CP1_Small C7
U 1 1 58D5E9AB
P 2425 2000
F 0 "C7" H 2435 2070 50  0000 L CNN
F 1 "100 uF" H 2435 1920 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D6.3mm_P2.50mm" H 2425 2000 50  0001 C CNN
F 3 "" H 2425 2000 50  0001 C CNN
	1    2425 2000
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C8
U 1 1 58D5EA6C
P 3225 2025
F 0 "C8" H 3235 2095 50  0000 L CNN
F 1 "10 uF" H 3235 1945 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.00mm" H 3225 2025 50  0001 C CNN
F 3 "" H 3225 2025 50  0001 C CNN
	1    3225 2025
	1    0    0    -1  
$EndComp
$Comp
L LM7805CT-RESCUE-pluto U11
U 1 1 58E10ED4
P 2825 1700
F 0 "U11" H 2625 1900 50  0000 C CNN
F 1 "LM7805CT" H 2825 1900 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Vertical" H 2825 1800 50  0001 C CIN
F 3 "" H 2825 1700 50  0001 C CNN
	1    2825 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 2000 1350 2100
$Comp
L +9V #PWR42
U 1 1 593AD94D
P 1900 1650
F 0 "#PWR42" H 1900 1500 50  0001 C CNN
F 1 "+9V" H 1900 1790 50  0000 C CNN
F 2 "" H 1900 1650 50  0001 C CNN
F 3 "" H 1900 1650 50  0001 C CNN
	1    1900 1650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
