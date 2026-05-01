---
tags: [knowledge, sdr, radio, rf]
created: 2026-05-01
topic: Software Defined Radio
chapter: 026
source: rewritten
---

# Learn SDR 23： GPS Reception
**Capturing signals from orbiting satellites using affordable consumer radio hardware and GNU Radio.**

---

## Overview

GPS reception via [[Software Defined Radio]] demonstrates how weak, distant signals can be captured, amplified, and decoded with proper hardware configuration and signal processing. This application bridges [[RF engineering]], [[antenna design]], and [[digital signal processing]], making it an excellent practical introduction to real-world satellite communication challenges. Understanding GPS reception teaches critical lessons about [[gain]] management, [[noise figure]], and signal-to-noise optimization that apply across all SDR work.

---

## Key Concepts

### Low Noise Amplification (LNA)
**Analogy**: Imagine whispering to someone across a football stadium. Your voice is faint by the time it reaches them. An LNA is like installing a megaphone at their ear—it amplifies that faint whisper *before* background noise drowns it out, making the message clearer.

**Definition**: A [[Low Noise Amplifier]] is a specialized RF circuit placed near the antenna that boosts weak incoming signals while adding minimal electronic noise. Unlike amplifiers placed downstream, an LNA operates at the signal's weakest point, preserving the [[signal-to-noise ratio]].

[[GPS]] satellites transmit at approximately 1.6 GHz with power levels so low they arrive at Earth as microwatt-level signals. Without an LNA, the [[RTL-SDR]] dongle's internal amplifier would add too much noise, drowning the satellite data.

**Key Parameters**:
- **Gain**: Typically 20–30 dB (100–1000× amplification)
- **Noise Figure**: <1 dB (adds minimal noise)
- **Power**: Often powered via [[bias tee]] over the antenna cable

---

### Bias Tee
**Analogy**: A bias tee is like a mail slot in a door—it lets mail (DC power) travel down the same physical path as letters (RF signals) without interfering with each other.

**Definition**: A [[Bias Tee]] is a passive network that combines RF signals and DC power on a single cable. It uses [[inductors]] and [[capacitors]] to allow DC current to power a remote amplifier while blocking that same power from entering RF-sensitive circuits.

```
┌─────────────────────────────┐
│   GPS Antenna + LNA         │
│  (requires 5V DC power)     │
└────────────┬────────────────┘
             │
          [Bias Tee]
             │
        ┌────┴─────┐
        │           │
    RF Signal    5V Power
        │           │
        └────┬─────┘
             │
        [RTL-SDR]
```

The [[RTL-SDR]] sends 5V DC down the cable; the bias tee separates it at the antenna. RF signals travel freely; DC power never reaches the receiver's RF circuits.

---

### Antenna Impedance Matching & Ground Plane
**Analogy**: Imagine throwing a ball at a wall—if the wall is solid, it bounces perfectly. If the wall has cracks, the bounce is chaotic. A [[ground plane]] under an antenna is like that solid wall for electromagnetic waves.

**Definition**: A [[ground plane]] is a large conductive surface (metal sheet or table) beneath an antenna that acts as an electromagnetic mirror. It improves [[directivity]], reduces multipath reflections, and ensures consistent [[impedance matching]]. GPS antennas often include a magnetic mount specifically to clamp to metal surfaces.

**Practical Effect**:
- Without ground plane: ~40% signal loss, erratic reception
- With 12"×12" metal table: Predictable hemispherical reception pattern
- Professional setups: 24"+ copper or aluminum plate

---

### Receiver Gain Configuration
**Analogy**: A microphone in a quiet recording studio can be turned up high to catch whispers; the same microphone at a rock concert must be turned down or it distorts. Gain isn't "always turn it up"—it's "turn it up until you capture the signal without breaking it."

**Definition**: [[Receiver gain]] on an [[RTL-SDR]] controls the amplification of incoming RF signals before [[analog-to-digital conversion]]. For satellite signals, gain must be maximized *without* causing [[ADC saturation]] or [[intermodulation distortion]].

**GPS-Specific Gain Strategy**:

| Gain Setting | Effect | GPS Context |
|---|---|---|
| 0 dB | No amplification | Signal lost in noise floor |
| 20–30 dB | Moderate boost | Marginal detection indoors |
| 40–50 dB | Maximum (typical RTL) | Optimal for weak satellite signals |
| >50 dB | Distortion risk | Introduces spurious signals |

Most [[GNU Radio]] GPS receiver flowgraphs set the [[RTL-SDR]] gain to **maximum (49.6 dB on most RTL2832U devices)** to compensate for the 140+ dB path loss over 22,000 km of satellite range.

---

### Signal-to-Noise Ratio (CNR / C/N₀)
**Analogy**: Standing in a crowded coffee shop, a friend's voice (signal) competes with background chatter (noise). Your ability to understand them depends on how much louder they are than the crowd. That difference is SNR.

**Definition**: [[Signal-to-Noise Ratio]] (SNR) or [[Carrier-to-Noise density]] (C/N₀) measures how far above the [[noise floor]] your desired signal sits. GPS signals are extremely weak (typically C/N₀ ≈ 35–50 dB-Hz for good satellite geometry).

**Formula**:
```
C/N₀ (dB-Hz) = 10 × log₁₀(Pₛᵢgnₐₗ / Pₙₒᵢsₑ)
```

**Observable Metric in GPS Test Apps**:
- <30 dB-Hz: Marginal, may lose lock
- 30–40 dB-Hz: Weak but usable
- 40–50 dB-Hz: Good reception
- >50 dB-Hz: Excellent (clear sky, optimal geometry)

