# Deep Packet Inspection

## What it is
If traditional firewalls are bouncers checking IDs at the door, Deep Packet Inspection (DPI) is a TSA agent who opens your luggage, reads your letters, and checks whether the contents match what's written on the envelope. DPI is a network analysis technique that examines not just packet headers (source/destination IP, ports) but also the payload — the actual data content — in real time. This allows devices to identify applications, detect malicious content, and enforce policy based on *what* is being communicated, not just *who* is communicating.

## Why it matters
A classic evasion technique is tunneling malicious traffic through allowed protocols — for example, running command-and-control communications over port 80 disguised as HTTP. A perimeter firewall passes it because the port is permitted; a DPI-enabled Next-Generation Firewall (NGFW) catches it by recognizing the traffic pattern doesn't match legitimate HTTP behavior, blocking the C2 channel before data exfiltration occurs.

## Key facts
- DPI operates at **Layer 7 (Application Layer)** of the OSI model, distinguishing it from stateful inspection which stops at Layer 4
- Used in **NGFWs, IDS/IPS systems, and web proxies** to enable application-aware filtering
- Can identify specific applications regardless of port (e.g., detecting BitTorrent on port 443)
- **SSL/TLS inspection** is a DPI extension requiring the device to decrypt, inspect, then re-encrypt traffic — raising privacy and performance considerations
- Employed by ISPs for **traffic shaping, lawful intercept, and censorship** — not exclusively a defensive tool
- DPI is computationally expensive; **hardware acceleration** (ASICs) is commonly used to maintain line-rate inspection speeds

## Related concepts
[[Stateful Inspection]] [[Next-Generation Firewall]] [[Intrusion Detection System]] [[SSL Inspection]] [[Protocol Tunneling]]