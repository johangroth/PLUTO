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
$Descr A3 16535 11693
encoding utf-8
Sheet 8 8
Title "IDE interface for PLUTO"
Date "2016-11-07"
Rev "V1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74HC74 U18
U 1 1 5932FB20
P 3900 2550
F 0 "U18" H 4050 2850 50  0000 C CNN
F 1 "74HC74" H 4200 2255 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 3900 2550 50  0001 C CNN
F 3 "" H 3900 2550 50  0000 C CNN
	1    3900 2550
	1    0    0    -1  
$EndComp
$Comp
L 74HC74 U18
U 2 1 5932FB21
P 3900 4200
F 0 "U18" H 4050 4500 50  0000 C CNN
F 1 "74HC74" H 4200 3905 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 3900 4200 50  0001 C CNN
F 3 "" H 3900 4200 50  0000 C CNN
	2    3900 4200
	1    0    0    -1  
$EndComp
$Comp
L 74LS139 U17
U 1 1 5932FB22
P 3850 1200
F 0 "U17" H 3850 1300 50  0000 C CNN
F 1 "74LS139" H 3850 1100 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 3850 1200 50  0001 C CNN
F 3 "" H 3850 1200 50  0000 C CNN
	1    3850 1200
	1    0    0    -1  
$EndComp
$Comp
L 74LS139 U17
U 2 1 5932FB23
P 3850 5600
F 0 "U17" H 3850 5700 50  0000 C CNN
F 1 "74LS139" H 3850 5500 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 3850 5600 50  0001 C CNN
F 3 "" H 3850 5600 50  0000 C CNN
	2    3850 5600
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U16
U 1 1 5932FB24
P 2100 2350
F 0 "U16" H 2100 2400 50  0000 C CNN
F 1 "74LS32" H 2100 2300 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 2100 2350 50  0001 C CNN
F 3 "" H 2100 2350 50  0000 C CNN
	1    2100 2350
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U16
U 2 1 5932FB25
P 2100 4000
F 0 "U16" H 2100 4050 50  0000 C CNN
F 1 "74LS32" H 2100 3950 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 2100 4000 50  0001 C CNN
F 3 "" H 2100 4000 50  0000 C CNN
	2    2100 4000
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U16
U 4 1 5932FB26
P 8900 2450
F 0 "U16" H 8900 2500 50  0000 C CNN
F 1 "74LS32" H 8900 2400 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 8900 2450 50  0001 C CNN
F 3 "" H 8900 2450 50  0000 C CNN
	4    8900 2450
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U16
U 3 1 5932FB27
P 6000 6600
F 0 "U16" H 6000 6650 50  0000 C CNN
F 1 "74LS32" H 6000 6550 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6000 6600 50  0001 C CNN
F 3 "" H 6000 6600 50  0000 C CNN
	3    6000 6600
	1    0    0    -1  
$EndComp
$Comp
L 74LS08 U19
U 2 1 5932FB28
P 7550 2550
F 0 "U19" H 7550 2600 50  0000 C CNN
F 1 "74LS08" H 7550 2500 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 7550 2550 50  0001 C CNN
F 3 "" H 7550 2550 50  0000 C CNN
	2    7550 2550
	1    0    0    -1  
$EndComp
$Comp
L 74LS574 U20
U 1 1 5932FB29
P 12375 2900
F 0 "U20" H 12375 2900 50  0000 C CNN
F 1 "74LS574" H 12425 2550 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12375 2900 50  0001 C CNN
F 3 "" H 12375 2900 50  0000 C CNN
	1    12375 2900
	-1   0    0    -1  
$EndComp
$Comp
L 74LS574 U21
U 1 1 5932FB2A
P 12400 5100
F 0 "U21" H 12400 5100 50  0000 C CNN
F 1 "74LS574" H 12450 4750 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12400 5100 50  0001 C CNN
F 3 "" H 12400 5100 50  0000 C CNN
	1    12400 5100
	1    0    0    -1  
