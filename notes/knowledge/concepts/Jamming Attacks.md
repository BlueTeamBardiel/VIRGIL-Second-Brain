# Jamming Attacks

## What it is
Like a heckler screaming into a megaphone during a lecture until no one can hear the professor, a jamming attack floods a wireless channel with noise or competing signals to prevent legitimate communication. It is a Denial-of-Service attack targeting the physical (Layer 1) or data link layer of wireless networks by overwhelming the radio frequency spectrum with interference, rendering the medium unusable.

## Why it matters
In 2011, Iranian forces reportedly used GPS jamming to spoof and land a U.S. RQ-170 Sentinel drone by disrupting its navigation signals. Beyond military contexts, attackers can jam 433 MHz frequencies used by home alarm systems to silently disable wireless sensors before a burglary — the alarm never triggers because its signals never reach the base station.

## Key facts
- **Types include:** constant jamming (continuous noise), deceptive jamming (injecting fake packets), reactive jamming (activates only when transmission is detected), and random jamming (alternates between active and sleep states to conserve attacker resources)
- **Reactive jamming is the hardest to detect** because it only activates during legitimate transmissions, mimicking natural interference
- **Countermeasures include:** Frequency Hopping Spread Spectrum (FHSS), Direct Sequence Spread Spectrum (DSSS), and increasing transmission power — FHSS rapidly switches channels, making targeted jamming extremely difficult
- **802.11 Wi-Fi networks** are vulnerable because they operate on shared, unlicensed spectrum (2.4 GHz / 5 GHz); a cheap software-defined radio can generate enough interference to collapse a local network
- **Detection methods** include monitoring carrier-sense values, packet delivery ratios, and signal-to-noise ratio (SNR) anomalies — sudden SNR drops without environmental cause indicate active jamming

## Related concepts
[[Denial of Service]] [[Frequency Hopping Spread Spectrum]] [[Wireless Network Security]] [[Radio Frequency Interference]] [[GPS Spoofing]]