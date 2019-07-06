EESchema Schematic File Version 4
LIBS:pluto-cache
EELAYER 26 0
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
L mechanical:Mounting_Hole MK3
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
L mechanical:Mounting_Hole MK4
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
L mechanical:Mounting_Hole MK5
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
L mechanical:Mounting_Hole MK6
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
L power:GND #PWR43
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
L conn:BARREL_JACK J4
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
L power:VCC #PWR44
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
L device:CP1_Small C7
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
L device:CP1_Small C8
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
L pluto-rescue:LM7805CT-RESCUE-pluto U11
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
L power:+9V #PWR42
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
