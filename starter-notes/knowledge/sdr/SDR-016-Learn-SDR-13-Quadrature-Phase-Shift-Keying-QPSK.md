---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 016
source: rewritten
---

# Learn SDR 13： Quadrature Phase-Shift Keying (QPSK)
**QPSK doubles your data rate by encoding information on both the in-phase and quadrature components of a carrier wave.**

---

## Overview
[[QPSK]] (Quadrature Phase-Shift Keying) is a fundamental modulation scheme that encodes digital data by rotating a carrier signal through four distinct phase angles instead of just two. Unlike its predecessor [[BPSK]], which only uses the real axis of the complex plane, QPSK harnesses both the I (in-phase) and Q (quadrature) components, effectively transmitting two bits per symbol and doubling spectral efficiency. This makes QPSK the foundation for countless modern communication standards and a critical stepping stone toward understanding advanced modulation techniques in SDR work.

---

## Key Concepts

### Binary Phase-Shift Keying (BPSK) Review
**Analogy**: Imagine a lightbulb that can only point left or right—you're encoding information by choosing one of two directions. That's BPSK: your signal can only take two positions, and you're using only half the available space.

**Definition**: [[BPSK]] transmits data by shifting the phase of a carrier wave between 0° and 180°, equivalent to multiplying the baseband signal by either +1 or −1. The result is a purely real signal with zero imaginary component.

```
BPSK Symbol Mapping:
Binary 0 → cos(ωt) × (−1) = −cos(ωt)  [180° phase shift]
Binary 1 → cos(ωt) × (+1) = +cos(ωt)  [0° phase shift]
```

**Limitation**: The imaginary (quadrature) axis remains completely unused, wasting half the complex plane's potential.

---

### Quadrature Components: In-Phase (I) and Quadrature (Q)
**Analogy**: Think of a 2D coordinate system with an X-axis and Y-axis. You can describe any point in that plane using two numbers. Radio signals work the same way—the I component is like X, and Q is like Y.

**Definition**: Any oscillating signal can be decomposed into two orthogonal (perpendicular) components:
- **I (In-phase)**: Cosine component aligned with the reference carrier
- **Q (Quadrature)**: Sine component shifted 90° from the reference

```
Baseband Complex Signal:
s(t) = I(t)·cos(ωt) + Q(t)·sin(ωt)

Or in complex notation:
s(t) = [I(t) + j·Q(t)] · e^(jωt)
```

This [[Quadrature Decomposition]] is the mathematical foundation that allows [[Software Defined Radio]] systems to capture and transmit data on both axes simultaneously.

---

### QPSK Symbol Mapping
**Analogy**: Instead of a lightbulb pointing left or right, imagine a compass needle that can point in four directions: north, south, east, or west. Each direction encodes two bits of information.

**Definition**: QPSK defines four possible phase angles (0°, 90°, 180°, 270°) on the complex plane, each representing a unique 2-bit symbol. The I and Q amplitudes can each be +1 or −1.

```
QPSK Constellation:
        Q (Imaginary)
        ↑
   11   |   10
        |
   -----+-----→ I (Real)
        |
   00   |   01
```

| Bit Pair | Phase | I Component | Q Component |
|----------|-------|-------------|-------------|
| 00       | 225°  | −1          | −1          |
| 01       | 315°  | +1          | −1          |
| 10       | 135°  | −1          | +1          |
| 11       | 45°   | +1          | +1          |

Each symbol point represents two bits transmitted simultaneously: one on the cosine (I) and one on the sine (Q).

---

### Complex Baseband Representation
**Analogy**: If BPSK is like controlling a single volume knob, QPSK is like controlling two volume knobs (one for vocals, one for instruments) independently to shape your output.

**Definition**: In [[QPSK]], the baseband signal is fully complex—both I and Q channels carry independent data streams.

```
QPSK Transmitted Signal:
s(t) = [I[n] + j·Q[n]] · e^(j·ω_c·t)

Where:
I[n], Q[n] ∈ {−1, +1}  (one bit each per symbol)
ω_c = carrier angular frequency
```

This complex representation is not theoretical—it's what your [[RTL-SDR]] or [[HackRF]] actually captures and processes.

---

### Spectral Efficiency Gain
**Analogy**: You have a pipeline that can carry water. BPSK fills one pipe with information; QPSK fills two independent pipes (I and Q) in the same space—double the flow.

**Definition**: [[Spectral Efficiency]] measures bits transmitted per hertz of bandwidth. QPSK achieves 2 bits/Hz, compared to BPSK's 1 bit/Hz, using the same bandwidth.

