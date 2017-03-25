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
Sheet 4 6
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
P 3325 2850
F 0 "U6" H 3075 3900 60  0000 C CNN
F 1 "WD65C22" V 3325 2750 60  0000 C CNN
F 2 "" H 2825 3050 60  0000 C CNN
F 3 "" H 2825 3050 60  0000 C CNN
	1    3325 2850
	1    0    0    -1  
$EndComp
$Comp
L DS1511Y+ U7
U 1 1 58D61FB4
P 7875 2725
F 0 "U7" H 7700 3450 60  0000 C CNN
F 1 "DS1511Y+" V 7925 2725 60  0000 C CNN
F 2 "" H 7625 3175 60  0001 C CNN
F 3 "" H 7625 3175 60  0001 C CNN
	1    7875 2725
	1    0    0    -1  
$EndComp
Text GLabel 7075 1950 0    60   Input ~ 0
A0
Text GLabel 7075 2100 0    60   Input ~ 0
A1
Text GLabel 7075 2250 0    60   Input ~ 0
A2
Text GLabel 7075 2400 0    60   Input ~ 0
A3
Text GLabel 7075 2550 0    60   Input ~ 0
A4
Text GLabel 4375 2975 2    60   Input ~ 0
A0
Text GLabel 4375 3100 2    60   Input ~ 0
A1
Text GLabel 4375 3225 2    60   Input ~ 0
A2
Text GLabel 4375 3350 2    60   Input ~ 0
A3
Text GLabel 4375 1900 2    60   Input ~ 0
D0
Text GLabel 4375 2025 2    60   Input ~ 0
D1
Text GLabel 4375 2150 2    60   Input ~ 0
D2
Text GLabel 4375 2275 2    60   Input ~ 0
D3
Text GLabel 4375 2400 2    60   Input ~ 0
D4
Text GLabel 4375 2525 2    60   Input ~ 0
D5
Text GLabel 4375 2650 2    60   Input ~ 0
D6
Text GLabel 4375 2775 2    60   Input ~ 0
D7
$Comp
L CONN_02X07 J2
U 1 1 58D65CA0
P 1550 2425
F 0 "J2" H 1550 2825 50  0000 C CNN
F 1 "CONN_02X07" V 1550 2425 50  0000 C CNN
F 2 "" H 1550 1225 50  0001 C CNN
F 3 "" H 1550 1225 50  0001 C CNN
	1    1550 2425
	1    0    0    -1  
$EndComp
$Comp
L CONN_02X07 J3
U 1 1 58D65CF3
P 1550 3950
F 0 "J3" H 1550 4350 50  0000 C CNN
F 1 "CONN_02X07" V 1550 3950 50  0000 C CNN
F 2 "" H 1550 2750 50  0001 C CNN
F 3 "" H 1550 2750 50  0001 C CNN
	1    1550 3950
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR13
U 1 1 58D69383
P 1125 4350
F 0 "#PWR13" H 1125 4200 50  0001 C CNN
F 1 "VCC" H 1125 4500 50  0000 C CNN
F 2 "" H 1125 4350 50  0001 C CNN
F 3 "" H 1125 4350 50  0001 C CNN
	1    1125 4350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR12
U 1 1 58D6939F
P 1125 3450
F 0 "#PWR12" H 1125 3200 50  0001 C CNN
F 1 "GND" H 1125 3300 50  0000 C CNN
F 2 "" H 1125 3450 50  0001 C CNN
F 3 "" H 1125 3450 50  0001 C CNN
	1    1125 3450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR10
U 1 1 58D6973D
P 1125 1950
F 0 "#PWR10" H 1125 1700 50  0001 C CNN
F 1 "GND" H 1125 1800 50  0000 C CNN
F 2 "" H 1125 1950 50  0001 C CNN
F 3 "" H 1125 1950 50  0001 C CNN
	1    1125 1950
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR11
U 1 1 58D69759
P 1125 2825
F 0 "#PWR11" H 1125 2675 50  0001 C CNN
F 1 "VCC" H 1125 2975 50  0000 C CNN
F 2 "" H 1125 2825 50  0001 C CNN
F 3 "" H 1125 2825 50  0001 C CNN
	1    1125 2825
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR14
U 1 1 58D6982A
P 4275 3550
F 0 "#PWR14" H 4275 3400 50  0001 C CNN
F 1 "VCC" H 4275 3700 50  0000 C CNN
F 2 "" H 4275 3550 50  0001 C CNN
F 3 "" H 4275 3550 50  0001 C CNN
	1    4275 3550
	1    0    0    -1  
