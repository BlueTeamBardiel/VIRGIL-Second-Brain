# WPA3

## What it is
Think of WPA2 as a combination lock where someone can photograph the dial spinning and crack it at home — WPA3 replaces that with a lock that *forgets* the combination after each use. WPA3 (Wi-Fi Protected Access 3) is the 2018 IEEE 802.11 wireless security standard that replaces WPA2, introducing Simultaneous Authentication of Equals (SAE) to replace the vulnerable Pre-Shared Key (PSK) handshake and providing forward secrecy by default.

## Why it matters
WPA2 networks are vulnerable to offline dictionary attacks: an attacker captures the 4-way handshake, walks away, and brute-forces the password on a GPU farm indefinitely. WPA3's SAE handshake eliminates this entirely — even if an attacker captures the exchange and later learns the password, they cannot decrypt past sessions because each session generates a unique encryption key (forward secrecy). This directly neutralizes the KRACK attack class that devastated WPA2 deployments.

## Key facts
- **SAE (Dragonfly handshake)** replaces PSK, preventing offline dictionary attacks by requiring real-time interaction to test each password guess
- **WPA3-Personal** uses 128-bit encryption; **WPA3-Enterprise** mandates 192-bit encryption (CNSA suite), targeting government and high-security environments
- **Forward secrecy**: unique session keys mean captured traffic cannot be decrypted even if the long-term password is later compromised
- **OWE (Opportunistic Wireless Encryption)** is part of the WPA3 ecosystem — it encrypts open networks (coffee shops) without requiring a password
- **Dragonblood vulnerabilities** (2019) revealed side-channel attacks against SAE itself, proving WPA3 is stronger but not perfect

## Related concepts
[[WPA2]] [[SAE (Simultaneous Authentication of Equals)]] [[Forward Secrecy]] [[4-Way Handshake]] [[KRACK Attack]]