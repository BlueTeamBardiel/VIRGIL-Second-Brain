---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 027
source: rewritten
---

# Radio Interferometry Jason Gallicchio
**Multiple radio dishes working together can achieve imaging resolution impossible for any single antenna alone.**

---

## Overview

Radio interferometry is a technique where multiple [[antenna|antennas]] or radio telescopes are electronically combined to create a single, ultra-high-resolution imaging system. Rather than using optical lenses or large physical dishes, interferometry exploits the wave nature of radio signals—specifically their ability to interfere constructively and destructively—to synthesize the imaging capability of a vastly larger telescope. For SDR hobbyists, understanding interferometry principles unlocks advanced sensing applications, amateur radio astronomy, and distributed signal processing workflows.

---

## Key Concepts

### Aperture and Resolution
**Analogy**: Imagine trying to read text on a distant billboard. A single pair of binoculars can only resolve so much detail. But if two observers stand far apart and compare what they see, they can determine finer details about the billboard's features through triangulation and comparison—that's what interferometry does with radio waves.

**Definition**: [[Aperture]] refers to the effective size of an imaging instrument. In traditional telescopes, physical aperture (dish diameter) directly limits [[Resolution|angular resolution]]. [[Rayleigh Criterion]] states that the minimum resolvable angle is proportional to wavelength divided by aperture diameter:

$$\theta_{\min} \approx 1.22 \frac{\lambda}{D}$$

Where:
- $\lambda$ = [[Wavelength]]
- $D$ = aperture diameter

A single small radio dish cannot resolve distant cosmic objects. However, multiple dishes separated by distance $B$ (baseline) act like a single dish with effective diameter $B$—achieving vastly improved resolution without building an impossibly large physical structure.

---

### Baseline and Synthetic Aperture
**Analogy**: Two ears on your head are separated by a few inches. Yet you can locate where a sound comes from because sound arrives at slightly different times to each ear. The distance between your ears is a "baseline," and your brain uses that baseline to synthesize directional information far more precise than either ear alone could achieve.

**Definition**: The [[Baseline (Radio Interferometry)|baseline]] is the vector distance between two [[antenna|antennas]] in an interferometric array. Long baselines create long "virtual" apertures. By collecting signals from multiple antenna pairs at varying baselines and orientations, the array synthesizes the imaging power of a single dish with diameter equal to the longest baseline.

**Key relationship**:
$$\text{Effective Aperture} \propto \text{Longest Baseline}$$

This principle is called [[Synthetic Aperture]] and is fundamental to radio astronomy, [[Synthetic Aperture Radar (SAR)|SAR]], and modern interferometric [[Software Defined Radio|SDR]] systems.

---

### Phase Coherence and Cross-Correlation
**Analogy**: Imagine two friends standing at opposite ends of a concert hall. They both hear the same song, but sound waves arrive at slightly different times due to distance. By carefully measuring the time delay and phase difference between what each friend hears, someone could reconstruct the precise location of the stage—that's what cross-correlation does electronically.

**Definition**: [[Phase Coherence]] describes the degree to which two received signals maintain a fixed phase relationship. In interferometry, signals from all antennas must be collected with known time and phase alignment (usually synchronized by atomic clocks or GPS). The [[Cross-Correlation|cross-correlation]] between pairs of antenna signals reveals the presence of coherent radio sources:

$$R_{12}(\tau) = \int_{-\infty}^{\infty} s_1(t) \cdot s_2(t+\tau) \, dt$$

Where $s_1$ and $s_2$ are voltage signals from antennas 1 and 2, and $\tau$ is the time delay. Peaks in cross-correlation indicate the time delay at which signals from a distant source align.

---

### Fringe Pattern and Visibility
**Analogy**: Drop two pebbles into a still pond. Ripples spread outward from each pebble and overlap, creating a pattern of peaks (constructive interference) and valleys (destructive interference). This visible pattern of interference fringes is exactly what happens when radio waves from a distant source reach two separated antennas.

**Definition**: A [[Fringe (Interferometry)|fringe]] is a bright or dark line in an interference pattern. In radio interferometry, [[Visibility]] measures the strength of the interference pattern between antenna pairs as a function of baseline and frequency:

$$V = \left| \int I(\vec{l}) e^{2\pi i (\vec{b} \cdot \vec{l}/\lambda)} \, d\vec{l} \right|$$

Where:
- $I(\vec{l})$ = intensity distribution of the radio source
- $\vec{b}$ = baseline vector
- $\lambda$ = wavelength

Higher visibility indicates stronger, more coherent radio sources. By measuring visibility across many baselines at different orientations, a mathematical reconstruction ([[Fourier Transform|inverse Fourier transform]]) recovers the original source image.

---

### Why Single-Dish Imaging Fails
**Analogy**: If you squint very hard with one eye, objects beyond a certain distance blur together. No amount of squinting (increasing sensitivity) will let you distinguish two trees on a distant hillside—you need two eyes (two viewpoints) to judge depth and separation.

**Definition**: A single radio dish has fixed [[Beam (Antenna)|beamwidth]] determined by:

$$\theta_{\text{beam}} \approx 1.22 \frac{\lambda}{D}$$

