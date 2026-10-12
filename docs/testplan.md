# UART 8N1 Transmitter — Test Plan

## 1. Test Environment

| Parameter | Value |
|---|---|
| Testbench | `tb/tb_uart_tx_top.sv` |
| Simulator | Icarus Verilog |
| Clock period | 10 time units |
| Clocks per bit (CPB) | 4 |
| Total test cases | 7 |

## 2. Test Cases

### Case 1 — Transmit `0x00`

**Objective:** Verify transmission of a byte containing all zeros.

**Checks:**
- START bit is low.
- All 8 data bits are correct and transmitted LSB first.
- STOP bit is high.
- TX returns to idle and `busy` is deasserted.

**Expected result:** PASS

### Case 2 — Transmit `0xFF`

**Objective:** Verify transmission of a byte containing all ones.

**Checks:**
- START and STOP bits are correct.
- All 8 data bits are correct and transmitted LSB first.
- TX returns to idle and `busy` is deasserted.

**Expected result:** PASS

### Case 3 — Transmit `0x55`

**Objective:** Verify alternating data bits and LSB-first ordering.

**Checks:**
- START and STOP bits are correct.
- All data bits match the expected sequence.
- TX returns to idle and `busy` is deasserted.

**Expected result:** PASS

### Case 4 — START Bit Duration

**Objective:** Measure the duration of the START bit.

**Procedure:**
1. Transmit `0x55`.
2. Measure the interval between the falling edge at START and the rising edge at the beginning of data bit 0.
3. Convert the measured interval into clock cycles.

**Expected result:** The measured duration equals `CPB` (4 clock cycles).

**Note:** This measurement uses `CPB = 4` in simulation. It does not establish final baud-rate accuracy.

### Case 5 — Two Sequential Bytes

**Test data:** `0xA5`, `0x3C`

**Objective:** Verify transmission of two bytes in sequence.

**Checks:**
- Both frames contain correct START, data, and STOP bits.
- The transmitter returns to idle between frames.

**Expected result:** PASS

### Case 6 — Separate Requests

**Test data:** `0xA5`, `0x3C`

**Objective:** Verify two separate transmission requests.

**Procedure:**
1. Send the first byte and wait for completion.
2. Keep `valid_in` low between requests.
3. Send the second byte.

**Checks:**
- `busy` is asserted for each transmission.
- Both frames are transmitted correctly.

**Expected result:** PASS

### Case 7 — Reset During Transmission

**Objective:** Verify reset behavior during an active frame.

**Procedure:**
1. Start transmitting `0xA5`.
2. Assert reset before the frame completes.

**Checks:**
- TX returns to logic high.
- `busy` is cleared.
- Outputs remain in the expected idle condition after reset.

**Expected result:** PASS

## 3. Simulation Summary

| Item | Result |
|---|---|
| Case 1 — `0x00` | PASS |
| Case 2 — `0xFF` | PASS |
| Case 3 — `0x55` | PASS |
| Case 4 — START duration | PASS |
| Case 5 — Sequential bytes | PASS |
| Case 6 — Separate requests | PASS |
| Case 7 — Reset during transmission | PASS |

**Latest observed result:** All 7 test cases passed.

## 4. Verification Scope and Limitations

The current testbench covers selected data patterns, frame formatting, START-bit duration, sequential requests, and reset behavior.

These tests do not constitute exhaustive UART verification. The START-bit measurement uses a simulation configuration of `CPB = 4`; baud-rate accuracy at the final target configuration has not yet been established.
