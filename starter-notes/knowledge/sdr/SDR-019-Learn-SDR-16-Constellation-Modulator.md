---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 019
source: rewritten
---

# Learn SDR: 16 Constellation Modulator
**Moving from simulation to real over-the-air transmission using 16-QAM modulation with practical SDR hardware.**

---

## Overview

In this session, we transition from theoretical signal processing in simulation to actually broadcasting modulated signals into the RF spectrum using a [[Pluto SDR]] transmitter while receiving on an [[RTL-SDR]] dongle. The 16 Constellation Modulator is a critical [[GNU Radio]] block that takes raw bit streams, maps them to 16-point [[QAM]] symbols, applies pulse shaping via [[filtering]], and upsamples the signal for transmission—essentially turning digital data into radio waves you can capture and measure in real hardware.

---

## Key Concepts

### Samples Per Symbol (SPS)
**Analogy**: Think of a film director shooting multiple camera angles of the same moment—more frames per second capture finer detail. Samples per symbol work the same way: more digital samples per data symbol let you capture sharper transitions and apply smoother filtering.

**Definition**: The ratio of [[sampling rate]] to [[symbol rate]]. If your sampling rate is 1 MHz and symbol rate is 62.5 kHz, you have 16 samples per symbol.

**Why it matters**: Higher SPS (commonly powers of two: 2, 4, 8, 16, 32) gives better [[pulse shaping]] quality and easier [[interpolation]], though it costs more CPU and bandwidth.

| SPS Value | Use Case | Trade-off |
|-----------|----------|-----------|
| 2–4 | Bandwidth-constrained systems | Coarse filtering |
| 8–16 | Lab/educational demos | Good detail, manageable CPU |
| 32–64 | High-quality applications | Heavy computation |

---

### Bit Packing
**Analogy**: Instead of shipping one Lego brick per box, you pack eight bricks into one box to be more efficient. Bit packing groups individual bits into bytes so downstream blocks can process data in standard 8-bit chunks.

**Definition**: Converting individual bit streams (0, 1, 0, 1, ...) into packed byte values (0–255) so that [[constellation mapper|constellation mapping blocks]] can directly index into a 16-QAM lookup table.

**Process**:
```
Input bits:   0 1 1 0 1 0 1 1 → Byte value: 0xB6 (182 decimal)
              └─────────────┘
              8 bits packed
```

[[GNU Radio]] provides the `Pack K Bits` block to automate this conversion.

---

### 16-QAM Constellation Mapper
**Analogy**: Imagine a game board with 16 labeled squares arranged in a 4×4 grid. Each pair of two-bit numbers (00, 01, 10, 11) combined gives you 4 values; two pairs create 16 unique positions on the board. The mapper looks at each 4-bit chunk of your byte and places it at its designated grid position.

**Definition**: A lookup table that converts each 4-bit input symbol (values 0–15) into a complex [[IQ]] point in the [[QAM]] plane. In 16-QAM, the 16 points are typically arranged in a square grid on the complex plane:

$$
\text{Symbol } k \rightarrow I_k + jQ_k
$$

where $(I_k, Q_k)$ represent the in-phase and quadrature components of the transmitted signal.

**Typical 16-QAM constellation**:
```
Quadrature (Q)
      │
   3  │  □   □   □   □
   1  │  □   □   □   □
  -1  │  □   □   □   □
  -3  │  □   □   □   □
      └────────────────── In-Phase (I)
     -3 -1  1  3
```

---

### Root Raised Cosine (RRC) Pulse Shaping
**Analogy**: Raw digital pulses are like sudden on/off light switches—sharp and jarring. RRC filtering is like a dimmer switch that smoothly ramps light up and down, reducing sudden edges. This gentleness keeps the signal from splashing energy into adjacent frequency bands.

**Definition**: A [[filter]] applied before transmission that shapes each symbol pulse to minimize [[intersymbol interference]] (ISI) and spectral leakage. The root-raised-cosine response has a smooth, tapered tail:

$$
h(t) = \frac{\sin(\pi t / T_s (1 - \beta)) + 4\beta(t / T_s)\cos(\pi t / T_s(1 + \beta))}{\pi t / T_s(1 - 4\beta^2 t^2 / T_s^2)}
$$

where $\beta$ is the **rolloff factor** (typically 0.35) and $T_s$ is the symbol period.

**Why it matters**: Keeps your transmitted signal within its allocated bandwidth and allows adjacent channels to coexist without interference.

---

