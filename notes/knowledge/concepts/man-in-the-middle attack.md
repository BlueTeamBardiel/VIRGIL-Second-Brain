# man-in-the-middle attack

## What it is
Imagine a postal worker who opens every letter you send, reads it, reseals it perfectly, and forwards it — both sides believe they're communicating privately, but a third party controls the entire conversation. A man-in-the-middle (MitM) attack occurs when an adversary secretly intercepts and potentially alters communications between two parties who believe they are talking directly to each other.

## Why it matters
In 2011, the DigiNotar CA breach allowed attackers to issue fraudulent SSL certificates for Google.com, enabling Iranian ISPs to perform MitM attacks on ~300,000 Gmail users — intercepting encrypted HTTPS traffic without triggering browser warnings. This attack exposed how certificate trust chains are a critical single point of failure in encrypted communications.

## Key facts
- **ARP poisoning** is the most common LAN-based MitM technique — the attacker sends gratuitous ARP replies associating their MAC address with a legitimate IP, redirecting traffic through their machine
- **SSL stripping** downgrades HTTPS connections to HTTP transparently, allowing plaintext interception even when the server supports encryption
- **HSTS (HTTP Strict Transport Security)** is the primary defense against SSL stripping — browsers refuse HTTP connections to sites that have declared HSTS headers
- MitM attacks are classified as **active attacks** (not passive) because the attacker modifies or injects data, distinguishing them from eavesdropping/sniffing
- **Certificate pinning** defends against fraudulent certificate-based MitM by hardcoding expected certificate fingerprints directly into applications

## Related concepts
[[ARP poisoning]] [[SSL stripping]] [[certificate pinning]] [[public key infrastructure]] [[session hijacking]]