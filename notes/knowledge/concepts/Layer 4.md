# Layer 4

## What it is
Think of Layer 4 as the postal sorting system that decides *how* packages get delivered — guaranteed registered mail (TCP) versus dropping a flyer in a general direction (UDP). The Transport Layer of the OSI model is responsible for end-to-end communication, segmentation, flow control, and error recovery between hosts, operating through port numbers that identify specific services.

## Why it matters
SYN flood attacks exploit Layer 4 directly: an attacker hammers a server with TCP SYN packets but never completes the three-way handshake, exhausting the server's connection table until legitimate users are denied service. Defenders counter this with SYN cookies — a technique where the server doesn't allocate resources until the handshake completes — and rate-limiting at Layer 4 firewalls or load balancers.

## Key facts
- **TCP** (port-based, connection-oriented) provides reliability via the three-way handshake: SYN → SYN-ACK → ACK
- **UDP** is connectionless and stateless — faster but with no delivery guarantee; used by DNS (53), DHCP (67/68), and SNMP (161)
- Port numbers 0–1023 are **well-known ports**, 1024–49151 are **registered ports**, and 49152–65535 are **ephemeral/dynamic ports**
- Layer 4 firewalls filter traffic based on **source/destination port and protocol** (TCP/UDP) without inspecting packet contents
- **Session hijacking** attacks often target Layer 4 by predicting TCP sequence numbers to inject malicious packets into an established connection

## Related concepts
[[TCP Three-Way Handshake]] [[SYN Flood Attack]] [[Stateful Firewall]] [[UDP]] [[Port Numbers]]