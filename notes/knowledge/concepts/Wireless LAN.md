# Wireless LAN

## What it is
Think of a Wireless LAN like a coffee shop where conversations travel through the air instead of through private phone lines — anyone nearby can potentially hear you unless you're whispering in code. Precisely, a Wireless LAN (WLAN) is a local area network that uses radio frequency (RF) signals, governed by IEEE 802.11 standards, to connect devices to an access point (AP) without physical cables.

## Why it matters
During a penetration test, an attacker parks outside a corporate office and uses a directional antenna to capture WPA2 handshakes from employee devices. Those handshakes are then subjected to offline dictionary attacks using tools like Hashcat, potentially exposing network credentials without ever setting foot inside the building — a realistic threat that purely wired networks eliminate entirely.

## Key facts
- **802.11 protocol family**: 802.11a/b/g/n/ac/ax define speeds and frequencies; 802.11ac (Wi-Fi 5) and 802.11ax (Wi-Fi 6) are the current dominant standards
- **WPA3** is the current recommended encryption standard, replacing WPA2's vulnerable 4-way handshake with Simultaneous Authentication of Equals (SAE), which resists offline dictionary attacks
- **Evil Twin attacks** involve rogue APs broadcasting a legitimate SSID to intercept credentials; mitigated by 802.1X/EAP enterprise authentication
- **WPS (Wi-Fi Protected Setup)** contains a known PIN vulnerability allowing brute-force in ~11,000 attempts — it should be **disabled** on all enterprise equipment
- **Channel overlap** on 2.4 GHz (only channels 1, 6, 11 are non-overlapping) is a vector for interference-based DoS attacks

## Related concepts
[[WPA3]] [[Evil Twin Attack]] [[802.1X Authentication]] [[Rogue Access Point]] [[War Driving]]