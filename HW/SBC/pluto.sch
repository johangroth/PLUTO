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
Sheet 1 8
Title "Pluto SCB"
Date "2017-03-25"
Rev "0.1"
Comp "Linux Grotto"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 1350 900  1875 1650
U 58D5892B
F0 "CPU, ROM and RAM" 60
F1 "cpu_rom_ram.sch" 60
F2 "A[0..15]" O L 1350 2375 60 
F3 "D[0..7]" B L 1350 2200 60 
F4 "RDY" I R 3225 1200 60 
F5 "BE" I R 3225 2250 60 
F6 "~IRQ" I L 1350 2050 60 
F7 "R/~W" O L 1350 1850 60 
F8 "~NMI" I R 3225 1750 60 
F9 "CLK" I R 3225 2500 60 
F10 "~MRD" I R 3225 1000 60 
F11 "~MWR" I R 3225 1100 60 
F12 "~RAMSEL" I R 3225 1450 60 
F13 "~ROMSEL" I R 3225 1325 60 
F14 "~RES" I R 3225 2400 60 
F15 "~SO" I R 3225 1975 60 
$EndSheet
$Sheet
S 1325 2850 1375 1900
U 58D58957
F0 "ACIA and MAX232" 60
F1 "acia_max232.sch" 60
F2 "~7FEX" I R 2700 3275 60 
F3 "R/~W" I L 1325 3500 60 
F4 "~RES" I R 2700 3075 60 
F5 "~IRQ" O L 1325 3350 60 
F6 "CLK" I R 2700 2950 60 
F7 "D[0..7]" B L 1325 3175 60 
F8 "A[0..15]" I L 1325 2975 60 
$EndSheet
$Sheet
S 7025 900  2250 2075
U 58D58980
F0 "VIAs and RTC" 60
F1 "via_rtc.sch" 60
F2 "V2PA[0..7]" B R 9275 2350 60 
F3 "D[0..7]" B R 9275 1650 60 
F4 "~7FCX" B L 7025 1475 60 
F5 "A[0..15]" I R 9275 1475 60 
F6 "~PWR" O L 7025 1625 60 
F7 "~RES" O R 9275 2500 60 
F8 "~IRQ" O L 7025 2000 60 
F9 "~MWR" I L 7025 1100 60 
F10 "~MRD" I L 7025 1000 60 
F11 "~7F8X" I L 7025 1225 60 
F12 "~7FAX" I L 7025 1350 60 
F13 "R/~W" I L 7025 1875 60 
F14 "CLK" I L 7025 1750 60 
F15 "V2CA1" O R 9275 2050 60 
F16 "V2CA2" O R 9275 2200 60 
F17 "~KS" I L 7025 2125 60 
$EndSheet
$Sheet
S 3825 900  2075 2450
U 58D589A4
F0 "Address decoding and support section" 60
F1 "address_decoding_and_support.sch" 60
F2 "CLK" O R 5900 1750 60 
F3 "A[0..15]" I R 5900 3200 60 
F4 "~MRD" O R 5900 1000 60 
F5 "~MWR" O R 5900 1100 60 
F6 "~ROMSEL" O L 3825 1325 60 
F7 "~RAMSEL" O L 3825 1450 60 
F8 "R/~W" I R 5900 1875 60 
F9 "~IRQ" B R 5900 2000 60 
F10 "~NMI" O L 3825 1750 60 
F11 "BE" O L 3825 2250 60 
F12 "~PWR" O R 5900 1625 60 
F13 "RDY" O L 3825 1200 60 
F14 "~RES" O L 3825 2400 60 
F15 "~7F6X" O L 3825 3125 60 
F16 "~7F8X" O R 5900 1225 60 
F17 "~7FAX" O R 5900 1350 60 
F18 "~7FCX" O R 5900 1475 60 
F19 "~7FEX" O L 3825 3275 60 
F20 "~KS" O R 5900 2125 60 
F21 "~SO" O L 3825 1975 60 
$EndSheet
$Sheet
S 1850 6900 1600 500 
U 58D589DC
F0 "Power and mounting holes" 60
F1 "power_and_expansion.sch" 60
$EndSheet
$Sheet
S 7325 3900 1950 2075
U 59306E56
F0 "Audio" 60
F1 "audio.sch" 60
F2 "V2PA[0..7]" B R 9275 4400 60 
F3 "V2CA2" I R 9275 4525 60 
F4 "V2CA1" I R 9275 4650 60 
F5 "~RES" I R 9275 4275 60 
F6 "CLK" I L 7325 4550 60 
$EndSheet
Wire Wire Line
	5900 2000 7025 2000
Wire Wire Line
	5900 1875 7025 1875
Wire Wire Line
	5900 1000 7025 1000
$Sheet
S 3750 3775 2150 2050
U 5932EBB3
F0 "16bit IDE interface" 60
F1 "IDE16bit.sch" 60
F2 "D[0..7]" I L 3750 5575 60 
F3 "~RES" I L 3750 4300 60 
F4 "A[0..15]" I R 5900 5575 60 
F5 "CLK" I R 5900 4550 60 
F6 "~MRD" I R 5900 4350 60 
F7 "~7F6X" I L 3750 3975 60 
F8 "~MWR" I R 5900 4100 60 
F9 "~IRQ" O R 5900 4750 60 
$EndSheet
Wire Wire Line
	5900 1100 7025 1100
