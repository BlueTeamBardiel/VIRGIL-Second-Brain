# Beacon Frame

## What it is
Like a lighthouse flashing its name and location every few seconds so ships know it exists, a beacon frame is a management frame broadcast by a wireless access point approximately 10 times per second to advertise its presence. It contains the SSID, supported data rates, encryption capabilities, and timing synchronization information so nearby clients can discover and join the network.

## Why it matters
Attackers use beacon frames as the foundation of evil twin attacks: a rogue AP broadcasts beacon frames with the same SSID as a legitimate network, luring clients to connect to attacker-controlled infrastructure where credentials and traffic can be intercepted. Defenders monitor for unexpected beacon frames on authorized SSIDs using wireless intrusion detection systems (WIDS) to catch these rogue APs before users connect.

## Key facts
- Beacon frames are transmitted on all channels by the AP at roughly **100ms intervals** (10 beacons/second) and are always sent unencrypted, even on WPA3 networks
- The **SSID field can be set to null** (empty/hidden), but the AP still broadcasts the beacon — tools like Wireshark or airodump-ng reveal the frame exists even if the name is suppressed
- Beacon frames are **802.11 management frames** (subtype 0x08) and are not authenticated or encrypted by default, making spoofing trivial
- **WPA2/3 capability flags** inside beacon frames tell attackers exactly what security suite the network uses before any association attempt
- Capturing beacon frames is the **first step in wireless reconnaissance**; tools like airodump-ng display BSSID, channel, encryption type, and SSID all parsed from beacon content

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[Wireless Intrusion Detection System]] [[802.11 Management Frames]] [[SSID]]