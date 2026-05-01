---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 022
source: rewritten
---

# Learn SDR 19: Carrier Phase Synchronization with a Costas Loop
**The Costas Loop automatically locks onto the carrier phase, enabling coherent demodulation of phase-modulated signals.**

---

## Overview

When your receiver picks up a radio signal, the electromagnetic wave arrives with an unknown phase offset determined by the transmitter's timing, distance, and local oscillator mismatch. To correctly decode phase-sensitive modulation schemes like [[BPSK]], [[QPSK]], or [[QAM]], your receiver must recover and track this phase in real time. The [[Costas Loop]] is a feedback control system that continuously measures phase error and corrects your local oscillator, keeping your demodulator perfectly aligned with the incoming carrier—without needing a separate pilot signal.

---

## Key Concepts

### Phase Offset in Reception
**Analogy**: Imagine tuning a guitar by ear. You pluck a string and listen for when it matches a reference tone. If the reference tone drifts, you adjust the tuning peg continuously. A Costas Loop does the same thing with radio carrier phase.

**Definition**: When an antenna receives a modulated signal, the carrier arrives with a phase shift φ relative to your local oscillator. This shift depends on path length, transmitter timing, and oscillator frequency error. Without correction, your demodulator rotates the received constellation, making symbols unrecognizable.

**Mathematical form**:
```
Received signal: A·cos(2πf_c·t + φ)
Complex baseband: A·e^(j(2πΔf·t + φ))
```

Where Δf = f_received − f_local (carrier frequency offset) and φ is the unknown phase alignment.

---

### The Costas Loop Architecture
**Analogy**: Think of a balance scale. One side measures error, the other side applies correction. If the scale tips toward error, a weight (feedback) shifts to rebalance it automatically.

**Definition**: The Costas Loop is a [[Phase-Locked Loop]] (PLL) variant that generates a phase-error signal from the in-phase (I) and quadrature (Q) components of a demodulated signal, then feeds this error back to adjust a [[Numerically Controlled Oscillator]] (NCO).

**Core topology**:

| Stage | Function | Input | Output |
|-------|----------|-------|--------|
| Mixer | Multiply received signal by NCO output | RF + local oscillator | Complex baseband |
| Low-Pass Filter | Remove high-frequency products | Mixed signal | Clean I/Q |
| Phase Detector | Compute error from I and Q magnitudes | I, Q samples | Phase error signal |
| Loop Filter | Smooth and integrate error | Phase error | Control voltage |
| NCO | Generate corrected oscillator | Control voltage | cos + j·sin at adjusted phase |

**Phase detector (nonlinear):**
```
Phase_error = I·Q* + I*·Q = 2·Im(I·Q*)
```

This cross-product naturally produces zero error when I and Q are properly aligned (I large, Q small).

---

### Carrier Frequency Offset vs. Phase Offset
**Analogy**: Phase offset is like a photograph's tilt angle; frequency offset is like the photograph rotating. A Costas Loop handles both—it tightens the angle (phase) while slowing the spin (frequency).

**Definition**: [[Frequency offset]] (Δf) causes the phase error to drift linearly over time. The Costas Loop's integral path (slow feedback) tracks this drift automatically by adjusting the NCO frequency, while the proportional path (fast feedback) corrects instantaneous phase wobbles.

**Comparison table**:

| Problem | Cause | Loop Response |
|---------|-------|----------------|
| Static phase error | Oscillator misalignment | Proportional gain corrects instantly |
| Drifting phase (frequency offset) | Oscillator frequency mismatch | Integral gain tracks slowly |
| Noise jitter | Receiver noise floor | Loop bandwidth limits bandwidth |

---

### Loop Gain and Bandwidth
**Analogy**: A servo motor with high gain responds quickly but may overshoot and oscillate. Low gain is sluggish but stable. Loop bandwidth is the sweet spot.

**Definition**: Loop bandwidth determines how fast the Costas Loop responds to phase changes and how much noise it rejects. Higher bandwidth → faster lock, higher noise sensitivity. Lower bandwidth → slower lock, better noise immunity.

