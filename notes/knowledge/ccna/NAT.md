# NAT

## What it is
Think of NAT like a corporate receptionist: dozens of employees inside make calls that all appear to come from one main company phone number, and the receptionist keeps a log to route replies back to the right desk. Network Address Translation works the same way — a router maps multiple private internal IP addresses to one (or a few) public IP addresses, rewriting packet headers and maintaining a translation table to track active connections.

## Why it matters
NAT provides obscurity as a soft defensive layer: an external attacker scanning the internet sees only the public IP, not the 192.168.x.x addresses of internal hosts. However, this obscurity is not security — attackers who compromise the NAT device itself (e.g., a vulnerable home router via CVE-exposed management interface) gain visibility into the entire internal network map, making router hardening critical.

## Key facts
- **Three types**: Static NAT (1-to-1 mapping), Dynamic NAT (pool-based), and PAT/NAT Overload (many-to-one using port numbers — the most common form in home/enterprise routers)
- Private address ranges exempt from public routing: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 (RFC 1918)
- NAT **breaks end-to-end connectivity** — protocols like IPsec AH and some VoIP applications require NAT traversal (NAT-T) workarounds
- NAT is **not a firewall** — it does not inspect packet payloads or enforce access control policies (common exam trap)
- Port Address Translation (PAT) differentiates connections using **source port numbers**, allowing thousands of internal hosts to share a single public IP simultaneously

## Related concepts
[[Firewall]] [[RFC 1918 Private Addressing]] [[Port Forwarding]] [[IPv6]] [[VPN Tunneling]]