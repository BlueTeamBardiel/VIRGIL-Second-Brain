---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 001
source: rewritten
---

# Learn SDR 01: FM Receiver with RTL SDR
**Your first practical introduction to software-defined radio: turning a $25 USB dongle into a working FM broadcast receiver.**

---

## Overview
Building an FM receiver is the foundational "Hello World" project for anyone entering [[Software Defined Radio]]. It demonstrates how [[Digital Signal Processing]] can replace traditional analog radio circuits, and proves that modern computing power lets us receive, decode, and play audio in real-time from raw RF samples. This project bridges the gap between RF theory and hands-on practice.

---

## Key Concepts

### RTL-SDR Hardware
**Analogy**: Think of it like swapping a fixed, single-purpose FM radio dial for a programmable computer that can listen to *any* frequency in its range — the same chip is now your tuner, your demodulator, and your decoder.

**Definition**: The [[RTL-SDR]] is an inexpensive USB dongle (typically under $30) containing a tuner IC and an ADC that samples RF signals across 24–1700 MHz. It streams raw [[IQ samples]] to your computer, where software performs all signal processing.

**Key specs:**
| Parameter | Value |
|-----------|-------|
| Sample Rate | 0.9–3.2 MHz |
| Frequency Range | 24 MHz – 1.7 GHz |
| Bit Depth | 8-bit (unsigned) |
| USB Interface | USB 2.0 |

---

### FM Demodulation
**Analogy**: Imagine a vinyl record's groove encodes music as physical wiggles. FM radio encodes audio the same way—as frequency shifts around a carrier wave. Demodulation is the needle reading those wiggles back out.

**Definition**: [[Frequency Modulation]] (FM) carries information by varying the instantaneous frequency of a carrier. The [[Demodulator]] recovers the original audio by measuring how much the received frequency deviates from the center [[Carrier Frequency]].

**FM broadcast band**: 88–108 MHz (stereo)

$$f_{\text{instantaneous}} = f_c + \Delta f \cdot m(t)$$

where:
- $f_c$ = carrier frequency (e.g., 101.5 MHz)
- $\Delta f$ = frequency deviation (±75 kHz for FM broadcast)
- $m(t)$ = modulating signal (audio)

---

### IQ Sampling and Complex Baseband
**Analogy**: Recording a conversation in stereo requires two channels (left and right). RF signals need two channels too (In-phase and Quadrature) to capture both amplitude *and* phase information.

**Definition**: [[IQ Sampling]] captures RF signals as complex numbers. Each sample has an **In-phase** (I) component and a **Quadrature** (Q) component, allowing digital recovery of signals centered at any frequency via [[Heterodyning]].

$$s(t) = I(t) + jQ(t)$$

This avoids the undersampling problems of real-valued sampling alone.

---

### GNU Radio Flowgraph
**Analogy**: A flowgraph is like a schematic diagram for software — blocks represent operations (tuning, filtering, demodulating), and connections show data flow, just as wires carry current in electronics.

**Definition**: [[GNU Radio]] is an open-source framework where you build radio applications by connecting signal-processing blocks in a directed graph. Each block performs one function; data flows left to right.

---

## Hands-On Application

### Setting Up Your RTL-SDR

1. **Attach the antenna** — Use the included monopole or purchase a telescoping VHF antenna. Fully extend it and position it vertically, away from your body and metal objects, for best FM reception.

2. **Plug into USB** — Connect the dongle to an available USB 2.0 port. Linux will auto-detect it; Windows/macOS may require drivers (libusb or rtl-sdr package).

3. **Verify detection**:
   ```bash
   rtl_test -t
   ```
   This confirms the device is present and the oscillator is stable.

### Building a Flowgraph in GNU Radio

**Typical FM receiver signal chain:**

```
[RTL-SDR Source] → [Low-Pass Filter] → [FM Demodulator] 
  → [Audio Decimator] → [Audio Sink (Speaker)]
```

