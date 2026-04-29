# RIRs

## What it is
Think of RIRs like regional DMVs for the internet — they don't make the roads, but they control who gets a license plate (IP address) in their geographic territory. Regional Internet Registries (RIRs) are the five nonprofit organizations authorized by IANA to allocate and manage public IP address blocks and Autonomous System Numbers (ASNs) within specific global regions.

## Why it matters
During threat intelligence investigations, analysts query RIR databases (via WHOIS) to identify who legitimately owns a suspicious IP address — a critical step in attributing attacks or identifying spoofed traffic. For example, if traffic claiming to originate from a U.S. financial institution actually traces back to an APNIC-managed block in Southeast Asia, that geographic mismatch is a strong indicator of spoofing or proxy abuse.

## Key facts
- The five RIRs are: **ARIN** (North America), **RIPE NCC** (Europe/Middle East/Central Asia), **APNIC** (Asia-Pacific), **LACNIC** (Latin America/Caribbean), and **AFRINIC** (Africa)
- RIRs maintain **WHOIS databases** — publicly queryable records linking IP blocks to registered organizations, used heavily in OSINT and incident response
- IP address exhaustion is real: ARIN announced depletion of its IPv4 free pool in **2015**, pushing adoption of IPv6 and the gray market for IPv4 blocks
- Attackers can register shell companies with RIRs to obtain legitimate IP allocations, making malicious traffic appear credible in reputation checks
- BGP hijacking attacks often exploit the gap between RIR records and actual routing announcements — RPKI (Resource Public Key Infrastructure) was developed to cryptographically bind RIR allocations to BGP routes

## Related concepts
[[WHOIS]] [[BGP Hijacking]] [[RPKI]] [[OSINT]] [[IP Geolocation]]