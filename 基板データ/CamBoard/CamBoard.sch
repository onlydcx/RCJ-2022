EESchema Schematic File Version 4
EELAYER 30 0
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
L MY_LIB:OpenMV U2
U 1 1 61FA9036
P 3200 2650
F 0 "U2" H 3225 3265 50  0000 C CNN
F 1 "OpenMV" H 3225 3174 50  0000 C CNN
F 2 "OpenMV_KICAD_LIB:OPENMV_H7" H 3200 3300 50  0001 C CNN
F 3 "" H 3200 3300 50  0001 C CNN
	1    3200 2650
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 J1
U 1 1 61FAA18C
P 1200 2550
F 0 "J1" H 1118 2025 50  0000 C CNN
F 1 "Power IN" H 1118 2116 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B6B-XH-A_1x06_P2.50mm_Vertical" H 1200 2550 50  0001 C CNN
F 3 "~" H 1200 2550 50  0001 C CNN
	1    1200 2550
	-1   0    0    1   
$EndComp
Text GLabel 1400 2250 2    50   Input ~ 0
7.4V
Text GLabel 1400 2450 2    50   Input ~ 0
5V
Text GLabel 1400 2650 2    50   Input ~ 0
3.3V
Text GLabel 1400 2550 2    50   Input ~ 0
GND
Text GLabel 1400 2350 2    50   Input ~ 0
GND
Text GLabel 1400 2750 2    50   Input ~ 0
GND
Text GLabel 3550 3000 2    50   Input ~ 0
GND
Text GLabel 3550 2900 2    50   Input ~ 0
5V
$Comp
L teensy:Teensy4.0 U3
U 1 1 61FABFB1
P 6150 3500
F 0 "U3" H 6150 5115 50  0000 C CNN
F 1 "Teensy4.0" H 6150 5024 50  0000 C CNN
F 2 "teensy:Teensy40" H 5750 3700 50  0001 C CNN
F 3 "" H 5750 3700 50  0001 C CNN
	1    6150 3500
	1    0    0    -1  
$EndComp
Text GLabel 7250 4450 2    50   Input ~ 0
5V
Text GLabel 7250 4550 2    50   Input ~ 0
GND
Text GLabel 7750 4500 0    50   Input ~ 0
5V
Text GLabel 8050 4500 2    50   Input ~ 0
GND
$Comp
L Device:C C1
U 1 1 61FAE351
P 7900 4500
F 0 "C1" V 7648 4500 50  0000 C CNN
F 1 "C" V 7739 4500 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 7938 4350 50  0001 C CNN
F 3 "~" H 7900 4500 50  0001 C CNN
	1    7900 4500
	0    1    1    0   
$EndComp
Text GLabel 5050 2150 0    50   Input ~ 0
GND
Text GLabel 5050 3750 0    50   Input ~ 0
GND
Text GLabel 7250 3650 2    50   Input ~ 0
RX
Text GLabel 7250 3550 2    50   Input ~ 0
TX
Text GLabel 2900 2800 0    50   Input ~ 0
RX
Text GLabel 2900 2700 0    50   Input ~ 0
TX
NoConn ~ 2900 2300
NoConn ~ 2900 2400
NoConn ~ 2900 2500
NoConn ~ 2900 2600
NoConn ~ 2900 2900
NoConn ~ 2900 3000
NoConn ~ 3550 2800
NoConn ~ 3550 2700
NoConn ~ 3550 2600
NoConn ~ 3550 2500
NoConn ~ 3550 2400
NoConn ~ 3550 2300
Text GLabel 5050 4150 0    50   Input ~ 0
A0
Text GLabel 5050 4250 0    50   Input ~ 0
A1
Text GLabel 5050 4350 0    50   Input ~ 0
A2
Text GLabel 5050 4450 0    50   Input ~ 0
A3
Text GLabel 7250 4850 2    50   Input ~ 0
A8
Text GLabel 7250 4750 2    50   Input ~ 0
A9
Text GLabel 5050 4750 0    50   Input ~ 0
A6
Text GLabel 5050 4850 0    50   Input ~ 0
A7
NoConn ~ 5050 3850
NoConn ~ 5050 3950
NoConn ~ 5050 4050
Text GLabel 5050 4550 0    50   Input ~ 0
SDA
Text GLabel 5050 4650 0    50   Input ~ 0
SCL
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 61FC0130
P 1450 4300
F 0 "J3" H 1368 3875 50  0000 C CNN
F 1 "I2C Port" H 1368 3966 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 1450 4300 50  0001 C CNN
F 3 "~" H 1450 4300 50  0001 C CNN
	1    1450 4300
	-1   0    0    1   
