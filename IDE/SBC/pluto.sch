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
LIBS:sbc
LIBS:65xx
LIBS:pluto-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L WD65C02_ U1
U 1 1 58C8AB80
P 3075 2900
F 0 "U1" H 3075 1750 60  0000 C CNN
F 1 "WD65C02_" V 3075 2950 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 2525 3100 60  0001 C CNN
F 3 "" H 2525 3100 60  0000 C CNN
	1    3075 2900
	1    0    0    -1  
$EndComp
$Comp
L WD65C22 U2
U 1 1 58D0D406
P 5625 2875
F 0 "U2" H 5625 1725 60  0000 C CNN
F 1 "WD65C22" V 5625 2775 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 5125 3075 60  0001 C CNN
F 3 "" H 5125 3075 60  0000 C CNN
	1    5625 2875
	1    0    0    -1  
$EndComp
NoConn ~ 2425 3100
NoConn ~ 2425 2800
NoConn ~ 2425 2900
NoConn ~ 2425 3400
NoConn ~ 3725 3800
NoConn ~ 4975 2075
NoConn ~ 4975 2175
NoConn ~ 4975 2275
NoConn ~ 4975 2375
NoConn ~ 4975 2475
NoConn ~ 4975 2575
NoConn ~ 4975 2675
NoConn ~ 4975 2775
NoConn ~ 4975 2875
NoConn ~ 4975 2975
NoConn ~ 4975 3075
NoConn ~ 4975 3175
NoConn ~ 4975 3275
NoConn ~ 4975 3375
NoConn ~ 4975 3475
NoConn ~ 4975 3575
NoConn ~ 4975 3675
NoConn ~ 4975 3775
NoConn ~ 6275 1975
NoConn ~ 6275 2075
NoConn ~ 6275 2575
NoConn ~ 6275 3475
NoConn ~ 6275 3575
NoConn ~ 6275 3675
NoConn ~ 6275 3775
NoConn ~ 6275 3875
NoConn ~ 3725 3600
NoConn ~ 3725 3700
NoConn ~ 3725 3800
NoConn ~ 3725 3900
NoConn ~ 2425 3500
NoConn ~ 2425 3600
NoConn ~ 2425 3700
NoConn ~ 2425 3200
NoConn ~ 2425 3000
$Comp
L Battery_Cell BT1
U 1 1 58D16E1E
P 875 2625
F 0 "BT1" H 975 2725 50  0000 L CNN
F 1 "Battery_Cell" H 975 2625 50  0000 L CNN
F 2 "Connect:CR2032V" V 875 2685 50  0001 C CNN
F 3 "" V 875 2685 50  0001 C CNN
	1    875  2625
	1    0    0    -1  
$EndComp
Wire Wire Line
	2425 2000 2250 2000
Wire Wire Line
	2425 2100 2250 2100
Wire Wire Line
	2425 2200 2250 2200
Wire Wire Line
	2425 2300 2250 2300
Wire Wire Line
	2425 2400 2250 2400
Wire Wire Line
	2425 2500 2250 2500
Wire Wire Line
	2425 2600 2250 2600
Wire Wire Line
	2425 2700 2250 2700
Text Label 2250 2000 0    60   ~ 0
D0
Text Label 2250 2100 0    60   ~ 0
D1
Text Label 2250 2200 0    60   ~ 0
D2
Text Label 2250 2300 0    60   ~ 0
D3
Text Label 2250 2400 0    60   ~ 0
D4
Text Label 2250 2500 0    60   ~ 0
D5
Text Label 2250 2600 0    60   ~ 0
D6
Text Label 2250 2700 0    60   ~ 0
D7
Wire Wire Line
	6275 2675 6600 2675
Wire Wire Line
	6275 2775 6600 2775
Wire Wire Line
	6275 2875 6600 2875
Wire Wire Line
	6275 2975 6600 2975
Wire Wire Line
	6275 3075 6600 3075
Wire Wire Line
	6275 3175 6600 3175
