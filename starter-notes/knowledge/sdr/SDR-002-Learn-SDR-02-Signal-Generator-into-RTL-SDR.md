---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 002
source: rewritten
---

# Learn SDR 02： Signal Generator into RTL-SDR
**Understanding how real RF signals appear in the SDR receiver and why complex numbers reveal what analog oscilloscopes cannot.**

---

## Overview

When you connect a physical [[Radio Frequency|RF]] signal into an [[RTL-SDR]] dongle, the receiver doesn't just hand you a simple waveform—it outputs [[Complex Numbers|complex-valued samples]] that capture both amplitude and phase information simultaneously. This lecture demonstrates the bridge between traditional analog test equipment and the digital signal processing world of [[Software Defined Radio|SDR]], showing how to visualize and interpret what your receiver actually sees.

---

## Key Concepts

### Complex-Valued Samples from the Receiver
**Analogy**: Think of a traditional oscilloscope as showing you a dancer from the side—you see up-and-down motion. A [[Software Defined Radio|SDR receiver]] watches from above as the dancer moves in a circle; it records both the north-south position (imaginary part) and east-west position (real part) at each moment. That pair of coordinates is a complex number, and it contains more information than either axis alone.

**Definition**: [[RTL-SDR|RTL-SDR receivers]] produce a stream of [[Complex Numbers|complex samples]] where each sample is represented as:
$$s[n] = I[n] + jQ[n]$$

where $I$ (in-phase) and $Q$ (quadrature) components capture the signal's amplitude and phase at that instant. This is called [[IQ Data|IQ sampling]].

**Why it matters**: An [[Analog Oscilloscope|analog oscilloscope]] shows you only one real-valued waveform at a time. A [[Software Defined Radio|digital receiver]] captures both dimensions of the signal simultaneously, allowing you to reconstruct modulation, measure phase relationships, and detect signals that real-only sampling would ambiguously alias.

---

### Tuning to Center Frequency
**Analogy**: Imagine you're listening to a radio: you tune the dial to 100 FM. Everything you hear and analyze happens relative to that center point. If someone whispers 10 kHz to the right of that dial position, you need to know where "100 MHz + 10 kHz" is to locate them.

**Definition**: The [[Center Frequency|center frequency]] is the frequency your [[RTL-SDR|SDR receiver]] is tuned to. All signals you observe are represented relative to this point. If tuned to 100.000 MHz and a signal arrives at 100.010 MHz, it appears as a +10 kHz [[Offset Frequency|offset]] in the [[Baseband|baseband]] representation.

**Setting**: In [[GNU Radio]], configure the RTL-SDR source block to output at a specific center frequency (e.g., 100e6 Hz).

---

### Real vs. Complex Signals
**Analogy**: A real signal is like a black-and-white photograph—it contains amplitude information only. A complex signal is like a color photograph—it contains amplitude *and* phase (or equivalently, two independent dimensions of information).

**Definition**: 
- **[[Real Signal|Real signal]]**: Single stream of values, $x[n] \in \mathbb{R}$. Exhibits [[Nyquist Sampling Theorem|Nyquist ambiguity]]—positive and negative frequencies are mirror images.
- **[[Complex Signal|Complex signal]]**: Paired values as $s[n] = I[n] + jQ[n]$. Positive and negative frequencies are *distinct*, allowing unambiguous representation of RF signals.

| Aspect | Real Sampling | Complex (IQ) Sampling |
|--------|---------------|----------------------|
| Samples per period | 2 × bandwidth | 1 × bandwidth |
| Negative frequencies | Mirror image (ambiguous) | Unique (unambiguous) |
| [[Sampling Rate]] required | $2 \times$ signal bandwidth | $1 \times$ signal bandwidth |
| CPU load | Lower | Higher (2 values/sample) |

---

### Negative Frequencies in the Complex Domain
**Analogy**: In real life, frequency is always positive—100 MHz is 100 MHz. But mathematically, a rotating vector can spin clockwise or counterclockwise. Negative frequencies represent counterclockwise rotation; positive frequencies represent clockwise rotation. A real sinusoid is *both* a positive and negative frequency rotating together.

**Definition**: When working with [[Complex Numbers|complex samples]], the [[Frequency Domain|frequency domain]] extends from $-f_s/2$ to $+f_s/2$, where $f_s$ is the [[Sampling Rate|sample rate]]. A signal at RF frequency $f_0$ appears as an offset from the [[Center Frequency|center frequency]]:

$$f_{\text{baseband}} = f_{\text{RF}} - f_{\text{center}}$$

If you tune to 100 MHz (center) and observe a signal at 100.010 MHz, it appears at +10 kHz in the [[Baseband|baseband]].

**Why SDR reveals this**: Analog oscilloscopes only show real waveforms. [[Software Defined Radio|SDR processing]] explicitly separates positive and negative frequencies, revealing the complete [[Phase|phase]] structure.

---

