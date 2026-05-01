---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 023
source: rewritten
---

# Learn SDR 20： Phase Ambiguity and Differential Encoding
**When your receiver locks onto the right symbols but can't tell which way is up**

---

## Overview

After a [[carrier recovery]] loop synchronizes your signal, it faces an invisible problem: it has no way of knowing if it's looking at the constellation rotated 0°, 90°, 180°, or 270° from the transmitter's perspective. This "phase ambiguity" means your demodulated bits might be systematically inverted or scrambled. Understanding how to resolve this ambiguity is critical for any practical [[digital modulation]] receiver you build.

---

## Key Concepts

### Phase Ambiguity in Constellation Lock

**Analogy**: Imagine you're reading a book in a dark room and someone rotates it without telling you. You recognize it's a book, but you can't tell if you're reading it right-side-up or upside-down—the shapes match either way, and you only realize the problem when the words stop making sense.

**Definition**: [[Phase ambiguity]] occurs when a [[phase-locked loop]] (PLL) or [[decision-feedback equalizer]] locks onto a valid [[symbol constellation]] point, but there exists a 180° (or 360°/N) phase rotation that is equally valid mathematically. The receiver has no inherent way to know which rotation is correct.

| Modulation | Possible Rotations | Problem |
|---|---|---|
| [[BPSK]] | 2 (0° or 180°) | Symbols inverted: +1 ↔ −1 |
| [[QPSK]] | 4 (0°, 90°, 180°, 270°) | Any quadrant rotation possible |
| [[16-QAM]] | 4 (quadrant ambiguity) | 4 possible phase offsets |
| [[Higher-order QAM]] | 2 or 4 | Depends on symmetry |

**Why it happens**: The cost function that the PLL minimizes depends only on the magnitude of error, not its sign or direction. A rotated constellation is mathematically equally valid.

---

## Resolution Technique 1: Preamble/Known Word Detection

**Analogy**: Instead of guessing which way a puzzle piece goes, you check it against the picture on the box—if it doesn't match, you rotate it until it does.

**Definition**: A [[preamble]] or [[sync word]] is a predetermined, long, unique bit sequence transmitted at the start of each packet or burst. The receiver tries all possible phase rotations and picks the one where the received symbols best match (via [[correlation]]) the known preamble.

**How it works**:
1. Transmitter sends a well-known symbol sequence (e.g., 64 or 128 symbols)
2. Receiver's timing recovery locks to preamble transitions
3. Receiver applies all N possible phase rotations
4. For each rotation, compute correlation with known preamble
5. Choose the rotation with highest correlation—this is the correct phase
6. Lock to that rotation and proceed with data payload

**Advantages**:
- Very reliable if preamble is long enough
- Works for any [[modulation scheme]]
- Naturally handles [[multi-symbol synchronization]]

**Disadvantages**:
- Wastes bandwidth (preamble carries no user data)
- Overhead grows with packet overhead
- Not suitable for continuous streams

---

## Resolution Technique 2: Differential Encoding

**Analogy**: Instead of marking absolute positions on a map, you only write down the turn directions—"left, right, straight, right." The starting point doesn't matter; only the changes matter.

**Definition**: [[Differential encoding]] encodes data not as absolute symbols, but as the *transitions* between consecutive symbols. The receiver ignores absolute constellation phase and instead looks at the phase *difference* between one symbol and the next.

**Example in [[DBPSK]] (Differential BPSK)**:

Instead of transmitting: `+1, +1, −1, +1, −1, −1`

Transmit the *difference*: 
- Start: reference = +1
- Data bit 0 → phase change 0° (no change): +1
- Data bit 0 → phase change 0°: +1
- Data bit 1 → phase change 180°: −1
- Data bit 0 → phase change 0°: +1
- Data bit 1 → phase change 180°: −1
- Data bit 1 → phase change 180°: −1

