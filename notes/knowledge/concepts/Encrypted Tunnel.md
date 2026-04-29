# Encrypted Tunnel

## What it is
Think of it like a pneumatic tube system inside a glass building — anyone can watch the tube, but the capsule inside is sealed and opaque. An encrypted tunnel is a logical communication channel that wraps plaintext data in encryption before transmission, so that intermediate nodes on the network see only ciphertext even if they can inspect every packet. The tunnel isolates data in transit from eavesdropping and tampering regardless of the underlying network's trustworthiness.

## Why it matters
A classic attack scenario: an attacker on a coffee shop Wi-Fi runs Wireshark and captures all traffic. Without an encrypted tunnel (e.g., VPN), they can read credentials and session cookies in cleartext. With an active TLS or IPSec tunnel in place, the captured packets reveal only cipher negotiation metadata — the payload is unreadable, neutralizing the threat of credential harvesting.

## Key facts
- **TLS (Transport Layer Security)** is the most common encrypted tunnel protocol, operating at Layer 4-7 and used by HTTPS, SMTPS, and IMAPS
- **IPSec** operates at Layer 3 and supports two modes: **Transport** (encrypts payload only) and **Tunnel** (encrypts entire IP packet, used in site-to-site VPNs)
- **SSH tunneling** can forward arbitrary TCP traffic through an encrypted SSH session — a technique used legitimately for remote access and maliciously for C2 data exfiltration
- Encrypted tunnels **do not guarantee authentication of the endpoint** unless paired with certificate validation or mutual TLS (mTLS)
- Security tools like **TLS inspection proxies** perform man-in-the-middle decryption to inspect tunnel contents — this requires organizations to deploy a trusted internal CA

## Related concepts
[[VPN]] [[TLS]] [[IPSec]] [[SSH]] [[Man-in-the-Middle Attack]]