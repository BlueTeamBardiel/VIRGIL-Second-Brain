# IANA

## What it is
Think of IANA as the DMV for the internet — it doesn't build the roads, but it issues every license plate, ZIP code, and vehicle classification that keeps traffic organized. The Internet Assigned Numbers Authority (IANA) is the global coordination body responsible for allocating IP address space, managing the DNS root zone, and maintaining protocol parameter registries (like port numbers and protocol types). It operates under ICANN and ensures no two entities claim the same fundamental identifier on the global internet.

## Why it matters
During BGP hijacking attacks, adversaries exploit the fact that internet routing trusts announcements rather than verifying IANA-assigned ownership — a malicious AS can announce a legitimate organization's IP prefix and intercept their traffic. Defenders reference IANA's Regional Internet Registry (RIR) allocations to validate that announced routes actually belong to their claimed owners, forming the foundation of RPKI (Resource Public Key Infrastructure) defenses. Without IANA's authoritative registry, there's no ground truth to compare against.

## Key facts
- IANA delegates IP address blocks to five **Regional Internet Registries (RIRs)**: ARIN (Americas), RIPE NCC (Europe), APNIC (Asia-Pacific), LACNIC (Latin America), AFRINIC (Africa)
- IANA maintains the **well-known port registry**: ports 0–1023 are IANA-assigned system ports (e.g., TCP 443 = HTTPS, TCP 22 = SSH)
- IANA manages the **DNS root zone** — the ultimate authoritative source for TLDs like `.com`, `.gov`, `.uk`
- **IPv4 exhaustion**: IANA allocated its last /8 blocks to RIRs in February 2011; scarcity drives NAT, IPv6 adoption, and address fraud risks
- IANA protocol registries define **IP protocol numbers** (e.g., protocol 6 = TCP, 17 = UDP, 1 = ICMP) used in packet filtering rules

## Related concepts
[[DNS]] [[BGP Hijacking]] [[RPKI]] [[IPv6]] [[Port Numbers]]