Receiver demodulation:
```
If symbol[n] × conj(symbol[n-1]) points toward +1 region → bit = 0
If symbol[n] × conj(symbol[n-1]) points toward -1 region → bit = 1
```

The absolute rotation doesn't matter—only the *relative* phase between consecutive symbols encodes the data.

**Why it works**: Multiplying symbol[n] by the complex conjugate of symbol[n-1] removes the absolute phase offset:
$$\text{relative phase} = \arg\left(\frac{s_n}{\overline{s_{n-1}}}\right) = \arg(s_n) - \arg(s_{n-1})$$

The receiver doesn't need to know what $\arg(s_n)$ is in absolute terms—only how it changed.

**Trade-off**: Each bit now depends on two consecutive symbols, so one symbol error can cause two bit errors (error propagation). Preamble method has no error propagation.

| Approach | Bandwidth Overhead | Phase Recovery | Error Propagation |
|---|---|---|---|
| Preamble-based | 5–20% | Perfect if preamble long | None |
| Differential encoding | 0% | Inherent in modulation | ±1 bits per symbol error |

---

## Hands-On Application

### With RTL-SDR and GNU Radio

**Setup**: [[GNU Radio]] allows you to experiment with both approaches in real-time.

**For preamble-based recovery**:
1. Create a [[Correlate Access Code]] block in GNU Radio
2. Feed it your known preamble as a bit string (e.g., `"11010010"` repeated)
3. Block outputs alignment signal when correlation exceeds threshold
4. Use this to reset your constellation decoder

**For differential encoding**:
1. Use a [[Multiply by Conjugate]] block followed by phase extraction (`atan2`)
2. Feed previous symbol to delay line
3. Multiply current symbol by conjugate of delayed symbol
4. Extract phase difference (rather than absolute phase)
5. Quantize phase difference into bits based on quadrants or regions

**Quick workflow**:
```
RTL-SDR → Frequency shift → Low-pass filter → PLL/Costas loop 
→ [Preamble detection OR Diff decoder] → Bit stream
```

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] dongle or [[HackRF One]]
- [[GNU Radio]] 3.8+
- Generated test signal (QPSK or BPSK modulated with known preamble)
- GQRX or custom flow graph

**Goal**: Observe that naive constellation lock fails to decode data correctly, then fix it using differential decoding.

**Steps**:

1. **Generate a test signal with known preamble**:
   - Create 64-bit sync word (e.g., alternating `10101010…`)
   - Append 256 data bits (random or test pattern)
   - [[QPSK modulate]] at 1 MHz, transmit via [[HackRF]]

2. **Receive and attempt naive decoding**:
   - Use [[RTL-SDR]] to capture signal
   - Apply [[matched filter]] and [[Costas loop]] PLL
   - Look at demodulated bits—observe they're garbage or inverted

3. **Add differential decoder**:
   - Insert [[Delay]] block (1 symbol) before [[Multiply by Conjugate]]
   - Extract phase of product
   - Quantize into bits
   - **Observe**: Now bits decode correctly regardless of rotation

4. **Optional: Implement preamble detection**:
   - Compute correlation of received bits against known sync word
   - Measure confidence; apply phase correction based on best correlation match
   - Compare BER (bit error rate) to differential method

5. **What it demonstrates**:
   - Phase ambiguity is real and unavoidable without external reference
   - Differential encoding trades error propagation for zero overhead
   - Preamble method is more robust but costs bandwidth

---

## Related Topics
- [[Carrier Recovery]]
- [[Costas Loop]]
- [[Phase Locked Loop (PLL)]]
- [[QPSK]]
- [[BPSK]]
- [[Differential Modulation (DBPSK, DQPSK)]]
- [[Correlation and Sync Word Detection]]
- [[Constellation Diagram]]
- [[GNU Radio]]
- [[HackRF One]]
- [[RTL-SDR]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Digital Communications]] | [[Modulation and Coding]]*