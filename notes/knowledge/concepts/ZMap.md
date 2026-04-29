# ZMap

## What it is
Like a census worker who knocks on every door in an entire country in under an hour, ZMap is an open-source network scanner designed to perform internet-wide port scans at extraordinary speed. Unlike traditional sequential scanners, it uses stateless scanning to send SYN packets across the entire IPv4 address space (4.3 billion addresses) in roughly 45 minutes from a single machine with a gigabit connection.

## Why it matters
Security researchers used ZMap to discover that hundreds of thousands of industrial control systems (SCADA devices) were directly exposed to the internet following Shodan enumeration work — ZMap-style scanning confirmed the actual attack surface at scale. Defenders use it for asset discovery to find rogue or forgotten internet-facing services before attackers do; attackers use it to rapidly identify vulnerable services running specific ports (e.g., port 22, 443, or 3389) across the entire public internet.

## Key facts
- ZMap completes a full IPv4 scan in ~45 minutes at 1 Gbps; Masscan can do it faster but ZMap pioneered the approach academically
- Uses **stateless TCP SYN scanning** — it never completes the TCP handshake, relying on return SYN-ACK packets to identify open ports
- Developed at the University of Michigan and released in 2013; commonly used in legitimate academic internet measurement research
- Generates extremely high packet rates (10M+ packets/second), which can appear as a DDoS event to network defenders and trigger IDS/IPS alerts
- Scanning the public internet without authorization is illegal in most jurisdictions under laws like the CFAA; ZMap includes ethical-use guidance and supports exclusion lists

## Related concepts
[[Masscan]] [[Nmap]] [[Port Scanning]] [[SYN Scanning]] [[Shodan]] [[Network Enumeration]]