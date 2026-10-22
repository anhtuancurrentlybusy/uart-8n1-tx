# UART 8N1 Transmitter — Design Specification

## 1. Overview

This project implements a UART (Universal Asynchronous Receiver/Transmitter) 8N1 transmitter using Verilog/SystemVerilog RTL.

The transmitter converts an 8-bit parallel input byte into a serial UART frame and transmits the frame through a single TX output. The project also provides status signals to indicate transmission activity and completion.

The design is developed and verified using RTL simulation, followed by synthesis and an ASIC-oriented implementation flow.

### 1.1 Objectives

- Implement UART 8N1 serial transmission.
- Transmit data least-significant bit first (LSB-first).
- Generate baud timing from the system clock using a configurable clock-cycle count.
- Provide transmission status through `busy` and `done` signals.
- Verify normal transmission, timing, consecutive requests, and reset behavior.
- Evaluate the design using synthesis, timing analysis, power analysis, and physical-design checks.

### 1.2 Scope

**Included:**
- UART transmitter
- 8-bit data input
- Start and stop bit generation
- Clock-cycle-based baud timing
- Transmission status signals
- RTL testbench and simulation
- ASIC implementation and report collection

**Excluded:**
- UART receiver
- APB or other bus interfaces
- FIFO buffering
- Parity generation
- Configurable data width or stop-bit count

The supported serial format is fixed at 8N1.

## 2. Functional Requirements

| ID | Requirement |
|---|---|
| FR-01 | The transmitter shall accept an 8-bit parallel data value. |
| FR-02 | Each transmitted frame shall contain one start bit, eight data bits, and one stop bit. |
| FR-03 | The start bit shall be logic `0`. |
| FR-04 | The eight data bits shall be transmitted LSB-first. |
| FR-05 | The stop bit shall be logic `1`. |
| FR-06 | The transmitter shall use a configurable number of system-clock cycles per transmitted bit. |
| FR-07 | The `busy` signal shall indicate that a transmission is in progress. |
| FR-08 | The `done` signal shall indicate completion of a transmitted frame. |
| FR-09 | The transmitter shall support separate transmission requests and sequential byte transmissions when permitted by the control logic. |
| FR-10 | An active-low reset shall initialize the transmitter to its idle condition and abort an in-progress transmission. |

## 3. Interface Specification

### 3.1 RTL Interface

The following table describes the functional RTL interface.

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | System clock |
| `rst_n` | Input | 1 | Active-low reset |
| `valid_in` | Input | 1 | Requests transmission of the input byte |
| `data_in` | Input | 8 | Parallel byte to transmit |
| `CLKS_PER_BIT` | Input or configuration parameter | Implementation-defined | Number of system-clock cycles per UART bit |
| `tx` | Output | 1 | Serial UART transmit signal |
| `busy` | Output | 1 | Indicates an active transmission |
| `done` | Output | 1 | Indicates completion of a transmission |

**Implementation note:** Confirm whether `CLKS_PER_BIT` is declared as a module parameter or an input in the final RTL. The table describes its function, not a definitive declaration.

### 3.2 Top-Level Pin Mapping

For the project wrapper interface, the signal mapping is:

| Pin | Function |
|---|---|
| `ui_in[7:0]` | Parallel data input |
| `uio_in[0]` | Transmission request |
| `uo_out[0]` | UART TX output |
| `uo_out[1]` | Busy status |
| `uo_out[2]` | Transmission completion status |

The wrapper maps the external interface to the internal transmitter logic.

## 4. UART Frame Format

The transmitter uses the standard 8N1 format:

- **8:** Eight data bits.
- **N:** No parity bit.
- **1:** One stop bit.

Each frame contains ten serial bits.

| Frame field | Value or content | Duration |
|---|---|---|
| Start bit | Logic `0` | One bit period |
| Data bit 0 | `data_in[0]` | One bit period |
| Data bit 1 | `data_in[1]` | One bit period |
| Data bit 2 | `data_in[2]` | One bit period |
| Data bit 3 | `data_in[3]` | One bit period |
| Data bit 4 | `data_in[4]` | One bit period |
| Data bit 5 | `data_in[5]` | One bit period |
| Data bit 6 | `data_in[6]` | One bit period |
| Data bit 7 | `data_in[7]` | One bit period |
| Stop bit | Logic `1` | One bit period |

The TX line shall remain at logic `1` when the transmitter is idle.

### 4.1 Transmission Example

For input byte `8'h55`:

```text
Input byte:  0x55
Binary:      0101_0101
Data order:  1, 0, 1, 0, 1, 0, 1, 0

UART frame:
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1  |   0   |  1 |  0 |  1 |  0 |  1 |  0 |  1 |  0 |  1
```

The data bits are transmitted from bit 0 through bit 7, regardless of the order in which the byte is normally written in binary notation.