$EndComp
Text GLabel 1650 4200 2    50   Input ~ 0
SDA
Text GLabel 1650 4100 2    50   Input ~ 0
SCL
Text GLabel 1650 4400 2    50   Input ~ 0
GND
Text GLabel 1650 4300 2    50   Input ~ 0
5V
Text GLabel 2350 4400 2    50   Input ~ 0
SDA
Text GLabel 2350 4300 2    50   Input ~ 0
SCL
Text GLabel 2350 4200 2    50   Input ~ 0
GND
Text GLabel 2350 4100 2    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x04 J5
U 1 1 61FC1EAD
P 2800 4300
F 0 "J5" H 2718 3875 50  0000 C CNN
F 1 "I2C Port" H 2718 3966 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 2800 4300 50  0001 C CNN
F 3 "~" H 2800 4300 50  0001 C CNN
	1    2800 4300
	-1   0    0    1   
$EndComp
Text GLabel 3000 4200 2    50   Input ~ 0
SDA
Text GLabel 3000 4100 2    50   Input ~ 0
SCL
Text GLabel 3000 4400 2    50   Input ~ 0
GND
Text GLabel 3000 4300 2    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x08 J4
U 1 1 61FC3997
P 2150 4500
F 0 "J4" H 2068 3875 50  0000 C CNN
F 1 "Gyro" H 2068 3966 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x08_P2.54mm_Vertical" H 2150 4500 50  0001 C CNN
F 3 "~" H 2150 4500 50  0001 C CNN
	1    2150 4500
	-1   0    0    1   
$EndComp
NoConn ~ 2350 4500
NoConn ~ 2350 4600
NoConn ~ 2350 4700
NoConn ~ 2350 4800
NoConn ~ 5050 2250
NoConn ~ 5050 2350
NoConn ~ 7250 2150
NoConn ~ 7250 2250
Text GLabel 5050 2450 0    50   Input ~ 0
M1_PWM
Text GLabel 5050 2550 0    50   Input ~ 0
M1_DIR
Text GLabel 5050 2650 0    50   Input ~ 0
M2_PWM
Text GLabel 5050 2750 0    50   Input ~ 0
M2_DIR
Text GLabel 5050 2850 0    50   Input ~ 0
M3_PWM
Text GLabel 5050 2950 0    50   Input ~ 0
M3_DIR
Text GLabel 5050 3050 0    50   Input ~ 0
M4_PWM
Text GLabel 5050 3150 0    50   Input ~ 0
M4_DIR
NoConn ~ 5050 3250
NoConn ~ 5050 3350
NoConn ~ 5050 3450
NoConn ~ 5050 3550
NoConn ~ 5050 3650
NoConn ~ 7250 4350
NoConn ~ 7250 4050
NoConn ~ 7250 3950
Text GLabel 7250 3850 2    50   Input ~ 0
A12
$Comp
L Connector_Generic:Conn_01x03 J12
U 1 1 61FBE081
P 8750 3250
F 0 "J12" H 8830 3292 50  0000 L CNN
F 1 "MotorSwitch" H 8830 3201 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 8750 3250 50  0001 C CNN
F 3 "~" H 8750 3250 50  0001 C CNN
	1    8750 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	8550 3250 8100 3250
NoConn ~ 8550 3150
Text GLabel 8800 3600 2    50   Input ~ 0
3.3V
Wire Wire Line
	8550 3350 8450 3350