[[Elevation angle]] and [[satellite geometry]] heavily influence this—satellites at 80° above horizon have 3–4 dB higher C/N₀ than those at 10° elevation.

---

### Satellite Geometry & Elevation Angle
**Analogy**: Trying to hear someone whisper through a thick door is harder than hearing them across an open field. A satellite directly overhead sends a stronger, clearer path than one on the horizon.

**Definition**: [[Elevation angle]] is the angle above the horizon at which a satellite appears. [[Ionospheric attenuation]], [[multipath]], and [[path loss]] all worsen as elevation decreases. At 5° elevation, the signal travels through ~30× more atmosphere than at 90° (zenith).

**Critical Receiver Design Implication**:
- **Zenith (90°)**: ~−161 dBm received power, ~45 dB-Hz CNR
- **5° Elevation**: ~−167 dBm received power, ~39 dB-Hz CNR
- **Below horizon**: Signal completely blocked

Professional GPS receivers track satellites above 10–15° elevation; hobbyist RTL-SDR systems require 20°+ for reliable decoding.

---

## Hands-On Application

### Setup & Hardware Chain

1. **Antenna Placement**: Mount a [[SAW filter|SAW-filtered]] GPS antenna (active 1575 MHz, ~$10–15) on a metal ground plane in an open-air location away from buildings and large reflectors.

2. **Cable Routing**: Connect antenna → [[Bias Tee]] → [[RTL-SDR]] USB adapter. Position the RTL-SDR as far as practical from the laptop to reduce CPU noise coupling into the RF chain.

3. **GNU Radio Flowgraph Configuration**:
   - [[RTL-SDR source]] block: Set gain to maximum, tuner frequency to **1575.42 MHz** (GPS L1 center)
   - [[Low Pass Filter]]: 4 MHz bandwidth (captures ±2 MHz around carrier)
   - [[AGC block]]: Enable to prevent [[ADC clipping]]
   - [[Correlator]] or [[DLL lock detector]]: Tracks spreading code phase

4. **Real-Time Signal Inspection**:
   - Use [[FFT sink]] to visualize the GPS band. You should see a flat, noise-like spectrum with slight 100× elevation if LNA is working.
   - Use [[Waterfall display]] to confirm signal stability over time (no sudden dropouts indicate multipath fading).

5. **Verification with Mobile App**:
   - Run a reference GPS app ([[GPS Test]] on Android, [[Satellite Insight]] on iOS) simultaneously to confirm which satellites should be visible. Cross-check their [[PRN numbers]] and C/N₀ values against your GNU Radio receiver's decoded output.

---

## Lab Exercise

**What you need**:
- [[RTL-SDR]] v3 or compatible [[Software Defined Radio|SDR]] dongle
- Active GPS antenna with [[Bias Tee]] support (~$15–30)
- [[GNU Radio]] 3.9+ installation
- [[GPS receiver flowgraph]] (available on git repositories or GNU Radio Companion template)
- Outdoor location with clear sky (minimum 120° horizon coverage)
- Mobile GPS test app for reference

**Goal**: Decode GPS signals from at least 4 satellites, extract their [[C/N₀]] values, and verify that your receiver's [[DOP]] (dilution of precision) and position estimate match a reference GPS receiver within 10 meters.

**Steps**:

1. **Initial Reconnaissance (5 min)**
   - Open GPS Test app or similar. Identify the 3–4 highest-elevation [[PRN|PRN-numbered]] satellites currently visible.
   - Record their C/N₀, elevation, and azimuth angles. These become your target signals.

2. **Tune & Acquire (10 min)**
   - Launch GNU Radio flowgraph with [[RTL-SDR source]] tuned to 1575.42 MHz, gain set to 49.6 dB.
   - Observe the FFT display. You should see a raised noise floor (2–3 dB above empty-band baseline) across ±2 MHz—this is the combined GPS signal from all visible satellites.
   - Confirm the [[Bias Tee]] is powering the antenna: antenna gain should suddenly drop if power is disconnected (deliberate test, then restore).

3. **Decode & Lock (15 min)**
   - The [[correlator]] block searches across all 32 GPS [[PRN codes]] (1023-chip sequences) to find matches.
   - As each satellite is acquired, its **code phase** and **Doppler offset** are refined via [[PLL lock|phase lock loop]].
   - Observe the console output: each line should show PRN, C/N₀, Doppler, and code phase for locked satellites.

4. **Cross-Validate (5 min)**
   - Compare your decoded PRNs and C/N₀ values against the reference app.
   - **Observable outcome**: Your receiver should detect 4–8 satellites; C/N₀ values should match within ±2 dB (differences account for antenna response and filtering differences).

5. **Position Solution (5 min)**
   - Once 4+ satellites are locked, the receiver's [[navigation filter]] computes position, velocity, and time.
   - Export the [[NMEA sentence]] (or proprietary format) from the flowgraph.
   - Compare lat/lon with your reference phone GPS. **Expected accuracy**: 5–15 meters (multipath effects in urban/semi-urban environments).

**What This Demonstrates**:
- [[RF front-end gain]] and [[noise figure]] management in practice
- The relationship between satellite geometry and signal strength
- How [[spread spectrum]] code detection works to extract signals below the noise floor
- The end-to-end chain from radio wave → digital bits → geolocation

---

## Related Topics
- [[RTL-SDR]]
- [[GNU Radio]]
- [[Low Noise Amplifier]] (LNA)
- [[Bias Tee]]
- [[GNSS