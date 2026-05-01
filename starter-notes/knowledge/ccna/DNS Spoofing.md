# DNS spoofing

## What it is
Imagine a corrupt phone book that lists your bank's address as a criminal's warehouse — callers think they're going somewhere legitimate, but they end up somewhere dangerous. DNS spoofing (also called DNS cache poisoning) is the attack where an adversary injects fraudulent DNS records into a resolver's cache, causing victims to receive a malicious IP address when querying a legitimate domain name.

## Why it matters
In 2008, researcher Dan Kaminsky disclosed a critical DNS vulnerability allowing attackers to poison resolver caches at scale by flooding resolvers with forged UDP responses before the legitimate reply arrived — affecting virtually every DNS implementation globally. A successful attack could silently redirect millions of users to phishing sites or malware download servers without any visible warning in their browsers.

## Key facts
- DNS operates over **UDP port 53** by default; UDP's connectionless nature makes it easier to forge responses than TCP
- Attacks exploit the **16-bit transaction ID** in DNS packets — Kaminsky's attack showed this space (65,536 values) could be brute-forced quickly
- **DNSSEC** (DNS Security Extensions) counters spoofing by digitally signing DNS records using asymmetric cryptography, allowing resolvers to verify authenticity
- Cache poisoning persists for the duration of the record's **TTL (Time to Live)** — attackers prefer low-TTL records to avoid long waits before re-poisoning
- **DNS over HTTPS (DoH)** and **DNS over TLS (DoT)** encrypt DNS traffic, preventing man-in-the-middle interception but not necessarily cache poisoning itself

## Related concepts
[[DNSSEC]] [[ARP spoofing]] [[Man-in-the-Middle attack]] [[DNS hijacking]] [[DNS Cache Poisoning]]