Wire Wire Line
	6275 3275 6600 3275
Wire Wire Line
	6275 3375 6600 3375
Text Label 6600 2675 2    60   ~ 0
D0
Text Label 6600 2775 2    60   ~ 0
D1
Text Label 6600 2875 2    60   ~ 0
D2
Text Label 6600 2975 2    60   ~ 0
D3
Text Label 6600 3075 2    60   ~ 0
D4
Text Label 6600 3175 2    60   ~ 0
D5
Text Label 6600 3275 2    60   ~ 0
D6
Text Label 6600 3375 2    60   ~ 0
D7
Entry Wire Line
	2150 2100 2250 2000
Entry Wire Line
	2150 2200 2250 2100
Entry Wire Line
	2150 2300 2250 2200
Entry Wire Line
	2150 2400 2250 2300
Entry Wire Line
	2150 2500 2250 2400
Entry Wire Line
	2150 2600 2250 2500
Entry Wire Line
	2150 2700 2250 2600
Entry Wire Line
	2150 2800 2250 2700
Wire Bus Line
	2150 2100 2150 2800
Entry Wire Line
	6600 2675 6700 2775
Entry Wire Line
	6600 2775 6700 2875
Entry Wire Line
	6600 2875 6700 2975
Entry Wire Line
	6600 2975 6700 3075
Entry Wire Line
	6600 3075 6700 3175
Entry Wire Line
	6600 3175 6700 3275
Entry Wire Line
	6600 3275 6700 3375
Entry Wire Line
	6600 3375 6700 3475
Wire Bus Line
	6700 2775 6700 3475
$Comp
L +5V #PWR05
U 1 1 58D17B34
P 875 2425
F 0 "#PWR05" H 875 2275 50  0001 C CNN
F 1 "+5V" H 875 2565 50  0000 C CNN
F 2 "" H 875 2425 50  0001 C CNN
F 3 "" H 875 2425 50  0001 C CNN
	1    875  2425
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 58D17B6B
P 875 2725
F 0 "#PWR06" H 875 2475 50  0001 C CNN
F 1 "GND" H 875 2575 50  0000 C CNN
F 2 "" H 875 2725 50  0001 C CNN
F 3 "" H 875 2725 50  0001 C CNN
	1    875  2725
	1    0    0    -1  
$EndComp
Wire Wire Line
	3725 2000 3950 2000
Wire Wire Line
	3725 2100 3950 2100
Wire Wire Line
	3725 2200 3950 2200
Wire Wire Line
	3725 2300 3950 2300
Wire Wire Line
	3725 2400 3950 2400
Wire Wire Line
	3725 2500 3950 2500
Wire Wire Line
	3725 2600 3950 2600
Wire Wire Line
	3725 2700 3950 2700
Wire Wire Line
	3725 2800 3950 2800
Wire Wire Line
	3725 2900 3950 2900
Wire Wire Line
	3725 3000 3950 3000
Wire Wire Line
	3725 3100 3950 3100
Wire Wire Line
	3725 3200 3950 3200
Wire Wire Line
	3725 3300 3950 3300
Wire Wire Line
	3725 3400 3950 3400
Wire Wire Line
	3725 3500 3950 3500
Text Label 3950 2000 2    60   ~ 0
A0
Text Label 3950 2100 2    60   ~ 0
A1
Text Label 3950 2200 2    60   ~ 0
A2
Text Label 3950 2300 2    60   ~ 0
A3
Text Label 3950 2400 2    60   ~ 0
A4
Text Label 3950 2500 2    60   ~ 0
A5
Text Label 3950 2600 2    60   ~ 0
A6
Text Label 3950 2700 2    60   ~ 0
A7
Text Label 3950 2800 2    60   ~ 0
A8
Text Label 3950 2900 2    60   ~ 0
A9
Text Label 3950 3000 2    60   ~ 0
A10
Text Label 3950 3100 2    60   ~ 0
A11
Text Label 3950 3200 2    60   ~ 0
A12
Text Label 3950 3300 2    60   ~ 0
A13
Text Label 3950 3400 2    60   ~ 0
A14
Text Label 3950 3500 2    60   ~ 0
A15
Entry Wire Line
	3950 2000 4050 2100
