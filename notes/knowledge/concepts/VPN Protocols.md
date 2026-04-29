# VPN protocols

## What it is
Think of VPN protocols as different shipping carriers for a secret package — each has its own routes, speeds, and tamper-evident seals, but they all promise the same thing: nobody reads your mail in transit. Precisely, VPN protocols define the rules for how traffic is encapsulated, encrypted, and authenticated between two endpoints across an untrusted network. The protocol chosen determines the cipher suites, handshake mechanisms, and tunneling method in use.

## Why it matters
In 2021, Pulse Secure VPN servers running outdated SSL/TLS configurations were exploited via CVE-2021-22893, allowing unauthenticated remote code execution before authentication even occurred. Attackers specifically targeted the VPN protocol implementation — not the underlying network — to harvest credentials and pivot into government networks. Choosing a modern, well-audited protocol like WireGuard or IKEv2/IPsec and patching promptly is a direct mitigation.

## Key facts
- **OpenVPN** uses TLS for control channel and can run over TCP/443 or UDP/1194, making it firewall-friendly but slower than native kernel solutions.
- **IKEv2/IPsec** is FIPS 140-2 compatible, supports MOBIKE for seamless network switching, and is commonly chosen for government and mobile enterprise use.
- **WireGuard** uses modern cryptography (ChaCha20, Curve25519, BLAKE2s) with ~4,000 lines of code vs. OpenVPN's ~100,000 — smaller attack surface.
- **L2TP/IPsec** is considered legacy; the NSA is suspected of having weakened its underlying IKE implementation, making it unsuitable for high-assurance environments.
- **PPTP** is cryptographically broken — MS-CHAPv2 is vulnerable to offline brute-force — and should never be deployed.

## Related concepts
[[IPsec]] [[TLS]] [[Split Tunneling]] [[Zero Trust Network Access]] [[Cryptographic Protocols]]