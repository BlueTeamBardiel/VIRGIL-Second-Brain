---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 009
source: rewritten
---

# Learn SDR 07： Frequency Spectra and the Fast Fourier Transform (FFT)
**Understanding how to break down radio signals into their frequency building blocks using mathematical decomposition.**

---

## Overview
Every radio signal you receive is actually a mixture of many different frequencies happening simultaneously. The [[Frequency Spectrum]] is the tool that lets you separate out "how much" of your signal exists at each frequency. This is absolutely essential in [[Software Defined Radio]] because you need to see what's actually on the airwaves before you can decode it, filter it, or amplify it.

---

## Key Concepts

### Frequency Spectrum
**Analogy**: Imagine a smoothie. You have a blend of strawberries, bananas, and yogurt all mixed together. A frequency spectrum is like a machine that separates that smoothie back into its individual ingredients, telling you "this much strawberry, that much banana." A radio signal is the smoothie; the spectrum is the ingredient list.

**Definition**: The [[Frequency Spectrum]] is a representation showing the amplitude (strength) of a signal at each individual frequency. It transforms your [[Time Domain]] view of a signal into a [[Frequency Domain]] view.

When you sample a radio signal digitally, you capture samples over time. The spectrum analyzer asks: "How much pure cosine wave at frequency 1 exists in my signal? How much at frequency 2? Frequency 3?" and so on.

---

### The Fourier Transform
**Analogy**: Think of a musical chord. When you hear a piano play C-E-G together, your ear naturally hears it as a single sound, but you *can* mentally separate out "that's a C note, that's an E, that's a G." The [[Fourier Transform]] is the mathematical equivalent of that ear—it breaks the chord into individual note frequencies.

**Definition**: The [[Fourier Transform]] is a mathematical operation that converts a signal from the [[Time Domain]] (what you measure over time) into the [[Frequency Domain]] (how much energy exists at each frequency). 

For a discrete, finite-length signal sampled N times, this becomes the [[Discrete Fourier Transform]] (DFT):

$$X[k] = \sum_{n=0}^{N-1} x[n] \cdot e^{-j2\pi kn/N}$$

Where:
- **x[n]** = your input samples
- **X[k]** = the strength (amplitude) at frequency bin k
- **k** = the frequency bin number (0 to N-1)
- **e^{-j2π...}** = a rotating complex exponential (the basis function)

Each frequency bin k is asking: "How much does a cosine + sine pair at this frequency match my signal?"

| Bin (k) | What It Represents | Visual Pattern |
|---------|-------------------|---|
| 0 | DC component (constant offset) | ━━━━━━━ (flat line) |
| 1 | Lowest non-zero frequency | ∿∿∿∿∿∿∿∿ (one full cycle) |
| 2 | Double the frequency | ∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿∿ (two cycles) |
| N/2 | Nyquist frequency (maximum) | ↑↓↑↓↑↓↑↓ (alternating samples) |

---

### The Fast Fourier Transform (FFT)
**Analogy**: Computing a DFT by brute force is like counting every grain of sand on a beach one by one. The [[Fast Fourier Transform]] (FFT) is like weighing all the sand at once—it uses clever mathematical shortcuts to get the same answer thousands of times faster.

**Definition**: The [[Fast Fourier Transform]] is an optimized algorithm that computes the [[Discrete Fourier Transform]] in O(N log N) time instead of O(N²). The most common variant is the [[Cooley-Tukey FFT]], which works by recursively breaking the transform into smaller pieces.

**Why this matters for SDR**: 
- A real-time [[RTL-SDR]] might stream 2.4 million samples per second
- Without the FFT, calculating the spectrum would be impossibly slow
- The FFT makes real-time waterfall displays and spectrum analyzers actually possible

**Common FFT sizes**: 256, 512, 1024, 2048, 4096, 8192, 16384 (always powers of 2 for maximum efficiency)

**Trade-off**: Larger FFT = better frequency resolution (you can see closer frequencies separately) but slower update rate. Smaller FFT = fast updates but fuzzy frequency resolution.

---

### Frequency Bins and Resolution
**Analogy**: Imagine shelves in a library. If your shelf is 10 cm wide, you can fit one book. If it's 100 cm wide, you can fit 10 books. [[Frequency Bins]] are like shelves—wider bins hold a broader range of frequencies together.

**Definition**: Each output of the FFT corresponds to one [[Frequency Bin]]. The width of each bin (called [[Frequency Resolution]]) depends on your [[Sample Rate]] and FFT size:

