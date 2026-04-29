# TCP

## What it is
Think of TCP like certified mail with return receipts — both sides must sign off before any package gets delivered, and every piece is tracked and acknowledged. Technically, TCP (Transmission Control Protocol) is a connection-oriented Layer 4 protocol that establishes a reliable, ordered, error-checked stream between two hosts using a three-way handshake (SYN → SYN-ACK → ACK).

## Why it matters
The three-way handshake is the mechanism behind SYN flood attacks, where an attacker sends thousands of SYN packets with spoofed source IPs, forcing the target server to hold half-open connections until its connection table overflows and legitimate users are denied service. Defenders mitigate this with SYN cookies, which allow servers to avoid storing state until the handshake completes.

## Key facts
- **Three-way handshake**: SYN, SYN-ACK, ACK — connection is *not* established until all three complete
- **Port numbers**: TCP uses source/destination ports (0–65535) to multiplex connections; ports below 1024 are "well-known" (e.g., TCP 443 = HTTPS, TCP 22 = SSH)
- **Flags**: Key TCP flags include SYN, ACK, FIN, RST, PSH, URG — Nmap uses abnormal flag combinations (e.g., NULL, XMAS scans) to fingerprint firewalls and OS behavior
- **Connection teardown**: Uses a four-step FIN/ACK exchange; a RST packet forces an abrupt termination, often used in TCP reset attacks to hijack or terminate sessions
- **Stateful vs. UDP**: Unlike UDP, TCP maintains state — this is why stateful firewalls track TCP connection entries and can detect out-of-state packets as suspicious

## Related concepts
[[UDP]] [[SYN Flood Attack]] [[Three-Way Handshake]] [[Port Scanning]] [[Stateful Firewall]]