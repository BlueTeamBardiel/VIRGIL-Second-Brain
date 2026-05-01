---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 025
source: rewritten
---

# Learn SDR 22： GPS Gold Codes; Spread Spectrum; Code-division multiple access (CDMA)
**Every GPS satellite broadcasts its own unique digital fingerprint by combining two shift register sequences in a clever way.**

---

## Overview

GPS satellites need to transmit their positioning signals simultaneously on the same frequency without interfering with each other. The solution is to give each satellite a mathematically unique spreading code—a Gold code—that acts as a digital signature. Understanding Gold codes is essential for anyone building GPS receivers, SDR signal analysis tools, or exploring how spread spectrum technology multiplexes multiple transmitters on a single channel.

---

## Key Concepts

### Gold Codes
**Analogy**: Imagine a crowd of people all speaking at the same time in a noisy room. If each person speaks using a unique combination of accents and word patterns, a listener wearing special headphones tuned to one person's pattern can filter out all the others and hear just their voice. That's what Gold codes do—they give each GPS satellite a unique "speaking pattern" on the shared GPS frequency.

**Definition**: A [[Gold code]] is a specific [[pseudorandom sequence]] created by combining two [[linear feedback shift register]] (LFSR) outputs using an [[XOR gate]]. Each GPS satellite uses a distinct [[tap selection|tap pair]] from the second shift register, creating orthogonal or near-orthogonal codes.

**Structure**:
- **G1 sequence**: 1,023-bit repeating pattern from an 11-stage LFSR
- **G2 sequence**: 1,023-bit repeating pattern from a different 11-stage LFSR
- **Output (CA code)**: G1 ⊕ G2[tap_i] ⊕ G2[tap_j]

Where ⊕ represents [[XOR operation]].

### Linear Feedback Shift Registers (LFSR)
**Analogy**: Think of a train of connected relay switches. After each clock pulse, data shifts down the line, and selected tap points feed their bit values back into the first position. The pattern never repeats until you've cycled through all possible states—that's what makes it "pseudo-random" and useful for GPS.

**Definition**: An [[LFSR]] is a shift register whose input bit is a linear function (typically XOR) of its previous state. In GPS, two identical 11-stage LFSRs generate the fundamental sequences that get combined into Gold codes.

| Property | G1 LFSR | G2 LFSR |
|----------|---------|---------|
| Stages | 11 | 11 |
| Sequence length | 1,023 chips | 1,023 chips |
| Feedback taps | Positions 10, 3 | Positions 10, 9, 8, 6 |
| Generates | Satellite base code | Tap pool for all satellites |

### Spread Spectrum
**Analogy**: You're painting a picture, but instead of using thick paint in one area, you spread thin paint evenly across the whole canvas. The image is still there, just distributed. Someone looking at the thin coating won't recognize the picture immediately, but the right filter reveals it. That's what spread spectrum does to a signal.

**Definition**: [[Spread spectrum]] is a modulation technique where a narrow-bandwidth data signal is deliberately spread across a wide frequency band using a spreading code. The receiver uses the same code to de-spread and recover the original signal.

**Key advantages**:
- Multiple signals can occupy the same spectrum without interfering
- Resistance to jamming and eavesdropping
- Better multipath rejection
- Lower spectral power density (appears as noise to non-synchronized receivers)

### Code-Division Multiple Access (CDMA)
**Analogy**: Imagine a library where multiple people speak simultaneously, but each person speaks a language only their listener understands. By "tuning" to the right language (code), you filter out all others and hear just your conversation. That's CDMA—multiple simultaneous transmitters share the channel, each with its own code.

**Definition**: [[CDMA]] is a multiple access scheme where different users transmit simultaneously on the same frequency band, each using a unique spreading code. Receivers correlate the received signal against their target code to extract their signal while suppressing others.

**How it works in GPS**:
- All satellites transmit on L1 (1,575.42 MHz)
- Each satellite uses its own Gold code
- Receiver correlates against the specific satellite's code
- Other satellites' signals appear as noise below the correlation peak

| Aspect | TDMA | FDMA | CDMA |
|--------|------|------|------|
| Separation method | Time slots | Frequency bands | Codes |
| Simultaneous users | One per slot | One per band | Many (code-limited) |
| Receiver complexity | Low | Low | High (correlation) |
| Spectrum efficiency | Good | Moderate | Excellent |
| GPS use | No | No | **Yes (C/A code)** |

### Code Phase Assignment & Tap Selection
**Analogy**: You have a library of 32 books, but readers only check out specific pairs of chapters from each book. Combining those chapter pairs uniquely identifies each reader's personal collection. GPS satellites similarly use unique pairs of "tap positions" from the G2 register.

