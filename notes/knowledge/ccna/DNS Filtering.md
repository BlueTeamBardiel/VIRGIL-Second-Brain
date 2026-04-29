# DNS filtering

## What it is
Think of DNS filtering like a school librarian who checks every book request before fetching it — if the title is on the banned list, you never see the book. Precisely, DNS filtering intercepts DNS queries and blocks resolution of domains categorized as malicious, inappropriate, or policy-violating, returning an NXDOMAIN response or a sinkhole IP instead of the real address. The user's device never reaches the destination because the "phone book lookup" itself is denied.

## Why it matters
During a ransomware campaign, infected endpoints often beacon out to command-and-control (C2) infrastructure using pre-registered or dynamically generated domains. A DNS filtering solution with threat intelligence feeds can block those C2 lookups before any payload is delivered or encryption keys are exchanged, breaking the kill chain at the Command & Control phase even when endpoint detection misses the initial infection.

## Key facts
- DNS filtering operates at **Layer 7** (Application layer) of the OSI model, intercepting queries before TCP connections are established
- **DNS sinkholes** redirect blocked domain queries to an internally controlled IP, allowing defenders to log which hosts attempted contact with malicious domains — providing threat intelligence
- Cisco Umbrella (formerly OpenDNS) and similar cloud-based DNS resolvers apply **category-based filtering** using continuously updated threat intelligence feeds
- DNS over HTTPS (**DoH**) can **bypass** traditional DNS filtering by encrypting queries directly to resolvers like 1.1.1.1, a key evasion technique attackers exploit
- On Security+/CySA+, DNS filtering is classified as a **preventive and detective control** — it blocks threats and logs attempted policy violations simultaneously

## Related concepts
[[DNS Sinkhole]] [[Command and Control (C2)]] [[Protective DNS]] [[Content Filtering]] [[DNS over HTTPS (DoH)]]