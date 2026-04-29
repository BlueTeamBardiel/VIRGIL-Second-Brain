# man-in-the-middle

## What it is
Imagine a postal worker who secretly opens every letter between two pen pals, reads or rewrites the contents, reseals the envelopes, and forwards them — while both parties believe they're corresponding privately. A man-in-the-middle (MitM) attack occurs when an attacker secretly intercepts and potentially alters communications between two parties who each believe they are communicating directly with the other. The attacker sits between both endpoints, with full visibility and control over the traffic.

## Why it matters
In 2011, attackers compromised certificate authority DigiNotar and issued fraudulent SSL certificates for Google domains, enabling state-sponsored MitM attacks against Iranian Gmail users — intercepting encrypted HTTPS traffic without victims receiving any browser warning. This demonstrates that MitM isn't just a LAN-level threat; a compromised trust chain can scale it to nation-state surveillance. Defense hinges on certificate pinning, HSTS, and robust PKI integrity.

## Key facts
- **ARP poisoning** is the classic LAN-layer MitM technique — the attacker sends fake ARP replies linking their MAC address to a legitimate IP, redirecting traffic through their machine
- **SSL stripping** downgrades HTTPS connections to HTTP, making encrypted sessions visible in plaintext; HSTS (HTTP Strict Transport Security) defeats this by refusing plaintext connections
- **SSL/TLS interception proxies** (e.g., corporate DLP tools) are *legitimate* MitM implementations — relevant for distinguishing authorized inspection from attacks on exams
- MitM attacks violate **confidentiality AND integrity** — attackers can read *and* modify traffic, making them more dangerous than passive eavesdropping alone
- **Certificate transparency logs** and **DNSSEC** are key infrastructure controls that help detect and prevent MitM attacks at the certificate and DNS resolution layers respectively

## Related concepts
[[ARP poisoning]] [[SSL stripping]] [[certificate authority]] [[PKI]] [[replay attack]]