$EndComp
$Comp
L 74HC245 U22
U 1 1 5932FB2B
P 12425 6900
F 0 "U22" H 12525 7475 50  0000 L BNN
F 1 "74HC245" H 12475 6325 50  0000 L TNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12425 6900 50  0001 C CNN
F 3 "" H 12425 6900 50  0000 C CNN
	1    12425 6900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR56
U 1 1 5932FB2C
P 1350 950
F 0 "#PWR56" H 1350 700 50  0001 C CNN
F 1 "GND" V 1350 775 50  0000 C CNN
F 2 "" H 1350 950 50  0000 C CNN
F 3 "" H 1350 950 50  0000 C CNN
	1    1350 950 
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR55
U 1 1 5932FB2D
P 1325 1650
F 0 "#PWR55" H 1325 1500 50  0001 C CNN
F 1 "VCC" V 1325 1825 50  0000 C CNN
F 2 "" H 1325 1650 50  0000 C CNN
F 3 "" H 1325 1650 50  0000 C CNN
	1    1325 1650
	0    -1   -1   0   
$EndComp
$Comp
L R R9
U 1 1 5932FB2E
P 1750 1650
F 0 "R9" V 1830 1650 50  0000 C CNN
F 1 "1k" V 1750 1650 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 1680 1650 50  0001 C CNN
F 3 "" H 1750 1650 50  0000 C CNN
	1    1750 1650
	0    1    1    0   
$EndComp
NoConn ~ 4500 2750
NoConn ~ 4500 4400
$Comp
L R R6
U 1 1 5932FB2F
P 1050 8250
F 0 "R6" V 1130 8250 50  0000 C CNN
F 1 "3.3K" V 1050 8250 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8250 50  0001 C CNN
F 3 "" H 1050 8250 50  0000 C CNN
	1    1050 8250
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 5932FB30
P 1050 8450
F 0 "R7" V 1130 8450 50  0000 C CNN
F 1 "1K" V 1050 8450 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8450 50  0001 C CNN
F 3 "" H 1050 8450 50  0000 C CNN
	1    1050 8450
	0    1    1    0   
$EndComp
$Comp
L R R8
U 1 1 5932FB31
P 1050 8650
F 0 "R8" V 1130 8650 50  0000 C CNN
F 1 "1K" V 1050 8650 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8650 50  0001 C CNN
F 3 "" H 1050 8650 50  0000 C CNN
	1    1050 8650
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR54
U 1 1 5932FB32
P 800 8050
F 0 "#PWR54" H 800 7900 50  0001 C CNN
F 1 "VCC" H 800 8200 50  0000 C CNN
F 2 "" H 800 8050 50  0000 C CNN
F 3 "" H 800 8050 50  0000 C CNN
	1    800  8050
	1    0    0    -1  
$EndComp
$Comp
L 74LS08 U19
U 1 1 5932FB33
P 6000 2450
F 0 "U19" H 6000 2500 50  0000 C CNN
F 1 "74LS08" H 6000 2400 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6000 2450 50  0001 C CNN
F 3 "" H 6000 2450 50  0000 C CNN
	1    6000 2450
	1    0    0    -1  
$EndComp
NoConn ~ 4700 5700
NoConn ~ 4700 5900
NoConn ~ 4700 5300
NoConn ~ 4700 1300
NoConn ~ 4700 1500
$Comp
L GND #PWR57
U 1 1 5932FB35
P 2150 6050
F 0 "#PWR57" H 2150 5800 50  0001 C CNN
F 1 "GND" H 2150 5900 50  0000 C CNN
F 2 "" H 2150 6050 50  0000 C CNN
F 3 "" H 2150 6050 50  0000 C CNN
	1    2150 6050
	1    0    0    -1  
