EESchema Schematic File Version 4
LIBS:pluto-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 8
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
L 65xx:WD65C02_ U1
U 1 1 58D58BE4
P 2175 2350
F 0 "U1" H 1925 3400 60  0000 C CNN
F 1 "WD65C02_" H 2300 1225 60  0000 C CNN
F 2 "Housings_DIP:DIP-40_W15.24mm_Socket" H 1625 2550 60  0001 C CNN
F 3 "" H 1625 2550 60  0000 C CNN
	1    2175 2350
	1    0    0    -1  
$EndComp
NoConn ~ 2825 3250
NoConn ~ 1525 2250
NoConn ~ 1525 2550
NoConn ~ 1525 2350
$Comp
L pluto-rescue:C C9
U 1 1 59051EFC
P 1150 3600
F 0 "C9" H 1175 3700 50  0000 L CNN
F 1 "0.1uF" H 1175 3500 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 1188 3450 50  0001 C CNN
F 3 "" H 1150 3600 50  0001 C CNN
	1    1150 3600
	1    0    0    -1  
$EndComp
$Comp
L pluto-rescue:C C10
U 1 1 59052A5B
P 5775 3700
F 0 "C10" H 5800 3800 50  0000 L CNN
F 1 "0.1uF" H 5800 3600 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 5813 3550 50  0001 C CNN
F 3 "" H 5775 3700 50  0001 C CNN
	1    5775 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR2
U 1 1 5924D5BB
P 1525 3350
F 0 "#PWR2" H 1525 3100 50  0001 C CNN
F 1 "GND" H 1525 3225 50  0000 C CNN
F 2 "" H 1525 3350 50  0001 C CNN
F 3 "" H 1525 3350 50  0001 C CNN
	1    1525 3350
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR1
U 1 1 5924D609
P 1150 3250
F 0 "#PWR1" H 1150 3100 50  0001 C CNN
F 1 "VCC" H 1150 3400 50  0000 C CNN
F 2 "" H 1150 3250 50  0001 C CNN
F 3 "" H 1150 3250 50  0001 C CNN
	1    1150 3250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR4
U 1 1 5924DBE5
P 5775 3550
F 0 "#PWR4" H 5775 3300 50  0001 C CNN
F 1 "GND" H 5775 3425 50  0000 C CNN
F 2 "" H 5775 3550 50  0001 C CNN
F 3 "" H 5775 3550 50  0001 C CNN
	1    5775 3550
	0    1    1    0   
$EndComp
$Comp
L power:VCC #PWR3
U 1 1 5924DCC6
P 5775 1050
F 0 "#PWR3" H 5775 900 50  0001 C CNN
F 1 "VCC" V 5700 1125 50  0000 C CNN
F 2 "" H 5775 1050 50  0001 C CNN
F 3 "" H 5775 1050 50  0001 C CNN
	1    5775 1050
	0    1    1    0   
$EndComp
Text Label 3000 1450 2    60   ~ 0
A0
Text Label 3000 1550 2    60   ~ 0
A1
Text Label 3000 1650 2    60   ~ 0
A2
Text Label 3000 1750 2    60   ~ 0
A3
Text Label 3000 1850 2    60   ~ 0
A4
Text Label 3000 1950 2    60   ~ 0
A5
Text Label 3000 2050 2    60   ~ 0
A6
Text Label 3000 2150 2    60   ~ 0
A7
Text Label 3000 2250 2    60   ~ 0
A8
Text Label 3000 2350 2    60   ~ 0
A9
Text Label 3000 2450 2    60   ~ 0
A10
Text Label 3000 2550 2    60   ~ 0
A11
Text Label 3000 2650 2    60   ~ 0
A12
Text Label 3000 2750 2    60   ~ 0
A13
Text Label 3000 2850 2    60   ~ 0
A14
Text Label 3000 2950 2    60   ~ 0
A15
Entry Wire Line
	3000 1450 3100 1350
Entry Wire Line
	3000 1550 3100 1450
Entry Wire Line
	3000 1650 3100 1550
Entry Wire Line
	3000 1750 3100 1650
Entry Wire Line
	3000 1850 3100 1750
Entry Wire Line
	3000 1950 3100 1850
