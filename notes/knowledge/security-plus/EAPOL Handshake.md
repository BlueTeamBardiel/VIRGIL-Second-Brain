# EAPOL Handshake

## What it is
Think of it like two strangers proving their identities by simultaneously solving a puzzle only the right person could solve — neither side ever hands over the secret directly. EAPOL (Extensible Authentication Protocol over LAN) is the 4-way handshake Wi-Fi clients and access points use to derive and confirm a shared session key (the PTK) after initial authentication, using the pre-shared key or 802.1X credentials without transmitting them over the air.

## Why it matters
An attacker running `airodump-ng` can passively capture this handshake by monitoring a client joining a network, then feed the captured frames into `hashcat` for offline dictionary attacks. This is the core mechanic behind WPA2-PSK cracking — the handshake itself isn't broken, but a weak passphrase makes brute-force trivially fast on a GPU rig.

## Key facts
- The 4-way handshake uses **ANonce** (AP-generated) and **SNonce** (client-generated) combined with the PMK to derive the **PTK** (Pairwise Transient Key)
- **PMKID attacks** (discovered 2018) allow cracking WPA2 without capturing a full handshake — only a single frame from the AP is needed
- The handshake confirms both parties hold the correct PMK **without ever transmitting it**, using MIC (Message Integrity Code) verification
- Captured handshakes are stored in `.cap` files; tools like **hashcat** convert them to `.hc22000` format for cracking
- WPA3 replaces PSK-based EAPOL with **SAE (Simultaneous Authentication of Equals)**, which is resistant to offline dictionary attacks

## Related concepts
[[WPA2 Cracking]] [[Pre-Shared Key Authentication]] [[802.1X EAP]] [[PMK and PTK Key Hierarchy]] [[Deauthentication Attack]]