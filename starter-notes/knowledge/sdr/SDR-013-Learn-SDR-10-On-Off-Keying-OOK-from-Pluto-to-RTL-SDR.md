---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 013
source: rewritten
---

# Learn SDR 10: On-Off Keying (OOK) from Pluto to RTL SDR
**Master the fundamental digital modulation technique that encodes information by switching a radio carrier between active and silent states.**

---

## Overview

On-Off Keying represents the most elementary approach to converting digital data into a transmittable radio signal. By using a [[Pluto SDR]] as a transmitter and an [[RTL-SDR]] as a receiver, you can observe how binary information gets encoded directly onto a [[Carrier Wave|carrier frequency]] through simple amplitude modulation. Understanding OOK provides essential foundations before progressing to more bandwidth-efficient modulation schemes.

---

## Key Concepts

### On-Off Keying (OOK)
**Analogy**: Think of OOK like a flashlight—you either shine the light brightly or turn it completely off. Each flash or darkness represents a binary digit. A receiver sees either a strong signal or silence.

**Definition**: [[On-Off Keying]] is a [[Digital Modulation|modulation technique]] where a [[Carrier Wave]] is transmitted at full amplitude when the data bit is "1," and the transmission ceases entirely (or drops to near-zero amplitude) when the data bit is "0."

**Mathematical Expression**:
```
s(t) = { A·cos(2πf_c·t)  if data bit = 1
       { 0               if data bit = 0
```

Where A = amplitude, f_c = carrier frequency, t = time

**Key Characteristics**:
| Property | Value/Description |
|----------|-------------------|
| Spectral Efficiency | Very poor (~1 bit/Hz) |
| Receiver Complexity | Extremely simple (envelope detection) |
| Power Efficiency | Poor (transmitter always at peak power) |
| Noise Immunity | Low |
| Use Cases | Legacy systems, IoT, long-range protocols |

---

### Digital Data Multiplication
**Analogy**: Imagine a gate that lets water flow (signal) or blocks it completely. The "gate control" is your binary data stream—when data says "1," the gate opens fully; when it says "0," the gate closes entirely.

**Definition**: In [[GNU Radio]], multiplying a continuous [[Carrier Wave]] by a binary data stream (0 or 1 values) implements OOK directly: the multiplication suppresses the carrier when data=0 and passes it unmodified when data=1.

**Block Diagram Pattern**:
```
[Data Source] ──┐
                ├──> [Multiply Block] ──> [Pluto TX Sink]
[Signal Source] ┘
```

---

### Transmitter-Receiver Coordination
**Analogy**: Like a morse code operator and listener who agree beforehand on timing—the sender taps at specific intervals, and the receiver watches for those exact moments to decode the pattern.

**Definition**: Both [[Pluto SDR|transmitter]] and [[RTL-SDR|receiver]] must be synchronized on the same [[RF Frequency|center frequency]] and [[Symbol Rate|data rate]]. The receiver must know exactly when to sample the incoming signal to detect "on" versus "off" states.

---

## Hands-On Application

### GNU Radio Workflow

**Step 1: Build the Transmitter Chain**
Start with your previous continuous-wave flowgraph. Instead of connecting the [[Signal Source]] directly to the [[Pluto SDR Sink]], insert a [[Multiply Block]]:
- **Input 0**: Your [[Cosine Oscillator]] (carrier)
- **Input 1**: A [[Bit Source]] or [[Vector Source]] containing your binary data (0.0 or 1.0 values)

**Step 2: Scale Data Appropriately**
Binary data (0 or 1) must be converted to a magnitude that won't overdrive the [[Pluto SDR|transmitter]]:
- Use a [[Multiply Const]] block set to 0.1 or 0.5 to scale the data stream
- Connect this scaled output to the multiply block's second input

**Step 3: Monitor Transmission**
Add a [[QT GUI Frequency Sink]] before the [[Pluto SDR Sink]] to verify:
- Carrier appears when data bit = 1
- Carrier disappears when data bit = 0
- No spectral spreading (OOK should show a narrow, clean tone)

### RTL-SDR Reception Workflow

**Receiving Side Setup**:
1. Launch [[SDR#]] or [[GQRX]] on a second computer
2. Tune to the exact same [[RF Frequency]] as your [[Pluto SDR|Pluto transmitter]]
3. Set [[Demodulation]] mode to **AM (Amplitude Modulation)** or **FM** with wide bandwidth
4. Observe the waterfall display: you'll see the carrier "blinking" on and off synchronously with your transmitted data

---

## Lab Exercise

**What you need**:
- One [[Pluto SDR]] (transmitter)
- One [[RTL-SDR]] dongle (receiver)
- [[GNU Radio Companion]] installed
- [[SDR#]] or [[GQRX]] (or GNU Radio RX flowgraph)
- Two [[Software Defined Radio|SDR]] cables and appropriate connectors
- Optional: RF attenuator (to prevent receiver saturation)

**Goal**: 
Transmit a repeating bit pattern (e.g., `0b10101010`) from Pluto and visually confirm that the received signal at RTL-SDR toggles between a visible carrier tone and silence, demonstrating that your digital data is actually encoded in the RF transmission.

**Steps**:

1. **Set Up Pluto TX Flowgraph**
   - Add [[Signal Source]]: frequency = 100 kHz, type = complex, amplitude = 1.0
   - Add [[Vector Source]]: data = [1, 1, 0, 0, 1, 1, 0, 0], repeat = Yes
   - Add [[Repeat Block]]: repeat = 10000 (slow down data for visibility)
   - Add [[Multiply Block]]: connect carrier to input 0, repeated data to input 1
   - Add [[Pluto SDR Sink]]: set to 915 MHz (or another unlicensed band), gain = 50 dB
   - Add [[QT GUI Frequency Sink]] before Pluto: observe carrier blinking

2. **Observe Output on GNU Radio**
   - Run the flowgraph and look at the frequency sink
   - You should see a tone at 915 MHz + 100 kHz when data bit = 1
   - The tone should disappear when data bit = 0
   - **Observable output**: Periodic "on-off" pattern in the waterfall that matches your data pattern

3. **Receive with RTL-SDR**
   - Open a second RTL-SDR RX flowgraph or use [[SDR#]]
   - Tune to 915 MHz
   - Demodulate as AM or FM
   - Listen or watch the waterfall: you'll hear/see the characteristic "chirping" or "thumping" of the OOK data
   - **What it demonstrates**: Your [[Pluto SDR|Pluto]] transmission successfully crossed the air gap and was received by an independent receiver, proving that modulation and RF propagation both occurred correctly

4. **Measure Data Rate**
   - Note the time interval between "on" and "off" states
   - Divide by the number of bits in your pattern
   - Compare to your [[Symbol Rate]]: this validates that transmission timing matches your design

---

## Related Topics
- [[Amplitude Modulation (AM)]]
- [[Digital Modulation]]
- [[Pluto SDR]]
- [[RTL-SDR]]
- [[GNU Radio]]
- [[Frequency Shift Keying (FSK)]]
- [[Quadrature Amplitude Modulation (QAM)]]
- [[Carrier Wave]]
- [[Symbol Rate]]
- [[Modulation Index]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[GNU Radio Companion]] | [[RF Engineering]]*