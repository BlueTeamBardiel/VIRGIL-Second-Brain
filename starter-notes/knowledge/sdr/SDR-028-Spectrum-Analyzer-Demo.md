---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 028
source: rewritten
---

# Spectrum Analyzer Demo
**Building an automated RF monitoring system that sweeps wide frequency ranges and captures anomalies in real time.**

---

## Overview

A spectrum analyzer in the SDR context is a software tool that continuously scans radio frequencies across a massive range—from DC all the way to 60 GHz—looking for signals that exceed normal background noise levels. This matters because it lets you detect unexpected transmissions, interference, or activity without manually tuning to each frequency. It's the digital equivalent of a security camera for the RF spectrum.

---

## Key Concepts

### Spectrum Sweep
**Analogy**: Imagine walking through a concert hall with your eyes closed, briefly opening them at different spots to see if anything interesting is happening. You don't stare at one location—you sample many places quickly.

**Definition**: [[Spectrum sweep]] is the technique of sequentially tuning a [[Software Defined Radio]] receiver to multiple [[Center Frequency|center frequencies]] in rapid succession, capturing a snapshot of signal power at each frequency band.

Related: [[Tuning]], [[Frequency Hopping]], [[Wideband Reception]]

$$f_1, f_2, f_3, \ldots, f_n \text{ (sequential center frequencies)}$$

---

### Threshold Detection
**Analogy**: Like a burglar alarm that only sounds when noise exceeds a certain decibel level—not at every tiny sound.

**Definition**: [[Threshold detection]] is a signal processing method where incoming [[Power Spectral Density]] measurements are compared against a preset noise floor or alert level. When a signal exceeds this threshold, it triggers recording or logging.

Related: [[Signal-to-Noise Ratio]], [[Detection Theory]], [[Energy Detection]]

$$\text{Trigger} = \begin{cases} \text{Record} & \text{if } P(f) > P_{\text{threshold}} \\ \text{Ignore} & \text{if } P(f) \leq P_{\text{threshold}} \end{cases}$$

---

### Multi-Channel Parallel Processing
**Analogy**: Instead of one person checking four doors one at a time, you have four people checking all doors simultaneously—each monitoring a different band.

**Definition**: [[Multi-channel processing]] uses multiple independent receiver threads or [[RF Frontends]] to capture different frequency ranges in parallel, dramatically reducing the total time to scan a wide spectrum.

Related: [[Channel Bank]], [[USRP]], [[Parallel Computing in SDR]]

| Approach | Frequency Coverage | Time to Complete Scan |
|----------|-------------------|----------------------|
| Single channel | 0–60 GHz | 120+ seconds |
| 4-channel parallel | 0–60 GHz | ~30 seconds |
| N-channel | 0–60 GHz | ~(120/N) seconds |

---

### Recording State Machine
**Analogy**: A DVR that normally just watches the input, but when motion is detected, it starts saving the footage for exactly 2 seconds before returning to standby.

**Definition**: A [[state machine]] in this context is a control flow that alternates between two modes: **monitoring mode** (continuously sweeping and analyzing) and **recording mode** (capturing raw [[I/Q data]] when a threshold event occurs). After a fixed duration, it returns to monitoring.

Related: [[Finite State Machine]], [[Event-Driven Programming]], [[I/Q Data]]

```
┌─────────────┐
│  MONITORING │ ──(threshold exceeded)──> ┌─────────────┐
│   (sweep)   │                           │  RECORDING  │
└─────────────┘ <──(timeout = 2 sec)──── │  (buffering)│
                                          └─────────────┘
```

---

### Noise Floor Filtering
**Analogy**: Turning down background TV noise so you can hear only important conversations.

**Definition**: [[Noise floor filtering]] is the suppression or zeroing-out of known, persistent RF signals (like commercial cell phone bands or broadcast TV) so that the analyzer focuses only on unexpected or anomalous activity. This reduces clutter and storage overhead.

Related: [[Notch Filter]], [[Frequency Masking]], [[Interference Mitigation]]

---

## Hands-On Application

**Setup**: You'll use a [[USRP]] (such as a B210 or X310) with [[UHD]] libraries, a Python environment with NumPy and Matplotlib, and enough disk storage for multi-second recordings.

**Workflow**:

1. **Initialize the USRP** via UHD with network parameters and buffer settings optimized for continuous streaming.

2. **Define a frequency list**: Partition your target range (e.g., 0–60 GHz) into 120 center frequencies spaced evenly across the band.

3. **Launch receiver threads**: Spawn 4 parallel threads, each tuned to a different sub-band at a high sample rate (e.g., 50 MSPS).

4. **Populate a shared dictionary**: Each thread writes its spectrum measurement results to a thread-safe data structure that the main plotting loop reads.

5. **Threshold check**: After each spectral snapshot, call a decision function that compares peak power against a preset floor. If exceeded, flip the state machine to recording mode.

6. **Record and plot**: Simultaneously capture raw [[I/Q data]] to disk (for later analysis) and update a live plot showing power across all frequencies.

7. **Return to sweep**: After the recording window closes (typically 2 seconds), resume normal monitoring.

---

## Lab Exercise

**What you need**:
- [[USRP]] X310, B210, or similar wideband transceiver
- Python 3.x with NumPy, Matplotlib, and [[UHD]] Python bindings
- Sufficient local storage (several GB for I/Q recordings)
- RF test source or nearby active RF emitter for testing

**Goal**: Build a live spectrum monitor that automatically detects and logs anomalous RF activity across a 0–6 GHz band, with visual feedback and timestamped recordings.

**Steps**:

1. **Initialize the USRP and set parameters**
   - Instantiate a USRP device object via UHD.
   - Configure 4 receive channels, each with a 50 MHz sample rate.
   - Verify daughterboard info prints to console.
   - **Observable output**: UHD prints daughterboard name, TX/RX capabilities, and frequency range.

2. **Define frequency centers and create channel assignments**
   - Divide 0–6 GHz into 120 evenly spaced points (50 MHz apart).
   - Assign each of the 4 channels one quarter of the band.
   - **Observable output**: Console lists the 30 center frequencies assigned to each channel.

3. **Launch the monitoring loop**
   - Start 4 receive threads that continually tune, capture FFT data, and write to a shared dictionary.
   - Main thread reads the dictionary and updates a Matplotlib figure showing power vs. frequency every 100 ms.
   - **What it demonstrates**: Real-time spectrum visualization across the entire band with sub-second update latency.

4. **Activate a test signal**
   - Tune a signal generator (or FM radio receiver) to a frequency within your monitored band.
   - Observe the peak appear in the live plot.
   - **Observable output**: A visible spike at the transmitter's center frequency.

5. **Test threshold detection**
   - Adjust the detection threshold (e.g., –80 dBm) to trigger on your test signal.
   - Observe the state machine transition from MONITORING to RECORDING.
   - **What it demonstrates**: The system autonomously identifies anomalies and begins capturing without manual intervention.

6. **Review recorded I/Q files**
   - After a 2-second recording window, check your working directory for timestamped `.cfile` or `.bin` files.
   - Load one file into GNU Radio or a custom Python script to analyze the waveform.
   - **Observable output**: Complex time-domain or frequency-domain plots of the captured event.

---

## Related Topics
- [[USRP]]
- [[UHD]] (Universal Hardware Driver)
- [[FFT]] (Fast Fourier Transform)
- [[I/Q Data]]
- [[Software Defined Radio]]
- [[Power Spectral Density]]
- [[Real-Time Signal Processing]]
- [[GNU Radio]]
- [[NumPy]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[USRP]] | [[Spectrum Analysis]]*