**Tuning parameters**:
```
Loop filter output: u[n] = K_p·e[n] + K_i·Σ(e[k])
NCO phase increment: Δφ[n] = 2π·Δf + u[n]
```

Where K_p (proportional gain) and K_i (integral gain) set the loop speed and stability.

---

### Complex Signal Representation in the Receiver
**Analogy**: Instead of tracking one needle on a meter, you watch two needles (I and Q) dance. When both are near zero except one, you're locked.

**Definition**: After [[Mixing]] the received signal with a local oscillator and [[Low-Pass Filtering]], you get complex samples: I(t) + j·Q(t). The [[In-phase component]] (I) should carry the data; the [[Quadrature component]] (Q) should be nearly zero when phase-locked. The loop uses Q's magnitude as error feedback.

---

## Hands-On Application

**GNU Radio Workflow:**

1. **Build a receiver chain:**
   - RTL-SDR source → Frequency xlating FIR filter (tune to baseband) → Costas Loop block → Constellation sink (visualization)

2. **Configure the Costas Loop block:**
   - Set *Order* to match modulation (2 for BPSK, 4 for QPSK)
   - Set *Loop BW* (0.01–0.1 typical; lower = slower but more stable)
   - Set *Alpha* (proportional gain) and *Beta* (integral gain) or let the block auto-compute from bandwidth

3. **Monitor outputs:**
   - **Constellation diagram:** Watch symbols converge to decision points (e.g., ±1 for BPSK)
   - **Phase error signal:** Should oscillate near zero once locked
   - **Frequency offset estimate:** Available as tagged output stream

**Typical GNU Radio blocks:**
- `digital.costas_loop_cc` (complex input, complex output)
- `blocks.rotator_cc` (manual phase rotation for testing)
- `qtgui.constellation_sink_c` (real-time IQ visualization)

---

## Lab Exercise

**What you need:**
- [[RTL-SDR]] dongle or [[HackRF]] One
- GNU Radio (3.8+)
- GQRX or a local [[BPSK]]/[[QPSK]] transmitter (e.g., second SDR in TX mode)
- Antenna or short cable (RX/TX loop-back)

**Goal:** Observe a Costas Loop lock onto an unknown carrier phase and track frequency drift in a BPSK or QPSK signal.

**Steps:**

1. **Generate a BPSK test signal in GNU Radio:**
   - Create a bit source → PSK modulator → USB modulator (to 100 kHz IF) → File sink
   - Record a few seconds to a file

2. **Build a receiver with a Costas Loop:**
   - File source → Frequency xlating FIR filter (tune to 100 kHz) → Costas Loop (order=2, BW=0.05) → Constellation sink + Phase error sink

3. **Vary initial conditions:**
   - Manually add a phase offset to the file (rotate all samples by e^(jπ/4), etc.)
   - Observe how long the loop takes to lock
   - Verify Q-component converges to near zero

4. **Introduce frequency offset:**
   - Shift the test file by ±5 kHz artificially
   - Confirm the loop's integral path corrects it over time
   - Note: if offset is too large (> BW/2), loop loses lock

5. **Measure lock time:**
   - Define "locked" as |Q| < 0.1 on average
   - Plot phase error vs. time; note exponential decay toward zero

**What it demonstrates:**
- Phase-Locked Loops are **feedback control systems**, not magic
- Loop bandwidth **trades off speed vs. stability**
- The Costas Loop exploits the **nonlinear phase detector** to achieve lock without a pilot signal
- Real signals have **frequency drift**; the integral path handles it

---

## Related Topics
- [[Phase-Locked Loop]] (PLL)
- [[Numerically Controlled Oscillator]] (NCO)
- [[BPSK]] and [[QPSK]] demodulation
- [[Timing Synchronization]] (companion to phase sync)
- [[Complex Baseband Signal]]
- [[Frequency Offset Estimation]]
- [[QAM Receiver Design]]
- [[Digital Modulation]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[GNU Radio]] | [[RTL-SDR]]*