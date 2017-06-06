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
LIBS:IDE_interface-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 8
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
L CP1_Small C7
U 1 1 58D5E9AB
P 2425 2175
F 0 "C7" H 2435 2245 50  0000 L CNN
F 1 "100 uF" H 2435 2095 50  0000 L CNN
F 2 "Capacitors_ThroughHole:CP_Radial_D6.3mm_P2.50mm" H 2425 2175 50  0001 C CNN
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
F 2 "Capacitors_ThroughHole:CP_Radial_D5.0mm_P2.00mm" H 3225 2175 50  0001 C CNN
F 3 "" H 3225 2175 50  0001 C CNN
	1    3225 2175
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR040
U 1 1 58D5EE10
P 5625 1650
F 0 "#PWR040" H 5625 1500 50  0001 C CNN
F 1 "VCC" H 5625 1800 50  0000 C CNN
F 2 "" H 5625 1650 50  0001 C CNN
F 3 "" H 5625 1650 50  0001 C CNN
	1    5625 1650
	1    0    0    -1  
$EndComp
Text Label 2025 1650 0    60   ~ 0
+9V
$Comp
L CONN_02X25 J5
U 1 1 58D76145
P 3600 4925
F 0 "J5" H 3600 6225 50  0000 C CNN
F 1 "Expansion Port" V 3600 4925 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_50pins" H 3600 4175 50  0001 C CNN
F 3 "" H 3600 4175 50  0001 C CNN
	1    3600 4925
	1    0    0    -1  
$EndComp
Wire Wire Line
	2825 2500 2825 1950
Wire Wire Line
	2425 2275 2425 2500
Wire Wire Line
	1900 2500 5625 2500
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
	1350 1900 1900 1900
Wire Wire Line
	1900 1900 1900 1650
Wire Wire Line
	1350 2100 1900 2100
Wire Wire Line
	1900 2100 1900 2500
Wire Wire Line
	3225 1650 5625 1650
$Comp
L VCC #PWR041
U 1 1 58D7686C
P 3600 3500
F 0 "#PWR041" H 3600 3350 50  0001 C CNN
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
L GND #PWR042
U 1 1 58D76B4A
P 3600 6325
F 0 "#PWR042" H 3600 6075 50  0001 C CNN
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
Connection ~ 3225 2500
$Comp
L GND #PWR043
U 1 1 58D85868
P 5625 2500
F 0 "#PWR043" H 5625 2250 50  0001 C CNN
F 1 "GND" H 5625 2350 50  0000 C CNN
F 2 "" H 5625 2500 50  0001 C CNN
F 3 "" H 5625 2500 50  0001 C CNN
	1    5625 2500
	1    0    0    -1  
$EndComp
$Comp
L LM7805CT U11
U 1 1 58E10ED4
P 2825 1700
F 0 "U11" H 2625 1900 50  0000 C CNN
F 1 "LM7805CT" H 2825 1900 50  0000 L CNN
F 2 "TO_SOT_Packages_THT:TO-220_Vertical" H 2825 1800 50  0001 C CIN
F 3 "" H 2825 1700 50  0001 C CNN
	1    2825 1700
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK1
U 1 1 59149E0C
P 6050 3325
F 0 "MK1" H 6050 3525 50  0000 C CNN
F 1 "Mounting_Hole" H 6050 3450 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6050 3325 50  0001 C CNN
F 3 "" H 6050 3325 50  0001 C CNN
	1    6050 3325
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK2
U 1 1 59149E41
P 6050 3725
F 0 "MK2" H 6050 3925 50  0000 C CNN
F 1 "Mounting_Hole" H 6050 3850 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6050 3725 50  0001 C CNN
F 3 "" H 6050 3725 50  0001 C CNN
	1    6050 3725
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK3
U 1 1 59149E60
P 6750 3300
F 0 "MK3" H 6750 3500 50  0000 C CNN
F 1 "Mounting_Hole" H 6750 3425 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6750 3300 50  0001 C CNN
F 3 "" H 6750 3300 50  0001 C CNN
	1    6750 3300
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK4
U 1 1 59149E83
P 6750 3725
F 0 "MK4" H 6750 3925 50  0000 C CNN
F 1 "Mounting_Hole" H 6750 3850 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6750 3725 50  0001 C CNN
F 3 "" H 6750 3725 50  0001 C CNN
	1    6750 3725
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 3825 2925 3550
Wire Wire Line
	3350 3925 2925 3700
