# SYN flood

## What it is
Imagine calling a restaurant to reserve a table, then hanging up before they can confirm — and doing this thousands of times per minute until their phone lines are completely jammed. A SYN flood is a Denial-of-Service attack that exploits TCP's three-way handshake: an attacker sends massive volumes of SYN packets with spoofed source IPs, forcing the server to allocate resources for half-open connections that are never completed, exhausting its connection table.

## Why it matters
In 2016, the Mirai botnet weaponized hundreds of thousands of compromised IoT devices to launch SYN floods against Dyn DNS, taking down Twitter, Netflix, and Reddit for hours across the US East Coast. This demonstrated that volumetric Layer 4 attacks don't require sophisticated exploits — just scale — and highlighted why upstream scrubbing centers and SYN cookies are critical infrastructure defenses.

## Key facts
- **SYN cookies** are the primary server-side defense: the server encodes connection state into the initial sequence number instead of storing it, eliminating the half-open connection table vulnerability
- A SYN flood targets **Layer 4 (Transport Layer)** of the OSI model and specifically abuses the TCP three-way handshake (SYN → SYN-ACK → ACK)
- The server holds each half-open connection in a **backlog queue** with a default timeout; flooding fills this queue, dropping legitimate connections
- Attackers almost always **spoof source IP addresses** to prevent SYN-ACK replies from returning and to evade IP-based blocking
- Mitigation techniques include **rate limiting SYN packets**, firewall-based SYN proxies, and upstream ISP-level traffic filtering (blackhole routing)

## Related concepts
[[TCP Three-Way Handshake]] [[DDoS Attack]] [[SYN Cookies]] [[Spoofing]] [[Denial of Service]]