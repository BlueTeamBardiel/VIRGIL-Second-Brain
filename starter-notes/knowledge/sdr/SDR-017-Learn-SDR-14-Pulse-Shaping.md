---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 017
source: rewritten
---

# Learn SDR 14: Pulse Shaping
**Smooth your signal's edges to reclaim wasted spectrum and reduce interference.**

---

## Overview

When you transmit data using abrupt on-off pulses, your signal bleeds energy across a wide swath of frequencies—wasting precious spectrum and interfering with neighbors. [[Pulse shaping]] applies mathematical smoothing to the edges of your data symbols, concentrating power in your assigned band while dramatically reducing out-of-band emissions. This is essential for any real-world [[digital communication]] system.

---

## Key Concepts

### Rectangular Pulse Problems
**Analogy**: Imagine slamming a door shut (rectangular pulse) versus slowly closing it (shaped pulse). The hard slam creates shock waves that propagate everywhere; the slow close contains energy locally.

**Definition**: [[Rectangular pulses]] are abrupt digital symbols with hard boundaries—they switch from zero to full amplitude instantly. In the [[frequency domain]], this creates a [[sinc function]] response with significant [[spectral sidelobes]].

**Spectral Cost**:
- Main lobe bandwidth: $\frac{2}{T_s}$ (where $T_s$ is symbol time)
- Sidelobes extend infinitely, falling slowly (~1/f)
- High out-of-band energy violates [[regulatory masks]]

| Property | Rectangular | Shaped |
|----------|-------------|--------|
| Time-domain sharpness | Very sharp | Gradual edges |
| Main lobe width | 2/Ts | ~1/Ts |
| Sidelobe level | -13 dB | -40 dB or better |
| Spectrum efficiency | Poor | Excellent |

---

### Root Raised Cosine (RRC) Filter
**Analogy**: Think of RRC as a gentle cosine hill that ramps your signal up and down smoothly, preventing the harsh cliff edges that spray energy everywhere.

**Definition**: The [[Root Raised Cosine]] filter is the most common [[pulse shaping filter]] in modern communications. It transitions symbol edges using a cosine taper over a rolloff region.

**Key Parameter — Rolloff Factor (α)**:
- α = 0: Narrowest bandwidth (Nyquist filter) but slow time decay
- α = 1: Widest bandwidth (easier to implement) but best spectral control
- α = 0.35: Common middle ground (4G/5G standard)

**Impulse Response** (simplified):
$$h(t) = \frac{\sin(\pi t/T_s)}{\pi t/T_s} \cdot \frac{\cos(\pi \alpha t/T_s)}{1 - 4\alpha^2 t^2/T_s^2}$$

**Why "Root"?** The RRC filter is actually $\sqrt{H(f)}$—the transmitter uses RRC, the receiver uses RRC, and together they perfectly reconstruct the signal while maintaining [[Nyquist criterion]] at symbol boundaries.

---

### Raised Cosine (RC) Filter
**Analogy**: If RRC is half a recipe, RC is the full recipe—you apply RRC at transmit *and* receive, and together they create a perfect pulse reconstruction.

**Definition**: The [[Raised Cosine]] filter is the cascade of RRC at transmitter and receiver. It's not typically applied directly; instead, both RRC filters combine to shape pulses.

---

### Why Pulse Shaping Matters
**Spectral Efficiency Gain**:
- Rectangular: 2/Ts main lobe → 99% power outside main lobe
- RRC (α=0.35): ~1.35/Ts main lobe → <1% power in sidelobes
- **Result**: 3× bandwidth reduction, compliant with [[FCC Part 15]], [[ETSI]], etc.

**ISI Prevention**: By respecting the [[Nyquist criterion]], shaped pulses guarantee zero [[intersymbol interference]] at sampling times, even with [[multipath]].

---

## Hands-On Application

### In GNU Radio
1. **Add RRC Filter Block**: `Filters → FIR Filter (Decimating)` or use `Root Raised Cosine Filter` block
2. **Set Parameters**:
   - Gain: 1.0
   - Sample rate: 32000 Hz (or your [[sample rate]])
   - Symbol rate: 4000 Hz (8× oversampling typical)
   - Rolloff: 0.35 (standard)
   - Number of taps: 21–51 (longer = steeper rolloff)
3. **Connect**: Data source → RRC → [[USRP]]/[[HackRF]]/file sink
4. **Observe**: Spectrum before/after shaping using [[FFT Sink]]

### In Python + NumPy
```python
import numpy as np
from scipy import signal

# Design RRC filter
symbol_rate = 4000
sample_rate = 32000
span = 10  # symbols to span
rolloff = 0.35

# Generate RRC coefficients
taps = signal.firwin(span * sample_rate // symbol_rate, 
                      1.0, window=('kaiser', 5.5))
# Apply normalized raised cosine
rrc = apply_rrc_window(taps, rolloff, sample_rate, symbol_rate)

# Convolve with symbols
symbols = np.random.choice([1, -1], 1000)
upsampled = np.repeat(symbols, sample_rate // symbol_rate)
shaped = np.convolve(upsampled, rrc, mode='same')
```

---

## Lab Exercise

**What you need**:
- [[GNU Radio]] (with RRC filter block)
- [[RTL-SDR]] dongle (optional—can use file sink)
- Spectrum analyzer or [[GQRX]] receiver

**Goal**: 
Transmit a [[BPSK]] signal with and without pulse shaping. Measure the spectral sidelobe power reduction and confirm compliance with spectral masks.

**Steps**:

1. **Build baseline (no shaping)**:
   - Create random ±1 symbols (1000 symbols)
   - Upsample 8× (32 ksps)
   - Connect to [[USRP]] Sink or FFT Sink
   - **Observe**: Main lobe ~8 kHz wide, sidelobes at -13 dB

2. **Add RRC shaping**:
   - Insert RRC Filter block (α = 0.35, 51 taps)
   - Between upsampler and [[USRP]]
   - Re-run flowgraph
   - **Observe**: Main lobe ~5.5 kHz, sidelobes at -40+ dB

3. **Measure spectral containment**:
   - Export both signals to files
   - Plot spectrum with `matplotlib` or `GQRX`
   - Calculate power in ±6 kHz band vs. outside
   - **Expected result**: 95%+ power in 6 kHz band with RRC

4. **What it demonstrates**:
   - [[Frequency domain]] filtering doesn't exist—only [[time domain]] pulse shaping works
   - [[Matched filtering]] principle: receiver's RRC recovers symbols optimally
   - Real-world regulations require shaped pulses ([[FCC]], [[CE mark]])

---

## Related Topics
- [[Root Raised Cosine Filter]]
- [[Digital Modulation]]
- [[BPSK (Binary Phase Shift Keying)]]
- [[Spectral Efficiency]]
- [[Nyquist Criterion]]
- [[Matched Filter]]
- [[Symbol Timing Recovery]]
- [[GNU Radio]]
- [[RTL-SDR]]
- [[USRP]]
- [[Raised Cosine Filter]]
- [[FIR Filter]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Communication]] Fundamentals*