EESchema Schematic File Version 2
LIBS:IDE_interface-rescue
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
LIBS:IDE_interface
LIBS:65xx
LIBS:IDE_interface-cache
EELAYER 25 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
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
L 74HC74 U3
U 1 1 5820EACB
P 3900 2550
F 0 "U3" H 4050 2850 50  0000 C CNN
F 1 "74HC74" H 4200 2255 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 3900 2550 50  0001 C CNN
F 3 "" H 3900 2550 50  0000 C CNN
	1    3900 2550
	1    0    0    -1  
$EndComp
$Comp
L 74HC74 U3
U 2 1 5820EB0E
P 3900 4200
F 0 "U3" H 4050 4500 50  0000 C CNN
F 1 "74HC74" H 4200 3905 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 3900 4200 50  0001 C CNN
F 3 "" H 3900 4200 50  0000 C CNN
	2    3900 4200
	1    0    0    -1  
$EndComp
$Comp
L 74LS139 U2
U 1 1 5820EE79
P 3850 1200
F 0 "U2" H 3850 1300 50  0000 C CNN
F 1 "74LS139" H 3850 1100 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 3850 1200 50  0001 C CNN
F 3 "" H 3850 1200 50  0000 C CNN
	1    3850 1200
	1    0    0    -1  
$EndComp
$Comp
L 74LS139 U2
U 2 1 5820EEDC
P 3850 5600
F 0 "U2" H 3850 5700 50  0000 C CNN
F 1 "74LS139" H 3850 5500 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm_Socket" H 3850 5600 50  0001 C CNN
F 3 "" H 3850 5600 50  0000 C CNN
	2    3850 5600
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 1 1 5820EFAD
P 2100 2350
F 0 "U1" H 2100 2400 50  0000 C CNN
F 1 "74LS32" H 2100 2300 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 2100 2350 50  0001 C CNN
F 3 "" H 2100 2350 50  0000 C CNN
	1    2100 2350
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 2 1 5820EFE4
P 2100 4000
F 0 "U1" H 2100 4050 50  0000 C CNN
F 1 "74LS32" H 2100 3950 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 2100 4000 50  0001 C CNN
F 3 "" H 2100 4000 50  0000 C CNN
	2    2100 4000
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 4 1 5820F025
P 8900 2450
F 0 "U1" H 8900 2500 50  0000 C CNN
F 1 "74LS32" H 8900 2400 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 8900 2450 50  0001 C CNN
F 3 "" H 8900 2450 50  0000 C CNN
	4    8900 2450
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U1
U 3 1 5820F1DF
P 6000 6600
F 0 "U1" H 6000 6650 50  0000 C CNN
F 1 "74LS32" H 6000 6550 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm_Socket" H 6000 6600 50  0001 C CNN
F 3 "" H 6000 6600 50  0000 C CNN
	3    6000 6600
	1    0    0    -1  
$EndComp
$Comp
L 74LS08 U4
U 2 1 5820F878
P 7550 2550
F 0 "U4" H 7550 2600 50  0000 C CNN
F 1 "74LS08" H 7550 2500 50  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm_Socket" H 7550 2550 50  0001 C CNN
F 3 "" H 7550 2550 50  0000 C CNN
	2    7550 2550
	1    0    0    -1  
$EndComp
$Comp
L 74LS574 U5
U 1 1 5820FDE3
P 12375 2900
F 0 "U5" H 12375 2900 50  0000 C CNN
F 1 "74LS574" H 12425 2550 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12375 2900 50  0001 C CNN
F 3 "" H 12375 2900 50  0000 C CNN
	1    12375 2900
	1    0    0    -1  
$EndComp
$Comp
L 74LS574 U6
U 1 1 5820FE38
P 12400 5100
F 0 "U6" H 12400 5100 50  0000 C CNN
F 1 "74LS574" H 12450 4750 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12400 5100 50  0001 C CNN
F 3 "" H 12400 5100 50  0000 C CNN
	1    12400 5100
	1    0    0    -1  
$EndComp
$Comp
L 74HC245 U7
U 1 1 5820FEE9
P 12425 6900
F 0 "U7" H 12525 7475 50  0000 L BNN
F 1 "74HC245" H 12475 6325 50  0000 L TNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 12425 6900 50  0001 C CNN
F 3 "" H 12425 6900 50  0000 C CNN
	1    12425 6900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 5820FF30