$EndComp
Text Label 13575 2400 2    60   ~ 0
IDE-D8
Text Label 13575 2500 2    60   ~ 0
IDE-D9
Text Label 13575 2600 2    60   ~ 0
IDE-D10
Text Label 13575 2700 2    60   ~ 0
IDE-D11
Text Label 13575 2800 2    60   ~ 0
IDE-D12
Text Label 13575 2900 2    60   ~ 0
IDE-D13
Text Label 13575 3000 2    60   ~ 0
IDE-D14
Text Label 13575 3100 2    60   ~ 0
IDE-D15
Text Label 13575 4600 2    60   ~ 0
IDE-D8
Text Label 13575 4700 2    60   ~ 0
IDE-D9
Text Label 13575 4800 2    60   ~ 0
IDE-D10
Text Label 13575 4900 2    60   ~ 0
IDE-D11
Text Label 13575 5000 2    60   ~ 0
IDE-D12
Text Label 13575 5100 2    60   ~ 0
IDE-D13
Text Label 13575 5200 2    60   ~ 0
IDE-D14
Text Label 13575 5300 2    60   ~ 0
IDE-D15
Text Label 11350 2400 0    60   ~ 0
IDE-D0
Text Label 11350 2500 0    60   ~ 0
IDE-D1
Text Label 11350 2600 0    60   ~ 0
IDE-D2
Text Label 11350 2700 0    60   ~ 0
IDE-D3
Text Label 11350 2800 0    60   ~ 0
IDE-D4
Text Label 11350 2900 0    60   ~ 0
IDE-D5
Text Label 11350 3000 0    60   ~ 0
IDE-D6
Text Label 11350 3100 0    60   ~ 0
IDE-D7
Text Label 11350 4600 0    60   ~ 0
IDE-D0
Text Label 11350 4700 0    60   ~ 0
IDE-D1
Text Label 11350 4800 0    60   ~ 0
IDE-D2
Text Label 11350 4900 0    60   ~ 0
IDE-D3
Text Label 11350 5000 0    60   ~ 0
IDE-D4
Text Label 11350 5100 0    60   ~ 0
IDE-D5
Text Label 11350 5200 0    60   ~ 0
IDE-D6
Text Label 11350 5300 0    60   ~ 0
IDE-D7
Text Label 13475 6400 2    60   ~ 0
IDE-D0
Text Label 13475 6500 2    60   ~ 0
IDE-D1
Text Label 13475 6600 2    60   ~ 0
IDE-D2
Text Label 13475 6700 2    60   ~ 0
IDE-D3
Text Label 13475 6800 2    60   ~ 0
IDE-D4
Text Label 13475 6900 2    60   ~ 0
IDE-D5
Text Label 13475 7000 2    60   ~ 0
IDE-D6
Text Label 13475 7100 2    60   ~ 0
IDE-D7
Text Label 11325 6400 0    60   ~ 0
D0
Text Label 11325 6500 0    60   ~ 0
D1
Text Label 11325 6600 0    60   ~ 0
D2
Text Label 11325 6700 0    60   ~ 0
D3
Text Label 11325 6800 0    60   ~ 0
D4
Text Label 11325 6900 0    60   ~ 0
D5
Text Label 11325 7000 0    60   ~ 0
D6
Text Label 11325 7100 0    60   ~ 0
D7
$Comp
L CONN_02X20 P1
U 1 1 5932FB36
P 8375 9400
F 0 "P1" H 8375 10450 50  0000 C CNN
F 1 "IDE0" V 8375 9400 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_40pins" H 8375 8450 50  0001 C CNN
F 3 "" H 8375 8450 50  0000 C CNN
	1    8375 9400
	1    0    0    -1  
