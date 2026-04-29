# WPA2 4-way handshake

## What it is
Like two strangers proving they both know a secret password by exchanging coded challenges — without ever whispering the actual password aloud — the 4-way handshake is a mutual authentication protocol between a Wi-Fi client and access point. It derives and confirms a fresh session encryption key (the PTK) using a shared secret (the PMK) without transmitting that secret over the air. The exchange happens in four EAPOL message frames immediately after a client associates with a WPA2 network.

## Why it matters
An attacker using a tool like **hcxdumptool** or **airodump-ng** can passively capture the 4-way handshake frames, then run an offline dictionary attack (with **hashcat** or **aircrack-ng**) against the captured hash to crack the Wi-Fi password — no active connection to the network required. This is the dominant attack vector against home and small-business WPA2 networks, making strong, random pre-shared keys a critical defense.

## Key facts
- The four messages confirm that both the client and AP hold the same PMK (Pairwise Master Key), derived from the SSID and passphrase via PBKDF2-SHA1 with 4096 iterations
- Message 1 and 2 exchange nonces (ANonce, SNonce) used to derive the **PTK** (Pairwise Transient Key), which is session-specific
- The PTK is broken into sub-keys: KCK (confirmation), KEK (encryption), and TK (actual traffic encryption)
- **Deauthentication attacks** (sending forged 802.11 deauth frames) force clients to re-associate, generating a fresh capturable handshake on demand
- WPA3 replaces the PSK-based handshake with **SAE (Simultaneous Authentication of Equals)**, which provides forward secrecy and resists offline dictionary attacks

## Related concepts
[[PMK and PTK Key Hierarchy]] [[WPA3 SAE]] [[Deauthentication Attack]] [[PBKDF2]] [[Evil Twin Attack]]