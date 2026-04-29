# evil twin attack

## What it is
Imagine a con artist setting up a fake passport control booth next to the real one — same uniforms, same forms, but everything you hand over goes straight to the thief. An evil twin attack works the same way: an attacker creates a rogue wireless access point that mimics a legitimate one (same SSID, often stronger signal), tricking nearby devices into connecting to it instead. Once connected, the attacker sits in the middle of all victim traffic.

## Why it matters
At a busy airport, an attacker runs a laptop with a Wi-Fi card broadcasting "AirportFreeWifi" — identical to the real network. Travelers auto-connect, and the attacker captures session cookies, credentials, and plaintext HTTP traffic in real time. Defense relies on using a VPN over untrusted networks and disabling auto-connect to open SSIDs on mobile devices.

## Key facts
- An evil twin is a specific form of a **rogue access point**, distinguished by intentionally cloning a legitimate SSID and BSSID (MAC address) to deceive clients
- Attackers often use **deauthentication (deauth) frames** to knock clients off the real AP, forcing them to reconnect to the evil twin
- The attack enables **on-path (man-in-the-middle)** interception, SSL stripping, and credential harvesting
- Detection methods include **wireless intrusion detection systems (WIDS)** that flag duplicate SSIDs with differing BSSIDs on the same channel
- **802.1X / EAP-based enterprise networks** are more resistant because mutual authentication prevents clients from connecting to unauthenticated APs

## Related concepts
[[rogue access point]] [[man-in-the-middle attack]] [[deauthentication attack]] [[SSL stripping]] [[wireless intrusion detection system]]