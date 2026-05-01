---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 005
source: rewritten
---

# Learn SDR 04： What's Inside an SDR： Designing one from First Principles
**Build intuition about SDR architecture by reverse-engineering how real signals transform into complex baseband samples.**

---

## Overview

An [[Software Defined Radio|SDR]] is fundamentally a signal converter—it takes a real-valued [[Radio Frequency|RF]] signal arriving at your antenna and transforms it into a stream of [[Complex Numbers|complex numbers]] that software can process. Understanding this conversion process is essential because it reveals why SDRs behave the way they do and how to interpret what you're observing. By systematically testing with known [[Signal Generator|signal generators]] and observing the output, we can reconstruct the inner workings of any SDR from first principles.

---

## Key Concepts

### Real Signals vs. Complex Baseband Representation

**Analogy**: Imagine watching a spinning coin. From above, you see circular motion (complex rotation). But if you only recorded the coin's shadow on a wall, you'd see back-and-forth motion (a real oscillation). The coin's 3D motion contains more information than its 1D projection—similarly, complex baseband samples contain the full information that a real RF signal can only hint at.

**Definition**: The [[Radio Frequency|RF signal]] entering your antenna is always a [[Real Number|real-valued]] function of time—it's a voltage that oscillates. The [[Software Defined Radio]] converts this single real stream into pairs of numbers (in-phase and quadrature components), creating [[Complex Numbers|complex samples]] that more naturally represent modulated signals.

$$x_{RF}(t) \in \mathbb{R} \rightarrow [I(t), Q(t)] \rightarrow x_{BB}(n) \in \mathbb{C}$$

Where $x_{RF}(t)$ is the analog RF signal, $I(t)$ and $Q(t)$ are the real and imaginary components, and $x_{BB}(n)$ are discrete complex baseband samples.

---

### Tuning and Frequency Translation

**Analogy**: Tuning an old AM radio dial is like sliding a window across a wall of different paintings. You're selecting which portion of the full spectrum to examine closely. An SDR's tuning works the same way—it mathematically "slides" to a center frequency and extracts everything nearby.

**Definition**: When you set an [[SDR Receiver|SDR receiver]] to a specific [[Center Frequency|center frequency]] (e.g., 100 MHz), you're performing [[Frequency Translation|frequency translation]]. Any signal component at that frequency appears as DC (0 Hz) in the output; components slightly above appear as positive frequencies, and components slightly below appear as negative frequencies in the [[Complex Baseband|complex baseband]] representation.

**Frequency Translation Formula**:
$$x_{BB}(t) = x_{RF}(t) \cdot e^{-i2\pi f_c t}$$

Where $f_c$ is the center frequency and the exponential term is a [[Local Oscillator|local oscillator]] signal.

---

### Observing Frequency Offset Through Tone Testing

**Analogy**: If you're searching for a friend in a crowded room and you hear their voice slightly to your left, you know they're offset from where you're facing. Similarly, when your SDR tunes to 100 MHz but receives a tone at 100.001 MHz, you'll see a 1 kHz oscillation in the complex output—it's the "offset signal" that escaped your tuning window.

**Definition**: A [[Pure Tone|pure tone]] at frequency $f_{tone}$ received when the SDR is tuned to $f_c$ produces a complex [[Exponential Function|exponential]] at baseband frequency $f_{tone} - f_c$. This is observable as a rotating phasor (spinning vector) in the complex plane.

**Test Results Table**:

| Input Tone Frequency | SDR Tuning | Baseband Frequency | Observable Pattern |
|---|---|---|---|
| 100.001 MHz | 100 MHz | +1 kHz | CW rotation (positive frequency) |
| 99.999 MHz | 100 MHz | −1 kHz | CCW rotation (negative frequency) |
| 100.000 MHz | 100 MHz | 0 Hz | DC (stationary phasor) |

$$x_{BB}(n) = e^{i2\pi(f_{tone}-f_c) n T_s}$$

Where $T_s$ is the [[Sampling Period|sampling period]].

---

### The ADC (Analog-to-Digital Converter) Stage

**Analogy**: An [[Analog-to-Digital Converter|ADC]] is like a photographer taking snapshots of a flowing river. The faster you take photos, the more detail you capture about the water's motion. Too-slow photos blur everything together; fast photos freeze the motion.

**Definition**: The ADC in an [[Software Defined Radio|SDR]] samples the incoming [[Radio Frequency|RF]] or intermediate frequency signal at a fixed [[Sampling Rate|sampling rate]] (e.g., 2.4 MSPS for an [[RTL-SDR]]). Each sample is quantized to a finite number of bits, limiting precision. The [[Nyquist Frequency|Nyquist sampling theorem]] requires the sampling rate to exceed twice the bandwidth of interest.

$$f_s \geq 2 \times f_{max}$$

---

### The Mixer (Frequency Down-Conversion)

**Analogy**: A mixer is like tuning a traditional superheterodyne radio. You multiply the incoming signal by a [[Local Oscillator|local oscillator]] tone at your desired center frequency, which mathematically shifts the spectrum. Components at that frequency drop to baseband (zero frequency), making them easy to filter and examine.

