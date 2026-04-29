# SSH

## What it is
Think of SSH as a bank's pneumatic tube system — the canister (your data) travels through a sealed, tamper-proof tube so nobody in the building can intercept or swap it mid-transit. Technically, SSH (Secure Shell) is a cryptographic network protocol operating on **port 22** that provides encrypted remote command-line access, file transfers, and port tunneling between networked hosts. It replaced plaintext predecessors like Telnet and rlogin.

## Why it matters
In 2023, attackers routinely scan the entire IPv4 address space for exposed SSH servers and attempt credential stuffing against default or weak passwords — a strategy that compromised thousands of cloud VMs in campaigns like RockYou2024. Defenders respond by disabling password authentication entirely and enforcing **public key authentication only**, rendering brute-force attacks computationally useless against the key pair.

## Key facts
- SSH uses **asymmetric cryptography** for initial key exchange and authentication, then switches to **symmetric encryption** (e.g., AES-256) for the session — best of both worlds on speed and security
- The default port is **22**; changing it provides minimal security but reduces automated scan noise (security through obscurity, not a real control)
- **SSH tunneling / port forwarding** can encapsulate other protocols (e.g., tunneling HTTP over SSH), which attackers abuse to bypass firewall rules — a known C2 evasion technique
- `~/.ssh/known_hosts` stores server fingerprints; an unexpected fingerprint change is a classic indicator of a **man-in-the-middle attack**
- SSHv1 is **deprecated and broken**; Security+ expects you to know only SSHv2 is considered secure

## Related concepts
[[Public Key Infrastructure]] [[Asymmetric Encryption]] [[Telnet]] [[Port Forwarding]] [[Man-in-the-Middle Attack]]