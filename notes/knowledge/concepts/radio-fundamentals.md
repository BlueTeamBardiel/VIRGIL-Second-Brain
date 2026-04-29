# radio-fundamentals

## What it is
Like ripples spreading across a pond when you drop a stone, radio waves are electromagnetic disturbances that propagate outward from a transmitter — except these ripples travel at the speed of light and carry encoded information. Precisely: radio communication uses modulated electromagnetic waves in the 3 Hz–300 GHz spectrum to transmit data wirelessly between a sender and receiver. Frequency determines range and penetration; amplitude and phase determine how data is encoded onto the carrier wave.

## Why it matters
An attacker with a software-defined radio (SDR) device costing under $30 can passively intercept unencrypted 433 MHz signals from key fobs, garage openers, or IoT sensors — then replay those signals to unlock a vehicle or building without ever touching a computer. Understanding radio fundamentals explains *why* replay attacks work (no challenge-response, no rolling code) and how defenses like frequency hopping and rolling codes specifically counter them.

## Key facts
- **Frequency vs. wavelength**: They are inversely proportional (λ = c/f). Lower frequencies travel farther and penetrate walls better; higher frequencies carry more bandwidth but attenuate quickly.
- **Modulation types**: AM (amplitude modulation) encodes data in signal strength; FM in frequency variation; digital schemes like QAM combine both for higher throughput (used in Wi-Fi).
- **ISM bands** (Industrial, Scientific, Medical) — 900 MHz, 2.4 GHz, 5 GHz — are unlicensed and heavily used by Wi-Fi, Bluetooth, and Zigbee, making them prime attack surfaces.
- **EIRP (Effective Isotropic Radiated Power)** is regulated by the FCC; exceeding legal limits is itself a legal violation and a red flag in wireless audits.
- **Half-duplex vs. full-duplex**: Most radios (walkie-talkies, 802.11 Wi-Fi) are half-duplex — they can't transmit and receive simultaneously on the same frequency, creating collision and jamming vulnerabilities.

## Related concepts
[[wireless-attacks]] [[software-defined-radio]] [[bluetooth-security]] [[jamming-and-interference]] [[802.11-protocols]]