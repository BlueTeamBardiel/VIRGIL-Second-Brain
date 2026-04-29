# IP addresses

## What it is
Like a postal address that tells the mail carrier both which building and which apartment to deliver to, an IP address is a numerical label assigned to every device on a network that identifies both the host and the network it belongs to. IPv4 uses 32-bit addresses written in dotted-decimal notation (e.g., 192.168.1.10), while IPv6 uses 128-bit addresses to solve the exhaustion problem IPv4 created.

## Why it matters
In a reconnaissance attack, an adversary uses tools like Nmap to sweep IP ranges and discover live hosts before launching targeted exploits — this is why network segmentation and firewall ACLs that restrict ICMP and port responses to untrusted IP ranges are critical defensive controls. Knowing whether an IP is public or private also determines whether NAT is hiding internal topology, which directly affects how an attacker maps your network.

## Key facts
- **IPv4 private ranges** (RFC 1918): 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 — these are non-routable on the public internet
- **APIPA range** (169.254.0.0/16): a device self-assigns an address here when DHCP fails — a sign of network misconfiguration
- **Loopback address**: 127.0.0.1 (IPv4) and ::1 (IPv6) — traffic never leaves the host; used for local service testing
- **IP spoofing** involves forging the source IP in packet headers to bypass IP-based access controls or obscure attack origin — common in DDoS amplification attacks
- IPv6 addresses include a **link-local prefix** (fe80::/10) analogous to APIPA, auto-configured on every IPv6-capable interface

## Related concepts
[[Subnetting]] [[NAT]] [[TCP/IP Model]] [[Firewall ACLs]] [[Network Reconnaissance]]