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
Sheet 6 6
Title "Expansion port, power supply and decoupling capacitators"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 "The expansion port is fully compatible with Daryl Rictor's SBC-2 v2.5"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LM7805 U11
U 1 1 58D5E978
P 2825 1700
F 0 "U11" H 2975 1504 50  0000 C CNN
F 1 "LM7805" H 2825 1900 50  0000 C CNN
F 2 "" H 2825 1700 50  0001 C CNN
F 3 "" H 2825 1700 50  0001 C CNN
	1    2825 1700
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C7
U 1 1 58D5E9AB
P 2425 2175
F 0 "C7" H 2435 2245 50  0000 L CNN
F 1 "100 uF" H 2435 2095 50  0000 L CNN
F 2 "" H 2425 2175 50  0001 C CNN
F 3 "" H 2425 2175 50  0001 C CNN
	1    2425 2175
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small C8
U 1 1 58D5EA6C
P 3225 2175
F 0 "C8" H 3235 2245 50  0000 L CNN
F 1 "10 uF" H 3235 2095 50  0000 L CNN
F 2 "" H 3225 2175 50  0001 C CNN
F 3 "" H 3225 2175 50  0001 C CNN
	1    3225 2175
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR22
U 1 1 58D5ED53
P 1900 2500
F 0 "#PWR22" H 1900 2250 50  0001 C CNN
F 1 "GND" H 1900 2350 50  0000 C CNN
F 2 "" H 1900 2500 50  0001 C CNN
F 3 "" H 1900 2500 50  0001 C CNN
	1    1900 2500
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR25
U 1 1 58D5EE10
P 5625 1650
F 0 "#PWR25" H 5625 1500 50  0001 C CNN
F 1 "VCC" H 5625 1800 50  0000 C CNN
F 2 "" H 5625 1650 50  0001 C CNN
F 3 "" H 5625 1650 50  0001 C CNN
	1    5625 1650
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 J4
U 1 1 58D74BEC
P 1300 2075
F 0 "J4" H 1300 2225 50  0000 C CNN
F 1 "POWER IN" H 1300 1875 50  0000 C CNN
F 2 "" H 1300 2075 50  0001 C CNN
F 3 "" H 1300 2075 50  0001 C CNN
	1    1300 2075
	-1   0    0    1   
$EndComp
Text Label 2025 1650 0    60   ~ 0
+9V
$Comp
L C_Small C9
U 1 1 58D74CC9
P 3550 1850
F 0 "C9" H 3560 1920 50  0000 L CNN
F 1 ".1uF" H 3560 1770 50  0000 L CNN
F 2 "" H 3550 1850 50  0001 C CNN
F 3 "" H 3550 1850 50  0001 C CNN
	1    3550 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C10
U 1 1 58D74D28
P 3800 1850
F 0 "C10" H 3810 1920 50  0000 L CNN
F 1 ".1uF" H 3810 1770 50  0000 L CNN
F 2 "" H 3800 1850 50  0001 C CNN
F 3 "" H 3800 1850 50  0001 C CNN
	1    3800 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C11
U 1 1 58D74D6D
P 4050 1850
F 0 "C11" H 4060 1920 50  0000 L CNN
F 1 ".1uF" H 4060 1770 50  0000 L CNN
F 2 "" H 4050 1850 50  0001 C CNN
F 3 "" H 4050 1850 50  0001 C CNN
	1    4050 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C14
U 1 1 58D74DA8
P 4800 1850
F 0 "C14" H 4810 1920 50  0000 L CNN
F 1 ".1uF" H 4810 1770 50  0000 L CNN
F 2 "" H 4800 1850 50  0001 C CNN
F 3 "" H 4800 1850 50  0001 C CNN
	1    4800 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C12
U 1 1 58D74DFB
P 4300 1850
F 0 "C12" H 4310 1920 50  0000 L CNN
F 1 ".1uF" H 4310 1770 50  0000 L CNN
F 2 "" H 4300 1850 50  0001 C CNN
F 3 "" H 4300 1850 50  0001 C CNN
	1    4300 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C13
U 1 1 58D74E20
P 4550 1850
F 0 "C13" H 4560 1920 50  0000 L CNN
F 1 ".1uF" H 4560 1770 50  0000 L CNN
F 2 "" H 4550 1850 50  0001 C CNN
F 3 "" H 4550 1850 50  0001 C CNN
	1    4550 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C16
U 1 1 58D74E77
P 5300 1850
F 0 "C16" H 5310 1920 50  0000 L CNN
F 1 ".1uF" H 5310 1770 50  0000 L CNN
F 2 "" H 5300 1850 50  0001 C CNN
F 3 "" H 5300 1850 50  0001 C CNN
	1    5300 1850
	1    0    0    -1  
