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
Sheet 7 7
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
L LM7805 U?
U 1 1 58D5E978
P 2825 1700
F 0 "U?" H 2975 1504 50  0000 C CNN
F 1 "LM7805" H 2825 1900 50  0000 C CNN
F 2 "" H 2825 1700 50  0001 C CNN
F 3 "" H 2825 1700 50  0001 C CNN
	1    2825 1700
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small 10uF
U 1 1 58D5E9AB
P 2425 2175
F 0 "10uF" H 2435 2245 50  0000 L CNN
F 1 "CP1_Small" H 2435 2095 50  0000 L CNN
F 2 "" H 2425 2175 50  0001 C CNN
F 3 "" H 2425 2175 50  0001 C CNN
	1    2425 2175
	1    0    0    -1  
$EndComp
$Comp
L CP1_Small 10uF
U 1 1 58D5EA6C
P 3225 2175
F 0 "10uF" H 3235 2245 50  0000 L CNN
F 1 "CP1_Small" H 3235 2095 50  0000 L CNN
F 2 "" H 3225 2175 50  0001 C CNN
F 3 "" H 3225 2175 50  0001 C CNN
	1    3225 2175
	1    0    0    -1  
$EndComp
Wire Wire Line
	2825 1950 2825 2500
Wire Wire Line
	2425 2275 2425 2500
Wire Wire Line
	1900 2500 3225 2500
Wire Wire Line
	3225 2500 3225 2275
Connection ~ 2825 2500
Connection ~ 2425 2500
$Comp
L GND #PWR?
U 1 1 58D5ED53
P 1900 2500
F 0 "#PWR?" H 1900 2250 50  0001 C CNN
F 1 "GND" H 1900 2350 50  0000 C CNN
F 2 "" H 1900 2500 50  0001 C CNN
F 3 "" H 1900 2500 50  0001 C CNN
	1    1900 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3225 2075 3225 1650
Wire Wire Line
	3225 1650 3875 1650
Wire Wire Line
	2425 2075 2425 1650
$Comp
L VCC #PWR?
U 1 1 58D5EE10
P 3875 1650
F 0 "#PWR?" H 3875 1500 50  0001 C CNN
F 1 "VCC" H 3875 1800 50  0000 C CNN
F 2 "" H 3875 1650 50  0001 C CNN
F 3 "" H 3875 1650 50  0001 C CNN
	1    3875 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2425 1650 1900 1650
$Comp
L +9V #PWR?
U 1 1 58D5EE42
P 1900 1650
F 0 "#PWR?" H 1900 1500 50  0001 C CNN
F 1 "+9V" H 1900 1790 50  0000 C CNN
F 2 "" H 1900 1650 50  0001 C CNN
F 3 "" H 1900 1650 50  0001 C CNN
	1    1900 1650
	1    0    0    -1  
$EndComp
$EndSCHEMATC