$EndComp
Text Label 7800 8450 0    60   ~ 0
~RES
Text Label 7725 8550 0    60   ~ 0
IDE-D7
Text Label 7725 8650 0    60   ~ 0
IDE-D6
Text Label 7725 8750 0    60   ~ 0
IDE-D5
Text Label 7725 8850 0    60   ~ 0
IDE-D4
Text Label 7725 8950 0    60   ~ 0
IDE-D3
Text Label 7725 9050 0    60   ~ 0
IDE-D2
Text Label 7725 9150 0    60   ~ 0
IDE-D1
Text Label 7725 9250 0    60   ~ 0
IDE-D0
Text Label 9125 8550 2    60   ~ 0
IDE-D8
Text Label 9125 8650 2    60   ~ 0
IDE-D9
Text Label 9125 8750 2    60   ~ 0
IDE-D10
Text Label 9125 8850 2    60   ~ 0
IDE-D11
Text Label 9125 8950 2    60   ~ 0
IDE-D12
Text Label 9125 9050 2    60   ~ 0
IDE-D13
Text Label 9125 9150 2    60   ~ 0
IDE-D14
Text Label 9125 9250 2    60   ~ 0
IDE-D15
NoConn ~ 8625 9350
Text Label 7725 9450 0    60   ~ 0
DMARQ
Text Label 7725 9550 0    60   ~ 0
~DIOW
Text Label 7725 9650 0    60   ~ 0
~DIOR
Text Label 7725 9750 0    60   ~ 0
IORDY
Text Label 7575 9850 0    60   ~ 0
~IDE:DMACK
Text Label 7725 9950 0    60   ~ 0
~IRQ
Text Label 7050 10050 0    60   ~ 0
A1
Text Label 7050 10150 0    60   ~ 0
A0
Text Label 9125 10150 2    60   ~ 0
A2
Text Label 7725 10250 0    60   ~ 0
~IDE:CS0
Text Label 7725 10350 0    60   ~ 0
~IDE:DASP
Text Label 9125 10250 2    60   ~ 0
~IDE:CS1
Text Label 9125 10350 2    60   ~ 0
GND
NoConn ~ 7725 9450
Text Label 7725 9350 0    60   ~ 0
GND
Text Label 9125 8450 2    60   ~ 0
GND
Text Label 9125 9450 2    60   ~ 0
GND
Text Label 9125 9550 2    60   ~ 0
GND
Text Label 9125 9650 2    60   ~ 0
GND
NoConn ~ 8625 9750
NoConn ~ 8625 10050
NoConn ~ 7725 9750
Text Label 9125 9850 2    60   ~ 0
GND
Text Label 1100 1100 0    60   ~ 0
A3
Text Label 1100 2250 0    60   ~ 0
~MRD
Text Label 1100 1950 0    60   ~ 0
CLK2
Text Label 1100 3100 0    60   ~ 0
~7F6X
Text Label 1100 4100 0    60   ~ 0
~MWR
Text Label 2100 8250 2    60   ~ 0
~IDE:DMACK
Text Label 2100 8450 2    60   ~ 0
~IDE:CS1
Text Label 2100 8650 2    60   ~ 0
~IDE:DASP
Text Label 9850 2450 2    60   ~ 0
~IDE:CS0
Text Label 9400 6050 2    60   ~ 0
~DIOR
Text Label 9400 6600 2    60   ~ 0
~DIOW
Text Label 9125 9950 2    60   ~ 0
GND
Wire Wire Line
	1325 1650 1600 1650
Wire Wire Line
	800  8050 800  8650
Wire Wire Line
	900  8450 800  8450
Connection ~ 800  8450
Wire Wire Line
	900  8250 800  8250
Connection ~ 800  8250
Wire Wire Line
	1200 8250 2100 8250
Wire Wire Line
	1200 8450 2100 8450
Wire Wire Line
	1100 2250 1500 2250
Wire Wire Line
	1350 950  3000 950 
Wire Wire Line
	800  8650 900  8650
Wire Wire Line
	1200 8650 1300 8650
Wire Wire Line
	1600 8650 2100 8650
Wire Wire Line
	4700 5500 11700 5500
Wire Wire Line
	6600 2450 6950 2450
Wire Wire Line
	6800 2450 6800 7400