$EndComp
Text GLabel 4375 3675 2    60   Input ~ 0
~7FCX
Text GLabel 4375 4100 2    60   Input ~ 0
R/~W
Text GLabel 4375 4225 2    60   Input ~ 0
CLK
Text GLabel 4375 4350 2    60   Input ~ 0
~RES
$Comp
L D_Small D1
U 1 1 58D69B92
P 4275 4475
F 0 "D1" H 4300 4350 50  0000 L CNN
F 1 "D" H 4150 4325 50  0000 C BNN
F 2 "" V 4275 4475 50  0001 C CNN
F 3 "" V 4275 4475 50  0001 C CNN
	1    4275 4475
	1    0    0    -1  
$EndComp
Text GLabel 4375 4475 2    60   Input ~ 0
~IRQ
Text GLabel 8775 1800 2    60   Input ~ 0
D0
Text GLabel 8775 1950 2    60   Input ~ 0
D1
Text GLabel 8775 2100 2    60   Input ~ 0
D2
Text GLabel 8775 2250 2    60   Input ~ 0
D3
Text GLabel 8775 2400 2    60   Input ~ 0
D4
Text GLabel 8775 2550 2    60   Input ~ 0
D5
Text GLabel 8775 2700 2    60   Input ~ 0
D6
Text GLabel 8775 2850 2    60   Input ~ 0
D7
Text GLabel 7075 2750 0    60   Input ~ 0
~7FAX
Text GLabel 7075 2875 0    60   Input ~ 0
~MRD
Text GLabel 7075 2975 0    60   Input ~ 0
~MWR
Text GLabel 7075 3200 0    60   Input ~ 0
~IRQ
Text GLabel 7075 3325 0    60   Input ~ 0
~RES
Wire Wire Line
	7400 2550 7075 2550
Wire Wire Line
	7400 2450 7225 2450
Wire Wire Line
	7225 2450 7225 2400
Wire Wire Line
	7225 2400 7075 2400
Wire Wire Line
	7400 2350 7275 2350
Wire Wire Line
	7275 2350 7275 2250
Wire Wire Line
	7275 2250 7075 2250
Wire Wire Line
	7400 2250 7325 2250
Wire Wire Line
	7325 2250 7325 2100
Wire Wire Line
	7325 2100 7075 2100
Wire Wire Line
	7400 2150 7400 1950
Wire Wire Line
	7400 1950 7075 1950
Wire Wire Line
	4100 2975 4375 2975
Wire Wire Line
	4100 3100 4375 3100
Wire Wire Line
	4100 3225 4375 3225
Wire Wire Line
	4100 3350 4375 3350
Wire Wire Line
	4100 1900 4375 1900
Wire Wire Line
	4100 2150 4375 2150
Wire Wire Line
	4100 2275 4375 2275
Wire Wire Line
	4100 2525 4375 2525
Wire Wire Line
	4100 2650 4375 2650
Wire Wire Line
	4100 2400 4375 2400
Wire Wire Line
	4100 2775 4375 2775
Wire Wire Line
	4100 2025 4375 2025
Wire Wire Line
	2675 1900 1800 2155
Wire Wire Line
	1800 2155 1340 2155
Wire Wire Line
	1340 2155 1300 2225
Wire Wire Line
	2675 2150 1800 2255
Wire Wire Line
	1800 2255 1340 2255
Wire Wire Line
	1340 2255 1300 2325
Wire Wire Line
	1300 2425 1340 2350
Wire Wire Line
	1300 2525 1340 2450
Wire Wire Line
	1300 2625 1340 2550
Wire Wire Line
	2675 2400 1800 2350
Wire Wire Line
	1800 2350 1340 2350
Wire Wire Line
	1340 2450 1800 2450
Wire Wire Line
	1340 2550 1800 2550
Wire Wire Line
	1800 2450 2675 2650
Wire Wire Line
	1800 2550 2675 2900
Wire Wire Line
	2675 2025 1800 2225
Wire Wire Line
	2675 2275 1800 2325
Wire Wire Line
	2675 2525 1800 2425
Wire Wire Line
	2675 2775 1800 2525
Wire Wire Line
	2675 3025 1800 2625
Wire Wire Line
	1300 3750 1340 3680
Wire Wire Line
	1300 3850 1340 3780
Wire Wire Line
	1300 3950 1340 3880
Wire Wire Line
	1300 4050 1340 3980
Wire Wire Line
	1300 4150 1340 4080
Wire Wire Line
	1340 3680 1800 3680
Wire Wire Line
	1340 3780 1800 3780
