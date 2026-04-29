# AFRINIC

## What it is
Think of AFRINIC as the "post office" that assigns mailing addresses for the African continent's internet — except instead of addresses, it distributes IP address blocks and AS numbers. AFRINIC (African Network Information Centre) is the Regional Internet Registry (RIR) responsible for allocating Internet resources (IPv4, IPv6, and AS numbers) to organizations across Africa, the Indian Ocean region, and the Caribbean. It's one of five global RIRs that collectively manage all publicly routable internet addresses.

## Why it matters
IP address hijacking and BGP route leaks targeting African networks often succeed because attackers can request resources from AFRINIC using forged documentation or social engineering. In 2020, attackers exploited weak AFRINIC verification processes to claim IP blocks and redirect traffic. Understanding AFRINIC's role in the allocation chain helps defenders recognize when address space legitimacy should be verified through whois records and formal RIR channels rather than trusting prefix origins blindly.

## Key facts
- AFRINIC allocates resources following "needs-based" criteria; organizations must justify IP requests
- Whois database queries reveal AFRINIC registrations, but data accuracy depends on registrant honesty
- AFRINIC members can request IPv6 (abundant) more easily than IPv4 (scarce), influencing security policies
- Resource requests require documentation; weak verification historically enabled address hijacking
- AFRINIC participates in RPKI (Resource Public Key Infrastructure) to cryptographically validate resource ownership

## Related concepts
[[BGP Hijacking]] [[RPKI]] [[Whois]] [[Regional Internet Registries]] [[IP Spoofing]]