P 1350 950
F 0 "#PWR01" H 1350 700 50  0001 C CNN
F 1 "GND" V 1350 775 50  0000 C CNN
F 2 "" H 1350 950 50  0000 C CNN
F 3 "" H 1350 950 50  0000 C CNN
	1    1350 950 
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR02
U 1 1 5820FF5E
P 1325 1650
F 0 "#PWR02" H 1325 1500 50  0001 C CNN
F 1 "VCC" V 1325 1825 50  0000 C CNN
F 2 "" H 1325 1650 50  0000 C CNN
F 3 "" H 1325 1650 50  0000 C CNN
	1    1325 1650
	0    -1   -1   0   
$EndComp
$Comp
L R R5
U 1 1 5820FF8C
P 1750 1650
F 0 "R5" V 1830 1650 50  0000 C CNN
F 1 "1k" V 1750 1650 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 1680 1650 50  0001 C CNN
F 3 "" H 1750 1650 50  0000 C CNN
	1    1750 1650
	0    1    1    0   
$EndComp
NoConn ~ 4500 2750
NoConn ~ 4500 4400
$Comp
L R R1
U 1 1 5821346D
P 1050 8250
F 0 "R1" V 1130 8250 50  0000 C CNN
F 1 "3.3K" V 1050 8250 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8250 50  0001 C CNN
F 3 "" H 1050 8250 50  0000 C CNN
	1    1050 8250
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 582134B0
P 1050 8450
F 0 "R2" V 1130 8450 50  0000 C CNN
F 1 "1K" V 1050 8450 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8450 50  0001 C CNN
F 3 "" H 1050 8450 50  0000 C CNN
	1    1050 8450
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 5821353B
P 1050 8650
F 0 "R3" V 1130 8650 50  0000 C CNN
F 1 "1K" V 1050 8650 50  0000 C CNN
F 2 "Resistors_ThroughHole:R_Axial_DIN0411_L9.9mm_D3.6mm_P12.70mm_Horizontal" V 980 8650 50  0001 C CNN
F 3 "" H 1050 8650 50  0000 C CNN
	1    1050 8650
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR03
U 1 1 582135C3
P 800 8050
F 0 "#PWR03" H 800 7900 50  0001 C CNN
F 1 "VCC" H 800 8200 50  0000 C CNN
F 2 "" H 800 8050 50  0000 C CNN
F 3 "" H 800 8050 50  0000 C CNN
	1    800  8050
	1    0    0    -1  
$EndComp
$Comp
L 74LS08 U4
U 1 1 5820F7B6
P 6000 2450
F 0 "U4" H 6000 2500 50  0000 C CNN
F 1 "74LS08" H 6000 2400 50  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm_Socket" H 6000 2450 50  0001 C CNN
F 3 "" H 6000 2450 50  0000 C CNN
	1    6000 2450
	1    0    0    -1  
$EndComp
$Comp
L LED-RESCUE-IDE_interface D1
U 1 1 5821ACFF
P 1500 8650
F 0 "D1" H 1500 8750 50  0000 C CNN
F 1 "LED" H 1500 8550 50  0000 C CNN
F 2 "LEDs:LED_D3.0mm" H 1500 8650 50  0001 C CNN
F 3 "" H 1500 8650 50  0000 C CNN
	1    1500 8650
	-1   0    0    1   
$EndComp
NoConn ~ 4700 5700
NoConn ~ 4700 5900
NoConn ~ 4700 5300
NoConn ~ 4700 1300
NoConn ~ 4700 1500
$Comp
L GND #PWR04
U 1 1 5821EF6B
P 2150 6050
F 0 "#PWR04" H 2150 5800 50  0001 C CNN
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
L CONN_02X20 P2
U 1 1 58235DE2
P 15000 1850
F 0 "P2" H 15000 2900 50  0000 C CNN
F 1 "IDE0" V 15000 1850 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_40pins" H 15000 900 50  0001 C CNN
F 3 "" H 15000 900 50  0000 C CNN
	1    15000 1850
	1    0    0    -1  
