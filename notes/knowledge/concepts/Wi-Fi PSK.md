# Wi-Fi PSK

## What it is
Like a secret handshake at a club door — everyone who knows the phrase gets in, and the bouncer never asks *who* you are. Wi-Fi Pre-Shared Key (PSK) is a symmetric authentication method where a single passphrase is shared among all users of a wireless network. The passphrase is used to derive the Pairwise Master Key (PMK), which seeds the 4-way handshake that establishes per-session encryption keys.

## Why it matters
During the 4-way handshake, both parties exchange nonces (ANonce and SNonce) in cleartext over the air. An attacker running `airodump-ng` can capture this handshake passively, then run the captured data against a wordlist using `hashcat` — cracking a weak passphrase entirely offline without ever alerting the network. This is why "WiFi123" on a WPA2-PSK network is a death sentence for confidentiality.

## Key facts
- **WPA2-PSK** uses PBKDF2 with HMAC-SHA1 (4096 iterations) to derive the 256-bit PMK from the passphrase and SSID — the SSID is part of the derivation, making rainbow tables SSID-specific.
- **WPA3-SAE** (Simultaneous Authentication of Equals) replaces PSK with a Dragonfly handshake, eliminating offline dictionary attacks by requiring live interaction per attempt.
- Capturing a **4-way handshake** is sufficient for offline cracking; the attacker can force a re-handshake by sending deauth frames (IEEE 802.11 deauthentication attack).
- **PMKID attacks** (discovered 2018) allow cracking WPA2-PSK without capturing a full handshake — just the first EAPOL frame from the AP is enough.
- Enterprise networks replace PSK with **802.1X/EAP**, issuing per-user credentials so compromising one password doesn't expose every client.

## Related concepts
[[WPA2]] [[4-Way Handshake]] [[802.1X EAP]] [[Deauthentication Attack]] [[PBKDF2]]