Entry Wire Line
	3950 2100 4050 2200
Entry Wire Line
	3950 2200 4050 2300
Entry Wire Line
	3950 2300 4050 2400
Entry Wire Line
	3950 2400 4050 2500
Entry Wire Line
	3950 2500 4050 2600
Entry Wire Line
	3950 2600 4050 2700
Entry Wire Line
	3950 2700 4050 2800
Entry Wire Line
	3950 2800 4050 2900
Entry Wire Line
	3950 2900 4050 3000
Entry Wire Line
	3950 3000 4050 3100
Entry Wire Line
	3950 3100 4050 3200
Entry Wire Line
	3950 3200 4050 3300
Entry Wire Line
	3950 3300 4050 3400
Entry Wire Line
	3950 3400 4050 3500
Entry Wire Line
	3950 3500 4050 3600
Wire Bus Line
	4050 2100 4050 3600
Wire Wire Line
	6275 2175 6525 2175
Wire Wire Line
	6275 2275 6525 2275
Wire Wire Line
	6275 2375 6525 2375
Wire Wire Line
	6275 2475 6525 2475
Text Label 6525 2175 2    60   ~ 0
A0
Text Label 6525 2275 2    60   ~ 0
A1
Text Label 6525 2375 2    60   ~ 0
A2
Text Label 6525 2475 2    60   ~ 0
A3
Entry Wire Line
	6525 2175 6625 2275
Entry Wire Line
	6525 2275 6625 2375
Entry Wire Line
	6525 2375 6625 2475
Entry Wire Line
	6525 2475 6625 2575
Wire Bus Line
	6625 2275 6625 2575
$Comp
L 74LS138 U?
U 1 1 58D4412E
P 5600 5200
F 0 "U?" H 5700 5700 50  0000 C CNN
F 1 "74LS138" H 5750 4651 50  0000 C CNN
F 2 "" H 5600 5200 50  0001 C CNN
F 3 "" H 5600 5200 50  0001 C CNN
	1    5600 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 4850 4700 4850
Wire Wire Line
	5000 4950 4700 4950
Wire Wire Line
	5000 5050 4700 5050
Wire Wire Line
	5000 5350 4700 5350
Wire Wire Line
	5000 5450 4700 5450
Wire Wire Line
	5000 5550 4700 5550
Text Label 4700 4850 0    60   ~ 0
A5
Text Label 4700 4950 0    60   ~ 0
A6
Text Label 4700 5050 0    60   ~ 0
A7
Text Label 4700 5550 0    60   ~ 0
~IOSEL
Wire Wire Line
	6200 4850 6525 4850
Wire Wire Line
	6200 4950 6525 4950
Wire Wire Line
	6200 5050 6525 5050
Wire Wire Line
	6200 5150 6525 5150
Wire Wire Line
	6200 5250 6525 5250
Wire Wire Line
	6200 5350 6525 5350
Wire Wire Line
	6200 5450 6525 5450
Wire Wire Line
	6200 5550 6525 5550
Text Label 6525 4850 2    60   ~ 0
~7F0X
Text Label 6525 4950 2    60   ~ 0
~7F2X
Text Label 6525 5050 2    60   ~ 0
~7F4X
Text Label 6525 5150 2    60   ~ 0
~7F6X
Text Label 6525 5250 2    60   ~ 0
~7F8X
Text Label 6525 5350 2    60   ~ 0
~7FAX
Text Label 6525 5450 2    60   ~ 0
~7FCX
Text Label 6525 5550 2    60   ~ 0
~7FEX
Text Label 4700 5350 0    60   ~ 0
+5V
Text Label 4700 5450 0    60   ~ 0
GND
$EndSCHEMATC
