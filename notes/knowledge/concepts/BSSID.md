# BSSID

## What it is
Like a MAC address tag stapled to a specific router's radio antenna, a BSSID (Basic Service Set Identifier) is the hardware address that uniquely identifies a single wireless access point within a network. It is a 48-bit value formatted exactly like a MAC address (e.g., `AA:BB:CC:DD:EE:FF`) and is broadcast in every 802.11 beacon frame an AP transmits.

## Why it matters
Attackers use BSSID spoofing to run **evil twin attacks** — cloning a legitimate AP's BSSID *and* SSID to create an indistinguishable rogue access point. When a victim's device auto-connects (trusting a remembered network), the attacker performs a man-in-the-middle, intercepting credentials, session tokens, and unencrypted traffic. Defenders monitor for duplicate BSSIDs on wireless intrusion detection systems (WIDS) as a primary evil twin indicator.

## Key facts
- A BSSID is the MAC address of the AP's wireless radio interface — not the device's wired MAC address
- Unlike SSIDs (human-readable names), BSSIDs are meant to be hardware-unique, but can be trivially spoofed with software tools like `macchanger` or `airbase-ng`
- One physical AP can broadcast **multiple BSSIDs** when hosting multiple SSIDs (virtual APs), each SSID gets its own BSSID
- Beacon frames containing the BSSID are broadcast approximately **10 times per second** by default, making passive discovery trivial with tools like `airodump-ng`
- WPA2/WPA3 handshakes capture includes the BSSID — used in offline cracking to confirm which network a captured handshake belongs to

## Related concepts
[[Evil Twin Attack]] [[Rogue Access Point]] [[SSID]] [[802.11 Beacon Frame]] [[Wireless Intrusion Detection System]]