```
Spectral Efficiency Comparison:
BPSK: 1 bit/symbol × 1 symbol/time-slot = 1 bit/Hz
QPSK: 2 bits/symbol × 1 symbol/time-slot = 2 bits/Hz
```

For a fixed channel bandwidth, QPSK transmits data twice as fast.

---

## Hands-On Application

### GNU Radio QPSK Transceiver Flow
To work with [[QPSK]] on your SDR hardware:

1. **Baseband Generation**: Create two independent bit streams (for I and Q channels). Use a [[Packed to Unpacked]] block to convert bytes into bits.

2. **Symbol Mapping**: Apply a [[Constellation Modulator]] block configured with the QPSK constellation (4 points at ±1±j). This maps each 2-bit pair to its corresponding complex symbol.

3. **Upsampling**: Insert a [[Repeat]] or [[Interpolating FIR Filter]] block to increase the sample rate before transmission (typically 4–16× interpolation).

4. **Pulse Shaping**: Apply a [[Root Raised Cosine (RRC)]] filter to limit bandwidth and reduce [[Inter-Symbol Interference]].

5. **Carrier Frequency Shifting**: Use a [[Multiply Const]] with a complex exponential to shift from baseband (0 Hz) to your target RF frequency.

6. **Transmission**: Send the complex signal to your [[HackRF]] or [[USRP]].

### RTL-SDR Reception Example
```
flowgraph structure:
[RTL-SDR Source] → [Low Pass Filter] → [Decimation] → 
[Costas Loop (frequency/phase sync)] → 
[Constellation Decoder] → [Unpacked to Packed] → [File Sink]
```

The [[Costas Loop]] automatically tracks frequency offsets and phase errors from the received QPSK signal.

---

## Lab Exercise

**What you need**:
- [[HackRF]] or compatible TX/RX SDR (RTL-SDR + HackRF combo for transceiver work)
- [[GNU Radio]] with gr-osmosdr bindings
- Two antennas (or a loopback cable for benchmarking)
- Python or GNU Radio Companion

**Goal**: Transmit a QPSK-modulated stream and demodulate it in real time, observing the constellation diagram and bit error rate.

**Steps**:

1. **Build a QPSK Transmitter in GNU Radio Companion**:
   - Create a bit source (e.g., Random Source outputting bytes)
   - Insert a Packed to Unpacked block (8 bits → 8 individual bits)
   - Add a Constellation Modulator (QPSK preset)
   - Apply Root Raised Cosine pulse shaping (alpha=0.35, samples/symbol=8)
   - Insert a Multiply block to apply a frequency offset (e.g., 100 kHz)
   - Connect to HackRF Sink with sample rate 2 MS/s, gain 20 dB

2. **Observe the I/Q Waveform**:
   - Add a Complex to Mag Squared block to view envelope
   - Add a QT GUI Frequency Sink to see spectrum
   - Run the flowgraph; you should see a clean, symmetric QPSK spectrum with a central lobe

3. **Build a QPSK Receiver**:
   - Use HackRF Source (same frequency/sample rate)
   - Insert a Low Pass Filter (cutoff ≈150 kHz for 100 kHz offset)
   - Add Costas Loop (order=2, loop BW=0.1)
   - Insert a Constellation Decoder (QPSK, differential encoding OFF)
   - View decoded bits and compare to transmitted stream
   - Check Bit Error Rate: should be < 1e−3 in clean reception

4. **Examine the Constellation Diagram**:
   - Insert a QT GUI Constellation Sink before the decoder
   - While running, you'll see received symbols scatter around the four QPSK points
   - Tight clustering = good SNR; scatter = noise or frequency offset

5. **Measure Phase and Frequency Offset**:
   - Vary HackRF TX/RX frequency by ±50 kHz intentionally
   - Watch the constellation rotate on screen (demonstrates phase offset)
   - Confirm that Costas Loop corrects this automatically (constellation re-centers)

**What it demonstrates**:
- How [[Quadrature Sampling]] captures both I and Q data
- Symbol timing and [[Eye Diagram]] quality
- [[Frequency Offset]] effects and correction via feedback loops
- Real-time demodulation of complex signals

---

## Related Topics
- [[BPSK]] (simpler precursor, 1 bit/symbol)
- [[16-QAM]] (extension to 16 symbols)
- [[Constellation Modulator]]
- [[Costas Loop]] (phase and frequency synchronization)
- [[Pulse Shaping]] and [[Root Raised Cosine Filter]]
- [[Inter-Symbol Interference]]
- [[Quadrature Sampling]]
- [[Complex Baseband]]
- [[GNU Radio]]
- [[HackRF]]
- [[RTL-SDR]]
- [[Software Defined Radio]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Modulation Techniques]] | [[GNU Radio]]*