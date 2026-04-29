# Zone transfer attacks

## What it is
Imagine a thief who walks up to a library's card catalog system and asks for a complete printout of every book, author, and shelf location in the building — and the librarian just hands it over. A DNS zone transfer attack exploits misconfigured DNS servers that respond to AXFR (full zone transfer) requests from unauthorized clients, handing over the entire DNS zone file containing every hostname, IP address, mail server, and subdomain in the organization.

## Why it matters
Before attacking a target, reconnaissance is everything. In documented cases, attackers have queried exposed DNS servers with `dig axfr @ns1.target.com target.com` and received complete internal network maps — discovering development servers, VPN endpoints, and staging environments that were never meant to be public. This single query can replace hours of active scanning and dramatically accelerate lateral movement planning.

## Key facts
- DNS zone transfers use TCP port 53 (not UDP) because the response payload is too large for UDP
- The AXFR request type pulls a full zone; IXFR pulls only incremental changes since a serial number
- Proper mitigation: restrict zone transfers using ACLs so only authorized secondary DNS servers (by IP) can request them
- DNSSEC does **not** prevent zone transfer attacks — it authenticates records but doesn't restrict who can request the full zone
- Tools commonly used: `dig`, `nslookup`, `fierce`, and `dnsrecon` can all perform or automate zone transfer enumeration

## Related concepts
[[DNS enumeration]] [[Reconnaissance]] [[DNSSEC]] [[Network footprinting]] [[TCP vs UDP port 53]]