Wire Wire Line
	8450 3350 8450 3600
Wire Wire Line
	8450 3600 8800 3600
$Comp
L Device:R R7
U 1 1 61FC0311
P 8100 2950
F 0 "R7" H 8170 2996 50  0000 L CNN
F 1 "100k" H 8170 2905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 8030 2950 50  0001 C CNN
F 3 "~" H 8100 2950 50  0001 C CNN
	1    8100 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 3100 8100 3250
Connection ~ 8100 3250
Wire Wire Line
	8100 3250 7250 3250
Wire Wire Line
	8100 2800 8100 2700
Wire Wire Line
	8100 2700 8750 2700
Text GLabel 8750 2700 2    50   Input ~ 0
GND
Text GLabel 7250 3350 2    50   Input ~ 0
LED1
Text GLabel 7250 3450 2    50   Input ~ 0
LED2
Text GLabel 7250 2850 2    50   Input ~ 0
GND
Text GLabel 4150 5800 0    50   Input ~ 0
LED1
Text GLabel 4150 5450 0    50   Input ~ 0
LED2
$Comp
L Device:R R3
U 1 1 61FC2202
P 4550 5450
F 0 "R3" V 4343 5450 50  0000 C CNN
F 1 "100K" V 4434 5450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 4480 5450 50  0001 C CNN
F 3 "~" H 4550 5450 50  0001 C CNN
	1    4550 5450
	0    1    1    0   
$EndComp
$Comp
L Device:R R4
U 1 1 61FC3141
P 4550 5800
F 0 "R4" V 4343 5800 50  0000 C CNN
F 1 "100K" V 4434 5800 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 4480 5800 50  0001 C CNN
F 3 "~" H 4550 5800 50  0001 C CNN
	1    4550 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	4400 5450 4150 5450
Wire Wire Line
	4150 5800 4400 5800
Text GLabel 5000 5450 2    50   Input ~ 0
GND
Text GLabel 5000 5800 2    50   Input ~ 0
GND
Wire Wire Line
	4700 5450 5000 5450
Wire Wire Line
	5000 5800 4700 5800
Text GLabel 7250 2950 2    50   Input ~ 0
UI_1
Text GLabel 7250 3050 2    50   Input ~ 0
UI_2
Text GLabel 7250 3150 2    50   Input ~ 0
UI_3
Text GLabel 7250 3750 2    50   Input ~ 0
UI_4
Text GLabel 6400 5300 0    50   Input ~ 0
M1_PWM
Text GLabel 6400 5400 0    50   Input ~ 0
M1_DIR
Text GLabel 6400 5700 0    50   Input ~ 0
M2_PWM
Text GLabel 6400 5800 0    50   Input ~ 0
M2_DIR
Text GLabel 7600 5300 0    50   Input ~ 0
M3_PWM
Text GLabel 7600 5400 0    50   Input ~ 0
M3_DIR
Text GLabel 7600 5700 0    50   Input ~ 0
M4_PWM
Text GLabel 7600 5800 0    50   Input ~ 0
M4_DIR
$Comp
L Connector_Generic:Conn_01x08 J10
U 1 1 61FC8308
P 6600 5600
F 0 "J10" H 6680 5592 50  0000 L CNN
F 1 "Motor Right" H 6680 5501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_S8B-XH-A_1x08_P2.50mm_Horizontal" H 6600 5600 50  0001 C CNN
F 3 "~" H 6600 5600 50  0001 C CNN
	1    6600 5600
	1    0    0    -1  
$EndComp
Text GLabel 6400 5500 0    50   Input ~ 0
GND
Text GLabel 6400 5600 0    50   Input ~ 0
5V
Text GLabel 6400 5900 0    50   Input ~ 0
GND
Text GLabel 6400 6000 0    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x08 J11
U 1 1 61FCA0EB
P 7800 5600
F 0 "J11" H 7880 5592 50  0000 L CNN
F 1 "Motor Left" H 7880 5501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_S8B-XH-A_1x08_P2.50mm_Horizontal" H 7800 5600 50  0001 C CNN
F 3 "~" H 7800 5600 50  0001 C CNN
	1    7800 5600
	1    0    0    -1  