### Sample Rate and Bandwidth
**Analogy**: A film camera captures still frames at a certain rate (fps). Faster frame rate = more detail captured. For [[Software Defined Radio|SDR]], [[Sampling Rate|sample rate]] determines how much [[Bandwidth|bandwidth]] you can observe without aliasing.

**Definition**: The [[Sampling Rate|sample rate]] is the number of [[Complex Numbers|complex samples]] per second your receiver produces. For an [[RTL-SDR|RTL-SDR]], this is typically 1–2.4 MHz. The usable bandwidth is approximately equal to the sample rate (for complex sampling).

**Formula**:
$$\text{Usable Bandwidth} \approx f_s = \frac{1}{T_s}$$

where $f_s$ is sample rate and $T_s$ is sample period.

---

## Hands-On Application

**Setup**:
1. Connect an [[RF Signal Generator|RF signal generator]] to an [[RTL-SDR]] dongle via a short cable or through near-field coupling (loose wires placed near the dongle's antenna).
2. Open [[GNU Radio]] Companion and create a new flowgraph.
3. Add an **osmocom RTL-SDR source** block.

**Key Configuration**:
- Set **Output Type**: Complex (this is mandatory; RTL-SDR always outputs complex samples)
- Set **Sample Rate**: 1 MHz (for viewing clarity; adjust as needed for your application)
- Set **Center Frequency**: Match your signal generator's frequency (e.g., 100e6 for 100 MHz)
- Leave gain and other parameters at defaults initially

**Visualization**:
- Connect the RTL-SDR source to a **QT GUI Time Sink** to plot the raw [[Complex Numbers|I and Q samples]] over time.
- Also connect to a **QT GUI Frequency Sink** to observe the [[Frequency Spectrum|frequency spectrum]].
- Run the flowgraph and observe how the signal appears in both time and frequency domains.

**Interpretation**:
- The **time domain** shows oscillation in the I and Q components; they are typically 90° out of phase.
- The **frequency domain** shows a single peak at the signal's frequency offset from center (not two mirror peaks like real sampling would show).

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] dongle
- [[GNU Radio]] Companion (installed and functional)
- An [[RF Signal Generator|RF signal generator]] or [[Function Generator|function generator]] capable of ~100 MHz output
- Short coaxial cable or two alligator-clip wires for coupling
- Computer with SDR software stack

**Goal**: 
Capture a known RF signal on an [[RTL-SDR|RTL-SDR]] receiver, observe it in both time and frequency domains, and confirm that the [[Complex Numbers|complex output]] reveals the signal unambiguously (single spectral peak, not a mirrored pair).

**Steps**:

1. **Generate a test signal**
   - Set an RF signal generator to exactly 100.010 MHz (100 MHz center + 10 kHz offset)
   - Output power: low (~–20 dBm or less)
   - Signal type: continuous wave (CW) or simple sinusoid

2. **Couple the signal into the RTL-SDR**
   - Use a short cable if available, or place two bare wires near the dongle's antenna input
   - Observe reception without a direct electrical connection (near-field coupling)

3. **Build the GNU Radio flowgraph**
   - Add **osmocom RTL-SDR Source** block
   - Set center frequency to 100e6 (100 MHz)
   - Set sample rate to 1e6 (1 MHz)
   - Connect to **QT GUI Time Sink** (observe I, Q waveforms)
   - Connect to **QT GUI Frequency Sink** (observe spectrum)

4. **Run and observe**
   - Execute the flowgraph
   - Watch the time-domain plot: you should see sinusoidal oscillation in both I and Q
   - Watch the frequency-domain plot: you should see a single sharp peak at +10 kHz (the 10 kHz offset)

5. **What this demonstrates**
   - [[Complex Numbers|Complex sampling]] captures phase information; I and Q are 90° apart
   - [[Software Defined Radio|SDR receivers]] output [[Complex Numbers|complex-valued samples]], not real-valued ones
   - [[Negative Frequencies|Negative frequencies]] are not "mirrored" as they would be in real sampling—a signal appears only once in the spectrum
   - The signal is **unambiguous**: you know exactly that the incoming signal is at 100.010 MHz, not at some aliased or folded frequency

6. **Extended exploration**
   - Retune to a slightly different center frequency (e.g., 100.005 MHz) and re-run; the peak should shift
   - Change the [[Sampling Rate|sample rate]] to 2 MHz; bandwidth doubles, but the peak position remains correct
   - Observe how the I and Q components relate: they should maintain a consistent 90° phase relationship

---

## Related Topics
- [[RTL-SDR]]: Hardware receiver used in this exercise
- [[GNU Radio]]: Signal processing and visualization framework
- [[Complex Numbers]]: Mathematical foundation for IQ sampling
- [[IQ Data]]: The I/Q sample representation in SDR
- [[Frequency Domain]]: Spectral view of signals
- [[Sampling Rate]]: Determines receiver bandwidth and fidelity
- [[Center Frequency]]: The tuning point of the receiver
- [[Quadrature Sampling]]: The technique behind complex sample generation
- [[Baseband Signal]]: The signal representation after downconversion
- [[Aliasing]]: Why proper sampling rate matters

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GNU Radio]]*