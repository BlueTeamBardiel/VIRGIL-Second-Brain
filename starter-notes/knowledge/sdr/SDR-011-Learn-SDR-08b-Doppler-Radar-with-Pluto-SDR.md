---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 011
source: rewritten
---

# Learn SDR 08b： Doppler Radar with Pluto SDR
**Building your first practical transceiver application: detecting motion through frequency shift.**

---

## Overview
Doppler radar represents one of the first genuinely useful [[Software Defined Radio]] projects—it moves beyond theory into real-world sensing. The [[Pluto SDR]] has both transmit and receive capabilities close together, making it ideal for detecting moving objects nearby. Understanding this application teaches you how [[Transceiver|transceivers]] work, how motion affects radio waves, and how to extract meaningful information from reflected signals.

---

## Key Concepts

### Doppler Shift
**Analogy**: Imagine standing by a highway. When an ambulance approaches you, its siren pitch rises; as it passes and moves away, the pitch drops. The sound waves are physically stretched or compressed by the ambulance's motion—same principle happens with radio waves bouncing off moving objects.

**Definition**: The apparent change in [[Frequency]] of a [[Radio Wave|radio wave]] when the source or reflector moves relative to the observer.

**Mathematical relationship**:
$$f_{observed} = f_{transmitted} \times \frac{c + v_{observer}}{c + v_{source}}$$

Where:
- $f_{transmitted}$ = original transmitted frequency
- $c$ = speed of light (or sound)
- $v$ = velocity (positive = approaching, negative = receding)

For typical [[Radar]] scenarios:
$$\Delta f = \frac{2 \times v \times f_0}{c}$$

The factor of 2 appears because the wave travels to the target *and back*.

**Related concepts**: [[Frequency Shift]], [[Motion Detection]], [[Velocity Estimation]]

---

### Monostatic Radar Geometry
**Analogy**: Think of shouting in an empty room and listening to your echo. A monostatic radar does exactly this—transmitter and receiver are at the same (or very close) location, sending out a signal and listening for reflections.

**Definition**: A radar system where the transmit and receive antennas are spatially close or colocated. The [[Pluto SDR]] uses monostatic geometry with antennas only centimeters apart.

**Why this matters for your setup**:
- Direct coupling dominates the received signal (strong [[Feedthrough|leakage]] from TX to RX)
- Reflected signals are much weaker (often 40–60 dB smaller)
- You must filter or subtract the strong direct path to see reflections

**Related concepts**: [[Radar Geometry]], [[Antenna Coupling]], [[Signal Isolation]]

---

### Signal Components in Reception
**Analogy**: Imagine a bright lamp in a dark room. The lamp itself (direct signal) is blinding. But if you look carefully, you can still see a faint reflection of the lamp in a mirror—that's the weak reflected component you're trying to measure.

**Definition**: In monostatic radar, the received signal consists of:
1. **Direct path**: Transmitted signal coupled directly from TX antenna → RX antenna (very strong, essentially constant)
2. **Reflected path**: Transmitted signal → target → back to RX antenna (weak, contains Doppler information)

**Signal model**:
$$s_{RX}(t) = A_{direct} \cdot e^{j 2\pi f_0 t} + A_{reflected} \cdot e^{j 2\pi (f_0 + \Delta f) t} + n(t)$$

Where:
- $A_{direct} \gg A_{reflected}$ (direct is 100× stronger or more)
- $\Delta f$ encodes the target velocity
- $n(t)$ is thermal noise

**Related concepts**: [[Phase Coherence]], [[Signal-to-Noise Ratio]], [[Interference Suppression]]

---

### Detection of Motion via Frequency Measurement
**Analogy**: Imagine two adjacent ripples on a pond. If the ripples are moving away from you, the spacing between them stretches; if they move toward you, it compresses. Count how fast the ripples pass a fixed point—that rate tells you their speed.

**Definition**: By observing how the received frequency shifts from the transmitted frequency, you can infer the velocity of reflective objects.

**Practical measurement approach**:
1. Transmit a pure [[Sinusoid]] at frequency $f_0$
2. Receive and demodulate (mix down to [[Baseband]])
3. Measure the frequency content of the received signal (use [[FFT]])
4. Identify peaks offset from zero—these offsets are $\Delta f$
5. Convert $\Delta f$ to velocity: $v = \frac{\Delta f \times c}{2 \times f_0}$

**Related concepts**: [[Baseband Demodulation]], [[Frequency Estimation]], [[FFT]], [[Velocity Estimation]]

---

### Isolation and Cancellation
**Analogy**: You're trying to hear a whisper across a noisy room. First, you ask everyone else to be quiet (isolation), then you position yourself closer to the whisperer (coupling reduction). If neither works perfectly, you memorize the background noise pattern and mentally subtract it (cancellation).

**Definition**: Techniques to remove or reduce the dominant direct-path signal so the weaker reflected component becomes visible.

**Common strategies**:
| Technique | Method | Effectiveness |
|-----------|--------|---|
| **Antenna Isolation** | Physical separation or shielding between TX/RX antennas | Moderate (~20–30 dB) |
| **Frequency Notch Filter** | [[Digital Filter]] to null out the transmitted frequency | High (~40–60 dB) on direct path |
| **Phase Cancellation** | Measure and subtract a replica of the direct signal | Very high (~60+ dB) if calibrated |
| **Passive Cancellation Network** | Directional coupler or hybrid that inherently isolates TX from RX | Moderate, hardware-based |