$EndComp
Text GLabel 7600 5500 0    50   Input ~ 0
GND
Text GLabel 7600 5600 0    50   Input ~ 0
5V
Text GLabel 7600 5900 0    50   Input ~ 0
GND
Text GLabel 7600 6000 0    50   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x08 J13
U 1 1 61FCC8EC
P 8800 5600
F 0 "J13" H 8880 5592 50  0000 L CNN
F 1 "LIne Right" H 8880 5501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_S8B-XH-A_1x08_P2.50mm_Horizontal" H 8800 5600 50  0001 C CNN
F 3 "~" H 8800 5600 50  0001 C CNN
	1    8800 5600
	1    0    0    -1  
$EndComp
Text GLabel 8600 5500 0    50   Input ~ 0
GND
Text GLabel 8600 5900 0    50   Input ~ 0
GND
$Comp
L Connector_Generic:Conn_01x08 J14
U 1 1 61FCC8F6
P 9800 5600
F 0 "J14" H 9880 5592 50  0000 L CNN
F 1 "Line Left" H 9880 5501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_S8B-XH-A_1x08_P2.50mm_Horizontal" H 9800 5600 50  0001 C CNN
F 3 "~" H 9800 5600 50  0001 C CNN
	1    9800 5600
	1    0    0    -1  
$EndComp
Text GLabel 9600 5500 0    50   Input ~ 0
GND
Text GLabel 9600 5900 0    50   Input ~ 0
GND
Text GLabel 8600 5600 0    50   Input ~ 0
3.3V
Text GLabel 8600 6000 0    50   Input ~ 0
3.3V
Text GLabel 9600 6000 0    50   Input ~ 0
3.3V
Text GLabel 9600 5600 0    50   Input ~ 0
3.3V
Text GLabel 8600 5300 0    50   Input ~ 0
A0
Text GLabel 8600 5400 0    50   Input ~ 0
A1
Text GLabel 8600 5700 0    50   Input ~ 0
A2
Text GLabel 8600 5800 0    50   Input ~ 0
A3
Text GLabel 9600 5300 0    50   Input ~ 0
A6
Text GLabel 9600 5400 0    50   Input ~ 0
A7
Text GLabel 9600 5700 0    50   Input ~ 0
A8
Text GLabel 9600 5800 0    50   Input ~ 0
A9
Text GLabel 1650 5750 2    50   Input ~ 0
UI_1
Text GLabel 1650 5900 2    50   Input ~ 0
UI_2
Text GLabel 1650 6050 2    50   Input ~ 0
UI_3
Text GLabel 1650 6200 2    50   Input ~ 0
UI_4
Text GLabel 1050 5750 0    50   Input ~ 0
GND
Text GLabel 1050 6050 0    50   Input ~ 0
5V
Text GLabel 1050 6200 0    50   Input ~ 0
SDA
Text GLabel 1050 6350 0    50   Input ~ 0
SCL
Text GLabel 1650 6350 2    50   Input ~ 0
3.3V
$Comp
L Connector_Generic:Conn_01x04 J7
U 1 1 61FD8365
P 3050 7500
F 0 "J7" H 3130 7492 50  0000 L CNN
F 1 "HC SR04" H 3130 7401 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 3050 7500 50  0001 C CNN
F 3 "~" H 3050 7500 50  0001 C CNN
	1    3050 7500
	-1   0    0    1   
$EndComp
Text GLabel 3250 7600 2    50   Input ~ 0
GND
Text GLabel 3250 7300 2    50   Input ~ 0
5V
$Comp
L Device:R R2
U 1 1 61FD9A77
P 3750 7400
F 0 "R2" V 3543 7400 50  0000 C CNN
F 1 "R" V 3634 7400 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 3680 7400 50  0001 C CNN
F 3 "~" H 3750 7400 50  0001 C CNN
	1    3750 7400
	0    1    1    0   
