# Internet Assigned Numbers Authority

## What it is
Think of IANA as the master librarian of the internet — it doesn't lend you books, but it maintains the official catalog that tells everyone what every number means. Precisely, IANA is a function operated by ICANN that manages global IP address space allocation, autonomous system numbers, DNS root zone management, and protocol parameter registries (like port numbers and protocol types). Without it, two organizations could independently decide port 443 means completely different things.

## Why it matters
Attackers who register lookalike domains exploit the same DNS root zone that IANA governs — when a threat actor registers `paypa1.com` for phishing, IANA's root zone delegation chain is what makes that domain resolvable globally. Defenders performing threat intelligence must understand that IANA delegates IP blocks to Regional Internet Registries (RIRs like ARIN or RIPE), and querying WHOIS against these RIRs reveals ownership data that can attribute malicious IP ranges during incident response.

## Key facts
- IANA maintains the **"well-known ports"** registry: ports 0–1023 require IANA assignment (e.g., port 80/HTTP, 443/HTTPS, 22/SSH)
- IANA delegates IP address blocks to **five Regional Internet Registries (RIRs)**: ARIN (Americas), RIPE NCC (Europe), APNIC (Asia-Pacific), LACNIC (Latin America), AFRINIC (Africa)
- IANA manages the **DNS root zone**, meaning it controls which top-level domains (TLDs like `.com`, `.gov`, `.mil`) are globally recognized
- Protocol numbers used in IP headers (e.g., TCP = 6, UDP = 17, ICMP = 1) are assigned and documented by IANA
- IANA is operated by **ICANN** (Internet Corporation for Assigned Names and Numbers) under a contract with the U.S. Department of Commerce, transitioned to global multistakeholder governance in 2016

## Related concepts
[[DNS]] [[IP Address Management]] [[Port Numbers]] [[WHOIS]] [[ICANN]]