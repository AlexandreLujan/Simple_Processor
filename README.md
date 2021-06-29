# Simple_Processor
-Implementation of a Simple Processor in VHDL.<br />
-One Instruction per Cycle.<br />
-Control unit based on a finite state machine.<br />
-Opcode 011 (Debug) stop the processor, preventing any new instruction.<br />
-All instructions are loaded from ROM and can save the result in RAM.<br />

## Built With
-Quartus Prime Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition<br />
(Copyright (C) 2020 Intel Corporation. All rights reserved).

## Circuit Schematic
![alt text](https://github.com/AlexandreLujan/Simple_Processor/blob/main/Schematic.png?raw=true)

## Instructions
![alt text](https://github.com/AlexandreLujan/Simple_Processor/blob/main/Opcode.png?raw=true)

## State Machine
![alt text](https://github.com/AlexandreLujan/Simple_Processor/blob/main/State_Machine.png?raw=true)

## Simulation
-Simulation result using ModelSim-Altera contained in Quartus.<br />
-Note: This project uses a testbench to simulate the clock signal. The testbench needs to be loaded into the simulation.<br />
![alt text](https://github.com/AlexandreLujan/Simple_Processor/blob/main/Simulation.png?raw=true)