**Definition**: Each of 32 GPS satellites is assigned a unique pair of [[tap positions]] (bit indices) from the G2 register. These taps are XORed together and combined with G1 to produce that satellite's specific C/A code.

**Example assignments**:
- **PRN 1** (Space Vehicle 1): G2 taps at positions 2, 6
- **PRN 2** (Space Vehicle 2): G2 taps at positions 3, 7
- **PRN 3** (Space Vehicle 3): G2 taps at positions 4, 8
- ... (up to PRN 32)

These assignments are documented in the official ICD-GPS-200 specification.

---

## Hands-On Application

### Observing Gold Codes with GNU Radio

1. **Generate a Gold code in GNU Radio**:
   - Use a custom Python block or HSP GRC module to instantiate two LFSR blocks
   - Set G1 feedback taps: [10, 3] (counting from stage 1)
   - Set G2 feedback taps: [10, 9, 8, 6]
   - Extract G2 taps at your target satellite's positions
   - XOR the G1 and selected G2 outputs
   - Output the resulting bit stream (1,023 chips per period at 1.023 MHz)

2. **Correlate real GPS signals**:
   - Use [[rtl_power]] or [[hackrf_transfer]] to capture raw I/Q data centered at L1
   - In [[GNSS-SDR]] or a custom GNU Radio flowgraph, correlate against multiple PRN codes simultaneously
   - Observe correlation peaks appearing at different delay offsets—each peak identifies a visible satellite

3. **Examine spectral properties**:
   - Plot the autocorrelation of a single Gold code (sharp central peak, noise floor elsewhere)
   - Plot cross-correlation between two different satellite codes (should be low)
   - Verify spread spectrum: code occupies ~2 MHz (1.023 MHz × 2) centered at L1

### Decoding GPS Messages

Once you correlate and acquire a satellite's code, you can:
- Track the code phase (pin timing to nanosecond precision)
- Recover the 50 bps [[navigation message]]
- Extract ephemeris and almanac data
- Calculate pseudoranges and position via trilateration

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] dongle (or [[HackRF One]] for stronger signals)
- [[GNU Radio]] 3.9+ with Python support
- [[GNSS-SDR]] framework (optional but recommended)
- GPS antenna (preferred) or indoor antenna
- Spectrum analyzer (gqrx or inspectrum)

**Goal**: Visualize GPS satellite signals at L1, manually correlate against a known PRN code, and observe the correlation peak that proves you're receiving a real satellite.

**Steps**:

1. **Capture raw GPS data**:
   ```bash
   rtl_sdr -f 1575420000 -s 2000000 -n 10000000 gps_capture.iq
   ```
   This records 10 million I/Q samples centered at L1, at 2 MSPS.

2. **Load and correlate in GNU Radio** (pseudocode):
   - File source → Load gps_capture.iq
   - Generate Gold code for PRN 1 (G1 ⊕ G2[taps 2,6]) at 1.023 MHz
   - **Correlate**: Multiply incoming signal by locally generated code (with variable delay offset)
   - Sum over 1,023-chip windows
   - Plot magnitude of correlation result vs. code phase delay
   
   **Observable**: A sharp peak emerges at the true code phase. Height of peak indicates signal strength; sharp rise/fall proves you've locked onto the spreading code structure.

3. **What it demonstrates**:
   - **Spread spectrum principle**: Without the code, the GPS signal is buried below thermal noise. Correlation "compresses" the spreading, raising it above the noise floor.
   - **CDMA in action**: If you correlate against PRN 2's code, the peak will be absent or much smaller—proving that codes are indeed orthogonal.
   - **Code phase ambiguity**: The peak position (code delay in chips) encodes the satellite's range modulo 1,023 chips.

**Extension**: Sweep through all 32 PRNs. Each visible peak identifies an in-view satellite. Use the acquisition output as input to a [[delay-locked loop]] (DLL) tracker for continuous signal monitoring.

---

## Related Topics
- [[Linear Feedback Shift Register (LFSR)]]
- [[Spread Spectrum Modulation]]
- [[Pseudorandom Sequence]]
- [[Correlation and Matched Filtering]]
- [[Code-Division Multiple Access (CDMA)]]
- [[GPS L1 C/A Code]]
- [[Navigation Message (GPS)]]
- [[Delay-Locked Loop (DLL)]]
- [[GNU Radio]]
- [[RTL-SDR]]
- [[GNSS-SDR]]
- [[XOR Gate]]
- [[ICD-GPS-200]] (official GPS specification)

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[RTL-SDR]] | [[GPS Fundamentals]]*