$EndComp
$Comp
L C_Small C15
U 1 1 58D74EA0
P 5050 1850
F 0 "C15" H 5060 1920 50  0000 L CNN
F 1 ".1uF" H 5060 1770 50  0000 L CNN
F 2 "" H 5050 1850 50  0001 C CNN
F 3 "" H 5050 1850 50  0001 C CNN
	1    5050 1850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR26
U 1 1 58D7579D
P 5625 2025
F 0 "#PWR26" H 5625 1775 50  0001 C CNN
F 1 "GND" H 5625 1875 50  0000 C CNN
F 2 "" H 5625 2025 50  0001 C CNN
F 3 "" H 5625 2025 50  0001 C CNN
	1    5625 2025
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X25 J5
U 1 1 58D76145
P 3600 4925
F 0 "J5" H 3600 6225 50  0000 C CNN
F 1 "Expansion Port" V 3600 4925 50  0000 C CNN
F 2 "" H 3600 4175 50  0001 C CNN
F 3 "" H 3600 4175 50  0001 C CNN
	1    3600 4925
	1    0    0    -1  
$EndComp
Wire Wire Line
	2825 2500 2825 1950
Wire Wire Line
	2425 2275 2425 2500
Wire Wire Line
	1900 2500 3225 2500
Wire Wire Line
	3225 2500 3225 2275
Connection ~ 2825 2500
Connection ~ 2425 2500
Wire Wire Line
	3225 1650 3225 2075
Wire Wire Line
	2425 2075 2425 1650
Wire Wire Line
	2425 1650 1900 1650
Wire Wire Line
	1500 2025 1900 2025
Wire Wire Line
	1900 2025 1900 1650
Wire Wire Line
	1500 2125 1900 2125
Wire Wire Line
	1900 2125 1900 2500
Wire Wire Line
	3225 1650 5625 1650
Wire Wire Line
	3225 2025 5625 2025
Connection ~ 3225 2025
Wire Wire Line
	3550 1750 3550 1650
Connection ~ 3550 1650
Wire Wire Line
	3550 1950 3550 2025
Connection ~ 3550 2025
Wire Wire Line
	3800 1750 3800 1650
Connection ~ 3800 1650
Wire Wire Line
	3800 1950 3800 2025
Connection ~ 3800 2025
Wire Wire Line
	4050 1750 4050 1650
Connection ~ 4050 1650
Wire Wire Line
	4050 1950 4050 2025
Connection ~ 4050 2025
Wire Wire Line
	4300 1750 4300 1650
Connection ~ 4300 1650
Wire Wire Line
	4300 1950 4300 2025
Connection ~ 4300 2025
Wire Wire Line
	4550 1750 4550 1650
Connection ~ 4550 1650
Wire Wire Line
	4550 1950 4550 2025
Connection ~ 4550 2025
Wire Wire Line
	4800 1750 4800 1650
Connection ~ 4800 1650
Wire Wire Line
	4800 1950 4800 2025
Connection ~ 4800 2025
Wire Wire Line
	5050 1750 5050 1650
Connection ~ 5050 1650
Wire Wire Line
	5050 1950 5050 2025
Connection ~ 5050 2025
Wire Wire Line
	5300 1750 5300 1650
Connection ~ 5300 1650
Wire Wire Line
	5300 1950 5300 2025
Connection ~ 5300 2025
$Comp
L VCC #PWR23
U 1 1 58D7686C
P 3600 3500
F 0 "#PWR23" H 3600 3350 50  0001 C CNN
F 1 "VCC" H 3600 3650 50  0000 C CNN
F 2 "" H 3600 3500 50  0001 C CNN
F 3 "" H 3600 3500 50  0001 C CNN
	1    3600 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3725 3350 3500
Wire Wire Line
	3350 3500 3850 3500
Wire Wire Line
	3850 3500 3850 3725
Connection ~ 3600 3500
$Comp
L GND #PWR24
U 1 1 58D76B4A
P 3600 6325
F 0 "#PWR24" H 3600 6075 50  0001 C CNN
F 1 "GND" H 3600 6175 50  0000 C CNN
F 2 "" H 3600 6325 50  0001 C CNN
F 3 "" H 3600 6325 50  0001 C CNN
	1    3600 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 6125 3350 6325
Wire Wire Line
	3350 6325 3850 6325
Wire Wire Line
	3850 6325 3850 6125
