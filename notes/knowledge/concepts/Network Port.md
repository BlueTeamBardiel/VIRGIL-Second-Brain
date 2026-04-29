# Network Port

## What it is
Think of an IP address as a hotel building and ports as the individual room numbers — the address gets you to the right building, but the port tells you exactly which room (service) to knock on. Precisely: a network port is a 16-bit logical number (0–65535) that identifies a specific process or service on a host, allowing multiple services to share a single IP address simultaneously.

## Why it matters
During reconnaissance, attackers run port scans (using tools like Nmap) to discover open ports and fingerprint running services — an open port 23 (Telnet) signals a target transmitting credentials in plaintext. Defenders respond by closing unnecessary ports and implementing firewall rules that follow the principle of least exposure, dramatically reducing the attack surface before an exploit attempt even begins.

## Key facts
- **Three ranges:** Well-known ports (0–1023) are reserved for standard services; registered ports (1024–49151) are assigned to applications; dynamic/ephemeral ports (49152–65535) are used for temporary client-side connections.
- **Critical port numbers to memorize:** 21 (FTP), 22 (SSH), 23 (Telnet), 25 (SMTP), 53 (DNS), 80 (HTTP), 443 (HTTPS), 3389 (RDP), 445 (SMB).
- **TCP vs. UDP:** TCP ports require a handshake and guarantee delivery; UDP ports are connectionless and faster — DNS uses both (53/TCP and 53/UDP).
- **Port scanning types matter:** A SYN scan (half-open) is stealthier than a full TCP connect scan because it never completes the three-way handshake, leaving fewer log entries.
- **Default port changes ≠ security:** Running SSH on port 2222 instead of 22 is security through obscurity — it reduces noise but doesn't stop a full-range scan.

## Related concepts
[[TCP/IP Model]] [[Firewall Rules]] [[Network Reconnaissance]] [[Attack Surface]] [[Nmap]]