Wire Wire Line
	6800 7400 11725 7400
Connection ~ 6800 2450
Wire Wire Line
	2700 2350 3300 2350
Wire Wire Line
	4500 2350 5400 2350
Wire Wire Line
	2700 4000 3300 4000
Wire Wire Line
	1100 4100 1500 4100
Wire Wire Line
	1500 2450 1500 4950
Wire Wire Line
	1500 4950 6400 4950
Wire Wire Line
	6400 4950 6400 2650
Wire Wire Line
	6400 2650 6950 2650
Connection ~ 1500 3900
Wire Wire Line
	1100 1100 3000 1100
Wire Wire Line
	4700 900  14125 900 
Wire Wire Line
	4700 1100 13875 1100
Wire Wire Line
	5400 2550 5400 6500
Wire Wire Line
	5400 5600 11700 5600
Connection ~ 5400 5600
Wire Wire Line
	3300 2550 3000 2550
Wire Wire Line
	3000 1950 3000 4200
Wire Wire Line
	3000 1950 1100 1950
Wire Wire Line
	3000 4200 3300 4200
Connection ~ 3000 2550
Wire Wire Line
	3900 1650 3900 2000
Wire Wire Line
	1900 1650 3900 1650
Wire Wire Line
	3900 3100 3200 3100
Wire Wire Line
	3200 1650 3200 4750
Connection ~ 3200 1650
Wire Wire Line
	3200 3650 3900 3650
Connection ~ 3200 3100
Wire Wire Line
	3200 4750 3900 4750
Connection ~ 3200 3650
Wire Wire Line
	4500 4000 5400 4000
Connection ~ 5400 4000
Wire Wire Line
	9400 6050 5200 6050
Wire Wire Line
	5200 2350 5200 7300
Connection ~ 5200 2350
Wire Wire Line
	5200 7300 11725 7300
Connection ~ 5200 6050
Wire Wire Line
	3000 5850 2800 5850
Wire Wire Line
	2800 4000 2800 6700
Connection ~ 2800 4000
Wire Wire Line
	2800 6700 5400 6700
Connection ~ 2800 5850
Wire Wire Line
	3000 5350 2150 5350
Wire Wire Line
	2150 5350 2150 6050
Wire Wire Line
	3000 5500 3000 4800
Wire Wire Line
	3000 4800 5000 4800
Wire Wire Line
	5000 4800 5000 700 
Wire Wire Line
	5000 700  2800 700 
Wire Wire Line
	2800 700  2800 1100
Connection ~ 2800 1100
Wire Wire Line
	8300 2350 8050 2350
Wire Wire Line
	8050 2350 8050 2100
Wire Wire Line
	8050 2100 5000 2100
Connection ~ 5000 2100
Wire Wire Line
	3000 1450 2800 1450
Wire Wire Line
	2800 1450 2800 2350
Connection ~ 2800 2350
Wire Wire Line
	1100 3100 1500 3100
Connection ~ 1500 3100
Wire Wire Line
	9500 2450 9850 2450
Wire Wire Line
	6600 6600 9400 6600
Wire Wire Line
	8150 2550 8300 2550
Wire Wire Line
	13075 2400 13575 2400
Wire Wire Line
	13075 2500 13575 2500
Wire Wire Line
	13075 2600 13575 2600
Wire Wire Line
	13075 2700 13575 2700
Wire Wire Line
	13075 2800 13575 2800
Wire Wire Line
	13075 2900 13575 2900
Wire Wire Line
	13075 3000 13575 3000
Wire Wire Line
	13075 3100 13575 3100
Wire Wire Line
	13100 4600 13575 4600
Wire Wire Line
	13100 4700 13575 4700
Wire Wire Line
	13100 4800 13575 4800
Wire Wire Line
	13100 4900 13575 4900
Wire Wire Line
	13100 5000 13575 5000
Wire Wire Line
	13100 5100 13575 5100
