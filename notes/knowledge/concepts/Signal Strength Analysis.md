# Signal Strength Analysis

## What it is
Like a detective triangulating a gunshot by how loud it sounds from different rooftops, signal strength analysis measures radio frequency (RF) power levels to determine the location, identity, or behavior of wireless transmitters. Precisely defined, it is the process of measuring Received Signal Strength Indicator (RSSI) values from wireless devices to map coverage, detect rogue access points, or geolocate unknown transmitters.

## Why it matters
In a rogue access point attack, an adversary plants an unauthorized WAP inside a corporate building. Security teams use signal strength analysis to physically locate it — a device appearing at -30 dBm on three different sensors can be triangulated to a specific room, exposing the attacker's hardware before credentials are harvested.

## Key facts
- **RSSI scale**: Values typically range from 0 dBm (strongest) to -100 dBm (weakest); -70 dBm is generally the minimum acceptable threshold for reliable enterprise Wi-Fi.
- **Trilateration vs. Triangulation**: Signal strength uses *trilateration* (measuring distances via signal power from ≥3 points), not true triangulation (which requires angles).
- **Evil Twin detection**: Legitimate APs spoofed by evil twins often show anomalous RSSI patterns — two devices broadcasting the same SSID at different signal strengths signals an impersonation attempt.
- **War driving leverage**: Attackers combine RSSI readings with GPS coordinates to map enterprise wireless footprints, identifying weak-boundary access points as entry vectors.
- **RF fingerprinting**: Each wireless chipset emits subtle power variance signatures; forensic signal analysis can attribute transmissions to specific hardware models even without MAC addresses.

## Related concepts
[[Rogue Access Point Detection]] [[War Driving]] [[RF Fingerprinting]]