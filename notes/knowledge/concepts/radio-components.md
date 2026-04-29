# radio-components

## What it is
Like the organs of a human body — each serving a distinct function to keep the whole system alive — radio components are the discrete hardware elements that together enable wireless signal transmission and reception. Precisely: they are the physical building blocks of RF systems, including antennas, oscillators, amplifiers, mixers, filters, and Software Defined Radio (SDR) chipsets that convert electrical signals to electromagnetic waves and back.

## Why it matters
In a rogue access point attack, an adversary uses a cheap RTL-SDR dongle (under $30) combined with commodity amplifiers and a directional antenna to impersonate legitimate Wi-Fi infrastructure — the specific combination of components determines attack range, signal fidelity, and detection difficulty. Defenders doing RF spectrum analysis must understand which components produce telltale signal artifacts (like oscillator drift) that fingerprint malicious transmitters.

## Key facts
- **Antennas** are characterized by gain (dBi) and directionality — a high-gain Yagi antenna can extend attack range to kilometers for targeted eavesdropping
- **SDR (Software Defined Radio)** replaces hardwired analog components with software-configurable digital processing, enabling tools like GNU Radio to decode GSM, Bluetooth, Zigbee, and ADS-B signals from one device
- **Oscillators** generate carrier frequencies; instability (frequency drift) is an RF fingerprinting indicator used to identify specific physical devices
- **Mixers** perform frequency translation — critical in both legitimate radio design and signal interception attacks that down-convert high-frequency RF to baseband for analysis
- **Faraday cages** (conductive enclosures) block RF signals by preventing electromagnetic waves from passing through — a hardware-layer defense relevant to TEMPEST/emanation security

## Related concepts
[[software-defined-radio]] [[rf-jamming]] [[wireless-attacks]] [[tempest-emanations]] [[signal-intelligence]]