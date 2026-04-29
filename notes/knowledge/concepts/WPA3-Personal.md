# WPA3-Personal

## What it is
Like a secret handshake that changes every time you perform it — even if someone films the whole thing, they can't use the recording to fake it later. WPA3-Personal is the current Wi-Fi security standard for home and small business networks, replacing WPA2-Personal by using Simultaneous Authentication of Equals (SAE) instead of the older Pre-Shared Key (PSK) handshake. It provides forward secrecy, meaning captured traffic cannot be decrypted retroactively even if the password is later compromised.

## Why it matters
Under WPA2, an attacker could capture the four-way handshake from a distance, then take it offline and run billions of password guesses per second using tools like Hashcat — the network never knew the attack was happening. WPA3-Personal's SAE protocol requires active, real-time interaction with the access point for each authentication attempt, effectively strangling offline dictionary and brute-force attacks. This single change eliminates one of the most common real-world Wi-Fi attack vectors.

## Key facts
- **SAE (Dragonfly handshake)** replaces PSK; each authentication derives a fresh session key even when using the same passphrase
- **Forward secrecy** is built-in: session keys are not derivable from the long-term password, so previously captured traffic stays encrypted permanently
- **192-bit security mode** is available in WPA3-Enterprise (not Personal), using CNSA Suite algorithms for high-security environments
- **Transition mode** allows WPA2 and WPA3 clients to share a network, but downgrades the security guarantee for WPA2 devices
- **Dragonblood vulnerabilities** (2019) revealed side-channel attacks against SAE implementations — patched, but a reminder that protocol design ≠ flawless implementation
- Replaces **WPA2** (2004 standard); mandated by Wi-Fi Alliance for certified devices since **July 2020**

## Related concepts
[[WPA2-Personal]] [[SAE (Simultaneous Authentication of Equals)]] [[Offline Dictionary Attack]] [[Forward Secrecy]] [[Four-Way Handshake]]