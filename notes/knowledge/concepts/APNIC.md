# APNIC

## What it is
Think of it like a regional post office responsible for handing out street addresses — but for the internet across Asia-Pacific. APNIC (Asia-Pacific Network Information Centre) is one of five Regional Internet Registries (RIRs) that manages the allocation and registration of IP addresses and Autonomous System Numbers (ASNs) for the Asia-Pacific region. It operates as a not-for-profit membership organization coordinating with IANA at the global level.

## Why it matters
During BGP hijacking incidents — such as the 2010 China Telecom event where roughly 15% of global internet traffic was briefly rerouted through Chinese networks — APNIC's WHOIS database and route registry become critical forensic tools. Security analysts query APNIC's records to verify legitimate IP block ownership and detect whether a network prefix is being announced by an unauthorized Autonomous System. Threat intelligence teams regularly use APNIC data to geolocate attack infrastructure and attribute malicious traffic to specific ISPs or regions.

## Key facts
- APNIC is one of five RIRs globally; the others are ARIN (North America), RIPE NCC (Europe), LACNIC (Latin America), and AFRINIC (Africa)
- APNIC allocates IPv4, IPv6 addresses, and ASNs; it also maintains a public WHOIS database for ownership lookups
- APNIC collaborated with Google on a major internet measurement project (APNIC/Google DNS study) tracking global IPv6 adoption
- IPv4 exhaustion: APNIC reached its final /8 allocation from IANA in April 2011, making it the first RIR to enter the last-resort phase
- APNIC operates RPKI (Resource Public Key Infrastructure) services, which allow ISPs to cryptographically validate legitimate route announcements and prevent BGP hijacking

## Related concepts
[[BGP Hijacking]] [[WHOIS]] [[RPKI]] [[Autonomous System Numbers]] [[IP Address Management]]