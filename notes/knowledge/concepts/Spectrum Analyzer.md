# Spectrum Analyzer

## What it is
Like a hospital EKG that turns a heartbeat into a readable waveform, a spectrum analyzer converts invisible radio frequency (RF) signals into a visual graph showing signal strength across a range of frequencies. Precisely, it is a hardware or software tool that measures the amplitude of signals across a defined frequency band, displaying power (dBm) versus frequency in real time.

## Why it matters
During a wireless penetration test or rogue device hunt, a security team can use a spectrum analyzer to detect unauthorized transmitters — including hidden cameras, wireless bugs, or rogue access points — that a standard Wi-Fi scanner would miss because they operate outside 802.11 channels. For example, a Bluetooth jammer or a 5.8 GHz covert transmitter broadcasting inside a secure facility would appear as an anomalous spike on the spectrum display, revealing both its presence and approximate location through signal triangulation.

## Key facts
- Spectrum analyzers display **frequency on the X-axis** and **signal power (dBm) on the Y-axis**, making interference and rogue transmissions visually obvious.
- Tools like **Wi-Spy** or **HackRF One** paired with software such as **Kismet** or **GQRX** give attackers and defenders software-defined spectrum analysis capabilities.
- Used in **RF site surveys** to identify channel congestion, co-channel interference, and non-802.11 interference sources (microwaves, baby monitors, Bluetooth).
- Critical for detecting **frequency-hopping spread spectrum (FHSS)** devices that evade traditional packet-capture tools by rapidly changing frequencies.
- On Security+/CySA+ exams, spectrum analyzers appear under **wireless security assessment tools**, distinct from protocol analyzers (Wireshark), which decode packet content rather than raw RF energy.

## Related concepts
[[Wireless Site Survey]] [[Software-Defined Radio]] [[Rogue Access Point]] [[RF Jamming]] [[Kismet]]