Entry Wire Line
	3000 2050 3100 1950
Entry Wire Line
	3000 2150 3100 2050
Entry Wire Line
	3000 2250 3100 2150
Entry Wire Line
	3000 2350 3100 2250
Entry Wire Line
	3000 2450 3100 2350
Entry Wire Line
	3000 2550 3100 2450
Entry Wire Line
	3000 2650 3100 2550
Entry Wire Line
	3000 2750 3100 2650
Entry Wire Line
	3000 2850 3100 2750
Entry Wire Line
	3000 2950 3100 2850
Text HLabel 2725 900  0    60   Output ~ 0
A[0..15]
Text Label 4750 1400 0    60   ~ 0
A0
Text Label 4750 1500 0    60   ~ 0
A1
Text Label 4750 1600 0    60   ~ 0
A2
Text Label 4750 1700 0    60   ~ 0
A3
Text Label 4750 1800 0    60   ~ 0
A4
Text Label 4750 1900 0    60   ~ 0
A5
Text Label 4750 2000 0    60   ~ 0
A6
Text Label 4750 2100 0    60   ~ 0
A7
Text Label 4750 2200 0    60   ~ 0
A8
Text Label 4750 2300 0    60   ~ 0
A9
Text Label 4750 2400 0    60   ~ 0
A10
Text Label 4750 2500 0    60   ~ 0
A11
Text Label 4750 2600 0    60   ~ 0
A12
Text Label 4750 2700 0    60   ~ 0
A13
Text Label 4750 2800 0    60   ~ 0
A14
Entry Wire Line
	4650 1300 4750 1400
Entry Wire Line
	4650 1400 4750 1500
Entry Wire Line
	4650 1500 4750 1600
Entry Wire Line
	4650 1600 4750 1700
Entry Wire Line
	4650 1700 4750 1800
Entry Wire Line
	4650 1800 4750 1900
Entry Wire Line
	4650 1900 4750 2000
Entry Wire Line
	4650 2000 4750 2100
Entry Wire Line
	4650 2100 4750 2200
Entry Wire Line
	4650 2200 4750 2300
Entry Wire Line
	4650 2300 4750 2400
Entry Wire Line
	4650 2400 4750 2500
Entry Wire Line
	4650 2500 4750 2600
Entry Wire Line
	4650 2600 4750 2700
Entry Wire Line
	4650 2700 4750 2800
Text Label 4725 900  0    60   ~ 0
A[0..15]
Text Label 7650 1450 0    60   ~ 0
A0
Text Label 7650 1550 0    60   ~ 0
A1
Text Label 7650 1650 0    60   ~ 0
A2
Text Label 7650 1750 0    60   ~ 0
A3
Text Label 7650 1850 0    60   ~ 0
A4
Text Label 7650 1950 0    60   ~ 0
A5
Text Label 7650 2050 0    60   ~ 0
A6
Text Label 7650 2150 0    60   ~ 0
A7
Text Label 7650 2250 0    60   ~ 0
A8
Text Label 7650 2350 0    60   ~ 0
A9
Text Label 7650 2450 0    60   ~ 0
A10
Text Label 7650 2550 0    60   ~ 0
A11
Text Label 7650 2650 0    60   ~ 0
A12
Text Label 7650 2750 0    60   ~ 0
A13
Text Label 7650 2850 0    60   ~ 0
A14
Entry Wire Line
	7550 1350 7650 1450
Entry Wire Line
	7550 1450 7650 1550
Entry Wire Line
	7550 1550 7650 1650
Entry Wire Line
	7550 1650 7650 1750
Entry Wire Line
	7550 1750 7650 1850
Entry Wire Line
	7550 1850 7650 1950
Entry Wire Line
	7550 1950 7650 2050
Entry Wire Line
	7550 2050 7650 2150
Entry Wire Line
	7550 2150 7650 2250
Entry Wire Line
	7550 2250 7650 2350
Entry Wire Line
	7550 2350 7650 2450
Entry Wire Line
	7550 2450 7650 2550
Entry Wire Line
	7550 2550 7650 2650
Entry Wire Line
	7550 2650 7650 2750
