# WPA2

## What it is
Think of WPA2 like a bank vault with a combination lock — the combination is derived from your password, but the actual locking mechanism (AES) is so strong that guessing the contents by rattling the door is essentially useless. Formally, WPA2 (Wi-Fi Protected Access 2) is a wireless security protocol defined by IEEE 802.11i that uses AES-CCMP for encryption and replaces the broken RC4-based WEP and TKIP schemes used in WPA1.

## Why it matters
In a WPA2-Personal (PSK) network, an attacker who captures the four-way handshake during a client's association can take that handshake offline and run a dictionary or brute-force attack against it — no need to stay on the network. Tools like `hashcat` with a GPU can crack weak passphrases in minutes, which is exactly why "CompanyWifi2014" is a catastrophic password choice even on a "secure" WPA2 network.

## Key facts
- **Two modes:** WPA2-Personal uses a Pre-Shared Key (PSK); WPA2-Enterprise uses 802.1X/EAP with a RADIUS server for per-user authentication.
- **Encryption:** Uses AES with CCMP (Counter Mode CBC-MAC Protocol), providing both confidentiality and integrity.
- **Four-way handshake:** Establishes session keys (PTK) without transmitting the actual PSK over the air — but the handshake itself can be captured and attacked offline.
- **KRACK vulnerability (2017):** Key Reinstallation Attack allows nonce reuse by replaying handshake messages, breaking confidentiality without knowing the passphrase.
- **Replaced by WPA3** (2018), which adds SAE (Simultaneous Authentication of Equals) to prevent offline dictionary attacks entirely.

## Related concepts
[[WPA3]] [[802.1X Authentication]] [[RADIUS]] [[Four-Way Handshake]] [[KRACK Attack]]