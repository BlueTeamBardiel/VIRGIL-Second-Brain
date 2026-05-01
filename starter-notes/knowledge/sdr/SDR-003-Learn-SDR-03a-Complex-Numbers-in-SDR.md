---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 003
source: rewritten
---

# Learn SDR 03a: Complex Numbers in SDR
**Master the mathematical foundation that makes modern radio signal processing possible.**

---

## Overview

[[Complex numbers]] are unavoidable when working with [[Software Defined Radio]] systems—the moment you connect an [[RTL-SDR]] dongle or [[HackRF]], you're swimming in them. Understanding what complex numbers represent, how to visualize them, and how to manipulate them mathematically is essential because all modern RF signal processing relies on decomposing signals into real and imaginary components that capture amplitude and phase information simultaneously.

---

## Key Concepts

### Complex Numbers as Coordinates
**Analogy**: Just as you use latitude and longitude to pinpoint a location on Earth, complex numbers use two perpendicular axes (real and imaginary) to locate a point in a 2D plane. A city at 40°N, 74°W is unique because of *both* coordinates—neither alone tells the full story. Similarly, a complex number needs both its real and imaginary parts to fully describe a signal.

**Definition**: A [[complex number]] is an expression of the form $a + bi$, where $a$ is the **real part**, $b$ is the **imaginary part**, and $i$ is the imaginary unit satisfying $i^2 = -1$. In the context of [[RF signals]], the real axis typically represents the in-phase (I) component, and the imaginary axis represents the quadrature (Q) component.

**The Complex Plane**:

| Axis | Meaning in SDR | Units |
|------|----------------|-------|
| Real (horizontal) | In-Phase (I) or cosine component | Amplitude |
| Imaginary (vertical) | Quadrature (Q) or sine component | Amplitude |

Example: The complex number $3 + 2i$ plots as a point 3 units right and 2 units up on the complex plane, or equivalently, as an arrow (vector) from the origin to that point.

---

### Arithmetic with Complex Numbers
**Analogy**: Adding complex numbers is like combining displacement vectors. If you walk 3 steps east and 2 steps north, then your friend walks 1 step east and 4 steps north from where you are, you both end up at a combined displacement. Just add each direction separately.

**Addition**: $(a + bi) + (c + di) = (a+c) + (b+d)i$

Add real parts to real parts, imaginary parts to imaginary parts.

**Subtraction**: $(a + bi) - (c + di) = (a-c) + (b-d)i$

**Multiplication**: $(a + bi) \cdot (c + di) = (ac - bd) + (ad + bc)i$

This is less intuitive because cross-multiplication occurs. In [[GNU Radio]] blocks, multiplication of complex signals is handled automatically by the underlying C++ libraries.

**Graphical Interpretation**:
- **Addition**: Place the tail of the second vector at the head of the first; the sum is the vector from origin to final position.
- **Subtraction**: Reverse the second vector and add.
- **Multiplication**: Scales magnitude and rotates phase (see [[Complex Exponentials]]).

---

### Magnitude and Phase
**Analogy**: A compass needle has two properties: how far it points from you (magnitude/length) and which direction it points (angle/phase). A complex number encodes exactly this information.

**Definition**: For a complex number $z = a + bi$:

$$|z| = \sqrt{a^2 + b^2} \quad \text{(magnitude)}$$

$$\angle z = \arctan\left(\frac{b}{a}\right) \quad \text{(phase in radians)}$$

In [[SDR]] applications, magnitude tells you signal strength, and phase tells you the timing relationship between the I and Q components—crucial for demodulation.

**Polar Form**: Any complex number can be rewritten as:
$$z = r \cdot e^{j\theta} = r(\cos\theta + j\sin\theta)$$

where $r = |z|$ and $\theta = \angle z$.

---

### Complex Sinusoids and the Exponential Form
**Analogy**: Imagine a point rotating around a circle at a constant speed. If you project its height onto a vertical axis, you see a sine wave; if you project its horizontal position, you see a cosine wave. A complex sinusoid captures *both* at once.

**Definition**: The [[complex exponential]] $e^{j2\pi ft}$ represents a rotating vector in the complex plane, spinning at frequency $f$ with one complete rotation per second (when $f=1$ Hz). In [[baseband signal processing]]:

$$e^{j2\pi ft} = \cos(2\pi ft) + j\sin(2\pi ft)$$