Entry Wire Line
	7550 2750 7650 2850
Text Label 1300 1450 0    60   ~ 0
D0
Text Label 1300 1550 0    60   ~ 0
D1
Text Label 1300 1650 0    60   ~ 0
D2
Text Label 1300 1750 0    60   ~ 0
D3
Text Label 1300 1850 0    60   ~ 0
D4
Text Label 1300 1950 0    60   ~ 0
D5
Text Label 1300 2050 0    60   ~ 0
D6
Text Label 1300 2150 0    60   ~ 0
D7
Entry Wire Line
	1200 1350 1300 1450
Entry Wire Line
	1200 1450 1300 1550
Entry Wire Line
	1200 1550 1300 1650
Entry Wire Line
	1200 1650 1300 1750
Entry Wire Line
	1200 1750 1300 1850
Entry Wire Line
	1200 1850 1300 1950
Entry Wire Line
	1200 1950 1300 2050
Entry Wire Line
	1200 2050 1300 2150
Text Label 6650 1400 2    60   ~ 0
D0
Text Label 6650 1500 2    60   ~ 0
D1
Text Label 6650 1600 2    60   ~ 0
D2
Text Label 6650 1700 2    60   ~ 0
D3
Text Label 6650 1800 2    60   ~ 0
D4
Text Label 6650 1900 2    60   ~ 0
D5
Text Label 6650 2000 2    60   ~ 0
D6
Text Label 6650 2100 2    60   ~ 0
D7
Entry Wire Line
	6650 1400 6750 1300
Entry Wire Line
	6650 1500 6750 1400
Entry Wire Line
	6650 1600 6750 1500
Entry Wire Line
	6650 1700 6750 1600
Entry Wire Line
	6650 1800 6750 1700
Entry Wire Line
	6650 1900 6750 1800
Entry Wire Line
	6650 2000 6750 1900
Entry Wire Line
	6650 2100 6750 2000
Text Label 5800 725  0    60   ~ 0
D[0..7]
Text Label 9150 1450 2    60   ~ 0
D0
Text Label 9150 1550 2    60   ~ 0
D1
Text Label 9150 1650 2    60   ~ 0
D2
Text Label 9150 1750 2    60   ~ 0
D3
Text Label 9150 1850 2    60   ~ 0
D4
Text Label 9150 1950 2    60   ~ 0
D5
Text Label 9150 2050 2    60   ~ 0
D6
Text Label 9150 2150 2    60   ~ 0
D7
Entry Wire Line
	9150 1450 9250 1350
Entry Wire Line
	9150 1550 9250 1450
Entry Wire Line
	9150 1650 9250 1550
Entry Wire Line
	9150 1750 9250 1650
Entry Wire Line
	9150 1850 9250 1750
Entry Wire Line
	9150 1950 9250 1850
Entry Wire Line
	9150 2050 9250 1950
Entry Wire Line
	9150 2150 9250 2050
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
	2825 3350 3000 3350
Wire Wire Line
	1525 2650 1300 2650
Wire Wire Line
	1525 2950 1300 2950
Wire Wire Line
	1525 3050 1300 3050
Wire Wire Line
	1525 3150 1300 3150
Wire Wire Line
	1525 2450 1300 2450
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
Wire Wire Line
	8900 1450 9150 1450
Wire Wire Line
	8900 1550 9150 1550
Wire Wire Line
	8900 1650 9150 1650
Wire Wire Line
	8900 1750 9150 1750
Wire Wire Line
	8900 1850 9150 1850
Wire Wire Line
	8900 1950 9150 1950
Wire Wire Line
	8900 2050 9150 2050
Wire Wire Line
	8900 2150 9150 2150
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
Wire Wire Line
	5075 3100 4750 3100
Wire Wire Line
	5075 3200 4750 3200
Wire Wire Line
	8900 2400 9150 2400
Wire Wire Line
	8900 2525 9150 2525
Wire Wire Line
	8900 2650 9150 2650
Wire Wire Line
	1150 3450 1150 3250
Wire Wire Line
	1150 3250 1525 3250
Wire Wire Line
	1150 3750 1525 3750
Wire Wire Line
	1525 3750 1525 3350
