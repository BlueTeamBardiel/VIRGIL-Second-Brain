# Sliver

## What it is
Think of it as a Swiss Army knife that an attacker mails to a compromised machine — once opened, it gives them persistent, encrypted remote control from anywhere. Sliver is an open-source, cross-platform Command and Control (C2) framework written in Go, developed by BishopFox as a red team alternative to Cobalt Strike. It generates implants (called "slivers") that beacon back to an attacker-controlled server over encrypted channels like mTLS, HTTP/S, DNS, or WireGuard.

## Why it matters
In 2022 and beyond, threat intelligence teams began observing nation-state actors and ransomware groups adopting Sliver as a Cobalt Strike replacement — likely because its signatures were less well-known to defenders and it's freely available. A defender hunting for Sliver must look for unusual outbound connections using mutual TLS on non-standard ports, or DNS beaconing with high query frequency, since traditional Cobalt Strike IOC rulesets won't catch it.

## Key facts
- Sliver implants support **multiple protocols**: mTLS, WireGuard, HTTP/S, and DNS — making egress filtering alone insufficient to block it
- Implants are **dynamically compiled** per operation, meaning each binary has unique cryptographic identifiers, defeating simple hash-based detection
- Uses **multiplayer mode**, allowing multiple red team operators to share a single C2 server simultaneously
- Written in **Go**, so compiled implants are statically linked and run cross-platform (Windows, Linux, macOS) without dependencies
- Detection focus: look for **mTLS certificates with random CN fields**, unusual DNS TXT record queries, and Go-compiled PE binaries (identifiable via strings or section analysis)

## Related concepts
[[Command and Control (C2)]] [[Cobalt Strike]] [[Beacon]] [[Lateral Movement]] [[Implant]]