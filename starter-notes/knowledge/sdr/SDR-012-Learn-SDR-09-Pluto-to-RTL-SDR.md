---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 012
source: rewritten
---

# Learn SDR 09： Pluto to RTL SDR
**Understanding cross-device signal transmission when clock rates and frequency ranges don't match perfectly.**

---

## Overview
Moving signals between two different [[Software Defined Radio]] devices introduces real-world constraints absent in loopback scenarios. The [[ADALM Pluto]] and [[RTL-SDR]] operate with different native clock rates, [[sampling rates]], and tuning ranges, requiring careful parameter alignment to achieve reliable inter-device communication. This lesson explores why transmitting between heterogeneous radios demands more planning than talking to yourself.

---

## Key Concepts

### Clock Rate Synchronization
**Analogy**: Imagine two dancers in different rooms trying to stay in sync without hearing the same music—one must adjust their tempo to match the other, or they'll gradually drift out of step.

**Definition**: [[Clock rate|Clock rates]] determine how quickly a radio samples the incoming signal and how it generates transmission waveforms. When two radios have different internal [[oscillator]] frequencies, their interpretations of the same signal will diverge over time.

- [[ADALM Pluto]] default: fixed crystal oscillator
- [[RTL-SDR]] default: typically lower stability
- **Solution**: Pin both devices to shared [[reference clock]] or accept frequency drift

**Impact Formula**:
```
Frequency Error = (Clock_Error / Clock_Nominal) × Center_Frequency
```

### Sampling Rate Compatibility
**Analogy**: Think of sampling rate like the frame rate in a film—24 fps vs 60 fps captures different levels of detail. A mismatch means one device records fast movements as blur while another captures them crisply.

**Definition**: [[Sampling rate]] (measured in samples per second, or [[Sps]]) defines how densely the [[Analog-to-Digital Converter|ADC]] or [[Digital-to-Analog Converter|DAC]] captures or generates signal information.

| Device | Default Samp Rate | Range | Notes |
|--------|-------------------|-------|-------|
| [[ADALM Pluto]] | 2.084 MSps | 0.5–61.44 MSps | Flexible via USB control |
| [[RTL-SDR]] (RTL2832U) | ~2 MSps | ~0.9–3.2 MSps | Limited by chip design |

**Key relationship**:
```
Nyquist_Bandwidth = Sampling_Rate / 2
```

At 2 MSps, both devices can capture signals up to ±1 MHz around their tuned frequency.

### Tuning Range Overlap
**Analogy**: Imagine two radios with different dial ranges—one covers 24–1766 MHz, the other 24–1700 MHz. The safe zone is where both dials overlap.

**Definition**: [[Center frequency]] is where each radio tunes; [[RF bandwidth]] is the span of frequencies it can simultaneously receive. Successful cross-device work requires choosing a center frequency within both devices' native ranges.

| Device | Min Freq | Max Freq | Default Range | Notes |
|--------|----------|----------|----------------|-------|
| [[ADALM Pluto]] | 70 MHz | 6 GHz | Broader native support | Can extend lower with external LO |
| [[RTL-SDR]] | 24 MHz | 1.7 GHz | Narrower upper limit | Better sensitivity in VHF/UHF |

**Safe overlap zone**: **24 MHz – 1.7 GHz**

### Variable Type Casting
**Analogy**: A hardware radio only understands whole-number frequency settings—you can't tune to 100.7643 MHz. Type casting is your translator.

**Definition**: [[GNU Radio]] variable blocks enforce data types (integer, float, complex). When passing parameters to [[ADALM Pluto|Pluto]] TX/RX blocks (which expect integers), you must explicitly cast floating-point user inputs.

```python
# Correct: Cast to integer
center_frequency = int(freq_slider)  # e.g., int(104500000) → 104500000
samp_rate = int(sampling_rate)       # e.g., int(2e6) → 2000000

# Incorrect: Pluto blocks will reject float
center_frequency = freq_slider  # ✗ Type mismatch error
```

