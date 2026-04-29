# Wi-Fi Protected Access

## What it is
Think of WPA like replacing a screen door lock (WEP) with a deadbolt that changes its key combination every few minutes — the mechanism looks similar, but breaking in becomes dramatically harder. WPA is a wireless security certification standard developed by the Wi-Fi Alliance in 2003 as an emergency patch to WEP's catastrophic vulnerabilities, using TKIP (Temporal Key Integrity Protocol) to dynamically rotate encryption keys per packet. WPA2 (2004) replaced TKIP with AES-CCMP, and WPA3 (2018) added Simultaneous Authentication of Equals (SAE) to defeat offline dictionary attacks.

## Why it matters
In the KRACK (Key Reinstallation Attack) discovered in 2017, researchers demonstrated that WPA2's four-way handshake could be manipulated to force nonce reuse, allowing an attacker within Wi-Fi range to decrypt traffic without knowing the password. This affected virtually every WPA2-enabled device and highlighted that even "strong" standards carry implementation vulnerabilities — patches were required at the client OS level, not the router.

## Key facts
- **WEP → WPA → WPA2 → WPA3**: Each generation addressed specific cryptographic failures in its predecessor
- **WPA2-Personal** uses a Pre-Shared Key (PSK); **WPA2-Enterprise** uses 802.1X with a RADIUS server for per-user authentication — a critical distinction for exam scenarios
- **TKIP** (WPA) uses RC4 with per-packet key mixing; **AES-CCMP** (WPA2) is considered cryptographically strong and is still recommended
- **WPA3-SAE** replaces PSK with a zero-knowledge proof handshake, making offline brute-force attacks against captured handshakes ineffective
- **WPS (Wi-Fi Protected Setup)** is a known weakness associated with WPA2 — its 8-digit PIN is vulnerable to brute force and should be disabled

## Related concepts
[[WEP]] [[802.1X Authentication]] [[Four-Way Handshake]] [[RADIUS]] [[TKIP]]