Wire Wire Line
	3350 4025 2925 3850
Wire Wire Line
	3350 4125 2925 4000
Wire Wire Line
	3350 4225 2925 4150
Wire Wire Line
	3350 4325 2925 4300
Wire Wire Line
	3350 4425 2925 4450
Wire Wire Line
	3350 4525 2925 4600
Wire Wire Line
	3350 4625 2925 4750
Wire Wire Line
	3350 4725 2925 4900
Wire Wire Line
	3350 4825 2925 5050
Wire Wire Line
	3350 4925 2925 5200
Wire Wire Line
	3850 3825 4250 3550
Wire Wire Line
	3850 3925 4250 3700
Wire Wire Line
	3850 4025 4250 3850
Wire Wire Line
	3850 4125 4250 4000
Wire Wire Line
	3850 4225 4250 4150
Wire Wire Line
	3850 4325 4250 4300
Wire Wire Line
	3850 4425 4250 4450
Wire Wire Line
	3850 4525 4250 4600
Wire Wire Line
	3850 4625 4250 4750
Wire Wire Line
	3850 4725 4250 4900
Wire Wire Line
	3850 4825 4250 5050
Wire Wire Line
	3850 4925 4250 5200
Wire Wire Line
	3350 5225 2925 5350
Wire Wire Line
	3350 5325 2925 5500
Wire Wire Line
	3350 5425 2925 5650
Wire Wire Line
	3350 5525 2925 5800
Wire Wire Line
	3350 5725 2925 5950
Wire Wire Line
	3350 5925 2925 6100
Wire Wire Line
	3350 6025 2925 6250
Wire Wire Line
	3850 5225 4250 5350
Wire Wire Line
	3850 5325 4250 5500
Wire Wire Line
	3850 5425 4250 5650
Wire Wire Line
	3850 5525 4250 5800
Wire Wire Line
	3850 5725 4250 5950
Wire Wire Line
	3850 5925 4250 6100
Wire Wire Line
	3850 6025 4250 6250
NoConn ~ 3850 5025
NoConn ~ 3850 5125
NoConn ~ 3350 5025
NoConn ~ 3350 5125
NoConn ~ 3350 5625
NoConn ~ 3850 5625
NoConn ~ 3350 5825
NoConn ~ 3850 5825
$Comp
L BARREL_JACK J4
U 1 1 5930508B
P 1050 2000
F 0 "J4" H 1050 2195 50  0000 C CNN
F 1 "BARREL_JACK" H 1050 1800 50  0000 C CNN
F 2 "Connect:BARREL_JACK" H 1050 2000 50  0001 C CNN
F 3 "" H 1050 2000 50  0001 C CNN
	1    1050 2000
	1    0    0    1   
$EndComp
Wire Wire Line
	1350 1900 1350 2000
$Comp
L Mounting_Hole MK5
U 1 1 5932DD04
P 6050 4225
F 0 "MK5" H 6050 4425 50  0000 C CNN
F 1 "Mounting_Hole" H 6050 4350 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6050 4225 50  0001 C CNN
F 3 "" H 6050 4225 50  0001 C CNN
	1    6050 4225
	1    0    0    -1  
$EndComp
$Comp
L Mounting_Hole MK6
U 1 1 5932DD62
P 6750 4225
F 0 "MK6" H 6750 4425 50  0000 C CNN
F 1 "Mounting_Hole" H 6750 4350 50  0000 C CNN
F 2 "Mounting_Holes:MountingHole_3.2mm_M3_Pad" H 6750 4225 50  0001 C CNN
F 3 "" H 6750 4225 50  0001 C CNN
	1    6750 4225
	1    0    0    -1  
$EndComp
$EndSCHEMATC
