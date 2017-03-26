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
LIBS:pluto-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 6
Title "CPU, ROM and RAM"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L WD65C02_ U1
U 1 1 58D58BE4
P 2175 2350
F 0 "U1" H 1925 3400 60  0000 C CNN
F 1 "WD65C02_" H 2300 1225 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm" H 1625 2550 60  0001 C CNN
F 3 "" H 1625 2550 60  0000 C CNN
	1    2175 2350
	1    0    0    -1  
$EndComp
Text GLabel 1300 1450 0    60   Input ~ 0
D0
Text GLabel 1300 1550 0    60   Input ~ 0
D1
Text GLabel 1300 1650 0    60   Input ~ 0
D2
Text GLabel 1300 1750 0    60   Input ~ 0
D3
Text GLabel 1300 1850 0    60   Input ~ 0
D4
Text GLabel 1300 1950 0    60   Input ~ 0
D5
Text GLabel 1300 2050 0    60   Input ~ 0
D6
Text GLabel 1300 2150 0    60   Input ~ 0
D7
Text GLabel 3000 1450 2    60   Input ~ 0
A0
Text GLabel 3000 1550 2    60   Input ~ 0
A1
Text GLabel 3000 1650 2    60   Input ~ 0
A2
Text GLabel 3000 1750 2    60   Input ~ 0
A3
Text GLabel 3000 1850 2    60   Input ~ 0
A4
Text GLabel 3000 1950 2    60   Input ~ 0
A5
Text GLabel 3000 2050 2    60   Input ~ 0
A6
Text GLabel 3000 2150 2    60   Input ~ 0
A7
Text GLabel 3000 2250 2    60   Input ~ 0
A8
Text GLabel 3000 2350 2    60   Input ~ 0
A9
Text GLabel 3000 2450 2    60   Input ~ 0
A10
Text GLabel 3000 2550 2    60   Input ~ 0
A11
Text GLabel 3000 2650 2    60   Input ~ 0
A12
Text GLabel 3000 2750 2    60   Input ~ 0
A13
Text GLabel 3000 2850 2    60   Input ~ 0
A14
Text GLabel 3000 2950 2    60   Input ~ 0
A15
Text GLabel 3000 3050 2    60   Input ~ 0
PHI2
Text GLabel 3000 3150 2    60   Input ~ 0
CLK
NoConn ~ 2825 3250
Text GLabel 3000 3350 2    60   Input ~ 0
~RES
Wire Wire Line
	1525 1450 1300 1450
Wire Wire Line
	1525 1550 1300 1550
Wire Wire Line
	1525 1650 1300 1650
Wire Wire Line
	1525 1750 1300 1750
Wire Wire Line
	1525 1850 1300 1850
Wire Wire Line
	1525 1950 1300 1950
Wire Wire Line
	1525 2050 1300 2050
Wire Wire Line
	1525 2150 1300 2150
Wire Wire Line
	2825 1450 3000 1450
Wire Wire Line
	2825 1550 3000 1550
Wire Wire Line
	2825 1650 3000 1650
Wire Wire Line
	2825 1750 3000 1750
Wire Wire Line
	2825 1850 3000 1850
Wire Wire Line
	2825 1950 3000 1950
Wire Wire Line
	2825 2050 3000 2050
Wire Wire Line
	2825 2150 3000 2150
Wire Wire Line
	2825 2250 3000 2250
Wire Wire Line
	2825 2350 3000 2350
Wire Wire Line
	2825 2450 3000 2450
Wire Wire Line
	2825 2550 3000 2550
Wire Wire Line
	2825 2650 3000 2650
Wire Wire Line
	2825 2750 3000 2750
Wire Wire Line
	2825 2850 3000 2850
Wire Wire Line
	2825 2950 3000 2950
Wire Wire Line
	2825 3050 3000 3050
Wire Wire Line
	2825 3150 3000 3150
Wire Wire Line
	2825 3350 3000 3350
Wire Wire Line
	1525 2650 1300 2650
