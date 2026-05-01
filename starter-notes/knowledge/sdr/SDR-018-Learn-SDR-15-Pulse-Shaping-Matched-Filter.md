---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 018
source: rewritten
---

# Learn SDR 15: Pulse Shaping Matched Filter
**Designing receivers that recognize your transmitted signal while rejecting noise through intelligent filtering.**

---

## Overview

The matched filter is one of the most powerful concepts in signal reception and radar systems. It answers a fundamental question: given that you've transmitted a known signal and it comes back corrupted by noise, how do you design a receiver filter that maximizes your ability to detect that signal? This becomes critical in SDR work because it bridges the gap between what we transmit (pulse-shaped waveforms) and how we actually receive and process those signals back.

---

## Key Concepts

### Matched Filter
**Analogy**: Imagine you're trying to find your friend in a crowded, noisy concert hall. The best way is to listen for their distinctive laugh pattern—if you mentally "match" incoming sounds against your memory of their laugh, you'll spot them even in the chaos. A matched filter does exactly this: it listens for a specific signal pattern you expect.

**Definition**: A [[Matched Filter]] is a receiver filter whose [[Impulse Response]] is the time-reversed, complex-conjugate replica of the expected transmitted signal. It maximizes the [[Signal-to-Noise Ratio (SNR)]] for detecting a known signal embedded in [[Additive White Gaussian Noise (AWGN)]].

**Mathematical Foundation**:
```
h[n] = s*[N - n]
(matched filter = time-reversed conjugate of transmitted signal s[n])

Output: y[n] = ∑ x[k]·h[n-k]  (correlation operation)
```

Where:
- `h[n]` = matched filter coefficients
- `s[n]` = transmitted signal
- `x[n]` = received noisy signal
- The output peaks when incoming signal aligns with filter

### Correlation vs. Convolution
**Analogy**: Convolution is like dragging a stencil across a surface—the stencil shape stays consistent. Correlation is like comparing two photographs by overlaying them and seeing how well they match at each position.

**Definition**: [[Correlation]] measures similarity between two signals as one slides past the other. In matched filtering, we correlate the received signal against a clean reference copy. [[Convolution]] (used in filters) involves time-reversal; correlation does not.

| Operation | Purpose | Time-Reversal? | SDR Application |
|-----------|---------|---|---|
| [[Convolution]] | General filtering | Yes | System impulse response |
| [[Correlation]] | Signal detection | No | Matched filter reception |

**Formula**:
```
Correlation: r[n] = ∑ x[k]·s*[n+k]
Convolution: y[n] = ∑ x[k]·h[n-k]
```

### Raised Cosine Pulse Shaping
**Analogy**: Imagine you're switching a light on and off—abrupt flips create electrical noise and interference. A raised cosine dimmer gradually transitions, creating smooth, predictable behavior that doesn't disturb neighboring circuits.

**Definition**: [[Raised Cosine]] filtering is a pulse shape in both transmit and receive that minimizes [[Intersymbol Interference (ISI)]]. The frequency response has a characteristic rolloff with zero crossings positioned so adjacent pulses don't interfere.

**Why it matters for matched filters**: 
- Transmitted pulse is **root-raised-cosine** (RRC)
- Receiver matched filter is **also RRC**
- Cascade creates the full raised-cosine response
- Zero-crossing property eliminates ISI

**Key Property—Zero Intersymbol Interference**:
```
Nyquist Criterion: At sampling times, only the current symbol peak is non-zero
h[nT] = {1 at n=0, 0 at n≠0}
```

### Why We Don't Transmit Full Raised Cosine
**Analogy**: If you wanted the loudest possible guitar sound at one concert venue, you wouldn't shape the sound for that specific room on stage—you'd shape it generically so any receiver can hear you clearly wherever they are.

**Definition**: We split the raised-cosine characteristic between transmitter and receiver using [[Root-Raised-Cosine (RRC)]] filters. Each is a √(raised-cosine) in frequency domain.

**Why this design**:
- Transmitter uses RRC → transmits efficient, bandwidth-limited pulse
- Channel adds noise and distortion
- Receiver uses RRC → matched filter for detection
- Together: RRC × RRC = full raised-cosine response
- Benefit: Optimal noise performance AND ISI elimination

---

## Hands-On Application

### GNU Radio Workflow
In [[GNU Radio]], implement matched filtering for QAM/PSK reception:

1. **Create Reference Signal Block**
   - Use RRC filter taps (pulse shaping filter)
   - Root-raised-cosine with roll-off factor α ≈ 0.35
   - Store as float32 array of 100+ samples

2. **Add Correlator Block**
   - Input: received baseband signal
   - Reference: clean RRC pulse replica
   - Output: correlation peaks at signal arrival times

3. **Add Threshold Detector**
   - Monitor correlator magnitude output
   - Trigger on peaks exceeding noise floor
   - Timestamp detections for decoding

### RTL-SDR + HackRF Practical Setup
```
Receiver Flow:
Antenna → [RTL-SDR/HackRF] → Frequency shift to baseband 
→ RRC Matched Filter → Correlator → Symbol Timing Recovery 
→ Constellation Decoder
```

**Key GNU Radio Blocks**:
- `RRC Filter Taps` generator: defines pulse shaping
- `FIR Filter`: implements matched filter convolution
- `Correlate Access Code`: built-in matched filter for preamble detection
- `Polyphase Clock Sync`: uses matched filtering for timing

---

## Lab Exercise

**What you need**: 
- GNU Radio (3.8+)
- [[RTL-SDR]] dongle OR HackRF One
- GQRX or GNU Radio (for signal capture)
- Python 3.8+

**Goal**: Demonstrate that a matched filter receiver detects a known pulse buried in noise and measure SNR improvement.

**Steps**:

1. **Build Transmitter (Simulation)**
   - Generate QPSK symbols: [1, -1, 1j, -1j]
   - Apply RRC pulse shaping with 8 samples/symbol, α=0.35
   - Add AWGN at -5 dB SNR
   - Save to file: `tx_signal.bin`
   - *Observe*: Waveform looks like noise; no visible symbols

2. **Implement Matched Filter Receiver**
   - Load transmitted RRC taps (time-reversed)
   - Create FIR filter block configured as matched filter
   - Pass noisy signal through filter
   - *Observe*: Four clean pulses appear at symbol times despite input noise
   - *Measures*: Peak correlation amplitude ≈ 40× larger than input SNR

3. **Compare Unfiltered vs. Filtered**
   - Plot received signal constellation before filtering: scattered cloud
   - Plot after matched filter: tight clusters at QPSK points
   - *Demonstrates*: Matched filter coherently combines signal energy, suppresses noise
   - *Result*: SNR improves by ~10 dB for this configuration

4. **Vary Roll-off Factor**
   - Repeat with α = 0.1 (sharp), 0.5 (gradual), 1.0 (maximum roll-off)
   - *Observe*: How spectral efficiency and pulse overlap trade off
   - Record symbol error rates for each

---

## Related Topics
- [[Pulse Shaping]]
- [[Root-Raised-Cosine Filter]]
- [[Intersymbol Interference (ISI)]]
- [[Signal Detection]]
- [[Correlation and Convolution]]
- [[Baseband Processing]]
- [[Symbol Timing Recovery]]
- [[QPSK Modulation]]
- [[GNU Radio]]
- [[RTL-SDR]]
- [[HackRF]]
- [[Receiver Design]]
- [[Optimal Filtering]]
- [[Nyquist Criterion]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Signal Processing]] | [[Receiver Design]]*