$EndComp
Text Label 14425 900  0    60   ~ 0
~RES
Text Label 14350 1000 0    60   ~ 0
IDE-D7
Text Label 14350 1100 0    60   ~ 0
IDE-D6
Text Label 14350 1200 0    60   ~ 0
IDE-D5
Text Label 14350 1300 0    60   ~ 0
IDE-D4
Text Label 14350 1400 0    60   ~ 0
IDE-D3
Text Label 14350 1500 0    60   ~ 0
IDE-D2
Text Label 14350 1600 0    60   ~ 0
IDE-D1
Text Label 14350 1700 0    60   ~ 0
IDE-D0
Text Label 15750 1000 2    60   ~ 0
IDE-D8
Text Label 15750 1100 2    60   ~ 0
IDE-D9
Text Label 15750 1200 2    60   ~ 0
IDE-D10
Text Label 15750 1300 2    60   ~ 0
IDE-D11
Text Label 15750 1400 2    60   ~ 0
IDE-D12
Text Label 15750 1500 2    60   ~ 0
IDE-D13
Text Label 15750 1600 2    60   ~ 0
IDE-D14
Text Label 15750 1700 2    60   ~ 0
IDE-D15
NoConn ~ 15250 1800
Text Label 14350 1900 0    60   ~ 0
DMARQ
Text Label 14350 2000 0    60   ~ 0
~DIOW
Text Label 14350 2100 0    60   ~ 0
~DIOR
Text Label 14350 2200 0    60   ~ 0
IORDY
Text Label 14200 2300 0    60   ~ 0
~IDE:DMACK
Text Label 14350 2400 0    60   ~ 0
~IRQ
Text Label 14350 2500 0    60   ~ 0
A1
Text Label 14350 2600 0    60   ~ 0
A0
Text Label 15750 2600 2    60   ~ 0
A2
Text Label 14350 2700 0    60   ~ 0
~IDE:CS0
Text Label 14350 2800 0    60   ~ 0
~IDE:DASP
$Comp
L CONN_02X25 P1
U 1 1 58243ADE
P 3900 8600
F 0 "P1" H 3900 9900 50  0000 C CNN
F 1 "EXPANSION PORT" V 3900 8600 50  0000 C CNN
F 2 "Connect:IDC_Header_Straight_50pins" H 3900 7850 50  0001 C CNN
F 3 "" H 3900 7850 50  0000 C CNN
	1    3900 8600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR05
U 1 1 582450DC
P 3900 7050
F 0 "#PWR05" H 3900 6900 50  0001 C CNN
F 1 "VCC" H 3900 7200 50  0000 C CNN
F 2 "" H 3900 7050 50  0000 C CNN
F 3 "" H 3900 7050 50  0000 C CNN
	1    3900 7050
	1    0    0    -1  
$EndComp
Text Label 3250 7500 0    60   ~ 0
A14
Text Label 3250 7600 0    60   ~ 0
A12
Text Label 3250 7700 0    60   ~ 0
A7
Text Label 3250 7800 0    60   ~ 0
A6
Text Label 3250 7900 0    60   ~ 0
A5
Text Label 3250 8100 0    60   ~ 0
A3
Text Label 3250 8200 0    60   ~ 0
A2
Text Label 3250 8300 0    60   ~ 0
A1
Text Label 3250 8400 0    60   ~ 0
A0
Text Label 4450 7700 2    60   ~ 0
A13
Text Label 4450 7800 2    60   ~ 0
A8
Text Label 4450 7900 2    60   ~ 0
A9
Text Label 4450 8000 2    60   ~ 0
A11
Text Label 4450 8200 2    60   ~ 0
A10
Text Label 4450 7600 2    60   ~ 0
~MWR
Text Label 4450 8100 2    60   ~ 0
~MRD
Text Label 4450 8400 2    60   ~ 0
D7
Text Label 4450 8500 2    60   ~ 0
D6
Text Label 4450 8600 2    60   ~ 0
D5
Text Label 4450 8700 2    60   ~ 0
D4
Text Label 4450 8800 2    60   ~ 0
D3
Text Label 4450 8900 2    60   ~ 0
A15
Text Label 3250 8500 0    60   ~ 0
D0
Text Label 3250 8600 0    60   ~ 0
D1
Text Label 3250 8700 0    60   ~ 0
D2
Text Label 3250 9000 0    60   ~ 0
~RES
Text Label 3250 9100 0    60   ~ 0
CLK2
Text Label 3250 9200 0    60   ~ 0
~IRQ
Text Label 3250 9300 0    60   ~ 0
~7FXX
Text Label 3250 9400 0    60   ~ 0
~NMI
Text Label 3250 9500 0    60   ~ 0
~R/W
$Comp
L GND #PWR06
U 1 1 58246EF9
P 3900 10100
F 0 "#PWR06" H 3900 9850 50  0001 C CNN
F 1 "GND" H 3900 9950 50  0000 C CNN
F 2 "" H 3900 10100 50  0000 C CNN
F 3 "" H 3900 10100 50  0000 C CNN
	1    3900 10100
	1    0    0    -1  
