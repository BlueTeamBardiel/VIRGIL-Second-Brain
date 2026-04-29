# DPI

## What it is
Like a customs officer who doesn't just check your passport but also opens your luggage and reads your letters, Deep Packet Inspection examines not just the header of a network packet but its actual payload content. DPI is a network filtering technique that analyzes the full content of packets in transit — including application-layer data — rather than just source/destination IP and port information used in traditional packet filtering.

## Why it matters
A corporate IDS using DPI can detect a command-and-control (C2) beacon that tunnels malicious traffic over port 443 (HTTPS) — something a standard firewall would wave through because the port "looks legitimate." Conversely, nation-state firewalls (like China's Great Firewall) use DPI to detect and block VPN protocols and Tor traffic even when they're disguised on standard ports, making it a dual-use surveillance and censorship tool.

## Key facts
- DPI operates at **Layer 7 (Application Layer)** of the OSI model, distinguishing it from stateful inspection which typically stops at Layer 4
- DPI engines use **signature matching, heuristics, and behavioral analysis** to classify traffic — not just port numbers
- **SSL/TLS inspection** (a form of DPI) requires a man-in-the-middle proxy to decrypt traffic before inspection, introducing certificate trust chain considerations
- DPI is a core capability of **Next-Generation Firewalls (NGFWs)** and **IDS/IPS systems** like Snort and Suricata
- Privacy concern: DPI by ISPs to throttle BitTorrent or inject ads is legally regulated differently across jurisdictions — relevant to **compliance and data handling** objectives

## Related concepts
[[Next-Generation Firewall]] [[Intrusion Detection System]] [[SSL TLS Inspection]] [[Stateful Inspection]] [[Protocol Tunneling]]