Wire Wire Line
	13100 5200 13575 5200
Wire Wire Line
	13100 5300 13575 5300
Wire Wire Line
	11675 2400 11350 2400
Wire Wire Line
	11675 2500 11350 2500
Wire Wire Line
	11675 2600 11350 2600
Wire Wire Line
	11675 2700 11350 2700
Wire Wire Line
	11675 2800 11350 2800
Wire Wire Line
	11675 2900 11350 2900
Wire Wire Line
	11675 3000 11350 3000
Wire Wire Line
	11675 3100 11350 3100
Wire Wire Line
	11700 4600 11350 4600
Wire Wire Line
	11700 4700 11350 4700
Wire Wire Line
	11700 4800 11350 4800
Wire Wire Line
	11700 4900 11350 4900
Wire Wire Line
	11700 5000 11350 5000
Wire Wire Line
	11700 5100 11350 5100
Wire Wire Line
	11700 5200 11350 5200
Wire Wire Line
	11700 5300 11350 5300
Wire Wire Line
	13125 6400 13475 6400
Wire Wire Line
	13125 6500 13475 6500
Wire Wire Line
	13125 6600 13475 6600
Wire Wire Line
	13125 6700 13475 6700
Wire Wire Line
	13125 6800 13475 6800
Wire Wire Line
	13125 6900 13475 6900
Wire Wire Line
	13125 7000 13475 7000
Wire Wire Line
	13125 7100 13475 7100
Wire Wire Line
	11725 6400 11325 6400
Wire Wire Line
	11725 6500 11325 6500
Wire Wire Line
	11725 6600 11325 6600
Wire Wire Line
	11725 6700 11325 6700
Wire Wire Line
	11725 6800 11325 6800
Wire Wire Line
	11725 6900 11325 6900
Wire Wire Line
	11725 7000 11325 7000
Wire Wire Line
	11725 7100 11325 7100
Wire Wire Line
	7725 8450 8125 8450
Wire Wire Line
	8125 8550 7725 8550
Wire Wire Line
	8125 8650 7725 8650
Wire Wire Line
	8125 8750 7725 8750
Wire Wire Line
	8125 8850 7725 8850
Wire Wire Line
	8125 8950 7725 8950
Wire Wire Line
	8125 9050 7725 9050
Wire Wire Line
	8125 9150 7725 9150
Wire Wire Line
	8125 9250 7725 9250
Wire Wire Line
	8125 9350 7725 9350
Wire Wire Line
	8125 9450 7725 9450
Wire Wire Line
	8125 9550 7725 9550
Wire Wire Line
	8125 9650 7725 9650
Wire Wire Line
	8125 9750 7725 9750
Wire Wire Line
	8125 9850 7575 9850
Wire Wire Line
	8125 10050 7050 10050
Wire Wire Line
	8125 10150 7050 10150
Wire Wire Line
	8125 10250 7725 10250
Wire Wire Line
	8125 10350 7725 10350
Wire Wire Line
	8625 8550 9125 8550
Wire Wire Line
	8625 8650 9125 8650
Wire Wire Line
	8625 8750 9125 8750
Wire Wire Line
	8625 8850 9125 8850
Wire Wire Line
	8625 8950 9125 8950
Wire Wire Line
	8625 9050 9125 9050
Wire Wire Line
	8625 9150 9125 9150
Wire Wire Line
	8625 9250 9125 9250
Wire Wire Line
	8625 9450 9400 9450
Wire Wire Line
	8625 9550 9400 9550
Wire Wire Line
	9400 9650 8625 9650
Wire Wire Line
	9400 9850 8625 9850
Wire Wire Line
	8625 10150 9125 10150
Wire Wire Line
	8625 10250 9125 10250
Wire Wire Line
	9400 10350 8625 10350
Wire Wire Line
	8625 8450 9125 8450
Wire Wire Line
	7050 9950 8125 9950
Wire Wire Line
	9400 9950 8625 9950
