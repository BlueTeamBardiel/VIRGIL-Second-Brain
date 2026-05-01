# DNS poisoning

## What it is
Imagine a city's street directory being secretly altered so that "123 Bank Street" now points to a criminal's warehouse — everyone following the directory gets robbed. DNS poisoning (also called DNS cache poisoning) works the same way: an attacker injects fraudulent DNS records into a resolver's cache, causing victims to resolve legitimate domain names to malicious IP addresses without any warning.

## Why it matters
In 2008, researcher Dan Kaminsky discovered a critical flaw allowing attackers to poison DNS resolvers at scale by flooding them with forged UDP responses, racing to win the transaction ID lottery before the legitimate answer arrived. This vulnerability affected the global internet infrastructure and required emergency coordinated patching across virtually every DNS implementation — demonstrating that DNS poisoning isn't academic, it's a systemic threat to trust online.

## Key facts
- DNS uses **UDP port 53** by default; UDP's connectionless nature makes spoofing easier since there's no handshake to verify the sender
- Attackers must match the **16-bit transaction ID** (only 65,536 possibilities) to successfully inject a forged response — the Kaminsky attack exploited this small space
- **DNSSEC** (DNS Security Extensions) mitigates poisoning by digitally signing DNS records, allowing resolvers to verify authenticity — but adoption remains incomplete
- Poisoned cache entries persist until **TTL (Time to Live)** expires, meaning a single successful attack can redirect thousands of victims
- DNS poisoning enables downstream attacks including **pharming**, credential harvesting, and man-in-the-middle SSL stripping

## Related concepts
[[DNSSEC]] [[Pharming]] [[Man-in-the-Middle Attack]] [[ARP Spoofing]] [[BGP Hijacking]]
