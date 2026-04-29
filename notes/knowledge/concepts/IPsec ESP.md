# IPsec ESP

## What it is
Think of ESP like a sealed, tamper-evident diplomatic pouch: the contents are hidden from everyone except the intended recipient, and any tampering is immediately detectable. Encapsulating Security Payload (ESP) is the IPsec protocol (IP Protocol 50) that provides confidentiality, integrity, authentication, and optional anti-replay protection for IP packets. Unlike AH, which only authenticates, ESP can encrypt the payload entirely.

## Why it matters
A VPN tunnel between a remote employee and corporate headquarters uses ESP in tunnel mode to prevent an ISP or on-path attacker from reading or modifying sensitive traffic. Without ESP, a man-in-the-middle on that network path could capture plaintext credentials or inject malicious payloads into the stream — ESP's encryption and HMAC-based integrity check stop both attacks simultaneously.

## Key facts
- ESP operates in two modes: **Transport mode** (encrypts only the payload, leaving the original IP header intact) and **Tunnel mode** (encrypts the entire original packet and wraps it in a new IP header — standard for VPNs)
- ESP provides **confidentiality** (encryption via AES), **data integrity**, **origin authentication**, and **anti-replay protection** via a sequence number field
- ESP uses a **Security Association (SA)** — a one-way agreement storing keys, algorithms, and parameters, identified by a Security Parameter Index (SPI)
- Because ESP encrypts the payload, it **cannot be inspected by stateful firewalls** without special deep-packet inspection capabilities or terminating the tunnel at the firewall
- AH (Authentication Header) authenticates the entire packet including the outer IP header; ESP authenticates only its own portion — when both protection types are needed, ESP + AH can be combined

## Related concepts
[[IPsec AH]] [[IKE (Internet Key Exchange)]] [[VPN Tunnel Mode]] [[Security Association]] [[Anti-Replay Protection]]