## 5. Timing Requirements

### 5.1 Bit Period

Let:

f_clk be the system-clock frequency in Hz.

N_CPB be the configured number of system-clock cycles per UART bit.

T_clk be the system-clock period.

The nominal UART bit period is:

T_bit = N_CPB × T_clk

Since T_clk = 1 / f_clk, the bit period can also be expressed as:

T_bit = N_CPB / f_clk

The corresponding baud rate is:

Baud rate = f_clk / N_CPB

For the RTL testbench configuration with CLKS_PER_BIT = 4, each UART bit is expected to occupy four system-clock periods.

The complete 8N1 frame contains ten bits: one start bit, eight data bits, and one stop bit. Therefore, the nominal frame duration is:

T_frame = 10 × T_bit

This duration excludes any additional idle time between frames.

### 5.2 Transmission Request

`valid_in` indicates a request to transmit `data_in`.

The intended request protocol is a one-clock-cycle request pulse. The transmitter must capture the requested byte when the request is accepted.

The testbench checks separate requests and sequential transmissions. The exact handling of requests asserted while `busy` is high must follow the implemented control logic; this specification does not assume the presence of a request queue.

### 5.3 Status Signals

- `busy` indicates that the transmitter is actively processing a frame.
- `done` indicates that the frame has completed.
- The exact pulse width and cycle alignment of `done` shall be verified against the RTL implementation and testbench.

## 6. Reset Requirements

The design uses an active-low reset, `rst_n`.

When reset is asserted:

- The current transmission shall be aborted.
- The TX output shall return to the idle level, logic `1`.
- `busy` shall indicate that no transmission is active.
- Internal transmission progress shall be reinitialized.

After reset is released, the transmitter shall be able to accept a new valid request.

The implementation's reset assertion and release behavior shall be consistent with the reset style used in the RTL.

## 7. RTL Architecture

The implementation is organized into the following functional modules:

| Module | Responsibility |
|---|---|
| `uart_tx_top` | Top-level integration and signal connectivity |
| `uart_tx_controller` | Transmission control and sequencing |
| `uart_tx_shift_register` | Storage and serial shifting of the data byte |
| `uart_baud_counter` | Bit-period timing |
| `uart_bit_counter` | Tracking transmission bit progress |

These module descriptions identify the responsibilities of the existing RTL blocks. Their detailed internal implementation and state transitions are defined by the RTL source.

## 8. Verification Requirements

The testbench shall verify the functional correctness of the transmitter.

| Test case | Description | Expected result |
|---|---|---|
| TC-01 | Transmit `0x00` | Correct start, data, and stop bits |
| TC-02 | Transmit `0xFF` | All eight data bits are logic `1` |
| TC-03 | Transmit `0x55` | Correct LSB-first serial sequence |
| TC-04 | Check start-bit duration | Start bit lasts four clock cycles with `CLKS_PER_BIT = 4` |
| TC-05 | Transmit `0xA5`, followed by `0x3C` | Both frames are transmitted correctly in sequence |
| TC-06 | Issue separate transmission requests | Each accepted request produces the expected frame |
| TC-07 | Assert reset during transmission of `0xA5` | Transmission is aborted and TX returns to idle |

### 8.1 Verification Pass Criteria

A test passes when the observed output and status behavior satisfy the relevant expected conditions.

The complete RTL verification passes when all seven test cases pass without an assertion or checking failure.

Simulation evidence is recorded in `sim/verification.log`. Waveform files may be used for additional debugging and timing inspection.

## 9. ASIC Implementation and Evaluation

The project includes an ASIC-oriented implementation flow to evaluate the synthesized and physically implemented design.

The evaluation covers:

- RTL synthesis and cell statistics
- Setup and hold timing analysis
- Power estimation
- Physical-design metrics
- Design-rule and connectivity checks, where supported by the flow

The results shall be reported using the generated reports under `reports/`.

Implementation results are flow- and configuration-dependent. Numerical PPA results and sign-off status should be documented from the corresponding run reports rather than assumed from this specification.

## 10. Project Deliverables

The repository is expected to contain:

- RTL source files under `rtl/`
- RTL testbench under `tb/`
- Test plan and design specification under `docs/`
- Block diagram and FSM figures under `spec/`
- Verification log under `sim/`
- ASIC implementation reports and figures under `reports/`
- Automated test workflow under `.github/workflows/`
- Project overview and usage instructions in `README.md`

## 11. Limitations

The current design is a basic UART 8N1 transmitter. It does not implement a receiver, parity checking, FIFO buffering, bus-based configuration, or a programmable frame format.

The design's functional correctness and implementation quality are evaluated against the supported interface, UART frame format, timing requirements, reset behavior, and verification criteria defined in this document.
