# Wireless Frame Security

## What it is
Think of a wireless frame like a postcard — anyone nearby can read the address, the content, and even forge who sent it, unless you seal it in a tamper-evident envelope. Wireless frames are the Layer 2 data units transmitted over 802.11 networks, consisting of management frames (beacons, probes), control frames (ACKs, RTS/CTS), and data frames — each vulnerable to inspection or spoofing without proper cryptographic protection.

## Why it matters
Management frames were historically sent in plaintext with no authentication, enabling attacks like deauthentication floods — an attacker sends forged 802.11 deauth frames impersonating the access point, forcibly disconnecting clients and enabling evil twin or credential-capture attacks. 802.11w (Management Frame Protection) was introduced specifically to cryptographically sign management frames, preventing this forgery. Without it enabled, tools like `mdk3` or `aireplay-ng` can trivially disrupt entire wireless networks.

## Key facts
- **WEP** used RC4 with a static key and a flawed IV implementation — crackable in minutes with tools like Aircrack-ng; deprecated and exam-relevant as a "never use" baseline
- **WPA2** uses CCMP/AES for data frame encryption and a 4-way handshake to derive the PTK (Pairwise Transient Key) — the handshake capture is the target of offline dictionary attacks
- **802.11w (MFP)** protects management frames using AES-128; required for WPA3 compliance
- **WPA3** introduces SAE (Simultaneous Authentication of Equals), replacing PSK and providing forward secrecy — even if a password is later compromised, past sessions remain protected
- **Deauthentication attacks** exploit unauthenticated management frames and are classified as a DoS technique; 802.11w mitigates this by requiring MIC (Message Integrity Code) on these frames

## Related concepts
[[WPA3 and SAE]] [[Evil Twin Attack]] [[802.1X and EAP Authentication]]