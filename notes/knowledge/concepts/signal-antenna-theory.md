# signal-antenna-theory

## What it is
Like a megaphone that concentrates your voice in one direction versus shouting in a circle, an antenna shapes *where* and *how far* radio energy travels. Precisely defined: antenna theory describes how conductors convert electrical signals into electromagnetic waves (and vice versa), with characteristics like gain, directionality, polarization, and frequency range determining the effective range and coverage pattern of any wireless transmission.

## Why it matters
In a wardriving attack, an attacker replaces a standard omnidirectional Wi-Fi adapter antenna with a high-gain directional Yagi antenna, extending their effective capture range from ~100 meters to over 1 kilometer — letting them harvest WPA2 handshakes from a parking lot far outside a building's physical security perimeter. Defenders use this same principle to configure directional access point antennas that minimize signal bleed outside facility walls, reducing the physical attack surface of a wireless network.

## Key facts
- **Gain (dBi)** measures how much an antenna concentrates signal compared to an isotropic radiator; every +3 dBi roughly doubles effective radiated power in the targeted direction
- **Omnidirectional antennas** radiate in a 360° horizontal pattern — common in consumer APs but maximally exploitable by passive eavesdroppers at any azimuth
- **Directional antennas** (Yagi, parabolic dish) focus energy into a narrow beam; used offensively in targeted eavesdropping and defensively in point-to-point links
- **Polarization mismatch** (e.g., vertical vs. horizontal orientation) causes 20+ dB signal loss — an accidental defense sometimes exploited deliberately
- **EIRP (Effective Isotropic Radiated Power)** is the legal regulatory metric; the FCC caps 2.4 GHz EIRP at 36 dBm — relevant for compliance questions on Security+

## Related concepts
[[wireless-security]] [[wardriving]] [[rf-jamming]]