$EndComp
NoConn ~ 4150 8300
NoConn ~ 3650 8800
NoConn ~ 3650 8900
NoConn ~ 3650 9600
NoConn ~ 3650 9700
NoConn ~ 4150 7500
Text Label 4450 9000 2    60   ~ 0
~7F0X
Text Label 4450 9100 2    60   ~ 0
~7F2X
Text Label 4450 9200 2    60   ~ 0
~7F4X
Text Label 4450 9300 2    60   ~ 0
~7F6X
Text Label 4450 9400 2    60   ~ 0
~7F8X
Text Label 4450 9500 2    60   ~ 0
~7FAX
Text Label 4450 9600 2    60   ~ 0
~7FCX
Text Label 4450 9700 2    60   ~ 0
~7FEX
Text Label 15750 2700 2    60   ~ 0
~IDE:CS1
Text Label 15750 2800 2    60   ~ 0
GND
NoConn ~ 3250 7500
NoConn ~ 3250 7600
NoConn ~ 3250 7700
NoConn ~ 3250 7800
NoConn ~ 3250 7900
NoConn ~ 4450 7700
NoConn ~ 4450 7800
NoConn ~ 4450 7900
NoConn ~ 4450 8000
NoConn ~ 4450 8200
NoConn ~ 4450 8900
NoConn ~ 3250 9300
NoConn ~ 3250 9400
NoConn ~ 3250 9500
NoConn ~ 14350 1900
Text Label 14350 1800 0    60   ~ 0
GND
Text Label 15750 900  2    60   ~ 0
GND
Text Label 15750 1900 2    60   ~ 0
GND
Text Label 15750 2000 2    60   ~ 0
GND
Text Label 15750 2100 2    60   ~ 0
GND
NoConn ~ 15250 2200
NoConn ~ 15250 2500
NoConn ~ 14350 2200
Text Label 15750 2300 2    60   ~ 0
GND
Text Label 1100 1100 0    60   ~ 0
A3
Text Label 1100 2250 0    60   ~ 0
~MRD
Text Label 1100 1950 0    60   ~ 0
CLK2
Text Label 1100 3100 0    60   ~ 0
~7F8X
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
Text Label 15750 2400 2    60   ~ 0
GND
Text Label 4150 7300 0    60   ~ 0
VCC
Text Label 3650 7250 0    60   ~ 0
VCC
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
	1700 8650 2100 8650
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
	4700 900  10400 900 
Wire Wire Line
	10400 900  10400 3300
Wire Wire Line
	10400 3300 11675 3300
Wire Wire Line
	4700 1100 10200 1100
Wire Wire Line
	10200 1100 10200 3400
Wire Wire Line
	10200 3400 11675 3400
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
	14750 900  14425 900 
Wire Wire Line
	14750 1000 14350 1000
Wire Wire Line
	14750 1100 14350 1100
Wire Wire Line
	14750 1200 14350 1200
Wire Wire Line
	14750 1300 14350 1300
Wire Wire Line
	14750 1400 14350 1400
Wire Wire Line
	14750 1500 14350 1500
Wire Wire Line
	14750 1600 14350 1600
Wire Wire Line
	14750 1700 14350 1700
Wire Wire Line
	14750 1800 14350 1800
Wire Wire Line
	14750 1900 14350 1900
Wire Wire Line
	14750 2000 14350 2000
Wire Wire Line
	14750 2100 14350 2100
