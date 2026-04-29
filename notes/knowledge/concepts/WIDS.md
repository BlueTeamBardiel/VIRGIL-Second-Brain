# WIDS

## What it is
Like a security guard who memorizes every face in a building and sounds the alarm when a stranger in a hoodie starts trying every door handle, a Wireless Intrusion Detection System watches all RF traffic on your airspace and alerts when something doesn't belong. WIDS is a dedicated system that monitors wireless networks for unauthorized access points, rogue devices, and attack patterns like deauthentication floods or evil twin attempts. Unlike a firewall, it doesn't block — it watches, logs, and alerts.

## Why it matters
During a red team engagement, an attacker sets up a rogue access point near the lobby broadcasting the same corporate SSID to harvest credentials from employees auto-connecting. A properly deployed WIDS detects the duplicate SSID broadcasting from an unrecognized BSSID (MAC address), triggers an alert, and allows the security team to physically locate and neutralize the device before credentials are compromised.

## Key facts
- WIDS detects **rogue APs**, **evil twins**, **deauthentication (deauth) attacks**, and **ad-hoc networks** that violate policy
- Operates by placing sensors in **monitor mode** — passively capturing all 802.11 frames without associating to any network
- Can identify **MAC spoofing** attempts by analyzing inconsistencies in frame timing, sequence numbers, and radio fingerprinting
- **WIPS** (Wireless Intrusion *Prevention* System) is the active counterpart — it can inject deauth frames to disconnect rogue devices (verify legal/policy approval first)
- On Security+/CySA+: WIDS is categorized under **network security monitoring controls** and is relevant to detecting **Layer 2 wireless attacks**

## Related concepts
[[Rogue Access Point]] [[Evil Twin Attack]] [[Deauthentication Attack]] [[WIPS]] [[802.11 Protocol]]