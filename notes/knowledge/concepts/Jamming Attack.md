# Jamming Attack

## What it is
Like a heckler screaming nonsense into a megaphone at a town hall meeting — nobody can hear the speaker anymore. A jamming attack floods a wireless communication channel with radio frequency (RF) noise or interference, preventing legitimate devices from transmitting or receiving signals. It is a Denial of Service (DoS) attack targeting the physical (Layer 1) or data link layer of the OSI model.

## Why it matters
In 2011, Iranian military forces reportedly used GPS jamming to spoof and capture a U.S. RQ-170 Sentinel drone by overpowering its GPS signal and feeding false navigation data. Defenders counter jamming through spread-spectrum techniques like Frequency Hopping Spread Spectrum (FHSS), which rapidly switches frequencies making sustained interference extremely difficult to maintain.

## Key facts
- **Types**: Constant jamming (continuous noise), Deceptive jamming (replays valid signals to confuse receivers), Reactive jamming (only transmits interference when it detects traffic — harder to detect)
- **Targets**: Wi-Fi (2.4 GHz / 5 GHz), GPS (1.575 GHz), cellular networks, and Bluetooth — any RF-dependent protocol
- **Detection indicators**: Sudden unexplained signal loss across multiple devices, unusually high noise floor on spectrum analyzers
- **Countermeasures**: FHSS, Direct Sequence Spread Spectrum (DSSS), directional antennas to isolate signal, and physical shielding (Faraday cages)
- **Legal status**: Transmitting jamming signals is illegal in the U.S. under FCC regulations (47 U.S.C. § 333), regardless of intent

## Related concepts
[[Denial of Service (DoS)]] [[Wireless Security]] [[Frequency Hopping Spread Spectrum (FHSS)]] [[GPS Spoofing]] [[RF Interference]]