# Regional Internet Registries

## What it is
Think of RIRs like regional DMVs for the internet — just as your state DMV issues license plates and tracks vehicle ownership within a geographic area, RIRs allocate and track IP address blocks and Autonomous System Numbers (ASNs) within their global regions. There are five RIRs (ARIN, RIPE NCC, APNIC, LACNIC, AFRINIC) that together manage the distribution of the entire IPv4 and IPv6 address space delegated to them by IANA.

## Why it matters
During a BGP hijacking incident, attackers announce ownership of IP prefixes they don't legitimately control, rerouting traffic through malicious infrastructure. Security analysts use RIR WHOIS databases to verify the legitimate owner of a prefix — if AS64496 is announcing 192.0.2.0/24 but ARIN's registry shows that block belongs to a different organization, that's a red flag indicating potential route hijacking or misconfiguration worth investigating immediately.

## Key facts
- **Five RIRs by region:** ARIN (North America), RIPE NCC (Europe/Middle East/Central Asia), APNIC (Asia-Pacific), LACNIC (Latin America/Caribbean), AFRINIC (Africa)
- **WHOIS lookups** against RIR databases reveal IP ownership, contact abuse addresses, and registration dates — critical during incident response attribution
- **IPv4 exhaustion is real:** ARIN reached its IPv4 free pool depletion in 2015; analysts may encounter legacy "swamp space" (legacy /8 blocks) with murky ownership records
- **ASNs are also RIR-managed:** Each Autonomous System routing independently on the internet requires an ASN registered through an RIR
- **RPKI (Resource Public Key Infrastructure)** is the cryptographic framework RIRs now support, allowing organizations to sign Route Origin Authorizations (ROAs) to prevent BGP hijacking

## Related concepts
[[BGP Hijacking]] [[WHOIS Enumeration]] [[RPKI]]