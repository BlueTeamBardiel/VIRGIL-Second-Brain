---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 004
source: rewritten
---

# Learn SDR 03b： Negative Frequency Question
**Negative frequencies don't exist in the physical world—they're a mathematical artifact of how we analyze real signals.**

---

## Overview

When you first encounter [[negative frequencies]] in [[SDR]] theory, it feels counterintuitive: radio waves travel through air at positive frequencies, so how can there be "negative" ones? The answer lies in understanding how [[real signals]] decompose mathematically. In practical [[RF]] work, negative frequencies help us comprehend why real-world transmissions always exhibit [[spectral symmetry]], and grasping this concept is essential for properly interpreting what your [[RTL-SDR]] or [[HackRF]] is actually receiving.

---

## Key Concepts

### Real Signals and Mathematical Decomposition
**Analogy**: Imagine describing a person's height. You could say they're 6 feet tall (one number), or you could say they're composed equally of +3 feet above a midpoint and -3 feet below it (two complementary parts that sum to the same thing). Both descriptions are true; the second is just a different mathematical framework.

**Definition**: A [[real signal]] in the physical world—any actual voltage on a wire or electromagnetic wave in space—can be mathematically represented as a sum of [[complex exponentials]]. These complex exponentials come in mirror-image pairs: one at positive frequency and one at negative frequency. The negative frequency component isn't "real" in the physical sense; it's a bookkeeping artifact of the math.

**Key insight**: Any real sinusoid (sine or cosine) can be decomposed as:

$$\cos(2\pi f t) = \frac{1}{2}e^{j2\pi f t} + \frac{1}{2}e^{-j2\pi f t}$$

The term $e^{-j2\pi f t}$ is the "negative frequency" representation.

---

### Spectral Symmetry
**Analogy**: If you fold a photograph of a landscape in half down the middle, the left and right sides mirror each other. A real signal's frequency spectrum does the same thing—whatever power exists at +100 MHz must have an equal mirror image at -100 MHz.

**Definition**: [[Spectral symmetry]] (or [[Hermitian symmetry]]) is a fundamental property of any real signal: its frequency domain representation is symmetric around zero frequency. If a signal has spectral content at frequency $+f$, it must have equal spectral content at frequency $-f$.

| Frequency Bin | Real Signal Spectrum | Complex Signal Spectrum |
|---|---|---|
| +100 MHz | Power P | Power P |
| -100 MHz | Power P | No conjugate pair |
| 0 Hz (DC) | Real-valued | Real-valued |

This symmetry is not a choice—it's a mathematical necessity when your signal consists of real numbers (not complex numbers) at every sample point.

---

### Why This Matters for SDR Receivers
**Analogy**: When you tune a traditional radio dial, you're only seeing the positive frequency half. But mathematically, your receiver is capturing both halves. It's like buying one shoe and automatically knowing the mirror-image shoe exists on the other foot.

**Definition**: [[RTL-SDR]] dongles and most practical receivers sample real signals (real voltage samples). When you record or process these real samples, the [[Fourier transform]] automatically produces this symmetric spectrum. The "negative frequency" half contains no additional information—it's redundant. You're paying bandwidth to receive information twice.

**Practical implication**: A real [[ADC]] (analog-to-digital converter) sampling at 2 MHz actually only gives you 1 MHz of unique bandwidth, because the other MHz is a mirror image. This is why [[software defined radio]] practitioners often use [[complex sampling]] (I/Q demodulation) instead—it lets you capture only the positive frequency half and avoid wasting resources on redundant data.

---

### Complex Signals vs. Real Signals
**Analogy**: A real signal is like a shadow on a wall (one number at each moment). A complex signal is like a full 3D object that casts that shadow—it has more information hidden in its structure.

**Definition**: A [[complex signal]] consists of I (in-phase) and Q (quadrature) components at every sample. Unlike real signals, complex signals do *not* have spectral symmetry—they can have genuine asymmetric content at negative frequencies. This is why [[I/Q demodulation]] is so powerful in SDR: it converts the redundant real signal into a more efficient complex signal representation.

