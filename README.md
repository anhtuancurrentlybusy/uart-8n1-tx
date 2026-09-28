# EEE703128 – UART 8N1 Transmitter

A small RTL design project developed for the course **EEE703128 – Introduction to Integrated Circuit Design**.

## Overview

This project focuses on designing a **UART 8N1 transmitter** at the RTL level.

The transmitter receives an 8-bit parallel data byte and serializes it into a UART frame consisting of:

* 1 start bit
* 8 data bits
* 1 stop bit

The project covers the basic design and verification process of a digital IC block, including RTL design, simulation, waveform verification, and RTL-to-GDSII flow.

## Interface

| Signal       | Direction | Description          |
| ------------ | --------- | -------------------- |
| `ui_in[7:0]` | Input     | 8-bit data byte      |
| `uio_in[0]`  | Input     | Transmission request |
| `uo_out[0]`  | Output    | UART TX              |
| `uo_out[1]`  | Output    | Busy status          |
| `uo_out[2]`  | Output    | Done status          |

## Project Information

* **Course:** EEE703128 – Introduction to Integrated Circuit Design
* **Project:** UART 8N1 Transmitter
* **Group:** H – Serial Communication
* **Design Level:** RTL
* **Target:** Digital IC / ASIC design flow
