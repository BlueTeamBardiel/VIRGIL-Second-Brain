# RIPE NCC

## What it is
Think of it as the DMV for IP addresses in Europe — but instead of registering cars, it registers who owns which blocks of the internet's address space. RIPE NCC (Réseaux IP Européens Network Coordination Centre) is one of five Regional Internet Registries (RIRs) responsible for allocating and registering IP address blocks and Autonomous System Numbers (ASNs) in Europe, the Middle East, and Central Asia. It maintains the authoritative WHOIS database for its region.

## Why it matters
During threat intelligence investigations, analysts query the RIPE NCC WHOIS database to attribute malicious IP addresses to specific organizations or ISPs — a critical step in identifying the origin of a DDoS attack or botnet C2 infrastructure. In 2019, attackers exploited weak authentication at a RIPE NCC member portal to hijack BGP routes, redirecting traffic for major networks through unauthorized autonomous systems, demonstrating that RIR account security directly impacts global routing integrity.

## Key facts
- RIPE NCC covers **Europe, Middle East, and parts of Central Asia** — one of five RIRs alongside ARIN, APNIC, LACNIC, and AFRINIC
- Manages allocation of **IPv4, IPv6 addresses, and ASNs** to Local Internet Registries (LIRs) and end users
- Operates the **RIPE Database (WHOIS)**, used extensively in OSINT and threat attribution workflows
- Supports **RPKI (Resource Public Key Infrastructure)** to cryptographically validate BGP route origins and prevent route hijacking
- Free account registration with RIPE NCC is used by security researchers to access tools like **RIS (Routing Information Service)** for BGP monitoring

## Related concepts
[[BGP Hijacking]] [[WHOIS Lookup]] [[Autonomous System Numbers]] [[RPKI]] [[IP Geolocation]]