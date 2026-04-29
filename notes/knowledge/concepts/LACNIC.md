# LACNIC

## What it is
Think of LACNIC as the DMV for IP addresses in Latin America — the place where organizations go to register and receive the "license plates" (IP blocks) that let them exist on the internet. Formally, LACNIC (Latin America and Caribbean Network Information Centre) is one of five Regional Internet Registries (RIRs) responsible for managing and distributing IPv4 and IPv6 address space, Autonomous System Numbers (ASNs), and reverse DNS within its geographic region.

## Why it matters
During threat intelligence and reconnaissance operations, attackers and defenders alike query LACNIC's WHOIS database to map IP ownership. A red team might identify that a target corporation owns a specific LACNIC-registered IP block, then scan that entire range for exposed services — meanwhile, a SOC analyst uses the same WHOIS data to attribute suspicious inbound traffic to a known threat actor operating out of a Brazilian hosting provider.

## Key facts
- LACNIC serves 33 countries across Latin America and the Caribbean, making it the RIR for one of the fastest-growing internet regions
- Querying `whois -h whois.lacnic.net <IP>` returns registration details, abuse contacts, and netblock ownership — a standard OSINT step
- LACNIC, like all RIRs, maintains a public database critical for IP geolocation accuracy and abuse reporting workflows
- ASNs registered through LACNIC identify the Border Gateway Protocol (BGP) routing entities — attackers performing BGP hijacking research target these registrations
- The five RIRs are ARIN (North America), RIPE NCC (Europe), APNIC (Asia-Pacific), AFRINIC (Africa), and LACNIC — knowing all five is exam-relevant

## Related concepts
[[WHOIS]] [[Regional Internet Registry]] [[OSINT]] [[BGP Hijacking]] [[IP Geolocation]]