Wire Wire Line
	1525 2950 1300 2950
Wire Wire Line
	1525 3050 1300 3050
Wire Wire Line
	1525 3150 1300 3150
NoConn ~ 1525 2850
NoConn ~ 1525 2250
NoConn ~ 1525 2550
NoConn ~ 1525 2350
Wire Wire Line
	1525 2450 1300 2450
Text GLabel 1300 2950 0    60   Input ~ 0
~IRQ
Text GLabel 1300 3050 0    60   Input ~ 0
R/~W
Text GLabel 1300 3150 0    60   Input ~ 0
~NMI
Text GLabel 1300 2650 0    60   Input ~ 0
BE
Text GLabel 1300 2450 0    60   Input ~ 0
RDY
$Comp
L 28C256 U2
U 1 1 58D5901B
P 5775 2300
F 0 "U2" H 5500 3300 50  0000 C CNN
F 1 "28C256" H 6075 1300 50  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm" H 5775 2300 50  0001 C CNN
F 3 "" H 5775 2300 50  0001 C CNN
	1    5775 2300
	1    0    0    -1  
$EndComp
$Comp
L HM62256BLP-7 U3
U 1 1 58D5907B
P 8475 2200
F 0 "U3" H 8175 3100 50  0000 C CNN
F 1 "HM62256BLP-7" H 8600 1400 50  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm" H 8475 2200 50  0001 C CIN
F 3 "" H 8475 2200 50  0001 C CNN
	1    8475 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5075 1400 4750 1400
Wire Wire Line
	5075 1500 4750 1500
Wire Wire Line
	5075 1600 4750 1600
Wire Wire Line
	5075 1700 4750 1700
Wire Wire Line
	5075 1800 4750 1800
Wire Wire Line
	5075 1900 4750 1900
Wire Wire Line
	5075 2000 4750 2000
Wire Wire Line
	5075 2100 4750 2100
Wire Wire Line
	5075 2200 4750 2200
Wire Wire Line
	5075 2300 4750 2300
Wire Wire Line
	5075 2400 4750 2400
Wire Wire Line
	5075 2500 4750 2500
Wire Wire Line
	5075 2600 4750 2600
Wire Wire Line
	5075 2700 4750 2700
Wire Wire Line
	5075 2800 4750 2800
Wire Wire Line
	7975 1450 7650 1450
Wire Wire Line
	7975 1550 7650 1550
Wire Wire Line
	7975 1650 7650 1650
Wire Wire Line
	7975 1750 7650 1750
Wire Wire Line
	7975 1850 7650 1850
Wire Wire Line
	7975 1950 7650 1950
Wire Wire Line
	7975 2050 7650 2050
Wire Wire Line
	7975 2150 7650 2150
Wire Wire Line
	7975 2250 7650 2250
Wire Wire Line
	7975 2350 7650 2350
Wire Wire Line
	7975 2450 7650 2450
Wire Wire Line
	7975 2550 7650 2550
Wire Wire Line
	7975 2650 7650 2650
Wire Wire Line
	7975 2750 7650 2750
Wire Wire Line
	7975 2850 7650 2850
