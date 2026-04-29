# WPA2-Personal

## What it is
Think of it like a neighborhood gate where every resident uses the same key — simple, but if one person loses their copy, everyone's potentially exposed. WPA2-Personal (also called WPA2-PSK) is a Wi-Fi security protocol that uses a single pre-shared key (PSK) shared among all users, protecting traffic with AES-CCMP encryption derived from the 4-way handshake between client and access point.

## Why it matters
An attacker within range can capture the 4-way handshake when any client connects to the network, then take it offline and run dictionary or brute-force attacks using tools like Hashcat or aircrack-ng — never touching the network again. This is exactly why using "password123" on a home router or a small business Wi-Fi is catastrophic: the captured handshake can be cracked in minutes on commodity hardware with common wordlists.

## Key facts
- Uses **AES-CCMP** as its encryption cipher (TKIP is legacy/deprecated and considered insecure)
- Authentication relies on a **Pre-Shared Key (PSK)** — all devices share the same passphrase, unlike WPA2-Enterprise which uses 802.1X/RADIUS per-user credentials
- The **4-way handshake** is the attack surface: capturing it offline enables passive cracking without further network interaction
- Vulnerable to **PMKID attacks** (a newer technique allowing cracking without waiting for a client to reconnect)
- WPA2-Personal does **not** provide forward secrecy — compromising the PSK can decrypt previously captured traffic
- **WPA3-Personal** addresses these weaknesses using SAE (Simultaneous Authentication of Equals), which resists offline dictionary attacks

## Related concepts
[[WPA3-Personal]] [[4-Way Handshake]] [[Pre-Shared Key (PSK)]] [[WPA2-Enterprise]] [[PMKID Attack]]