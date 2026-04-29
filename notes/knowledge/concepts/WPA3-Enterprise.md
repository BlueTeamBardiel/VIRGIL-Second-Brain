# WPA3-Enterprise

## What it is
Think of WPA3-Enterprise as a corporate building where every employee gets a unique keycard issued by a central HR office — no shared master key exists that, if stolen, unlocks every door. Technically, it is a Wi-Fi security protocol that uses IEEE 802.1X authentication with a RADIUS server to issue per-user credentials, eliminating shared passphrases entirely. The strongest mode mandates 192-bit cryptographic security using GCMP-256, HMAC-SHA-384, and ECDH/ECDSA-384 for government and high-security environments.

## Why it matters
In 2017, the KRACK attack demonstrated that WPA2's 4-way handshake could be replayed to force nonce reuse and decrypt traffic — WPA3's Simultaneous Authentication of Equals (SAE) handshake eliminates this by making each session cryptographically independent. In a hospital network running WPA3-Enterprise, even if an attacker captures authentication traffic using a rogue access point, they cannot crack individual session keys or impersonate users without defeating the RADIUS server's certificate validation. The mandatory use of 802.1X means stolen credentials alone aren't enough — mutual certificate authentication must also succeed.

## Key facts
- Uses **802.1X/EAP** with a RADIUS server — no Pre-Shared Key (PSK) exists to steal
- **192-bit Security Mode** (Suite B) is required for government use; mandates GCMP-256 encryption and ECDH-384 key exchange
- **PMF (Protected Management Frames)** is mandatory, blocking deauthentication/disassociation spoofing attacks
- Mutual authentication prevents evil twin attacks — the client validates the server's certificate before sending credentials
- Forward secrecy is built-in: compromising one session key does not expose previous sessions

## Related concepts
[[WPA2-Enterprise]] [[RADIUS]] [[802.1X Authentication]] [[SAE (Simultaneous Authentication of Equals)]] [[EAP-TLS]]