Entry Wire Line
	13575 2400 13675 2500
Entry Wire Line
	13575 2500 13675 2600
Entry Wire Line
	13575 2600 13675 2700
Entry Wire Line
	13575 2700 13675 2800
Entry Wire Line
	13575 2800 13675 2900
Entry Wire Line
	13575 2900 13675 3000
Entry Wire Line
	13575 3000 13675 3100
Entry Wire Line
	13575 3100 13675 3200
Entry Wire Line
	13575 4600 13675 4500
Entry Wire Line
	13575 4700 13675 4600
Entry Wire Line
	13575 4800 13675 4700
Entry Wire Line
	13575 4900 13675 4800
Entry Wire Line
	13575 5000 13675 4900
Entry Wire Line
	13575 5100 13675 5000
Entry Wire Line
	13575 5200 13675 5100
Entry Wire Line
	13575 5300 13675 5200
Entry Wire Line
	13475 6400 13575 6300
Entry Wire Line
	13475 6500 13575 6400
Entry Wire Line
	13475 6600 13575 6500
Entry Wire Line
	13475 6700 13575 6600
Entry Wire Line
	13475 6800 13575 6700
Entry Wire Line
	13475 6900 13575 6800
Entry Wire Line
	13475 7000 13575 6900
Entry Wire Line
	13475 7100 13575 7000
Text Notes 11950 3600 0    60   ~ 0
High byte from IDE\n
Text Notes 12025 5800 0    60   ~ 0
High byte to IDE
Entry Wire Line
	11250 2500 11350 2400
Entry Wire Line
	11250 2600 11350 2500
Entry Wire Line
	11250 2700 11350 2600
Entry Wire Line
	11250 2800 11350 2700
Entry Wire Line
	11250 2900 11350 2800
Entry Wire Line
	11250 3000 11350 2900
Entry Wire Line
	11250 3100 11350 3000
Entry Wire Line
	11250 3200 11350 3100
Entry Wire Line
	11250 4700 11350 4600
Entry Wire Line
	11250 4800 11350 4700
Entry Wire Line
	11250 4900 11350 4800
Entry Wire Line
	11250 5000 11350 4900
Entry Wire Line
	11250 5100 11350 5000
Entry Wire Line
	11250 5200 11350 5100
Entry Wire Line
	11250 5300 11350 5200
Entry Wire Line
	11250 5400 11350 5300
Entry Wire Line
	11225 6500 11325 6400
Entry Wire Line
	11225 6600 11325 6500
Entry Wire Line
	11225 6700 11325 6600
Entry Wire Line
	11225 6800 11325 6700
Entry Wire Line
	11225 6900 11325 6800
Entry Wire Line
	11225 7000 11325 6900
Entry Wire Line
	11225 7100 11325 7000
Entry Wire Line
	11225 7200 11325 7100
Wire Bus Line
	13675 2500 13675 5200
Wire Bus Line
	13675 5200 14475 5200
Text Label 14475 5200 2    60   ~ 0
IDE[D8..D15]
Wire Bus Line
	11250 2500 11250 6075
Wire Bus Line
	11250 6075 13575 6075
Wire Bus Line
	13575 6075 13575 7000
Wire Bus Line
	13575 7000 14475 7000
Text Label 14475 7000 2    60   ~ 0
IDE[D0..D7]
Entry Wire Line
	9125 8550 9225 8650
Entry Wire Line
	9125 8650 9225 8750
Entry Wire Line
	9125 8750 9225 8850
Entry Wire Line
	9125 8850 9225 8950
Entry Wire Line
	9125 8950 9225 9050
Entry Wire Line
	9125 9050 9225 9150
Entry Wire Line
	9125 9150 9225 9250
Entry Wire Line
	9125 9250 9225 9350
Entry Wire Line
	7625 8450 7725 8550
Entry Wire Line
	7625 8550 7725 8650
Entry Wire Line
	7625 8650 7725 8750
