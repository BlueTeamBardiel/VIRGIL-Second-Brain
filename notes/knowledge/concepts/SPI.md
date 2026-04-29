# SPI

## What it is
Like a nightclub bouncer who checks every ID against a guest list *and* remembers everyone already inside — Stateful Packet Inspection (SPI) is a firewall technique that tracks the full context of network connections, not just individual packets. Unlike simple packet filtering, SPI maintains a state table recording each active session's source, destination, ports, and TCP flags, allowing it to validate that incoming packets belong to a legitimately established connection.

## Why it matters
In a SYN flood attack, an attacker sends thousands of forged SYN packets to exhaust a server's connection queue. An SPI firewall can detect this anomaly by observing that no corresponding SYN-ACK/ACK handshake ever completes in its state table, allowing it to drop the malicious half-open connections before they overwhelm the target — something a stateless ACL cannot do.

## Key facts
- SPI firewalls maintain a **state table** (also called a connection table) that tracks TCP session states: SYN_SENT, ESTABLISHED, TIME_WAIT, etc.
- SPI operates at **Layer 4 (Transport Layer)** of the OSI model, though some implementations inspect up to Layer 7.
- SPI can automatically **allow return traffic** for outbound connections without requiring explicit inbound rules — a major advantage over stateless filtering.
- SPI is the baseline mechanism in **next-generation firewalls (NGFWs)** and is considered the minimum standard for perimeter defense in modern networks.
- A key limitation: SPI **cannot inspect encrypted payloads** (e.g., HTTPS tunnels) — that requires SSL/TLS inspection layered on top.

## Related concepts
[[Stateless Packet Filtering]] [[Next-Generation Firewall]] [[TCP Three-Way Handshake]] [[SYN Flood Attack]] [[Deep Packet Inspection]]