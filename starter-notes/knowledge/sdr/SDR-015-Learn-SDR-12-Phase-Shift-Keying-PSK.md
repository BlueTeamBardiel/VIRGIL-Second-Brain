---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 015
source: rewritten
---

# Learn SDR 12： Phase-Shift Keying (PSK)
**A modulation technique that encodes digital data by rotating the phase of a carrier wave instead of changing its strength.**

---

## Overview
Phase-Shift Keying (PSK) is a digital modulation scheme where information is transmitted by deliberately shifting the phase angle of a [[carrier wave]]. Rather than modulating [[amplitude]] like [[ASK]], PSK keeps the signal strength constant while the phase angle becomes the vessel for your data. This makes PSK more resistant to [[noise]] and [[fading]] in real-world RF environments, which is why it's fundamental to modern wireless communications.

---

## Key Concepts

### Phase Modulation
**Analogy**: Imagine a pendulum swinging back and forth. You can encode messages either by making it swing harder (amplitude) or by flipping when it starts—backward instead of forward. The energy stays the same; only the direction changes. That's phase modulation.

**Definition**: The rotation of a sinusoidal [[waveform]] around the unit circle in the [[complex plane]], measured in degrees (0°–360°) or radians (0–2π).

[[Phase]] = the instantaneous angular position of a periodic signal
$$\phi(t) = \phi_0 + \Delta\phi \cdot m(t)$$

where $\phi_0$ is the base phase and $m(t)$ is your modulating signal.

---

### Binary Phase-Shift Keying (BPSK)
**Analogy**: A light switch that's always on (constant brightness) but you rotate its direction—facing north for a 0 bit, facing south for a 1 bit. The observer sees the same intensity but knows the message from which direction the beam points.

**Definition**: The simplest form of PSK where the [[carrier wave]] is shifted between exactly two phase states, typically 0° and 180°.

**Mathematical representation**:
$$s(t) = A \cos(2\pi f_c t + \phi[n])$$

where $\phi[n] \in \{0°, 180°\}$ based on whether your bit is 0 or 1.

**Implementation trick**: Multiply your data stream (±1 values) by the [[carrier]]:
$$s(t) = \text{data}[n] \times \cos(2\pi f_c t)$$

When data = +1: you get $\cos(2\pi f_c t)$ (normal phase)  
When data = −1: you get $-\cos(2\pi f_c t)$ (inverted 180°)

---

### Quadrature Phase-Shift Keying (QPSK)
**Analogy**: Instead of a two-way compass (north/south), you now have a four-way compass (north, east, south, west). You can pack twice as much information in the same bandwidth.

**Definition**: An extension of BPSK using four phase angles (0°, 90°, 180°, 270°), allowing two bits per symbol transmission.

| **Phase Angle** | **Bit Pair** | **I (In-phase)** | **Q (Quadrature)** |
|---|---|---|---|
| 0° | 00 | +1 | 0 |
| 90° | 01 | 0 | +1 |
| 180° | 10 | −1 | 0 |
| 270° | 11 | 0 | −1 |

[[QPSK]] uses [[I/Q modulation]]—two orthogonal carriers 90° apart.

---

### Phase Transitions and Zero-Crossing Alignment
**Analogy**: Imagine two trains switching tracks. If you switch at a station (zero-crossing), the passengers barely notice. If you switch mid-tunnel, the jolt is violent. Phase transitions are similar—timing matters.

**Definition**: The moment when phase shifts from one state to another, ideally timed near [[zero crossings]] of the [[carrier]] to minimize [[spectral splatter]] and RF noise.

When a bit transitions:
- **Poor timing**: Sharp discontinuity → [[harmonics]] and [[bandwidth]] splatter
- **Good timing**: Near zero-crossing → clean phase rotation

---

### Constellation Diagram
**Analogy**: A star chart showing all possible positions your signal can occupy in the sky. Each star is a valid symbol you're allowed to transmit.

