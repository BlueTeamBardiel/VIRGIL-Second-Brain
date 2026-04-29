# Raw Sockets

## What it is
Like bypassing a restaurant's ordering system and walking directly into the kitchen to plate your own food, raw sockets let a program skip the OS networking stack and craft packets from scratch — headers and all. Precisely: a raw socket is a socket type that grants direct access to lower-level protocols (IP, ICMP, TCP), allowing the programmer to manually construct every field of the packet without the kernel filling in defaults.

## Why it matters
Raw sockets are the engine behind most network reconnaissance and spoofing tools. When an attacker runs `hping3` to perform a SYN flood with spoofed source IPs, raw sockets are what make IP address falsification possible — because the OS would normally enforce the real source address automatically. Defenders use the same mechanism in tools like Wireshark's packet injection and Scapy-based honeypot probes.

## Key facts
- **Root/admin privileges required** — Linux and Windows both restrict raw socket creation to privileged users, making them a red flag in privilege escalation chains
- **ICMP tools depend on them** — `ping` and `traceroute` use raw sockets because ICMP has no transport-layer socket type
- **Enables IP spoofing** — raw sockets allow setting arbitrary source addresses, the foundation of amplification DDoS attacks (e.g., DNS/NTP reflection)
- **Used by OS fingerprinting tools** — Nmap's `-O` flag sends carefully malformed raw packets to analyze TCP/IP stack quirks in responses
- **Detectable via behavior analysis** — EDR tools flag raw socket creation by non-system processes as high-suspicion activity (maps to MITRE ATT&CK T1095)

## Related concepts
[[IP Spoofing]] [[ICMP Attacks]] [[Packet Crafting]] [[SYN Flood]] [[Network Reconnaissance]]