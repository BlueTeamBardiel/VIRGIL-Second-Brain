# fiber-optic

## What it is
Like water flowing through a glass pipe using only the pipe's walls to stay on course, fiber-optic cables transmit data as pulses of light through thin glass or plastic strands using total internal reflection. Unlike copper cables that carry electrical signals, fiber-optic cables are immune to electromagnetic interference and do not emit radio frequency (RF) signals that can be intercepted from a distance.

## Why it matters
Fiber-optic cables were long considered physically tap-proof, but the "FiberTap" attack demonstrated that bending a fiber cable causes light to leak outward — a device clamped onto the cable can capture that leaked light and reconstruct the data stream without cutting or interrupting the signal. This passive, undetected interception technique has been used in nation-state espionage operations targeting submarine transatlantic cables, prompting organizations to treat physical cable security as a critical layer of defense.

## Key facts
- Fiber is resistant to **electromagnetic eavesdropping** (no RF emissions), making it preferred for high-security environments over copper cabling
- **Bend-radius attacks** (macro-bending) can intercept traffic without breaking the optical signal — no packet loss alerts are generated
- Fiber supports significantly higher bandwidth and longer transmission distances than copper (100+ km without amplification for single-mode fiber)
- **Single-mode fiber** carries one light wavelength and is used for long-distance, high-security links; **multi-mode fiber** supports shorter distances with multiple wavelengths simultaneously
- Physical tamper detection systems (e.g., OTDR — Optical Time Domain Reflectometry) can identify splices or bends on a fiber line and are a compensating control against tap attacks

## Related concepts
[[physical security]] [[wiretapping]] [[network segmentation]]