Text GLabel 4750 1400 0    60   Input ~ 0
A0
Text GLabel 4750 1500 0    60   Input ~ 0
A1
Text GLabel 4750 1600 0    60   Input ~ 0
A2
Text GLabel 4750 1700 0    60   Input ~ 0
A3
Text GLabel 4750 1800 0    60   Input ~ 0
A4
Text GLabel 4750 1900 0    60   Input ~ 0
A5
Text GLabel 4750 2000 0    60   Input ~ 0
A6
Text GLabel 4750 2100 0    60   Input ~ 0
A7
Text GLabel 4750 2200 0    60   Input ~ 0
A8
Text GLabel 4750 2300 0    60   Input ~ 0
A9
Text GLabel 4750 2400 0    60   Input ~ 0
A10
Text GLabel 4750 2500 0    60   Input ~ 0
A11
Text GLabel 4750 2600 0    60   Input ~ 0
A12
Text GLabel 4750 2700 0    60   Input ~ 0
A13
Text GLabel 4750 2800 0    60   Input ~ 0
A14
Text GLabel 7650 1450 0    60   Input ~ 0
A0
Text GLabel 7650 1550 0    60   Input ~ 0
A1
Text GLabel 7650 1650 0    60   Input ~ 0
A2
Text GLabel 7650 1750 0    60   Input ~ 0
A3
Text GLabel 7650 1850 0    60   Input ~ 0
A4
Text GLabel 7650 1950 0    60   Input ~ 0
A5
Text GLabel 7650 2050 0    60   Input ~ 0
A6
Text GLabel 7650 2150 0    60   Input ~ 0
A7
Text GLabel 7650 2250 0    60   Input ~ 0
A8
Text GLabel 7650 2350 0    60   Input ~ 0
A9
Text GLabel 7650 2450 0    60   Input ~ 0
A10
Text GLabel 7650 2550 0    60   Input ~ 0
A11
Text GLabel 7650 2650 0    60   Input ~ 0
A12
Text GLabel 7650 2750 0    60   Input ~ 0
A13
Text GLabel 7650 2850 0    60   Input ~ 0
A14
Wire Wire Line
	8975 1450 9150 1450
Wire Wire Line
	8975 1550 9150 1550
Wire Wire Line
	8975 1650 9150 1650
Wire Wire Line
	8975 1750 9150 1750
Wire Wire Line
	8975 1850 9150 1850
Wire Wire Line
	8975 1950 9150 1950
Wire Wire Line
	8975 2050 9150 2050
Wire Wire Line
	8975 2150 9150 2150
Text GLabel 9150 1450 2    60   Input ~ 0
D0
Text GLabel 9150 1550 2    60   Input ~ 0
D1
Text GLabel 9150 1650 2    60   Input ~ 0
D2
Text GLabel 9150 1750 2    60   Input ~ 0
D3
Text GLabel 9150 1850 2    60   Input ~ 0
D4
Text GLabel 9150 1950 2    60   Input ~ 0
D5
Text GLabel 9150 2050 2    60   Input ~ 0
D6
Text GLabel 9150 2150 2    60   Input ~ 0
D7
Wire Wire Line
	6475 1400 6650 1400
Wire Wire Line
	6475 1500 6650 1500
Wire Wire Line
	6475 1600 6650 1600
Wire Wire Line
	6475 1700 6650 1700
Wire Wire Line
	6475 1800 6650 1800
Wire Wire Line
	6475 1900 6650 1900
Wire Wire Line
	6475 2000 6650 2000
Wire Wire Line
	6475 2100 6650 2100
Text GLabel 6650 1400 2    60   Input ~ 0
D0
Text GLabel 6650 1500 2    60   Input ~ 0
D1
Text GLabel 6650 1600 2    60   Input ~ 0
D2
Text GLabel 6650 1700 2    60   Input ~ 0
D3
Text GLabel 6650 1800 2    60   Input ~ 0
D4
Text GLabel 6650 1900 2    60   Input ~ 0
D5
Text GLabel 6650 2000 2    60   Input ~ 0
D6
Text GLabel 6650 2100 2    60   Input ~ 0
D7
Wire Wire Line
	5075 3100 4750 3100
Wire Wire Line
	5075 3200 4750 3200
Wire Wire Line
	8975 2300 9150 2300
Wire Wire Line
	8975 2400 9150 2400
Wire Wire Line
	8975 2550 9150 2550
Text GLabel 9150 2300 2    60   Input ~ 0
~MRD
Text GLabel 9150 2400 2    60   Input ~ 0
~MWR
Text GLabel 9150 2550 2    60   Input ~ 0
~RAMSEL
Text GLabel 4750 3100 0    60   Input ~ 0
~MRD
Text GLabel 4750 3200 0    60   Input ~ 0
~ROMSEL
NoConn ~ 5075 3000
$EndSCHEMATC