For cosmic radio sources at wavelengths of centimeters to meters, even the largest single dishes (e.g., Arecibo's 305-meter reflector) achieve beamwidths of arcminutes to arcseconds. Many celestial objects are separated by arcseconds or less, making single-dish observation incapable of resolving them into distinct structures.

| Imaging Method | Angular Resolution | Typical Application |
|---|---|---|
| Single dish (1 m, 1 GHz) | ~60 arcminutes | Broad survey |
| Single dish (10 m, 1 GHz) | ~6 arcminutes | Nebulae, clusters |
| Interferometer (100 m baseline, 1 GHz) | ~0.6 arcseconds | Galaxy jets, supernova remnants |
| Interferometer (10 km baseline, 1 GHz) | ~0.006 arcseconds | Stellar disks, AGN cores |

---

### Very Large Array (VLA) Geometry
**Analogy**: A photographer wants to capture a vast landscape. A single camera position captures limited perspective. But if the photographer stands at multiple carefully-chosen locations—foreground, midground, background, left, right—and combines the images intelligently, they reveal depth and structure impossible from any single angle. The VLA arranges antennas similarly.

**Definition**: The [[Very Large Array (VLA)|VLA]] consists of 27 radio antennas arranged in a Y-shaped configuration near Socorro, New Mexico. Antennas are movable along railroad tracks and can be deployed in multiple configurations (A, B, C, D array) to vary baseline lengths. The Y-shaped pattern (rather than a line or random scatter) optimizes coverage of [[Fourier Space|Fourier space]], enabling uniform sensitivity to angular scales across different directions on the sky.

**Why Y-shaped?**
- Three arms at 120° angles provide uniform directional sensitivity
- Avoids "blind spots" where baseline distribution would be sparse
- Allows the 2D array to sample enough of Fourier space for high-quality image reconstruction

---

## Hands-On Application

### SDR Interferometry Workflow

Modern SDR platforms ([[GNU Radio]], [[USRP]], [[HackRF]]) can implement simplified interferometry:

**Single-Baseline Interferometer (Two RTL-SDRs)**
1. **Synchronization**: Connect two [[RTL-SDR|RTL-SDR dongles]] via a shared external clock (GPS-disciplined oscillator or lab signal generator at ~28 MHz). This ensures phase coherence between receivers.
2. **Signal Capture**: Configure both RTL-SDRs to observe the same radio source (e.g., a strong FM station, solar radio burst, or known celestial object) at identical frequency and sample rate.
3. **Cross-Correlation**: In [[GNU Radio]] or Python (using scipy), compute the cross-correlation between digitized signals from both antennas.
4. **Delay Estimation**: Identify the lag at which cross-correlation peaks—this reveals the geometric delay introduced by the baseline.
5. **Image Reconstruction**: Repeat observations at different antenna separations (move one SDR further away or rotate the pair) to sample different baselines and reconstruct a coarse radio map.

**Tools**:
- [[GNU Radio Companion]]: flowgraph for real-time correlation
- [[Python]] with NumPy/SciPy: offline correlation analysis
- [[FFTW]] libraries: fast Fourier transforms for Fourier-space analysis

**Key parameters to control**:
- **Baseline length** $B$ (in meters)
- **Observation frequency** $f$ (Hz) → wavelength $\lambda = c/f$
- **Integration time** (seconds of coherent accumulation)
- **Phase calibration** (reference antenna, phase wrapping correction)

---

## Lab Exercise

**What you need**:
- Two [[RTL-SDR|RTL-SDR dongles]] or two [[HackRF One|HackRF]] units
- GPS receiver or [[GPSDO|GPS-disciplined oscillator]] (GPSDO) for clock synchronization
- Matching dipole [[antenna|antennas]] or small parabolic dishes
- [[GNU Radio]] or Python environment with signal processing libraries
- Accessible radio source (strong FM station, radio beacon, or controlled RF source)

**Goal**:
Observe interference fringes and time-delay patterns from a known radio source using two separated antennas, demonstrating that baseline separation improves directional sensitivity.

**Steps**:

1. **Build synchronized dual-receiver setup**
   - Connect external 10 MHz reference from GPSDO to both RTL-SDR dongles (or HackRF units).
   - Verify phase lock by observing stable I/Q constellation in [[GNU Radio]] at both receivers.
   - Place antennas 1–10 meters apart, pointing toward a strong radio emitter (FM station at ~100 MHz, or a local WiFi access point at 2.4 GHz).

2. **Capture synchronized IQ data**
   - Configure both SDRs for identical center frequency, sample rate (~2 MSps for RTL-SDR, ~20 MSps for HackRF), and gain.
   - Record 10–30 seconds of IQ samples from both receivers simultaneously using GNU Radio's *File Sink* blocks (or similar).
   - **Observable output**: Two parallel complex signal streams with identical noise and signal content, but with different phase shifts due to path-length difference.

3. **Compute cross-correlation and phase delay**
   ```
   import numpy as np
   from scipy.signal import correlate
   
   # Load IQ data from both receivers
   sig1 = np.fromfile('antenna1.cf32', dtype=np.complex64)
   sig2 = np.fromfile('antenna2.cf32', dtype=np.complex64)
   
   # Compute cross-correlation
   xcorr = correlate(sig1, sig2, mode='full')
   lags = np.arange(len(xcorr)) - len(sig1)
   
   # Find peak lag (time delay between signals)
   peak_lag = lags[np.argmax(np.abs(xcorr))]
   geometric_delay = peak_lag / sample_rate  # seconds
   ```
   **Observable output**: A peak in the magnitude of cross-correlation at non-zero lag, indicating the time delay between antennas. Peak magnitude indicates signal coherence; higher peaks = stronger source.

4. **Repeat with varying antenna separation**
   - Move one antenna 1, 2, 5, and 10 meters further away (or rotate the pair).
   - Re-record and re-compute cross-correlation for each baseline.
   - **Observable output**: As baseline increases, the time-delay resolution improves (peak becomes sharper). At longer baselines, the same source produces proportionally larger delays.

5. **Visualize baseline vs. resolution**