$EndComp
Wire Wire Line
	3250 7500 4050 7500
Wire Wire Line
	4050 7500 4050 7400
Wire Wire Line
	4050 7400 3900 7400
$Comp
L Connector_Generic:Conn_01x04 J9
U 1 1 61FDC7CB
P 4550 7500
F 0 "J9" H 4630 7492 50  0000 L CNN
F 1 "HC SR04" H 4630 7401 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 4550 7500 50  0001 C CNN
F 3 "~" H 4550 7500 50  0001 C CNN
	1    4550 7500
	-1   0    0    1   
$EndComp
Text GLabel 4750 7600 2    50   Input ~ 0
GND
Text GLabel 4750 7300 2    50   Input ~ 0
5V
$Comp
L Device:R R6
U 1 1 61FDC7D3
P 5250 7400
F 0 "R6" V 5043 7400 50  0000 C CNN
F 1 "R" V 5134 7400 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 5180 7400 50  0001 C CNN
F 3 "~" H 5250 7400 50  0001 C CNN
	1    5250 7400
	0    1    1    0   
$EndComp
Wire Wire Line
	4750 7500 5550 7500
Wire Wire Line
	5550 7500 5550 7400
Wire Wire Line
	5550 7400 5400 7400
$Comp
L Connector_Generic:Conn_01x04 J6
U 1 1 61FDF321
P 3050 6750
F 0 "J6" H 3130 6742 50  0000 L CNN
F 1 "HC SR04" H 3130 6651 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 3050 6750 50  0001 C CNN
F 3 "~" H 3050 6750 50  0001 C CNN
	1    3050 6750
	-1   0    0    1   
$EndComp
Text GLabel 3250 6850 2    50   Input ~ 0
GND
Text GLabel 3250 6550 2    50   Input ~ 0
5V
$Comp
L Device:R R1
U 1 1 61FDF329
P 3750 6650
F 0 "R1" V 3543 6650 50  0000 C CNN
F 1 "R" V 3634 6650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 3680 6650 50  0001 C CNN
F 3 "~" H 3750 6650 50  0001 C CNN
	1    3750 6650
	0    1    1    0   
$EndComp
Wire Wire Line
	3600 6650 3500 6650
Wire Wire Line
	3250 6750 4050 6750
Wire Wire Line
	4050 6750 4050 6650
Wire Wire Line
	4050 6650 3900 6650
$Comp
L Connector_Generic:Conn_01x04 J8
U 1 1 61FDF333
P 4550 6750
F 0 "J8" H 4630 6742 50  0000 L CNN
F 1 "HC SR04" H 4630 6651 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x04_P2.54mm_Vertical" H 4550 6750 50  0001 C CNN
F 3 "~" H 4550 6750 50  0001 C CNN
	1    4550 6750
	-1   0    0    1   
$EndComp
Text GLabel 4750 6850 2    50   Input ~ 0
GND
Text GLabel 4750 6550 2    50   Input ~ 0
5V
$Comp
L Device:R R5
U 1 1 61FDF33B
P 5250 6650
F 0 "R5" V 5043 6650 50  0000 C CNN
F 1 "R" V 5134 6650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 5180 6650 50  0001 C CNN
F 3 "~" H 5250 6650 50  0001 C CNN
	1    5250 6650
	0    1    1    0   
$EndComp
Wire Wire Line
	5100 6650 5000 6650
Wire Wire Line
	4750 6750 5550 6750
Wire Wire Line
	5550 6750 5550 6650
Wire Wire Line
	5550 6650 5400 6650
Text GLabel 3500 6250 2    50   Input ~ 0
HC-SR04-Front
Text GLabel 5000 6250 2    50   Input ~ 0
HC-SR04-Back
Text GLabel 3500 7050 2    50   Input ~ 0
HC-SR04-Left
Text GLabel 5000 7050 2    50   Input ~ 0
HC-SR04-Right
Wire Wire Line
	5000 6250 5000 6650
