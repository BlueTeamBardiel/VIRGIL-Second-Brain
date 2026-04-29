# TTL

## What it is
Like a library book that self-destructs after a set number of renewals, TTL (Time To Live) is a counter embedded in IP packets that decrements by 1 at each router hop — when it hits zero, the packet is discarded and an ICMP "Time Exceeded" message is sent back to the source. This prevents zombie packets from looping forever across the internet.

## Why it matters
Attackers use TTL manipulation in OS fingerprinting: different operating systems ship with different default TTL values (Windows starts at 128, Linux at 64), so a port scanner like Nmap can infer the target OS by examining the TTL in responses without ever triggering an IDS signature. Defenders can detect this reconnaissance by flagging TTL values that don't match expected baselines for known internal systems.

## Key facts
- **Default TTL values by OS:** Windows = 128, Linux/Unix = 64, Cisco IOS = 255 — critical for passive fingerprinting
- **Traceroute weaponizes TTL:** it sends packets with TTL=1, 2, 3… forcing each router to reveal itself via ICMP Time Exceeded responses
- **TTL-based covert channels:** malware can encode data by manipulating TTL values to smuggle information past firewalls
- **DNS TTL** is a separate concept — it controls how long resolvers cache a record, not packet lifetime (commonly abused in DNS fast-flux attacks)
- **TTL = 0 is illegal** in transit; a router must drop the packet, making TTL exhaustion a potential DoS vector against routing infrastructure

## Related concepts
[[OS Fingerprinting]] [[ICMP]] [[Traceroute]] [[DNS Fast-Flux]] [[Passive Reconnaissance]]