$$\Delta f = \frac{f_s}{N}$$

Where:
- **Δf** = frequency resolution (width of each bin)
- **fs** = sample rate
- **N** = FFT size

**Example**: If you sample at 2.4 MHz and use a 1024-point FFT:
- Each bin is 2,400,000 / 1024 ≈ 2.34 kHz wide
- You can see frequencies from 0 to 1.2 MHz (half the sample rate, due to [[Nyquist Theorem]])
- You get 512 usable frequency bins

---

### Nyquist Frequency and Aliasing
**Analogy**: If you photograph a spinning wheel by taking pictures only twice per rotation, the wheel might appear to be rotating backwards. [[Aliasing]] is when you sample too slowly and frequencies "fold back" into the wrong region.

**Definition**: The [[Nyquist Frequency]] is the maximum frequency you can accurately represent when sampling at rate fs. It equals fs/2. Any frequency content above Nyquist gets "folded back" and appears as a false signal ([[Aliasing]]).

This is why [[Anti-Aliasing Filters]] matter—they remove everything above Nyquist *before* sampling, preventing garbage data.

| Sample Rate | Nyquist Frequency | Usable Spectrum |
|---|---|---|
| 2.4 MHz | 1.2 MHz | 0 to 1.2 MHz |
| 8 MHz | 4 MHz | 0 to 4 MHz |
| 28.8 MHz | 14.4 MHz | 0 to 14.4 MHz |

---

## Hands-On Application

### Using FFT in GNU Radio
In [[GNU Radio]], the FFT block appears everywhere:

1. **FFT sink** = the waterfall display you see. It continuously computes FFTs of incoming samples and stacks them vertically over time.
2. **FFT size parameter** = controls resolution vs. update speed tradeoff
3. **Window function** = [[Hamming]], [[Hann]], or [[Blackman]] windows reduce spectral leakage (artifacts from finite-length signals)

### With an RTL-SDR and GQRX
- **GQRX** uses FFT internally to generate the spectrum display
- Larger FFT size = sharper peaks in the waterfall (better for weak signals)
- Smaller FFT size = faster waterfall refresh (better for dynamic signals)

### Command-Line with Python + NumPy
```python
import numpy as np

# Assume you have samples in array 'signal'
# Compute 1024-point FFT
fft_output = np.fft.fft(signal, n=1024)

# Get magnitude spectrum (throw away phase info)
magnitude = np.abs(fft_output)

# Get power spectrum (magnitude squared)
power = magnitude ** 2

# Get frequency axis
freq_bins = np.fft.fftfreq(1024, d=1/sample_rate)
```

---

## Lab Exercise

**What you need**: 
- [[RTL-SDR]] dongle (or [[HackRF]] for transmit capability)
- [[GNU Radio]] with flowgraph editor
- GQRX spectrum analyzer (optional alternative)

**Goal**: 
Observe a real radio signal's frequency spectrum in real-time and understand how FFT size affects what you see.

**Steps**:

1. **Tune to a known broadcast station** (FM radio at 88–108 MHz, or a local transmitter you know)
   - Open GQRX or build a GNU Radio flowgraph with RTLSDr source → FFT sink
   - Note the carrier frequency and any sidebands

2. **Change the FFT size** (try 256, 1024, 8192)
   - Observe that larger FFT = narrower, sharper peaks
   - Observe that larger FFT = slower waterfall updates
   - **Why?** Larger FFT gives better frequency resolution (narrower bins), but takes longer to compute

3. **Measure bandwidth**
   - In GQRX, identify the -3dB points (where signal power drops to half)
   - This is the [[Occupied Bandwidth]] of the station
   - An FM station should be ~200 kHz wide; a narrow digital signal might be <1 kHz

4. **Apply a window function** (if available)
   - Switch from rectangular to Hamming window
   - Observe that spectral leakage artifacts vanish but peaks get slightly wider
   - **Lesson**: Real-world FFT involves tradeoffs

---

## Related Topics
- [[Discrete Fourier Transform (DFT)]]
- [[Cooley-Tukey FFT Algorithm]]
- [[Time Domain vs Frequency Domain]]
- [[Windowing Functions]] (Hamming, Hann, Blackman)
- [[Spectral Leakage]] and [[Spectral Resolution]]
- [[Nyquist–Shannon Sampling Theorem]]
- [[Anti-Aliasing Filters]]
- [[GNU Radio]]
- [[RTL-SDR]]
- [[GQRX]]
- [[Software Defined Radio]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[FFT]] | [[GNU Radio]]*