Wire Wire Line
	1340 3880 1800 3880
Wire Wire Line
	1340 3980 1800 3980
Wire Wire Line
	1340 4080 1800 4080
Wire Wire Line
	1800 3680 2675 3350
Wire Wire Line
	1800 3780 2675 3600
Wire Wire Line
	1800 3880 2675 3850
Wire Wire Line
	1800 3980 2675 4100
Wire Wire Line
	1800 4080 2675 4350
Wire Wire Line
	2675 3475 1800 3750
Wire Wire Line
	2675 3725 1800 3850
Wire Wire Line
	2675 3975 1800 3950
Wire Wire Line
	2675 4225 1800 4050
Wire Wire Line
	2675 4475 1800 4150
Wire Wire Line
	1800 4350 1800 4250
Wire Wire Line
	1125 4350 1800 4350
Wire Wire Line
	1300 4350 1300 4250
Wire Wire Line
	1800 3450 1800 3650
Wire Wire Line
	1125 3450 1800 3450
Wire Wire Line
	1300 3450 1300 3650
Connection ~ 1300 4350
Connection ~ 1300 3450
Wire Wire Line
	1800 2825 1800 2725
Wire Wire Line
	1125 2825 1800 2825
Wire Wire Line
	1300 2825 1300 2725
Connection ~ 1300 2825
Wire Wire Line
	1800 1950 1800 2125
Wire Wire Line
	1125 1950 1800 1950
Wire Wire Line
	1300 1950 1300 2125
Connection ~ 1300 1950
Wire Wire Line
	4100 3550 4275 3550
Wire Wire Line
	4100 3675 4375 3675
Wire Wire Line
	4100 4100 4375 4100
Wire Wire Line
	4100 4225 4375 4225
Wire Wire Line
	4100 4350 4375 4350
Wire Wire Line
	4100 4475 4175 4475
Wire Wire Line
	7075 2750 7400 2750
Wire Wire Line
	7400 2875 7075 2875
Wire Wire Line
	7400 2975 7075 2975
Wire Wire Line
	7400 3200 7075 3200
Wire Wire Line
	7400 3325 7075 3325
Wire Wire Line
	8450 2850 8775 2850
Wire Wire Line
	8450 2750 8725 2750
Wire Wire Line
	8725 2750 8725 2700
Wire Wire Line
	8725 2700 8775 2700
Wire Wire Line
	8450 2650 8700 2650
Wire Wire Line
	8700 2650 8700 2550
Wire Wire Line
	8700 2550 8775 2550
Wire Wire Line
	8450 2550 8650 2550
Wire Wire Line
	8650 2550 8650 2400
Wire Wire Line
	8650 2400 8775 2400
Wire Wire Line
	8450 2450 8600 2450
Wire Wire Line
	8600 2450 8600 2250
Wire Wire Line
	8600 2250 8775 2250
Wire Wire Line
	8450 2350 8550 2350
Wire Wire Line
	8550 2350 8550 2100
Wire Wire Line
	8550 2100 8775 2100
Wire Wire Line
	8450 2250 8500 2250
Wire Wire Line
	8500 2250 8500 1950
Wire Wire Line
	8500 1950 8775 1950
Wire Wire Line
	8450 2150 8450 2150
Wire Wire Line
	8450 2150 8450 1800
Wire Wire Line
	8450 1800 8775 1800
$Comp
L GND #PWR15
U 1 1 58D6B152
P 7825 3725
F 0 "#PWR15" H 7825 3475 50  0001 C CNN
F 1 "GND" H 7825 3575 50  0000 C CNN
F 2 "" H 7825 3725 50  0001 C CNN
F 3 "" H 7825 3725 50  0001 C CNN
	1    7825 3725
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 3725 7825 3725
$Comp
L VCC #PWR16
U 1 1 58D6B2C3
P 7900 1850
F 0 "#PWR16" H 7900 1700 50  0001 C CNN
F 1 "VCC" H 7900 2000 50  0000 C CNN
F 2 "" H 7900 1850 50  0001 C CNN
F 3 "" H 7900 1850 50  0001 C CNN
	1    7900 1850
	1    0    0    -1  
$EndComp
NoConn ~ 8450 3100
NoConn ~ 8450 3225
NoConn ~ 8450 3350
Text GLabel 8775 2975 2    60   Input ~ 0
~PWR
Wire Wire Line
	8450 2975 8775 2975
Text Notes 3425 4925 0    60   ~ 0
The intention is to use a WDC65C22\nso a diod has been added.
$EndSCHEMATC
