# ALG

## What it is
Think of ALG (Application Layer Gateway) like a smart security guard at a restaurant's kitchen door—it doesn't just check that someone has a ticket (traditional firewall), it actually reads the menu order and watches what's being prepared to catch poisoned dishes. Technically, ALG is a firewall function that inspects and understands application-layer protocols (HTTP, FTP, DNS, SIP) rather than just TCP/UDP ports, allowing it to detect and block malicious payloads embedded *inside* legitimate protocol traffic.

## Why it matters
A traditional firewall might permit all port 80 traffic as "safe," but an ALG can catch SQL injection attacks hidden in HTTP requests, malformed DNS queries attempting zone transfers, or FTP commands exploiting backend systems. During a targeted attack, adversaries rely on the assumption that application-layer firewalls won't inspect their crafted payloads—ALG breaks that assumption by understanding the actual protocol semantics.

## Key facts
- ALG performs **deep packet inspection (DPI)** on application protocols, not just network headers
- Stateful protocol understanding allows ALG to detect protocol violations (e.g., invalid FTP commands) that raw packet inspection misses
- Common in NAT firewalls to handle protocols with embedded IP/port data (FTP, SIP)
- Performance cost: ALG inspection consumes more CPU than stateless filtering
- ALG enables protocol-specific threat blocking: blocking dangerous DNS query types, sanitizing HTTP headers, validating RTP streams

## Related concepts
[[Deep Packet Inspection]] [[Stateful Firewall]] [[WAF]] [[Protocol Analysis]]