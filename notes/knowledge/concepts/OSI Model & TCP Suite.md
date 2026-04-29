# OSI Model & TCP Suite

## What it is
Think of sending a letter internationally: you write the message, seal it in an envelope, address it, hand it to a postal worker, who loads it on a truck, then a plane, then delivers it — each person handles only their layer without caring about the others. The OSI model is a 7-layer conceptual framework (Physical, Data Link, Network, Transport, Session, Presentation, Application) that standardizes how network communication is broken down and reassembled. TCP/IP is the real-world implementation that collapses those 7 layers into 4 practical ones (Network Access, Internet, Transport, Application).

## Why it matters
When a penetration tester performs a SYN flood attack, they're exploiting TCP's Transport layer (Layer 4) three-way handshake by sending thousands of SYN packets without completing the connection, exhausting server resources. Defenders respond with SYN cookies or rate-limiting at the same layer — knowing *which* layer is under attack directs the exact defensive tool to apply.

## Key facts
- OSI Layer 3 (Network) uses IP addressing; Layer 2 (Data Link) uses MAC addressing — ARP poisoning attacks bridge these two layers by spoofing MAC-to-IP mappings
- The TCP three-way handshake is SYN → SYN-ACK → ACK; a half-open connection (SYN only) is the signature of a SYN flood DoS attack
- Firewalls operating at Layer 4 filter by port/protocol; Next-Generation Firewalls (NGFWs) inspect up to Layer 7 (Application), enabling deep packet inspection
- UDP (also Layer 4) is connectionless — no handshake — making it preferred for DNS, DHCP, and amplification-based DDoS attacks
- Wireshark captures at Layer 2 and above; understanding which layer an anomaly appears at is critical for CySA+ packet analysis questions

## Related concepts
[[TCP/IP Attacks & DoS]] [[Firewalls & Packet Filtering]] [[ARP Poisoning]]