| Property | Real Signal | Complex Signal |
|---|---|---|
| Samples | Single real number per time step | Pair (I, Q) per time step |
| Bandwidth (sampling rate 2 MHz) | 1 MHz unique | 2 MHz unique |
| Spectral symmetry | Yes (required) | No (can be asymmetric) |
| Negative frequencies | Mathematical artifact only | Can represent real information |

---

## Hands-On Application

### With RTL-SDR and GNU Radio

When you open [[GNU Radio]] and connect an [[RTL-SDR]] dongle, you're receiving a [[real signal]]. The software displays the [[power spectral density]] centered at your tuned frequency (e.g., 100 MHz). 

What you're actually seeing: Only the positive frequency half of the full spectrum. The other half (the negative frequencies relative to your center frequency) exists mathematically but is hidden from view because it contains no new information.

**Practical workflow:**
1. Tune to 100 MHz with your [[RTL-SDR]]
2. View the spectrum in [[GNU Radio Companion]] or [[GQRX]]
3. You see a signal at, say, 100.5 MHz
4. Behind the scenes, your receiver also captured the mirror image at 99.5 MHz (100 MHz - 0.5 MHz offset)
5. The receiver's [[FFT]] (fast Fourier transform) computed both positive and negative frequencies, then discarded the redundant negative side

### With Complex Sampling (I/Q)

If you enable [[I/Q output]] in your SDR software, you're now working with [[complex samples]]:
- The RTL-SDR's internal [[mixer]] downconverts the signal to [[baseband]]
- The [[ADC]] captures both I and Q channels
- You receive a complex signal where "negative frequencies" can now represent real asymmetric information around your tuned frequency

---

## Lab Exercise

**What you need**: 
- [[RTL-SDR]] dongle
- [[GNU Radio Companion]]
- [[GQRX]] (optional, for quick visualization)

**Goal**: 
Observe [[spectral symmetry]] in a real received signal and understand why negative frequencies are just a mathematical reflection of positive ones.

**Steps**:

1. **Capture a narrowband real signal**
   - Open GQRX and tune to a local FM radio station (e.g., 104.5 MHz)
   - Record 5 seconds of audio-rate samples as a real signal (.wav file)
   - What you observe: A single peak at the station frequency

2. **Compute the full spectrum (positive and negative frequencies)**
   - In GNU Radio, load the .wav file with a [[File Source]] block
   - Connect to an [[FFT]] block (with size 4096)
   - Connect the FFT output to a [[QT GUI Sink]] with a logarithmic scale
   - Run the flowgraph
   - What you observe: The spectrum is *symmetric*. The peak at +104.5 MHz (relative to center) has an equal mirror image at -104.5 MHz

3. **Verify it's just a mirror**
   - Zoom to see both sides clearly
   - Measure the peak power on the positive frequency side
   - Measure the peak power on the negative frequency side
   - They match—because one is just the mathematical reflection of the other
   - What it demonstrates: Negative frequencies are not "real" in the physical sense; they're a consequence of representing a real sinusoid as a sum of complex exponentials

4. **Optional: Compare with complex signal**
   - Modify your flowgraph to use an [[IQ File Source]] (complex baseband)
   - Now the spectrum is *asymmetric* around zero
   - The negative frequency side might look completely different from the positive side
   - What it demonstrates: Complex signals can have genuine non-redundant information at negative frequencies, which is why [[I/Q sampling]] is more efficient than real sampling

---

## Related Topics
- [[Real vs. Complex Signals]]
- [[I/Q Demodulation]]
- [[Spectral Symmetry]]
- [[Fourier Transform]]
- [[Hermitian Symmetry]]
- [[Baseband Processing]]
- [[RTL-SDR]]
- [[GNU Radio]]
- [[Software Defined Radio]]
- [[Nyquist Theorem]]
- [[Complex Exponentials]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GNU Radio]]*