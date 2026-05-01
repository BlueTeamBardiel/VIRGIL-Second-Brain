---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 020
source: rewritten
---

# Learn SDR 17： Frequency Locked Loop (FLL)
**Automatically tracking and correcting frequency drift in received signals without needing a pilot tone.**

---

## Overview

A [[Frequency Locked Loop]] (FLL) is a closed-loop control system that detects and eliminates frequency offset between a transmitted signal and your receiver's local oscillator. In real-world reception, your receiver's clock never perfectly matches the transmitter's clock—there's always drift. The FLL measures this mismatch and automatically adjusts your receive frequency to stay synchronized, which is essential before you can correctly demodulate [[modulated]] signals like [[BPSK]] or [[QPSK]].

---

## Key Concepts

### Frequency Offset Problem
**Analogy**: Imagine two musicians playing the same song, but one's instrument is tuned slightly sharp. Even if their rhythms are locked together, the pitch difference remains constant—listeners hear a warbling sound. Similarly, if your receiver's local oscillator drifts 1 kHz higher than the transmitter's frequency, every received symbol rotates continuously around the constellation.

**Definition**: [[Frequency offset]] is a constant, systematic difference between the transmitter's carrier frequency and your receiver's tuning frequency. It causes all received symbols to rotate at a fixed rate in the complex plane.

| Effect | Without Correction | With FLL |
|--------|-------------------|----------|
| Symbol rotation | Continuous spiral | Static constellation |
| Demodulation | Fails after few symbols | Stable over time |
| Frequency drift | Accumulates | Tracked automatically |

---

### The FLL Feedback Loop
**Analogy**: A thermostat measures room temperature and adjusts the furnace to maintain setpoint. Similarly, an FLL continuously measures how fast the received constellation is rotating, then adjusts the receiver frequency to counteract that rotation.

**Definition**: The FLL is a [[feedback control]] system with four stages:

1. **Detection**: Measure the instantaneous phase rotation rate between consecutive symbols
2. **Error calculation**: Compare measured rotation to expected zero
3. **Loop filter**: Smooth the error signal to generate a correction voltage
4. **VCO update**: Adjust the digital local oscillator frequency

**Mathematical model**:

```
Received signal phase: φ(n) = φ₀ + 2π·Δf·n/Fs
where:
  Δf = frequency offset (Hz)
  n = symbol index
  Fs = sample rate

FLL output: f_corrected = f_tuned + K·∫(phase_error) dt
```

---

### Phase Detector in FLL
**Analogy**: A smoke detector continuously samples air; when smoke appears, it triggers an alarm that activates a fan. An FLL's phase detector samples symbol phase; when phase changes, it triggers frequency correction.

**Definition**: The [[phase detector]] extracts the instantaneous rate of phase change by comparing consecutive demodulated symbols. Common approaches:

- **Cross-product discriminator**: `error = Im(s[n] · conj(s[n-1]))`
- **Arctangent discriminator**: `error = atan2(Q[n], I[n]) - atan2(Q[n-1], I[n-1])`

The cross-product method is computationally lighter and works well for [[QPSK]], [[16-QAM]], and higher-order constellations.

---

### Loop Filter Design
**Analogy**: A shock absorber on a car suspension dampens oscillation without stopping all movement—too stiff and you feel every bump, too soft and you bounce wildly. The FLL loop filter balances fast lock (quick frequency tracking) against stability (no hunting oscillations).

**Definition**: The [[loop filter]] is typically a proportional-integrator (PI) filter that combines:

- **Proportional gain (Kp)**: Responds instantly to frequency error
- **Integral gain (Ki)**: Accumulates persistent error to eliminate steady-state offset

```
Frequency correction: Δf = Kp·error + Ki·∫error dt
```

**Tuning trade-offs**:

| Parameter | Fast Lock | Stable Tracking |
|-----------|-----------|-----------------|
| Kp (high) | Quick correction | Risk oscillation |
| Ki (high) | Reduces offset | Slow response |
| Bandwidth | Wider | Narrower |

Typical bandwidth: 5–10% of symbol rate.

---

### FLL vs. [[Phase Locked Loop]]
**Analogy**: A PLL is a perfectionist who adjusts to match exactly; an FLL is a pragmatist who just tracks the drift rate without caring about absolute alignment.

| Feature | FLL | PLL |
|---------|-----|-----|
| Tracks | Frequency drift | Phase + frequency |
| Error signal | Phase *rate* | Phase *value* |
| Complexity | Simpler | More complex |
| Lock time | Faster | Slower, more stable |
| Noise immunity | Good for large offsets | Better for tracking jitter |
| Use case | Initial coarse lock | Fine carrier recovery |

---

## Hands-On Application

### GNU Radio FLL Workflow

1. **Place a `Frequency Locked Loop Discriminator` block** in your receive chain after the matched filter and constellation slicer
2. **Configure loop parameters**:
   - Damping factor: 0.5–1.0 (higher = less oscillation)
   - Natural frequency: 20–100 Hz (proportional to symbol rate)
3. **Monitor the frequency correction** using a [[probe]] block or message sink to watch the VCO output frequency
4. **Adjust demodulation reference** to use the FLL's corrected frequency instead of a fixed value

### With RTL-SDR and SDR#

- Use the **PLL Enabled** option in receiver settings
- Monitor the **Frequency Error** display to confirm the FLL is converging toward zero
- Watch the constellation diagram tighten from a spiral to a tight cluster

---

## Lab Exercise

**What you need**: 
- [[RTL-SDR]] dongle (or [[HackRF]])
- GNU Radio 3.10+
- A second SDR transmitter or pre-recorded IQ file with known frequency offset

**Goal**: 
Observe an FLL automatically correcting a 5 kHz frequency offset and stabilize a [[QPSK]] constellation from a rotating spiral into a static four-point pattern.

**Steps**:

1. **Create a test signal**: 
   - Generate a QPSK source with 1000 symbols/sec
   - Apply a deliberate +5 kHz frequency offset using a `Multiply Const` block with `exp(j·2π·5000·t)`
   - Transmit or save to file

2. **Build receive chain**:
   - RTL-SDR source → Rational Resampler → Matched Filter → Slicer
   - Connect `FLL Band-Edge` or `FLL Discriminator` block
   - Feed corrected symbols to Constellation Sink

3. **Observe behavior**:
   - **Before FLL**: Constellation rotates steadily clockwise
   - **After FLL engages**: Spiral tightens, rotation slows, then stops
   - **Frequency probe**: Should read 0 Hz after 100–200 symbols

4. **What it demonstrates**:
   - FLL converges without explicit knowledge of frequency offset
   - Works across wide offset ranges (±50 kHz typical)
   - Faster than manual tuning, essential for frequency-hopping or mobile scenarios

---

## Related Topics
- [[Phase Locked Loop]] — Fine-grain phase and frequency lock
- [[QPSK]] — Common modulation used in FLL examples
- [[Constellation Diagram]] — Visual feedback of FLL correction
- [[Matched Filter]] — Often precedes FLL in receiver chain
- [[Loop Filter]] — Core component of feedback systems
- [[Discriminator]] — Extracts error signal from received symbols
- [[GNU Radio]] — FLL implementation platform
- [[RTL-SDR]] — Hardware platform for testing
- [[Carrier Recovery]] — Broader topic encompassing FLL and PLL
- [[Frequency Offset]] — The problem FLL solves

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Radio Receiver Design]]*