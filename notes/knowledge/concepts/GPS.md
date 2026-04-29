# GPS

## What it is
Like a lighthouse network in space, GPS lets your device triangulate its position by measuring how long it takes signals from multiple satellites to arrive. Formally, GPS (Global Positioning System) is a satellite-based radio navigation system operated by the U.S. Space Force that provides location, velocity, and time data to receivers anywhere on Earth. Civilian GPS signals are unencrypted and unauthenticated by default.

## Why it matters
GPS spoofing attacks — where an attacker broadcasts counterfeit GPS signals stronger than the real ones — can redirect ships, drones, or autonomous vehicles to false locations. In 2019, vessels in the Black Sea reported being "teleported" to an inland airport by spoofed signals, demonstrating how critical infrastructure can be physically manipulated through radio frequency attacks. Defenders counter this with multi-constellation receivers (using GPS + GLONASS + Galileo), signal anomaly detection, and inertial navigation cross-checks.

## Key facts
- **GPS spoofing** transmits fake satellite signals to deceive a receiver; **GPS jamming** simply overwhelms legitimate signals with noise — both are illegal under FCC regulations in the U.S.
- Civilian GPS uses the L1 frequency (1575.42 MHz) and is unencrypted; military GPS uses encrypted P(Y)-code signals resistant to spoofing
- GPS time signals (accurate to ~20–30 nanoseconds) are used to timestamp financial transactions, cellular handoffs, and SIEM log synchronization — corrupting GPS time can cause cascading authentication failures
- GPS data feeds into **geofencing** controls used in mobile device management (MDM) and location-based access policies
- A **Faraday cage** or GPS jammer blocks GPS reception entirely, which can be used maliciously to disable tracking on stolen assets or vehicles

## Related concepts
[[Radio Frequency (RF) Attacks]] [[Signal Jamming]] [[Geofencing]] [[NTP Security]] [[Spoofing Attacks]]