**Definition**: The [[Mixer|mixer]] multiplies the sampled RF signal by a complex exponential at the [[Local Oscillator|local oscillator]] frequency:

$$x_{mixed}(n) = x_{RF}(n) \cdot e^{-i2\pi f_{LO} n / f_s}$$

This operation shifts the RF spectrum down so the [[Center Frequency|center frequency]] becomes zero in the baseband representation.

---

### Low-Pass Filtering and Alias Prevention

**Analogy**: Imagine a wide highway with cars (signal components) traveling at different speeds. A low-pass filter is like placing a gate that only lets slow-moving cars through, stopping the fast ones. In radio, "slow" means low frequency and "fast" means high frequency.

**Definition**: After mixing, a [[Low-Pass Filter|low-pass filter]] removes frequency components above half the [[Sampling Rate|sampling rate]] to prevent [[Aliasing|aliasing]]—the false re-creation of high-frequency signals at incorrect lower frequencies.

$$f_{cutoff} < \frac{f_s}{2}$$

---

## Hands-On Application

### Testing with RTL-SDR

1. **Set up your environment**: Install [[GNU Radio]], [[GQRX]], or [[CubicSDR]].

2. **Connect a signal source**:
   - Use a [[Signal Generator]] (function generator or software simulator) or
   - Use existing FM radio at known frequencies (88–108 MHz)

3. **Observe tuning behavior**:
   ```
   - Open your SDR application
   - Set center frequency to 100 MHz
   - Input a 100.001 MHz tone from a signal generator
   - Observe the waterfall display—you should see a signal line
   - In time-domain IQ plot, watch the phasor rotate at 1 kHz
   ```

4. **Test frequency offset**:
   - Slowly sweep the input tone frequency upward
   - Watch the rotation rate in the IQ display increase
   - At exactly 100 MHz, the phasor locks (0 Hz rotation)
   - Below 100 MHz, rotation reverses direction (negative frequency)

5. **Verify baseband representation**:
   - Use [[GNU Radio]]'s [[FFT Sink]] to plot the baseband spectrum
   - Input a tone 5 kHz above center frequency
   - Confirm the FFT peak appears at +5 kHz (not at the original RF frequency)

---

## Lab Exercise

**What you need**: 
- [[RTL-SDR]] dongle or [[HackRF]] 
- [[GNU Radio]] or [[GQRX]]
- Signal generator (hardware or software like [[GNU Radio]]'s Signal Source block)
- USB antenna (included or aftermarket)

**Goal**: 
Build a mental model of [[Frequency Translation|frequency translation]] by observing how an [[SDR Receiver|SDR receiver]] converts a real RF tone into a complex rotating phasor at baseband.

**Steps**:

1. **Generate a test tone**:
   - In [[GNU Radio]], create a flowgraph with a [[Signal Source]] block set to 100.005 MHz, amplitude 0.1
   - If using hardware generator, output a 100.005 MHz CW tone at moderate power (~0 dBm)

2. **Configure RTL-SDR receiver**:
   - Set center frequency to 100 MHz
   - Set [[Sampling Rate|sampling rate]] to 2.4 MSPS (RTL-SDR default)
   - Connect to antenna or attenuated signal generator output

3. **Visualize baseband output**:
   - Open [[GQRX]] → Tools → I/Q Recorder, or
   - Use [[GNU Radio]] with [[QT GUI Sink]] (Frequency and IQ Time)
   - You should see:
     - **Frequency domain**: Sharp peak at +5 kHz
     - **Time domain (IQ plot)**: Rotating circle at 5 kHz frequency
     - **Constellation plot**: Circle (constant magnitude, rotating phase)

4. **Verify offset behavior**:
   - Change generator to 99.995 MHz (5 kHz below center)
   - Observe FFT peak shift to −5 kHz
   - Observe phasor rotation reversal (CCW instead of CW)

5. **Sweep through center frequency**:
   - Slowly change [[RTL-SDR]] tuning from 99 MHz to 101 MHz
   - Keep input tone at 100.005 MHz
   - Watch the baseband tone frequency change: large negative → zero → large positive
   - At 100.005 MHz tuning, baseband becomes DC (stationary phasor)

**What it demonstrates**:
- The real RF signal contains no explicit frequency information—it's just a voltage changing in time
- [[Frequency Translation|Frequency translation]] creates the illusion of a rotating phasor by multiplying by a [[Local Oscillator|local oscillator]]
- [[Complex Numbers|Complex representation]] (IQ) captures both magnitude and phase information that a real signal cannot show
- The [[Software Defined Radio|SDR's]] ability to tune is purely mathematical—it's retuning the [[Local Oscillator|local oscillator]], not a physical component

---

## Related Topics
- [[RTL-SDR Fundamentals]]
- [[GNU Radio Basics]]
- [[Complex Baseband Signals]]
- [[Frequency Translation]]
- [[Nyquist Sampling Theorem]]
- [[Quadrature Sampling]]
- [[Local Oscillator]]
- [[In-Phase and Quadrature Components]]
- [[Aliasing in SDR]]
- [[Superheterodyne Architecture]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GNU Radio]]*