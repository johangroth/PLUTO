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
LIBS:pluto-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74HCT00 U?
U 1 1 58D59B66
P 5450 2150
F 0 "U?" H 5450 2200 50  0000 C CNN
F 1 "74HCT00" H 5450 2050 50  0000 C CNN
F 2 "" H 5450 2150 50  0001 C CNN
F 3 "" H 5450 2150 50  0001 C CNN
	1    5450 2150
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U?
U 2 1 58D59B7D
P 8150 2600
F 0 "U?" H 8150 2650 50  0000 C CNN
F 1 "74HCT00" H 8150 2500 50  0000 C CNN
F 2 "" H 8150 2600 50  0001 C CNN
F 3 "" H 8150 2600 50  0001 C CNN
	2    8150 2600
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U?
U 3 1 58D59C3A
P 6250 1200
F 0 "U?" H 6250 1250 50  0000 C CNN
F 1 "74HCT00" H 6250 1100 50  0000 C CNN
F 2 "" H 6250 1200 50  0001 C CNN
F 3 "" H 6250 1200 50  0001 C CNN
	3    6250 1200
	1    0    0    -1  
$EndComp
$Comp
L 74HCT00 U?
U 4 1 58D59CAD
P 7800 1675
F 0 "U?" H 7800 1725 50  0000 C CNN
F 1 "74HCT00" H 7800 1575 50  0000 C CNN
F 2 "" H 7800 1675 50  0001 C CNN
F 3 "" H 7800 1675 50  0001 C CNN
	4    7800 1675
	1    0    0    -1  
$EndComp
$Comp
L 74LS30 U?
U 1 1 58D59CF0
P 6950 3075
F 0 "U?" H 6950 3175 50  0000 C CNN
F 1 "74LS30" H 6950 2975 50  0000 C CNN
F 2 "" H 6950 3075 50  0001 C CNN
F 3 "" H 6950 3075 50  0001 C CNN
	1    6950 3075
	1    0    0    -1  
$EndComp
$Comp
L 74LS138 U?
U 1 1 58D59D0F
P 7925 4575
F 0 "U?" H 8025 5075 50  0000 C CNN
F 1 "74LS138" H 8075 4026 50  0000 C CNN
F 2 "" H 7925 4575 50  0001 C CNN
F 3 "" H 7925 4575 50  0001 C CNN
	1    7925 4575
	1    0    0    -1  
$EndComp
Text GLabel 4575 2250 0    60   Input ~ 0
A15
Text GLabel 9075 2150 2    60   Input ~ 0
~ROMSEL
Text GLabel 4575 1100 0    60   Input ~ 0
R/~W
Text GLabel 9075 1200 2    60   Input ~ 0
~MRD
Text GLabel 4575 1775 0    60   Input ~ 0
CLK
Text GLabel 9075 1675 2    60   Input ~ 0
~MWR
Text GLabel 9075 2600 2    60   Input ~ 0
~RAMSEL
Text GLabel 9075 3075 2    60   Input ~ 0
~IOSEL
Text GLabel 4575 2625 0    60   Input ~ 0
A11
Text GLabel 4575 2800 0    60   Input ~ 0
A8
Text GLabel 4575 3000 0    60   Input ~ 0
A14
Text GLabel 4575 3200 0    60   Input ~ 0
A13
Text GLabel 4575 3400 0    60   Input ~ 0
A12
Text GLabel 4575 3600 0    60   Input ~ 0
A9
Text GLabel 4575 3800 0    60   Input ~ 0
A10
Text GLabel 6700 4175 0    60   Input ~ 0
A5
Text GLabel 6700 4325 0    60   Input ~ 0
A6
Text GLabel 6700 4475 0    60   Input ~ 0
A7
Text GLabel 6700 5100 0    60   Input ~ 0
~IOSEL
Text GLabel 9125 3900 2    60   Input ~ 0
~7F0X
Text GLabel 9125 4075 2    60   Input ~ 0
~7F2X
Text GLabel 9125 4250 2    60   Input ~ 0
~7F4X
Text GLabel 9125 4425 2    60   Input ~ 0
~7F6X
Text GLabel 9125 4600 2    60   Input ~ 0
~7F8X
Text GLabel 9125 4775 2    60   Input ~ 0
~7FAX
Text GLabel 9125 4950 2    60   Input ~ 0
~7FCX
Text GLabel 9125 5125 2    60   Input ~ 0
~7FEX
$Comp
L R_Network05 RN?
U 1 1 58D5E052
P 2075 1650
F 0 "RN?" V 1775 1650 50  0000 C CNN
F 1 "3.3kOhm" V 2375 1650 50  0000 C CNN
F 2 "Resistors_THT:R_Array_SIP6" V 2450 1650 50  0001 C CNN
F 3 "" H 2075 1650 50  0001 C CNN
	1    2075 1650
	1    0    0    -1  
$EndComp
Text GLabel 6700 4900 0    60   Input ~ 0
GND
Text GLabel 6700 4725 0    60   Input ~ 0
VCC
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
	7550 3075 9075 3075
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
	8525 4225 8650 4225
Wire Wire Line
	8650 4225 8650 3900
Wire Wire Line
	8650 3900 9125 3900
Wire Wire Line
	8525 4325 8700 4325
Wire Wire Line
	8700 4325 8700 4075
Wire Wire Line
	8700 4075 9125 4075
Wire Wire Line
	8525 4425 8750 4425
Wire Wire Line
	8750 4425 8750 4250
Wire Wire Line
	8750 4250 9125 4250
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
	2275 1850 2275 2050
Wire Wire Line
	2275 2050 2600 2050
Wire Wire Line
	2175 1850 2175 2225
Wire Wire Line
	2175 2225 2600 2225
Wire Wire Line
	2075 1850 2075 2375
Wire Wire Line
	2075 2375 2625 2375
Wire Wire Line
	1975 1850 1975 2525
Wire Wire Line
	1975 2525 2600 2525
Wire Wire Line
	1875 1850 1875 2675
Wire Wire Line
	1875 2675 2600 2675
Text GLabel 2600 2050 2    60   Input ~ 0
~IRQ
Text GLabel 2600 2225 2    60   Input ~ 0
~NMI
Text GLabel 2625 2375 2    60   Input ~ 0
BE
Text GLabel 2600 2525 2    60   Input ~ 0
~RES
Text GLabel 2600 2675 2    60   Input ~ 0
RDY
Wire Wire Line
	1875 1450 1875 1275
Text GLabel 1875 1275 0    60   Input ~ 0
VCC
$EndSCHEMATC