Wire Wire Line
	4050 3850 5775 3850
Wire Wire Line
	4050 1050 4050 3850
Wire Wire Line
	4050 1050 5775 1050
Wire Wire Line
	5075 3000 4050 3000
Connection ~ 4050 3000
Wire Bus Line
	3100 900  3100 2850
Wire Bus Line
	4650 900  4650 2700
Wire Bus Line
	7550 900  7550 2750
Wire Bus Line
	1200 725  1200 2050
Wire Bus Line
	6750 725  6750 2000
Wire Bus Line
	9250 725  9250 2050
Wire Bus Line
	975  725  9250 725 
Text HLabel 975  725  0    60   BiDi ~ 0
D[0..7]
Wire Bus Line
	2725 900  7550 900 
Connection ~ 6750 725 
Connection ~ 4650 900 
Connection ~ 3100 900 
Text HLabel 1300 2450 0    60   Input ~ 0
RDY
Text HLabel 1300 2650 0    60   Input ~ 0
BE
Text HLabel 1300 2950 0    60   Input ~ 0
~IRQ
Text HLabel 1300 3050 0    60   Output ~ 0
R/~W
Text HLabel 1300 3150 0    60   Input ~ 0
~NMI
Text HLabel 3000 3350 2    60   Input ~ 0
~RES
Text HLabel 3000 3050 2    60   Input ~ 0
CLK
NoConn ~ 2825 3150
Text HLabel 9150 2400 2    60   Input ~ 0
~MRD
Text HLabel 9150 2650 2    60   Input ~ 0
~MWR
Text HLabel 9150 2525 2    60   Input ~ 0
~RAMSEL
Text HLabel 4750 3100 0    60   Input ~ 0
~MRD
Text HLabel 4750 3200 0    60   Input ~ 0
~ROMSEL
$Comp
L pluto-rescue:28C256-RESCUE-pluto U2
U 1 1 59386D85
P 5775 2300
AR Path="/59386D85" Ref="U2"  Part="1" 
AR Path="/58D5892B/59386D85" Ref="U2"  Part="1" 
F 0 "U2" H 5975 3300 50  0000 C CNN
F 1 "28C256" H 6075 1300 50  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 5775 2300 50  0001 C CNN
F 3 "" H 5775 2300 50  0001 C CNN
	1    5775 2300
	1    0    0    -1  
$EndComp
$Comp
L pluto:AS6C62256A U3
U 1 1 59399129
P 8450 2225
F 0 "U3" H 8575 3100 60  0000 C CNN
F 1 "AS6C62256A" V 8450 2250 60  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 8450 2225 60  0001 C CNN
F 3 "" H 8450 2225 60  0001 C CNN
	1    8450 2225
	1    0    0    -1  
$EndComp
$Comp
L pluto-rescue:C C11
U 1 1 593998AF
P 8450 3550
F 0 "C11" H 8475 3650 50  0000 L CNN
F 1 "0.1uF" H 8475 3450 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 8488 3400 50  0001 C CNN
F 3 "" H 8450 3550 50  0001 C CNN
	1    8450 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8450 3700 7375 3700
Wire Wire Line
	7375 3700 7375 1200
Wire Wire Line
	7375 1200 8450 1200
$Comp
L power:GND #PWR6
U 1 1 5939C93B
P 8450 3200
F 0 "#PWR6" H 8450 2950 50  0001 C CNN
F 1 "GND" H 8450 3050 50  0000 C CNN
F 2 "" H 8450 3200 50  0001 C CNN
F 3 "" H 8450 3200 50  0001 C CNN
	1    8450 3200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8450 3400 8450 3200
$Comp
L power:VCC #PWR5
U 1 1 5939CBCE
P 8450 1200
F 0 "#PWR5" H 8450 1050 50  0001 C CNN
F 1 "VCC" H 8450 1350 50  0000 C CNN
F 2 "" H 8450 1200 50  0001 C CNN
F 3 "" H 8450 1200 50  0001 C CNN
	1    8450 1200
	1    0    0    -1  
$EndComp
Text HLabel 1300 2850 0    60   Input ~ 0
~SO
Wire Wire Line
	1525 2850 1300 2850
$EndSCHEMATC
