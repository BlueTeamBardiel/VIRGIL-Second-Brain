# Sub-GHz

## What it is
Think of it like a bass guitar versus a piccolo — Sub-GHz radio operates at frequencies below 1 GHz, where signals travel farther and penetrate walls better than higher-frequency WiFi or Bluetooth. Precisely, Sub-GHz refers to radio frequency (RF) communication bands (commonly 315 MHz, 433 MHz, 868 MHz, 915 MHz) used by low-power, long-range wireless devices. These frequencies are unlicensed ISM bands, meaning anyone can transmit on them with minimal regulation.

## Why it matters
A classic attack involves capturing and replaying the 433 MHz RF signal from a car key fob to unlock vehicles — a **replay attack** requiring no cryptographic knowledge, just a cheap SDR (Software Defined Radio) like a HackRF or Flipper Zero. Rolling code implementations (like KeeLoq) were designed to defeat this, but vulnerabilities in their implementation have been repeatedly exploited. Garage doors, SCADA sensors, weather stations, and implanted medical devices all commonly use Sub-GHz, making this attack surface much broader than most defenders realize.

## Key facts
- **Common frequencies**: 315 MHz (North America), 433 MHz (Europe/worldwide), 868 MHz (EU), 915 MHz (US ISM band)
- **Range advantage**: Sub-GHz signals can travel 1–2 km in open environments, far exceeding Bluetooth (~10m) or WiFi (~50m)
- **Flipper Zero** is a popular pentest tool capable of capturing, analyzing, and replaying Sub-GHz signals out of the box
- **Replay attacks** are the primary threat — capturing a fixed-code transmission and retransmitting it later to trigger the same action
- **Rolling codes** (also called hopping codes) are the main countermeasure, generating a new code each transmission — but implementation flaws remain a real vulnerability

## Related concepts
[[Replay Attack]] [[Software Defined Radio]] [[Radio Frequency Identification]] [[Physical Security]] [[Signal Jamming]]