# Cache Poisoning

## What it is
Imagine a town's only librarian keeps a quick-reference notepad of frequently asked questions — but a prankster sneaks in and rewrites "Where is the hospital?" to point to a cliff. Cache poisoning works the same way: an attacker injects malicious data into a caching system so that future legitimate requests receive the fraudulent response instead of the real one. It exploits the trust a system places in its own memory.

## Why it matters
In DNS cache poisoning (the Kaminsky Attack, 2008), an attacker floods a DNS resolver with forged responses to redirect users from legitimate banking sites to attacker-controlled clones — without the victim ever knowing. This was severe enough that emergency coordinated patches were issued across the entire internet infrastructure simultaneously, making it one of the most significant DNS vulnerabilities ever disclosed.

## Key facts
- **DNS cache poisoning** tricks resolvers into storing false IP-to-domain mappings; mitigated by DNSSEC, which cryptographically signs DNS records
- **Web cache poisoning** manipulates HTTP headers (e.g., `X-Forwarded-Host`) so CDNs serve malicious content to all users requesting a cached page
- The **Kaminsky Attack** exploited the predictable 16-bit transaction ID space in DNS, enabling brute-force forgery; modern mitigation uses source port randomization
- Cache poisoning differs from cache overflow — poisoning injects *false data*, while overflow corrupts *memory structure*
- Impacts **confidentiality and integrity**; can enable phishing, session hijacking, and malware distribution at scale without touching the origin server

## Related concepts
[[DNS Spoofing]] [[DNSSEC]] [[Man-in-the-Middle Attack]] [[HTTP Response Splitting]] [[CDN Security]]