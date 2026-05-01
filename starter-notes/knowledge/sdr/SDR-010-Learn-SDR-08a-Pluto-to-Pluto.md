---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 010
source: rewritten
---

# Learn SDR 08a： Pluto to Pluto
**Building your first two-way RF link: transmitting and receiving on the same hardware platform.**

---

## Overview

The [[ADALM-Pluto]] is a compact, affordable [[Software Defined Radio]] transceiver capable of both transmission and reception across a wide frequency range. This lesson focuses on establishing a closed-loop communication system where one Pluto device transmits a signal that another Pluto receives, demonstrating the fundamental [[duplex]] principles underlying all RF communication systems. This hands-on approach is essential for understanding how [[modulation]], [[signal generation]], and [[antenna coupling]] work in practice.

---

## Key Concepts

### Antenna Orientation and Coupling
**Analogy**: Imagine two people shouting at each other in a canyon. If they face the same direction (parallel), sound bounces off the same walls and returns to both ears efficiently. If one turns away, the signal degrades.

**Definition**: [[Antenna]] alignment directly affects [[RF coupling]] efficiency between transmitter and receiver. [[Vertical antenna]] orientation and parallel alignment maximize [[electromagnetic field]] overlap between devices.

For the [[ADALM-Pluto]], the included [[broadband antenna|antennas]] are optimized for [[ISM bands]]:
- **915 MHz** (Industrial Scientific Medical band)
- **2.4 GHz** (WiFi/Bluetooth band)

**Installation technique**: Hold the antenna body stationary; rotate only the connector collar. This prevents damage to the [[SMA connector]] pin.

---

### Full-Duplex Transmission Architecture
**Analogy**: A walkie-talkie that can talk and listen simultaneously is like having two separate radio channels happening at once—your mouth uses one frequency band while your ears monitor another.

**Definition**: [[Full-duplex]] operation requires separate [[transmit]] and [[receive]] signal paths within the same [[transceiver]]. The [[ADALM-Pluto]] uses [[Industrial IIO (Input/Output)]] libraries to manage bidirectional data flow.

| Component | Role | In GNU Radio |
|-----------|------|--------------|
| [[Pluto SDR Source]] | Receives incoming RF | Data output (complex samples) |
| [[Pluto SDR Sink]] | Transmits outgoing RF | Data input (complex samples) |
| [[IIO Library]] | Hardware interface | PlutoSDR block family |

---

### Complex Exponential Transmission
**Analogy**: A spinning clock hand traces a circle. Its position at any moment encodes both amplitude (hand length) and phase (angle). In radio, this spinning pattern creates a pure tone.

**Definition**: A [[complex exponential]] signal of the form:

$$e^{i\omega t} = \cos(\omega t) + i\sin(\omega t)$$

represents a single [[RF tone]] spinning at angular frequency $\omega$. When this complex baseband signal is [[upconverted]] to RF frequencies, it produces a single-frequency transmission with no harmonic distortion.

**In the [[ADALM-Pluto]] context**:
- You generate complex samples in [[GNU Radio]]
- The [[Pluto SDR Sink]] upconverts them to your target RF frequency
- The result: a clean, controllable tone transmitted from the antenna

---

### Signal Path: Baseband to RF
**Analogy**: Imagine composing a song on a piano (baseband), then broadcasting it over a radio station (RF). The station's transmitter amplifies and shifts the music to the broadcast frequency.

**Definition**: [[Baseband]] signals (typically 0–5 MHz in GNU Radio) are mathematically shifted to higher [[RF frequency|RF frequencies]] via [[frequency translation]]. The [[ADALM-Pluto]] performs this internally:

$$RF_{output} = \text{Baseband}_{complex} \times e^{i\omega_{carrier}t}$$

---

## Hands-On Application

### Setting Up the Pluto-to-Pluto Link

**GNU Radio Workflow**:

1. **Create transmit path**:
   - Drag `PlutoSDR Sink` block from *Industrial → IIO*
   - Set **Center Frequency**: 915 MHz (or 2.4 GHz for WiFi band testing)
   - Set **Sample Rate**: 1 MS/s (1,000,000 samples/second)
   - Adjust **Gain**: Start conservative (20–30 dB)

2. **Create receive path**:
   - Drag `PlutoSDR Source` block from *Industrial → IIO*
   - Match the same center frequency and sample rate
   - Connect output to a `Complex to Magnitude²` and `QT GUI Time Sink` for visualization

3. **Generate test signal**:
   - Insert `Signal Source` block (sine wave or complex exponential)
   - Set frequency to **1 kHz** (well within the baseband window)
   - Connect to the **PlutoSDR Sink**

4. **Monitor reception**:
   - Run the flowgraph
   - The **PlutoSDR Source** should capture the transmitted tone
   - Watch the time-domain plot for a clear sinusoid at your baseband frequency

**Common Pitfalls**:
- Forgetting to set both devices to the **same frequency**
- Using **mismatched sample rates** (causes timing errors)
- **Antennas too close** (saturation) or too far (weak signal)

---

## Lab Exercise

**What you need**:
- Two [[ADALM-Pluto]] devices with antennas attached
- [[GNU Radio]] 3.8+ installed
- USB power for each Pluto
- USB cables for computer connection

**Goal**: 
Establish bidirectional communication where Pluto #1 transmits a 1 kHz tone that Pluto #2 receives and displays in real-time, then reverse roles.

**Steps**:

1. **Hardware setup**:
   - Attach antennas to both Plutos, oriented vertically and parallel
   - Space devices 0.5–1 meter apart
   - Connect both via USB

2. **Transmitter flowgraph (Pluto #1)**:
   - `Signal Source` (sine, 1 kHz) → `PlutoSDR Sink` (915 MHz, 1 MS/s)
   - Set output gain to 20 dB
   - Run the flowgraph

3. **Receiver flowgraph (Pluto #2)**:
   - `PlutoSDR Source` (915 MHz, 1 MS/s) → `Complex to Magnitude²` → `QT GUI Time Sink`
   - Launch in a separate GNU Radio window
   - Run and observe the incoming tone

4. **Observe and measure**:
   - **Frequency domain**: FFT shows spike at baseband 1 kHz ✓
   - **Time domain**: Sinusoidal oscillation visible ✓
   - **Signal strength**: Adjust transmit gain; watch receiver magnitude change proportionally ✓
   - **Phase coherence**: Multiple runs produce consistent waveform shape (no random noise) ✓

5. **Reverse roles**:
   - Swap transmitter/receiver flowgraphs between devices
   - Confirm symmetric bidirectional operation
   - **Demonstrates**: Hardware is identical; software determines TX/RX function

---

## Related Topics
- [[ADALM-Pluto]]
- [[GNU Radio]]
- [[Industrial IIO Drivers]]
- [[RF Transceiver Architecture]]
- [[Complex Baseband Signals]]
- [[Frequency Translation and Upconversion]]
- [[ISM Bands]]
- [[SMA Connector]]
- [[Duplex Communication]]
- [[Signal Source Block]]
- [[PlutoSDR Sink and Source]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[ADALM-Pluto]] | Instructor-led rewrite*