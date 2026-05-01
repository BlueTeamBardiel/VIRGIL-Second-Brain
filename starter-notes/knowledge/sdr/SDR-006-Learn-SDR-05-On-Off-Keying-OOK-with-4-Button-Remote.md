---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 006
source: rewritten
---

# Learn SDR 05： On-Off Keying (OOK) with 4 Button Remote
**Discover how simple binary switching in radio—the digital cousin of Morse code—powers consumer wireless devices.**

---

## Overview
On-Off Keying (OOK) is the foundation of wireless remote control communication, where information is encoded by toggling a radio signal on and off. For SDR practitioners, understanding OOK is essential because it demonstrates how real-world devices like key fobs transmit commands, and it's simple enough to observe and decode with basic equipment like an [[RTL-SDR]] dongle. This lesson bridges the gap between theory and practice by capturing actual transmissions from a 315 MHz remote control.

---

## Key Concepts

### On-Off Keying (OOK) Modulation
**Analogy**: OOK works like flipping a light switch on and off to send a message—the presence or absence of the signal itself carries the information, just as a person at distance might flash a light to spell out Morse code.

**Definition**: [[On-Off Keying]] (OOK) is a form of [[amplitude shift keying]] where a [[carrier wave]] at a fixed [[frequency]] is simply switched between full power (1) and zero power (0) to encode data. No frequency change occurs; only the amplitude toggles.

**Mathematical representation**:
```
s(t) = A(t) × cos(2πf_c × t)

where:
  A(t) = {1, 0} (binary amplitude modulation)
  f_c  = carrier frequency (315 MHz in this example)
```

---

### 315 MHz ISM Band Remotes
**Analogy**: These remote controls are like small, single-purpose radio stations broadcasting on a crowded neighborhood frequency that doesn't require a license—many devices share the same frequency and just take turns talking.

**Definition**: Consumer remote controls operate in the [[ISM band]] (Industrial, Scientific, Medical), specifically around 315 MHz in North America. This [[license-free frequency]] allows devices to transmit without regulatory approval, but introduces the possibility of interference.

| Parameter | Value |
|-----------|-------|
| Center Frequency | 315 MHz |
| Bandwidth | ~1–2 MHz (typical remote signal width) |
| Modulation Type | [[OOK]] |
| ISM Band Status | License-free |
| Typical Range | 10–100 meters |

---

### Signal Detection and Visualization
**Analogy**: When you watch a waterfall display as someone presses a remote button, it's like watching smoke billow from a chimney—nothing for a while, then suddenly a plume appears at a specific location, revealing both *when* and *where* the transmission occurred.

**Definition**: The [[waterfall display]] (frequency vs. time) and [[time-domain waveform]] are two complementary views. The waterfall reveals spectral spikes (energy at specific frequencies), while the time display shows signal strength fluctuations. Together, they confirm both the presence and structure of the transmission.

---

## Hands-On Application

### Capturing a 4-Button Remote with GNU Radio

**Workflow overview**:

1. **Initialize [[GNU Radio Companion]] project** with RTL-SDR source
   - Set sample rate to 1 MHz (or higher for better resolution)
   - Tune center frequency to 315 MHz
   - Configure [[RTL-SDR]] gain appropriately

2. **Build dual visualization chain**
   - Connect [[RTL-SDR source]] to [[QT GUI Sink]] (time domain view)
   - Connect [[RTL-SDR source]] to [[QT GUI Frequency Sink]] (waterfall/spectrum view)
   - This allows simultaneous time and frequency observation

3. **Observe baseline noise**
   - Run the flowgraph before pressing any buttons
   - Note the noise floor level and any ambient 315 MHz activity

4. **Trigger and capture**
   - Press a remote button while flowgraph is running
   - Watch for:
     - Spike in time-domain amplitude
     - Bright vertical line (or constellation of lines) in frequency waterfall
     - Duration of transmission (typically 10–100 ms)

5. **Log and analyze**
   - Use [[File Sink]] block to save [[IQ samples]] for post-processing
   - Extract and decode the binary pulse train from captured data

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] dongle (or [[HackRF One]] for transmission)
- [[GNU Radio Companion]] (3.8+)
- 315 MHz four-button key fob remote
- Antenna (simple wire or monopole)
- Computer running Linux or Windows with SDR drivers

**Goal**: 
Visually confirm OOK transmission from a real remote control and demonstrate that binary switching at RF frequencies is directly observable in both time and frequency domains.

**Steps**:

1. **Launch GNU Radio Companion and create new flowgraph**
   - Name it `remote_monitor`
   - Set global sample rate to 1e6 (1 MHz)

2. **Add RTL-SDR Source block**
   - Double-click block
   - Set center frequency to 315e6 (315 MHz)
   - Enable automatic gain control or set gain to 40 dB
   - Confirm sample rate matches flowgraph (1e6)

3. **Add two QT GUI visualization sinks**
   - **Sink A (Time Domain)**:
     - Label: "Remote Signal (Time)"
     - X-axis: time samples
     - Y-axis: amplitude
   - **Sink B (Frequency Domain)**:
     - Label: "Remote Signal (Spectrum)"
     - Display type: Waterfall or spectrogram
     - Y-axis: frequency offset from 315 MHz

4. **Connect blocks**
   - RTL-SDR source → Time sink
   - RTL-SDR source → Frequency sink

5. **Run flowgraph and observe baseline**
   - Hit play (green triangle)
   - Note noise floor and spectrum appearance with *no* transmission
   - **Observable output**: Mostly flat, low-amplitude noise

6. **Press remote button while recording**
   - Depress one of the four buttons on the key fob
   - Position remote ~1 meter from antenna
   - **Observable output**: 
     - Time display: sudden amplitude spike lasting 10–100 ms
     - Frequency display: bright vertical line(s) appearing at or near center frequency
     - Pattern repeats if button held down

7. **Analyze the pulse structure**
   - Note the *on/off envelope*—discrete pulses separated by silence
   - Each pulse represents a symbol (1 or 0 in the binary message)
   - Measure pulse width (typically 0.5–2 ms per symbol)
   - **What it demonstrates**: Binary amplitude modulation in action; the remote doesn't change frequency, only power

8. **Optional: Decode the button press**
   - Use [[Python]] with [[scipy]]/[[numpy]] to extract [[IQ samples]]
   - Threshold time-domain signal: high amplitude = 1, low = 0
   - Convert binary sequence to decimal (e.g., `10110011` → button ID)
   - Verify same button press produces identical bit pattern

9. **Repeat with different buttons**
   - Press buttons 2, 3, and 4
   - **Observable output**: Each generates a unique binary pattern
   - Frequency and timing remain consistent; only the data payload changes

---

## Related Topics
- [[RTL-SDR]] — affordable receiver hardware for SDR hobbyists
- [[GNU Radio Companion]] — visual flowgraph programming environment
- [[Amplitude Shift Keying]] (ASK) — broader class of amplitude modulation
- [[ISM Band]] — unlicensed RF frequencies for industrial and consumer use
- [[IQ Sampling]] — complex number representation of RF signals
- [[Waterfall Display]] — time-frequency spectrogram visualization
- [[Frequency Domain Analysis]] — spectral methods in SDR
- [[Pulse Detection]] — identifying modulated signal boundaries
- [[RF Modulation Schemes]] — comparison of OOK, FSK, PSK, QAM
- [[Remote Control Protocols]] — proprietary encoding (Keeloq, rolling code, etc.)

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GNU Radio]]*