Connection ~ 5000 6650
Wire Wire Line
	5000 6650 4750 6650
Wire Wire Line
	5000 7050 5000 7400
Wire Wire Line
	3500 7050 3500 7400
Wire Wire Line
	3500 6250 3500 6650
Connection ~ 3500 6650
Wire Wire Line
	3500 6650 3250 6650
Connection ~ 3500 7400
Wire Wire Line
	3500 7400 3250 7400
Wire Wire Line
	3500 7400 3600 7400
Connection ~ 5000 7400
Wire Wire Line
	5000 7400 4750 7400
Wire Wire Line
	5000 7400 5100 7400
$Comp
L MY_LIB:10pin_FlatCable U1
U 1 1 61FF0005
P 1350 6050
F 0 "U1" H 1350 6575 50  0000 C CNN
F 1 "10pin_FlatCable" H 1350 6484 50  0000 C CNN
F 2 "My_Lib:20pin_FlatCable" H 1350 6600 50  0001 C CNN
F 3 "" H 1350 6600 50  0001 C CNN
	1    1350 6050
	1    0    0    -1  
$EndComp
Text GLabel 1050 5900 0    50   Input ~ 0
GND
NoConn ~ 7250 4650
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 61FFA8B9
P 1200 3250
F 0 "J2" H 1280 3242 50  0000 L CNN
F 1 "Voltage" H 1280 3151 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B2B-XH-A_1x02_P2.50mm_Vertical" H 1200 3250 50  0001 C CNN
F 3 "~" H 1200 3250 50  0001 C CNN
	1    1200 3250
	-1   0    0    1   
$EndComp
Text GLabel 1400 3150 2    50   Input ~ 0
7.4V
Text GLabel 1400 3250 2    50   Input ~ 0
GND
$Comp
L Connector_Generic:Conn_01x04 J15
U 1 1 61FFE5CC
P 9700 4600
F 0 "J15" H 9780 4592 50  0000 L CNN
F 1 "Conn_01x04" H 9780 4501 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B4B-XH-A_1x04_P2.50mm_Vertical" H 9700 4600 50  0001 C CNN
F 3 "~" H 9700 4600 50  0001 C CNN
	1    9700 4600
	1    0    0    -1  
$EndComp
Text GLabel 9200 4500 0    50   Input ~ 0
A12
Text GLabel 9500 4600 0    50   Input ~ 0
3.3V
Wire Wire Line
	9500 4500 9450 4500
$Comp
L Device:R R9
U 1 1 620026D5
P 9450 4150
F 0 "R9" H 9520 4196 50  0000 L CNN
F 1 "100k" H 9520 4105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 9380 4150 50  0001 C CNN
F 3 "~" H 9450 4150 50  0001 C CNN
	1    9450 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9450 4000 9450 3900
Wire Wire Line
	9450 3900 10100 3900
Text GLabel 10100 3900 2    50   Input ~ 0
GND
Wire Wire Line
	9450 4300 9450 4500
Connection ~ 9450 4500
Wire Wire Line
	9450 4500 9200 4500
Text GLabel 9050 4800 0    50   Input ~ 0
3.3V
Text GLabel 9500 4700 0    50   Input ~ 0
GND
$Comp
L Device:R R8
U 1 1 6200A0DC
P 9350 4800
F 0 "R8" H 9420 4846 50  0000 L CNN
F 1 "47" H 9420 4755 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P12.70mm_Horizontal" V 9280 4800 50  0001 C CNN
F 3 "~" H 9350 4800 50  0001 C CNN
	1    9350 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	9200 4800 9050 4800
Text GLabel 7250 2350 2    50   Input ~ 0
HC-SR04-Front
Text GLabel 7250 2450 2    50   Input ~ 0
HC-SR04-Back
Text GLabel 7250 2550 2    50   Input ~ 0
HC-SR04-Right
Text GLabel 7250 2750 2    50   Input ~ 0
HC-SR04-Left
NoConn ~ 7250 2650
$EndSCHEMATC