Wire Wire Line
	14750 2200 14350 2200
Wire Wire Line
	14750 2300 14200 2300
Wire Wire Line
	14750 2500 14350 2500
Wire Wire Line
	14750 2600 14350 2600
Wire Wire Line
	14750 2700 14350 2700
Wire Wire Line
	14750 2800 14350 2800
Wire Wire Line
	15250 1000 15750 1000
Wire Wire Line
	15250 1100 15750 1100
Wire Wire Line
	15250 1200 15750 1200
Wire Wire Line
	15250 1300 15750 1300
Wire Wire Line
	15250 1400 15750 1400
Wire Wire Line
	15250 1500 15750 1500
Wire Wire Line
	15250 1600 15750 1600
Wire Wire Line
	15250 1700 15750 1700
Wire Wire Line
	15250 1900 15750 1900
Wire Wire Line
	15250 2000 15750 2000
Wire Wire Line
	15250 2100 15750 2100
Wire Wire Line
	15250 2300 15750 2300
Wire Wire Line
	15250 2600 15750 2600
Wire Wire Line
	15250 2700 15750 2700
Wire Wire Line
	15250 2800 15750 2800
Wire Wire Line
	15250 900  15750 900 
Wire Wire Line
	3650 7400 3650 7050
Wire Wire Line
	3650 7050 4150 7050
Wire Wire Line
	4150 7050 4150 7400
Connection ~ 3900 7050
Wire Wire Line
	4150 10100 4150 9800
Wire Wire Line
	3650 10100 4150 10100
Wire Wire Line
	3650 9800 3650 10100
Connection ~ 3900 10100
Wire Wire Line
	4150 7600 4450 7600
Wire Wire Line
	4150 7700 4450 7700
Wire Wire Line
	4150 7800 4450 7800
Wire Wire Line
	4150 7900 4450 7900
Wire Wire Line
	4150 8000 4450 8000
Wire Wire Line
	4150 8100 4450 8100
Wire Wire Line
	4150 8200 4450 8200
Wire Wire Line
	4150 8400 4450 8400
Wire Wire Line
	4150 8500 4450 8500
Wire Wire Line
	4150 8600 4450 8600
Wire Wire Line
	4150 8700 4450 8700
Wire Wire Line
	4150 8800 4450 8800
Wire Wire Line
	4150 8900 4450 8900
Wire Wire Line
	4150 9000 4450 9000
Wire Wire Line
	4150 9100 4450 9100
Wire Wire Line
	4150 9200 4450 9200
Wire Wire Line
	4150 9300 4450 9300
Wire Wire Line
	4150 9400 4450 9400
Wire Wire Line
	4150 9500 4450 9500
Wire Wire Line
	4150 9600 4450 9600
Wire Wire Line
	4150 9700 4450 9700
Wire Wire Line
	3650 7500 3250 7500
Wire Wire Line
	3650 7600 3250 7600
Wire Wire Line
	3650 7700 3250 7700
Wire Wire Line
	3650 7800 3250 7800
Wire Wire Line
	3650 7900 3250 7900
Wire Wire Line
	3650 8100 3250 8100
Wire Wire Line
	3650 8200 3250 8200
Wire Wire Line
	3650 8300 3250 8300
Wire Wire Line
	3650 8400 3250 8400
Wire Wire Line
	3650 8500 3250 8500
Wire Wire Line
	3650 8600 3250 8600
Wire Wire Line
	3650 8700 3250 8700
Wire Wire Line
	3650 9000 3250 9000
Wire Wire Line
	3650 9100 3250 9100
Wire Wire Line
	3650 9200 3250 9200
Wire Wire Line
	3650 9300 3250 9300
Wire Wire Line
	3650 9400 3250 9400
Wire Wire Line
	3650 9500 3250 9500
Wire Wire Line
	14750 2400 14350 2400
Wire Wire Line
	15250 2400 15750 2400
NoConn ~ 4450 9000
NoConn ~ 4450 9100
NoConn ~ 4450 9200
NoConn ~ 4450 9300
NoConn ~ 4450 9600
NoConn ~ 4450 9700
Text Label 3650 8000 2    60   ~ 0
A4
NoConn ~ 3650 8000
NoConn ~ 4450 9500
$EndSCHEMATC