### Center Frequency & ISM Band
**Analogy**: Like choosing which radio station to tune to—915 MHz is a shared "unlicensed" frequency band (in North America) where many devices broadcast without needing FCC approval, as long as they follow power and bandwidth rules.

**Definition**: The [[RF]] frequency at which your modulated signal is centered. The [[ISM band]] (Industrial, Scientific, Medical) at 915 MHz is license-free in the US and commonly used for hobby/lab SDR work.

**Best practice**: If multiple people are transmitting in the same lab, coordinate to use slightly different frequencies (e.g., 912 MHz, 918 MHz) to avoid collisions.

---

## Hands-On Application

### Setup
1. **Transmitter**: [[Pluto SDR]] running the constellation modulation flowgraph
2. **Receiver**: [[RTL-SDR]] dongle tuned to the same center frequency
3. **Software**: [[GNU Radio]] Companion with the flowgraph loaded
4. **Frequency**: 915 MHz (or adjust based on local lab coordination)

### Workflow
1. **Generate random bytes** using the Random Source block → configure for values 0–255
2. **Pack bits** if needed (some constellation mappers accept bit streams directly)
3. **16-QAM Constellation Modulator** block:
   - Input: packed bytes (0–255)
   - Output: complex-valued [[IQ]] samples at baseband
   - Parameter: 16 symbols in standard square grid
4. **Apply RRC filter** to interpolate from symbol rate to sample rate (SPS × symbol rate)
5. **Multiply by complex exponential** to upconvert to center frequency
6. **Transmit via Pluto** using UHD Sink block
7. **Receive on RTL-SDR** using UHD Source or gr-osmosdr
8. **Demodulate** using the inverse blocks (RRC matched filter, symbol synchronizer, QAM slicer)
9. **Visualize** using Constellation Sink and Frequency Sink

### Observable Behavior
- **Frequency domain**: 16-QAM signal occupies ~1 MHz bandwidth (with 1 MHz sample rate, 62.5 kHz symbol rate)
- **Constellation diagram**: 16 tight clusters of IQ points (noiseless in simulation; noisy in real RF)
- **Time domain**: Smooth, shaped pulses instead of hard edges

---

## Lab Exercise

**What you need**:
- [[Pluto SDR]] or compatible transmitter ([[HackRF One]], [[USRP]])
- [[RTL-SDR]] dongle or second [[Pluto SDR]] for reception
- [[GNU Radio]] 3.8 or later
- Antenna or short loopback cable
- Safe RF environment (low power, shielded if possible)

**Goal**: Transmit a 16-QAM signal from the Pluto and capture its [[constellation diagram]] on the RTL-SDR receiver, observing 16 distinct symbol points in the IQ plane.

**Steps**:

1. **Create transmitter flowgraph**:
   - Random Source (0–255, 1000 samples/sec)
   - 16-QAM Constellation Modulator (input: byte stream)
   - Multiply by tuning frequency complex exponential (915 MHz)
   - Scale amplitude to safe TX level (~0.3 V peak)
   - UHD Sink (Pluto SDR, sample rate 1 MHz)
   
2. **Create receiver flowgraph**:
   - UHD Source (RTL-SDR, 915 MHz, 1 MHz sample rate)
   - Multiply by conjugate of tuning frequency (downconvert)
   - RRC matched filter (SPS=16, same RRC taps as TX)
   - Constellation Sink (refresh every 1024 symbols)
   
3. **Run both flowgraphs**:
   - Start receiver first, then transmitter
   - Observe constellation diagram on receiver
   - Should see 16 distinct clusters of points (ideal case) or a noisy cloud around 16 grid positions (real RF)
   
4. **Vary parameters and observe**:
   - Increase TX power slightly → more concentrated constellation
   - Introduce frequency offset → rotating spiral pattern
   - Deactivate matched filter → dispersed, blurry symbol cloud
   - Change RRC rolloff factor (0.25 vs. 0.5) → observe sidelobe suppression

**What it demonstrates**: 
- The complete chain from bits → symbols → shaping → RF transmission
- How modulation patterns appear in the time/frequency domain
- The critical role of matched filtering in reception
- Real-world degradation (noise, frequency error) vs. simulation

---

## Related Topics
- [[QAM Modulation]]
- [[Pulse Shaping Filter]]
- [[Symbol Synchronization]]
- [[Constellation Diagram]]
- [[Root Raised Cosine Filter]]
- [[Pluto SDR]]
- [[RTL-SDR]]
- [[GNU Radio]]
- [[UHD (USRP Hardware Driver)]]
- [[ISM Band]]
- [[Intersymbol Interference]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Modulation]] | [[Transmitter Design]]*