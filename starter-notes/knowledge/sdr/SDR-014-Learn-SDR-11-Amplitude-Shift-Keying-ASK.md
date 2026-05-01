---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 014
source: rewritten
---

# Learn SDR 11： Amplitude Shift Keying (ASK)
**Encode digital information by switching between discrete power levels of a carrier signal.**

---

## Overview
[[Amplitude Shift Keying]] (ASK) extends the simplicity of [[On-Off Keying]] by representing data across multiple amplitude states rather than just binary on/off positions. This technique is fundamental to many practical RF systems and provides an important stepping stone toward understanding more complex [[Digital Modulation]] schemes. Learning ASK gives you insight into how real transmitted signals carry information in their envelope characteristics.

---

## Key Concepts

### Amplitude Shift Keying (ASK)
**Analogy**: Think of a dimmer switch for a light bulb. Instead of just flipping it fully on or completely off (like [[On-Off Keying]]), you can set it to 10%, 50%, 75%, or fully bright—each brightness level represents a different piece of information.

**Definition**: ASK is a [[Digital Modulation]] technique where data is encoded by switching a [[Carrier Wave]] between two or more discrete amplitude levels while keeping frequency and phase constant.

**How it differs from OOK**:

| Characteristic | [[On-Off Keying]] | [[Amplitude Shift Keying]] |
|---|---|---|
| States | 2 (on/off) | 2 or more (multiple amplitude levels) |
| Information per symbol | 1 bit | 1+ bits (depends on levels) |
| Complexity | Minimal | Medium |
| Noise sensitivity | Low | Higher |

---

### Complex Envelope & Received Signal
**Analogy**: Imagine watching a spinning coin through a foggy window. The coin's actual spin rate (the carrier) stays the same, but you're measuring how thick or thin it appears (the amplitude), which tells you what data symbol is being sent.

**Definition**: In an [[SDR]] receiver, incoming RF signals are converted to [[Complex Baseband]] representation—a complex number whose:
- **Magnitude** (amplitude) = proportional to the transmitted signal's power level
- **Phase** = rotates at the [[Intermediate Frequency]] (difference between transmit and receive local oscillators)

**Mathematical representation**:
```
Received complex signal: z(t) = A(t) · e^(j·2π·Δf·t)

where:
  A(t) = amplitude modulation (carries data)
  Δf = frequency offset between TX and RX tuning
  j = imaginary unit
```

---

### Frequency Offset and Phase Drift
**Analogy**: Two clocks running at slightly different speeds—even if you start them at noon, after an hour one shows 1:00 and the other shows 1:00:01. This tiny mismatch accumulates visibly over time.

**Definition**: In practical [[Software Defined Radio]] systems, the [[Local Oscillator]] clocks on transmitter and receiver hardware are never perfectly synchronized. This creates a residual [[Intermediate Frequency]] that causes the received complex signal's phase to rotate continuously.

**Why it matters for ASK**:
- You extract data by measuring **magnitude only**, so phase rotation is ignored
- This makes ASK more tolerant of [[Frequency Offset]] than phase-sensitive schemes like [[Phase Shift Keying]]

---

## Hands-On Application

### Detection Workflow with RTL-SDR + Transmitter

1. **Tune receiver** ([[RTL-SDR]] or [[HackRF]]) to the transmission frequency (e.g., 915 MHz)
2. **Capture [[IQ Samples]]** continuously from the receiver
3. **Extract magnitude** from each complex sample: `|z(n)| = √(I² + Q²)`
4. **Apply threshold detection** to identify which amplitude level each symbol represents
5. **Decode symbols** to recover original data stream

### GNU Radio Implementation Pattern

```
[Signal Source (Pluto TX)] 
  → Multiply by Amplitude Envelope
  → RF Frontend
        ↓
[RTL-SDR RX]
  → Complex to Magnitude
  → Threshold / Slicer
  → Symbol Decoder
  → Output (file/display)
```

**Key blocks in GNU Radio**:
- `UHD Source` / `UHD Sink` — interface with Pluto, HackRF
- `Complex to Mag` — extract envelope
- `Threshold` or `Slicer` — convert continuous magnitude to discrete levels
- `File Sink` — capture raw data for analysis

---

## Lab Exercise

**What you need**: 
- [[RTL-SDR]] receiver dongle
- [[Pluto SDR]] or [[HackRF]] transmitter (or generate test signal via file)
- [[GNU Radio]] or [[GQRX]]
- Coaxial cable with attenuator (to avoid saturating receiver)

**Goal**: Observe and decode a 4-level ASK signal, extracting the amplitude transitions and confirming correspondence to transmitted bit patterns.

**Steps**:

1. **Build transmitter flowgraph in GNU Radio**:
   - Create bit source (e.g., `Vector Source` with [0,1,0,1,1,0,...])
   - Map bits to amplitude levels using `Pack K Bits` + lookup table
   - Multiply carrier by amplitude envelope
   - Transmit via UHD (Pluto/HackRF)

2. **Build receiver flowgraph**:
   - Receive IQ samples from RTL-SDR
   - Compute magnitude: `sqrt(I² + Q²)`
   - Observe waterfall/constellation in real-time using `QT GUI Sink`
   - Use `Threshold` block set to midpoints between expected amplitude levels

3. **What you'll observe**:
   - Waterfall shows horizontal bands at distinct power levels (no frequency shift)
   - Magnitude plot shows step-like transitions between 0, A₁, A₂, A₃ (or however many levels)
   - Decoded bits match your transmit sequence (accounting for symbol timing)

4. **What it demonstrates**:
   - Data lives in **amplitude, not frequency**
   - [[Frequency Offset]] appears as rotating phase (invisible to magnitude detector)
   - [[Symbol Rate]] determines how quickly amplitude changes

---

## Related Topics
- [[On-Off Keying]] — predecessor technique (2-level ASK)
- [[Phase Shift Keying]] — encodes data in phase instead of amplitude
- [[Frequency Shift Keying]] — encodes data in frequency
- [[Quadrature Amplitude Modulation]] — combines ASK in two orthogonal channels
- [[Complex Baseband]] — IQ representation used in all digital demodulation
- [[UHD]] — software layer for Pluto, HackRF, USRP control
- [[GNU Radio]] — primary tool for building ASK systems
- [[RTL-SDR]] — affordable receiver for lab experiments

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Modulation]] Fundamentals*