Connection ~ 3600 6325
NoConn ~ 3850 3825
Text GLabel 2925 4825 0    60   Input ~ 0
A0
Text GLabel 2925 4675 0    60   Input ~ 0
A1
Text GLabel 2925 4525 0    60   Input ~ 0
A2
Text GLabel 2925 4375 0    60   Input ~ 0
A3
Text GLabel 2925 4225 0    60   Input ~ 0
A4
Text GLabel 2925 4075 0    60   Input ~ 0
A5
Text GLabel 2925 3925 0    60   Input ~ 0
A6
Text GLabel 2925 3775 0    60   Input ~ 0
A7
Text GLabel 4250 3775 2    60   Input ~ 0
A8
Text GLabel 4250 3925 2    60   Input ~ 0
A9
Text GLabel 4250 4375 2    60   Input ~ 0
A10
Text GLabel 4250 4075 2    60   Input ~ 0
A11
Text GLabel 2925 3625 0    60   Input ~ 0
A12
Text GLabel 4250 3625 2    60   Input ~ 0
A13
Text GLabel 2925 3475 0    60   Input ~ 0
A14
Text GLabel 4250 5275 2    60   Input ~ 0
A15
Text GLabel 4250 3475 2    60   Input ~ 0
~MWR
Text GLabel 4250 4225 2    60   Input ~ 0
~MRD
Text GLabel 4250 5425 2    60   Input ~ 0
~7F0X
Text GLabel 4250 5575 2    60   Input ~ 0
~7F2X
Text GLabel 4250 5725 2    60   Input ~ 0
~7F4X
Text GLabel 4250 5875 2    60   Input ~ 0
~7F6X
Text GLabel 4250 6025 2    60   Input ~ 0
~7F8X
Text GLabel 2925 4975 0    60   Input ~ 0
D0
Text GLabel 2925 5125 0    60   Input ~ 0
D1
Text GLabel 2925 5275 0    60   Input ~ 0
D2
Text GLabel 4250 5125 2    60   Input ~ 0
D3
Text GLabel 4250 4975 2    60   Input ~ 0
D4
Text GLabel 4250 4825 2    60   Input ~ 0
D5
Text GLabel 4250 4675 2    60   Input ~ 0
D6
Text GLabel 4250 4525 2    60   Input ~ 0
D7
Text GLabel 2925 5575 0    60   Input ~ 0
~CLK
Text GLabel 2925 5725 0    60   Input ~ 0
~IRQ
Text GLabel 2925 5875 0    60   Input ~ 0
~7FXX
Text GLabel 2925 6025 0    60   Input ~ 0
~NMI
Text GLabel 2925 6175 0    60   Input ~ 0
R/~W
Text GLabel 2925 5425 0    60   Input ~ 0
~RES
NoConn ~ 3350 5125
NoConn ~ 3350 5225
NoConn ~ 3850 4625
NoConn ~ 3350 5925
NoConn ~ 3350 6025
Wire Wire Line
	3350 3825 2925 3475
Wire Wire Line
	3350 3925 2925 3625
Wire Wire Line
	3350 4025 2925 3775
Wire Wire Line
	3350 4125 2925 3925
Wire Wire Line
	3350 4225 2925 4075
Wire Wire Line
	3350 4325 2925 4225
Wire Wire Line
	3350 4425 2925 4375
Wire Wire Line
	3350 4525 2925 4525
Wire Wire Line
	3350 4625 2925 4675
Wire Wire Line
	3350 4725 2925 4825
Wire Wire Line
	3350 4825 2925 4975
Wire Wire Line
	3350 4925 2925 5125
Wire Wire Line
	3350 5025 2925 5275
Wire Wire Line
	2925 5425 3350 5325
Wire Wire Line
	2925 5575 3350 5425
Wire Wire Line
	2925 5725 3350 5525
Wire Wire Line
	2925 5875 3350 5625
Wire Wire Line
	2925 6025 3350 5725
Wire Wire Line
	2925 6175 3350 5825
Wire Wire Line
	4250 3475 3850 3925
Wire Wire Line
	4250 3625 3850 4025
Wire Wire Line
	4250 3775 3850 4125
Wire Wire Line
	4250 3925 3850 4225
Wire Wire Line
	4250 4075 3850 4325
Wire Wire Line
	4250 4225 3850 4425
Wire Wire Line
	4250 4375 3850 4525
Wire Wire Line
	4250 4525 3850 4725
Wire Wire Line
	4250 4675 3850 4825
Wire Wire Line
	4250 4825 3850 4925
Wire Wire Line
	4250 4975 3850 5025
Wire Wire Line
	4250 5125 3850 5125
Wire Wire Line
	4250 5275 3850 5225
Wire Wire Line
	4250 5425 3850 5325
Wire Wire Line
	4250 5575 3850 5425
Wire Wire Line
	4250 5725 3850 5525
Wire Wire Line
	4250 5875 3850 5625
Wire Wire Line
	4250 6025 3850 5725
NoConn ~ 3850 5825
NoConn ~ 3850 5925
NoConn ~ 3850 6025
$EndSCHEMATC
