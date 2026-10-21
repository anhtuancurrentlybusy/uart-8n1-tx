# EEE703128 – UART 8N1 Transmitter

A small RTL design project developed for the course **EEE703128 – Introduction to Integrated Circuit Design**.

## Overview

This project focuses on designing a **UART 8N1 transmitter** at the RTL level.

The transmitter receives an 8-bit parallel data byte and serializes it into a UART frame consisting of:

- 1 start bit
- 8 data bits
- 1 stop bit

The project covers the basic design and verification process of a digital IC block, including RTL design, simulation, waveform verification, and RTL-to-GDSII flow.

## Interface

| **Signal** | **Direction** | **Description** |
|---|---|---|
| `ui_in[7:0]` | Input | 8-bit data byte |
| `uio_in[0]` | Input | Transmission request |
| `uo_out[0]` | Output | UART TX |
| `uo_out[1]` | Output | Busy status |
| `uo_out[2]` | Output | Done status |

## Project Information

- **Course:** EEE703128 – Introduction to Integrated Circuit Design
- **Project:** UART 8N1 Transmitter
- **Group:** H – Serial Communication
- **Design Level:** RTL
- **Target:** Digital IC / ASIC design flow

## Implementation Results

The design was evaluated using an OpenLane RTL-to-GDSII flow.

- **OpenLane run:** `RUN_2026-10-20_09-04-44`
- **Final standard-cell instances:** 161
- **Sequential cells:** 22
- **Standard-cell area:** 1293.74 µm²
- **Core area:** 2169.58 µm²
- **Core utilization:** 59.63%

### Static Timing Analysis

Timing was evaluated across multiple process, voltage, and temperature (PVT) corners.

| Metric | Worst result across analyzed corners |
|---|---:|
| Setup worst slack (WNS) | 13.3689 ns |
| Hold worst slack (WNS) | 0.1133 ns |
| Setup total negative slack (TNS) | 0 ns |
| Hold total negative slack (TNS) | 0 ns |

The worst setup and hold slack values are positive, and both setup and hold TNS are zero. However, five maximum-slew violations remain in the SS corners.

### Power Analysis

Reported total power by PVT corner:

| Corner | Total power |
|---|---:|
| FF, -40°C, 1.95 V | 119.8933 µW |
| SS, 100°C, 1.60 V | 82.22447 µW |
| TT, 25°C, 1.80 V | 103.2835 µW |

These values are from the post-route power reports for the selected run.

### Physical Verification

| Check | Result |
|---|---|
| Magic DRC | 0 violations |
| KLayout DRC | 0 violations |
| LVS | Circuits match uniquely |
| Antenna net violations | 0 |
| Antenna pin violations | 0 |

**Known issue:** Maximum-slew violations remain in the SS corners and require further investigation.
