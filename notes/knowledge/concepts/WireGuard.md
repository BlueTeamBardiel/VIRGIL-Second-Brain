# WireGuard

## What it is
Think of WireGuard like a Swiss Army knife compared to OpenVPN's full toolbox — it does one thing (VPN tunneling) with a minimal, elegant blade rather than dozens of attachments. WireGuard is a modern, open-source VPN protocol built directly into the Linux kernel that uses state-of-the-art cryptography (ChaCha20, Curve25519, BLAKE2s) to create encrypted peer-to-peer tunnels. Its entire codebase is roughly 4,000 lines — compared to OpenVPN's ~100,000 — making it dramatically easier to audit for vulnerabilities.

## Why it matters
A corporate security team replacing legacy IPsec VPN infrastructure with WireGuard reduces their cryptographic attack surface significantly — fewer cipher negotiation options means fewer misconfiguration paths for an attacker to exploit. WireGuard's "silent by default" behavior (it doesn't respond to unauthenticated packets) also makes endpoints invisible to port scanners like Nmap, frustrating reconnaissance attempts.

## Key facts
- Uses **UDP only** (default port 51820) — no TCP option natively, which simplifies firewall rules but requires UDP to be permitted
- **No certificate authority required** — authentication relies on static public/private key pairs, similar to SSH key authentication
- **Cryptokey routing**: each peer is defined by its public key and allowed IP ranges, forming the access control model
- WireGuard is **stateless from the network perspective** — it drops all packets that don't authenticate, producing no response to probes (stealth posture)
- Integrated into the **Linux kernel since version 5.6** (2020), reducing overhead versus user-space VPN solutions; also available on Windows, macOS, iOS, Android

## Related concepts
[[VPN Protocols]] [[IPsec]] [[Public Key Cryptography]] [[Zero Trust Network Access]] [[Tunneling Protocols]]