**Definition**: A visual representation of modulated signals in the [[IQ plane]] ([[complex plane]]), where each point represents a unique symbol.

```
BPSK Constellation:        QPSK Constellation:
        Q                           Q
        |                           |
   •    |    •              •    •  |  •    •
        |                           |
   -----+-----I              -------+-------I
        |                           |
   •    |    •              •    •  |  •    •
        |                           |
```

Lower error rate = points farther apart and more distinct.

---

## Hands-On Application

### Transmitting BPSK with GNU Radio
1. **Source**: Create a [[signal source]] (constant carrier) or use a [[Vector Source]] block
2. **Data generation**: Use a [[Repeat Block]] to stretch binary data (0101...) across multiple samples
3. **Multiplication**: Multiply your ±1 data stream by the [[carrier wave]]
4. **Output**: Send to [[USB Sink]] or [[File Sink]]

### GNU Radio Flow Graph Structure
```
[Bit Vector] → [Convert to ±1] → [Repeat to match carrier rate]
                                         ↓
[Sine Wave Generator] ←────────────[Multiply] → [To USRP/HackRF]
```

### RTL-SDR Reception
- Tune to your [[carrier frequency]] with [[GQRX]] or [[SDR#]]
- Look for phase discontinuities in the [[waterfall display]]
- Use [[Inspectrum]] to visualize bit transitions in time-frequency space

### Key Parameters to Tweak
- **Symbol rate**: How fast bits transition (affects bandwidth)
- **Carrier frequency**: Where in the spectrum you transmit
- **Sample rate**: Must be ≥ 2× your highest signal bandwidth ([[Nyquist theorem]])
- **Bit timing**: When transitions occur relative to zero-crossings

---

## Lab Exercise

**What you need**:
- [[HackRF One]] or [[USRP]] (transmitter)
- [[RTL-SDR]] dongle or second radio (receiver)
- [[GNU Radio]] 3.9+
- Basic coaxial cable patch

**Goal**: 
Transmit a simple BPSK signal and observe phase inversion on the receiver's [[constellation diagram]].

**Steps**:

1. **Build transmit flow graph**
   - Signal Source: Sine wave at 915 MHz, 1 dBm power
   - Vector Source: [1, 1, 1, 1, −1, −1, −1, −1] (alternating bit pattern)
   - Repeat: 1000 samples per bit (symbol rate = 1 kHz)
   - Multiply: Carrier × Data stream
   - USRP Sink: Set to HackRF or USRP device
   - **What happens**: Sine wave flips 180° every 4 symbols

2. **Monitor with receiver constellation**
   - RTL-SDR Source tuned to 915 MHz
   - Throttle: Match sample rate
   - QT GUI Constellation Sink
   - **Observable output**: Two dots (±180°) on IQ plot, jumping between them
   - What it demonstrates: Binary phase states are clearly distinguishable

3. **Measure spectral efficiency**
   - Add FFT Sink to both transmitter and receiver
   - **Observation**: BPSK occupies narrower bandwidth than [[ASK]] at same bit rate
   - Why: Amplitude is constant; only phase carries information
   - Conclusion: Phase modulation is more spectrum-efficient than amplitude modulation

4. **Introduce timing jitter** (optional challenge)
   - Delay bit transitions away from zero-crossings
   - **Result**: Increased [[phase error]] and [[spectral splatter]]
   - Learning: Why synchronization and timing recovery matter in real receivers

---

## Related Topics
- [[Amplitude-Shift Keying (ASK)]]
- [[Frequency-Shift Keying (FSK)]]
- [[I/Q Modulation]]
- [[Constellation Diagram]]
- [[Symbol Timing Recovery]]
- [[Phase Detector]]
- [[Complex Baseband Representation]]
- [[GNU Radio]]
- [[HackRF]]
- [[RTL-SDR]]
- [[Modulation Schemes]]
- [[Digital Communications]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Modulation]] | [[GNU Radio Tutorials]]*