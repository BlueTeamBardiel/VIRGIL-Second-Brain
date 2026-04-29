# ICMP

## What it is
Think of ICMP as the postal service's "return to sender" and "address correction" system — it doesn't carry mail itself, but it sends back status notifications when delivery fails or routes need updating. Precisely: ICMP (Internet Control Message Protocol) is a Layer 3 network protocol used by routers and hosts to send error messages and operational information about IP packet delivery. It is connectionless, requires no handshake, and lives inside IP packets (protocol number 1).

## Why it matters
Attackers weaponize ICMP's trusted status in **ICMP tunneling** attacks, where tools like `icmptunnel` or `ptunnel` embed arbitrary data inside ping packets to exfiltrate data or establish covert command-and-control channels through firewalls that permit ICMP. Defenders detect this by flagging ICMP packets with unusually large payloads (normal ping payload is 32–56 bytes) or abnormally high ICMP traffic volume from a single host.

## Key facts
- **Type 8 / Type 0**: ICMP Echo Request (ping) is Type 8; Echo Reply is Type 0 — the most common types tested on exams
- **Type 3 (Destination Unreachable)** and **Type 11 (Time Exceeded)** are what `traceroute` exploits to map network paths
- ICMP has **no port numbers** — filtering it requires firewall rules based on ICMP type/code, not port ACLs
- **Ping of Death** is a legacy ICMP attack sending malformed/oversized packets (>65,535 bytes) to crash target systems
- **Smurf Attack** amplifies ICMP by spoofing the victim's IP as the source in broadcast ping requests, overwhelming the target with replies

## Related concepts
[[Ping of Death]] [[Network Reconnaissance]] [[Covert Channels]] [[traceroute]] [[DDoS Amplification Attacks]]