Wire Wire Line
	5900 1625 7025 1625
Wire Wire Line
	5900 1750 7025 1750
Wire Wire Line
	3225 1000 3425 1000
Wire Wire Line
	3425 1000 3425 650 
Wire Wire Line
	3425 650  6125 650 
Wire Wire Line
	6125 650  6125 4350
Connection ~ 6125 1000
Wire Wire Line
	3225 1100 3550 1100
Wire Wire Line
	3550 1100 3550 775 
Wire Wire Line
	3550 775  6025 775 
Wire Wire Line
	6025 775  6025 4100
Connection ~ 6025 1100
Wire Wire Line
	3225 1200 3825 1200
Wire Wire Line
	3225 1325 3825 1325
Wire Wire Line
	3225 1450 3825 1450
Wire Wire Line
	5900 1225 7025 1225
Wire Wire Line
	5900 1350 7025 1350
Wire Wire Line
	5900 1475 7025 1475
Wire Wire Line
	9275 2050 10025 2050
Wire Wire Line
	10025 4650 9275 4650
Wire Wire Line
	9275 2200 9900 2200
Wire Wire Line
	9275 4525 9900 4525
Wire Wire Line
	9275 2500 9650 2500
Wire Wire Line
	9650 4275 9275 4275
Wire Wire Line
	9650 2500 9650 4275
Wire Wire Line
	9900 4525 9900 2200
Wire Wire Line
	10025 2050 10025 4650
Wire Bus Line
	9275 2350 9775 2350
Wire Bus Line
	9775 2350 9775 4400
Wire Bus Line
	9775 4400 9275 4400
Text Label 9275 4400 0    60   ~ 0
V2PA[0..7]
Wire Wire Line
	2700 3275 3825 3275
Wire Wire Line
	3225 2500 3325 2500
Wire Wire Line
	3325 2500 3325 6025
Wire Wire Line
	3325 2950 2700 2950
Wire Wire Line
	3225 2400 3825 2400
Wire Wire Line
	3425 2400 3425 4300
Wire Wire Line
	3425 3075 2700 3075
Wire Wire Line
	3225 2250 3825 2250
Wire Bus Line
	1350 2375 975  2375
Wire Bus Line
	975  2375 975  6250
Wire Bus Line
	975  2975 1325 2975
Text Label 975  2375 0    60   ~ 0
A[0..15]
Wire Bus Line
	1350 2200 900  2200
Wire Bus Line
	900  2200 900  6150
Wire Bus Line
	900  3175 1325 3175
Text Label 900  2200 0    60   ~ 0
D[0..7]
Wire Wire Line
	1350 2050 825  2050
Wire Wire Line
	825  575  825  3350
Wire Wire Line
	825  3350 1325 3350
Wire Wire Line
	1350 1850 750  1850
Wire Wire Line
	750  1850 750  6350
Wire Wire Line
	750  3500 1325 3500
Wire Bus Line
	9275 1650 10150 1650
Wire Bus Line
	10150 1650 10150 6150
Wire Bus Line
	10150 6150 900  6150
Wire Bus Line
	9275 1475 10275 1475
Wire Bus Line
	10275 1475 10275 6250
Wire Bus Line
	10275 6250 975  6250
Connection ~ 975  2975
Connection ~ 900  3175
Wire Bus Line
	3750 5575 3600 5575
Wire Bus Line
	3600 5575 3600 6150
Connection ~ 3600 6150
Wire Bus Line
	5900 5575 6025 5575
Wire Bus Line
	6025 5575 6025 6250
Connection ~ 6025 6250
Wire Wire Line
	6025 4100 5900 4100
Wire Wire Line
	6125 4350 5900 4350
Wire Wire Line
	5900 4550 7325 4550
Wire Wire Line
	6225 1750 6225 6025
Connection ~ 6225 4550
Connection ~ 6225 1750
Wire Wire Line
	825  575  6325 575 
Wire Wire Line
	6325 575  6325 4750
Connection ~ 6325 2000
Connection ~ 825  2050
Wire Wire Line
	6325 4750 5900 4750
Connection ~ 3425 2400
Wire Wire Line
	3425 4300 3750 4300
Connection ~ 3425 3075
Wire Wire Line
	3425 3550 9650 3550
Connection ~ 9650 3550
Connection ~ 3425 3550
Wire Wire Line
	3225 1750 3825 1750
Wire Wire Line
	3825 3125 3675 3125
Wire Wire Line
	3675 3125 3675 3975
Wire Wire Line
	3675 3975 3750 3975
Wire Bus Line
	5900 3200 6425 3200
Wire Bus Line
	6425 3200 6425 6250
Connection ~ 6425 6250
Wire Wire Line
	750  6350 6525 6350
Wire Wire Line
	6525 6350 6525 1875
Connection ~ 6525 1875
Connection ~ 750  3500
Wire Wire Line
	6225 6025 3325 6025
Connection ~ 3325 2950
Wire Wire Line
	7025 2125 5900 2125
Wire Wire Line
	3825 1975 3225 1975
$EndSCHEMATC