---

## Hands-On Application

### Setting Up a Cross-Device Flowgraph

1. **Define global variables** at the top level of your [[GNU Radio]] flowgraph:
   - `center_frequency`: shared tuning point (integer, MHz range)
   - `samp_rate`: shared sampling rate (integer, must satisfy both devices)
   - `gain_tx`: transmit amplification
   - `gain_rx`: receive amplification

2. **Configure [[ADALM Pluto]] transmitter**:
   - Set TX [[center frequency]] to your variable
   - Set TX [[sampling rate]] to your variable
   - Enable TX on appropriate channel (usually 0)

3. **Configure [[RTL-SDR]] receiver**:
   - Tune RX [[center frequency]] to same variable
   - Match [[sampling rate]] to TX setting
   - Verify driver supports your chosen rate (test with `rtl_test`)

4. **Account for frequency offset**:
   - [[RTL-SDR]] may have PPM (parts-per-million) error due to cheap crystal
   - Use [[GNU Radio]] [[Frequency Xlating FIR Filter|frequency correction blocks]] or accept ±50 kHz drift

5. **Monitor and validate**:
   - Use [[GNU Radio]] [[FFT Sink]] on receiver to visualize signal arrival
   - Check for [[aliasing]] (signal appearing at unexpected frequency)
   - Measure actual vs. expected tone position

### Command-Line Quick Check
```bash
# Test RTL-SDR sampling capability
rtl_sdr -f 104500000 -s 2000000 -n 1000000 test.iq
# Confirm no overruns or errors reported

# View Pluto hardware status
iio_info -u ip:192.168.2.1
# Verify TX/RX channels active and clock locked
```

---

## Lab Exercise

**What you need**:
- One [[ADALM Pluto]] (or [[HackRF One]])
- One [[RTL-SDR]] dongle (RTL2832U chip)
- USB hub and cables
- [[GNU Radio]] 3.8+ with `gr-iio` module
- Two antennas or RF loopback cable

**Goal**: 
Transmit a known test signal (pure tone or QPSK) from Pluto at 104.5 MHz and receive it on RTL-SDR at the same frequency, observing signal arrival, frequency stability, and any clock drift.

**Steps**:

1. **Create Pluto TX flowgraph**:
   - Signal Source (sine wave, 100 kHz offset from center)
   - Multiply by complex envelope (or use Tone block)
   - [[ADALM Pluto]] Sink block
   - Connect center_frequency and samp_rate variables as integers
   - Save and test with antenna off (RF shielded environment)

2. **Create RTL-SDR RX flowgraph**:
   - [[RTL-SDR]] Source block (same center_frequency, samp_rate)
   - [[FFT Sink]] or Frequency Sink to display waterfall
   - File Sink to log IQ samples
   - Run and observe spectrum around your target frequency

3. **Observe and measure**:
   - **Frequency accuracy**: Is your 100 kHz offset tone visible exactly ±100 kHz from center?
   - **Time stability**: Does the tone drift over 30 seconds? Indicates clock mismatch.
   - **SNR**: How strong is the signal? Note attenuation (free space vs. cable)
   - **Aliasing**: Do you see mirror images? Indicates sampling rate mismatch.

4. **What it demonstrates**:
   - Real-world frequency synchronization challenges
   - Impact of [[hardware imperfections|hardware tolerance]] (crystal aging, temperature drift)
   - Importance of matching [[data types]] between variables and hardware blocks
   - How to debug [[RF system]] integration problems empirically

---

## Related Topics
- [[ADALM Pluto]]
- [[RTL-SDR]]
- [[GNU Radio]]
- [[Sampling Theory]]
- [[Nyquist Frequency]]
- [[Center Frequency]]
- [[Clock Oscillator]]
- [[Frequency Offset]]
- [[FFT Sink]]
- [[Type Casting in SDR]]
- [[Inter-Device Synchronization]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Cross-Device Communication]] | [[ADALM Pluto]] | [[RTL-SDR]]*