**Related concepts**: [[Signal Subtraction]], [[Filtering]], [[Adaptive Filtering]], [[Self-Interference Cancellation]]

---

## Hands-On Application

### SDR Setup for Doppler Radar

**Hardware needed**:
- [[Pluto SDR]] with USB power and host connection
- Antenna pair (provided with Pluto, or small dipoles)
- Computer with [[GNU Radio]] or [[MATLAB]]/[[Python]]

**Software workflow**:

1. **Initialize the Pluto transceiver**
   - Set transmit frequency: ~3.5 GHz (near Pluto's maximum)
   - Set receive frequency: identical to transmit
   - Transmit power: low (~0 dBm) to avoid saturation
   - Sampling rate: 2–5 MHz (sufficient for Doppler detection)

2. **Generate transmit signal**
   - Single-tone [[CW (Continuous Wave)]] at baseband (e.g., 100 kHz offset, or 0 Hz if using hardware oscillator)
   - Alternatively, [[Chirp]] signal for [[Range Resolution|range]] + velocity info

3. **Receive and demodulate**
   - Capture raw [[IQ (In-Phase/Quadrature)]] samples
   - Apply [[Notch Filter]] centered at DC or transmitted frequency to suppress feedthrough
   - Compute running [[FFT]] to observe frequency content over time

4. **Detect and measure Doppler**
   - Identify spectral peaks away from DC
   - Track peak frequency as you move hand toward/away from device
   - Map frequency shift → velocity using Doppler formula

**Example GNU Radio flow**:
```
[Pluto SDR TX: CW at 100 kHz] 
    ↓
[Pluto SDR RX: capture IQ]
    ↓
[Notch/Highpass Filter]
    ↓
[FFT Sink / Frequency Plot]
    ↓
[Observe peaks shift when you move]
```

---

## Lab Exercise

**What you need**:
- [[Pluto SDR]] with antenna connectors
- [[GNU Radio]] or [[Python]] with [[Plutosdr]] driver (`pyadi-iio`)
- USB cable and host PC
- Optional: [[HackRF]] or [[USRP]] as alternative [[Software Defined Radio|SDR]] platform

**Goal**: 
Transmit a continuous 3.5 GHz tone and observe frequency shifting (typically ±100 Hz to ±1 kHz range) as you move your hand closer and farther from the Pluto's antennas.

**Steps**:

1. **Configure Pluto for simultaneous TX/RX**
   - Open [[GNU Radio Companion]] and create a new flowgraph
   - Add [[Pluto SDR Source]] block (RX): frequency = 3.500 GHz, sample rate = 4 MHz
   - Add [[Pluto SDR Sink]] block (TX): same frequency, sample rate 4 MHz
   - Add [[Signal Source]] (sine wave, 100 kHz) to TX path
   - Connect TX source → Pluto TX sink

2. **Receive and filter**
   - Connect Pluto RX source → [[High Pass Filter]] (cutoff ~1 kHz, remove DC and feedthrough)
   - Connect filtered signal → [[FFT]] / **Frequency Plot** sink (or [[Waterfall Sink]])
   - Set FFT window size to 2048 points, averaging enabled

3. **Run and observe**
   - Execute flowgraph
   - Observe the frequency plot—you should see a sharp peak near 0 Hz from the strong direct signal
   - **Slowly move your hand toward the Pluto antenna** — watch the plot shift right (positive Doppler, approaching motion)
   - **Slowly move your hand away** — watch the plot shift left (negative Doppler, receding motion)

4. **Quantify the shift**
   - Note the peak frequency offset (in Hz) at different hand positions
   - Estimate hand velocity from: $v \approx \frac{\Delta f \times c}{2 f_0}$ where $c = 3 \times 10^8$ m/s, $f_0 = 3.5 \times 10^9$ Hz
   - For a 100 Hz shift: $v \approx 4$ cm/s (reasonable hand motion)

5. **What it demonstrates**
   - **Transceiver operation**: Real-time TX/RX on same hardware
   - **Doppler physics**: Observed frequency shift matches theory
   - **Motion sensing**: Simple Doppler radar is viable with [[Software Defined Radio]]
   - **Signal processing**: Filtering, FFT, and real-time analysis on captured RF

**Expected observations**:
- Direct-path signal at DC offset (very strong, visible on all plots)
- Reflected signal ±100–500 Hz depending on hand speed
- Smooth frequency sweep as hand accelerates/decelerates
- Noise floor typically 20–40 dB below strong signals

---

## Related Topics
- [[Pluto SDR]]
- [[Transceiver|Transceiver Design]]
- [[Frequency Shift Keying|Modulation and Doppler]]
- [[Radar Fundamentals]]
- [[Motion Detection]]
- [[Phase Coherence]]
- [[Software Defined Radio]]
- [[GNU Radio]]
- [[Signal Processing]]
- [[Notch Filter]]
- [[FFT]]
- [[IQ Modulation]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Doppler Radar]] | [[Pluto SDR]] | Practical RF Sensing*