Entry Wire Line
	7625 8750 7725 8850
Entry Wire Line
	7625 8850 7725 8950
Entry Wire Line
	7625 8950 7725 9050
Entry Wire Line
	7625 9050 7725 9150
Entry Wire Line
	7625 9150 7725 9250
Wire Bus Line
	9225 8650 9225 9350
Wire Bus Line
	9225 9350 9850 9350
Text Label 9850 9350 2    60   ~ 0
IDE[D8..D15]
Wire Bus Line
	7625 8450 7625 9150
Wire Bus Line
	7625 8450 7050 8450
Text Label 7050 8450 0    60   ~ 0
IDE[D0..D7]
Wire Bus Line
	11225 6500 11225 7825
Wire Bus Line
	11225 7825 10650 7825
Text Label 10875 7825 0    60   ~ 0
D[0..7]
Text HLabel 10650 7825 0    60   Input ~ 0
D[0..7]
Wire Wire Line
	14125 900  14125 3400
Wire Wire Line
	14125 3400 13075 3400
Wire Wire Line
	13875 1100 13875 3300
Wire Wire Line
	13875 3300 13075 3300
$Comp
L GND #PWR59
U 1 1 5933B988
P 9125 8450
F 0 "#PWR59" H 9125 8200 50  0001 C CNN
F 1 "GND" H 9125 8300 50  0000 C CNN
F 2 "" H 9125 8450 50  0001 C CNN
F 3 "" H 9125 8450 50  0001 C CNN
	1    9125 8450
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR58
U 1 1 5933C0BC
P 7725 9350
F 0 "#PWR58" H 7725 9100 50  0001 C CNN
F 1 "GND" H 7725 9200 50  0000 C CNN
F 2 "" H 7725 9350 50  0001 C CNN
F 3 "" H 7725 9350 50  0001 C CNN
	1    7725 9350
	0    1    1    0   
$EndComp
Wire Wire Line
	7725 8450 7725 8225
Wire Wire Line
	7725 8225 7050 8225
Text HLabel 7050 8225 0    60   Input ~ 0
~RES
Text HLabel 7050 9950 0    60   Output ~ 0
~IRQ
$Comp
L GND #PWR60
U 1 1 5934CB71
P 9400 10350
F 0 "#PWR60" H 9400 10100 50  0001 C CNN
F 1 "GND" H 9400 10200 50  0000 C CNN
F 2 "" H 9400 10350 50  0001 C CNN
F 3 "" H 9400 10350 50  0001 C CNN
	1    9400 10350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 9450 9400 10350
Connection ~ 9400 9950
Connection ~ 9400 9850
Connection ~ 9400 9650
Connection ~ 9400 9550
Text HLabel 1100 1100 0    60   Input ~ 0
A[0..15]
Text HLabel 1100 1950 0    60   Input ~ 0
CLK
Text HLabel 1100 2250 0    60   Input ~ 0
~MRD
Text HLabel 1100 3100 0    60   Input ~ 0
~7F6X
Text HLabel 1100 4100 0    60   Input ~ 0
~MWR
Entry Wire Line
	6950 10250 7050 10150
Entry Wire Line
	6950 10150 7050 10050
Wire Bus Line
	6950 10150 6950 10250
Wire Bus Line
	6950 10250 6475 10250
Text Label 6475 10250 0    60   ~ 0
A[0..15]
Text HLabel 6475 10250 0    60   Input ~ 0
A[0..15]
$Comp
L LED D3
U 1 1 59388E35
P 1450 8650
F 0 "D3" H 1450 8750 50  0000 C CNN
F 1 "LED" H 1450 8550 50  0000 C CNN
F 2 "LEDs:LED_D3.0mm" H 1450 8650 50  0001 C CNN
F 3 "" H 1450 8650 50  0001 C CNN
	1    1450 8650
	-1   0    0    1   
$EndComp
$EndSCHEMATC