**Key blocks:**

| Block | Function |
|-------|----------|
| [[RTL-SDR Source]] | Tunes receiver and streams IQ samples |
| [[Low-Pass Filter]] (FIR or IIR) | Removes out-of-band noise |
| [[Quadrature Demod]] | Converts FM to audio baseband |
| [[Rational Resampler]] | Decimates to audio rate (~48 kHz) |
| [[Audio Sink]] | Plays sound to speakers |

**Critical parameters:**
- **Sample rate**: 2 MHz (good balance of bandwidth and CPU load)
- **Center frequency**: Tune to your local FM station (e.g., 101.5 MHz)
- **RF gain**: 30–40 dB (start lower if you hear noise; increase to recover weaker stations)
- **Audio gain**: 0.1 (prevent clipping; adjust by ear)

---

## Lab Exercise

**What you need**:
- RTL-SDR dongle + antenna
- GNU Radio (v3.10+ recommended)
- Computer with USB 2.0 port
- Speakers or headphones

**Goal**: Receive, demodulate, and play live FM broadcast audio from a local radio station.

**Steps**:

1. **Launch GNU Radio Companion** and create a new flowgraph.
   - Name it `rtl_sdr_fm` (valid Python identifier).
   - Title: "RTL-SDR FM Receiver"

2. **Add an [[RTL-SDR Source]] block**.
   - Set **Sample Rate** to 2e6 (2 MHz).
   - Set **Center Frequency** to your target station (e.g., 101.5e6 for 101.5 MHz).
   - **Gain** slider: start at 30 dB.
   - Connect output to the next block.

3. **Add a [[Low-Pass Filter]]** block (Taps: ~50).
   - Set **Cutoff Frequency** to 100 kHz (well below ±75 kHz FM deviation).
   - Set **Transition Width** to 10 kHz.
   - Connect input from RTL-SDR, output to demodulator.

4. **Add a [[Quadrature Demodulator]]** block.
   - Set **Gain** to 1.0.
   - This converts FM (frequency variations) to audio (amplitude variations).

5. **Add a [[Rational Resampler]]** (or [[Decimating FIR Filter]]).
   - Decimate by a factor of 40 to drop sample rate from 2 MHz → 50 kHz.
   - Then add a second resampler: interpolate to 48 kHz (audio standard).

6. **Add an [[Audio Sink]]** block.
   - Set **Sample Rate** to 48000 Hz.
   - Connect the resampler output to it.

7. **Run the flowgraph** (press ▶ or Ctrl+R).
   - **Observable output**: You should hear FM audio within 1–2 seconds.
   - If silent: check gain, verify the station is strong in your area, or try a different frequency.
   - If noisy: lower the gain or improve antenna placement.

**What it demonstrates**:
- [[Heterodyning]] and frequency translation via the RTL-SDR tuner
- [[IQ sampling]] and baseband signal recovery
- [[FM demodulation]] using a simple frequency-to-amplitude converter
- Real-time [[Decimation]] to reduce computational load
- End-to-end signal flow from RF → audio

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| No sound | Increase RF gain; verify center frequency matches a real station; check antenna placement |
| Loud noise | Reduce RF gain; add a stronger low-pass filter; move away from interference sources |
| Crackling/dropouts | Lower sample rate to 1 MHz; reduce flowgraph complexity; close other CPU-heavy apps |
| Device not detected | Reinstall libusb drivers; try a different USB port; reboot |

---

## Related Topics
- [[RTL-SDR]] — Hardware platform and driver ecosystem
- [[GNU Radio]] — Signal processing framework
- [[Frequency Modulation]] (FM) — Modulation scheme
- [[IQ Sampling]] — Complex baseband representation
- [[Quadrature Demodulation]] — Recovering audio from FM
- [[Low-Pass Filter]] — Removing out-of-band noise
- [[Heterodyning]] — Frequency translation principle
- [[Software Defined Radio]] — Broader discipline

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GNU Radio]]*