The real part is a [[cosine wave]], the imaginary part is a [[sine wave]]—locked together perfectly at 90° phase offset.

**Why This Matters for SDR**:
- [[Demodulation]] requires multiplying incoming [[RF signals]] by a complex sinusoid to shift them down to baseband.
- The result contains I and Q [[baseband samples]] that fully capture amplitude and phase of the original signal.

---

## Hands-On Application

When you open a [[Software Defined Radio]] receiver in [[GNU Radio]] or [[SDR#]], raw data arrives as **complex samples** (I/Q pairs). Each sample is one point in the complex plane.

**Workflow**:
1. **Receive**: [[RTL-SDR]] ADC outputs I and Q samples at a chosen sample rate (e.g., 2.4 MS/s).
2. **Visualize**: Plot samples on a [[constellation diagram]] (complex plane) to see signal clouds, constellations, and noise.
3. **Process**: Multiply received samples by complex sinusoids to shift frequency, filter out noise, extract data.
4. **Decode**: Phase and magnitude changes in the I/Q stream directly reveal modulated symbols.

**Key Tools**:
- [[GNU Radio]]: `complex_float32` data type; drag-and-drop complex math blocks (multiply, add, divide).
- [[SDR#]]: Real-time waterfall and constellation displays auto-compute complex representation internally.
- [[MATLAB/Python]]: `np.complex64` arrays; `.real` and `.imag` attributes access components; `numpy.abs()` and `numpy.angle()` extract magnitude and phase.

**Command-line example** (Python with NumPy):
```python
import numpy as np

# Create I/Q samples: I=0.7, Q=0.3
sample = 0.7 + 0.3j

# Extract components
i_part = sample.real
q_part = sample.imag

# Compute magnitude and phase
magnitude = abs(sample)  # √(0.7² + 0.3²) ≈ 0.764
phase = np.angle(sample)  # arctan(0.3/0.7) ≈ 0.407 rad

print(f"Magnitude: {magnitude:.3f}, Phase: {phase:.3f} rad")
```

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] dongle (or [[HackRF]] or [[LimeSDR]]) and USB cable
- [[GNU Radio]] installed with Python 3
- A nearby FM broadcast transmitter or local signal generator

**Goal**: Observe real I/Q samples from an incoming signal and verify that magnitude and phase correspond to signal strength and phase relationships.

**Steps**:

1. **Set up a simple receiver**
   - Launch [[GNU Radio Companion]]
   - Create an `RTL-SDR Source` block (sample rate: 1 MS/s, frequency: ~100 MHz for FM)
   - Connect output to a `Complex to Mag²` block (measures power)
   - Add a `QT GUI Time Sink` to view magnitude over time

2. **Run and observe magnitude**
   - Press Execute; tune near an FM station
   - You should see magnitude spike when the transmitter is present, drop to noise floor when not
   - This demonstrates that $|z| = \sqrt{I^2 + Q^2}$ tracks signal strength

3. **Add phase observation**
   - Insert an `Arg` (phase) block after the RTL-SDR Source
   - Connect to second GUI Time Sink; observe phase wraps between $-\pi$ and $+\pi$
   - Phase changes rapidly for frequency offsets; stable phase = frequency-locked signal

4. **Constellation diagram**
   - Connect RTL-SDR output directly to `QT GUI Constellation Sink`
   - Switch to a narrowband signal (CW, QPSK, etc.)
   - Watch the cloud of points in the I/Q plane; tightly grouped = clean signal, scattered = noisy

**What it demonstrates**:
- Complex numbers are not abstract; they're the native language of modern [[RF receivers]].
- Magnitude and phase extraction from I/Q samples reveals signal quality and information content.
- The [[complex plane]] visualization (constellation) is the fastest way to diagnose receiver health and signal quality.

---

## Related Topics
- [[RTL-SDR]]
- [[GNU Radio]]
- [[IQ Sampling]]
- [[Baseband Processing]]
- [[Complex Exponentials]]
- [[Quadrature Demodulation]]
- [[Constellation Diagram]]
- [[Frequency Translation]]
- [[Digital Signal Processing]]
- [[Software Defined Radio]]

---

*Source: Learn SDR Series | [[Software Defined Radio]] | [[Complex Numbers]] | [[RTL-SDR]]*