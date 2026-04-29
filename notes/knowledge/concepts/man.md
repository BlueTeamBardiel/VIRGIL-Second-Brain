# man

## What it is
Like a postal worker who secretly opens your letter, reads it, alters it, then reseals it before delivery — a Man-in-the-Middle (MitM) attack is when an adversary secretly intercepts and potentially modifies communications between two parties who believe they are talking directly to each other. The attacker positions themselves in the communication path, relaying messages while maintaining the illusion of a legitimate connection.

## Why it matters
In 2011, the DigiNotar CA breach allowed attackers to issue fraudulent SSL certificates for Google.com, enabling Iranian ISPs to perform MitM attacks against ~300,000 Gmail users — intercepting credentials before those users ever knew. This illustrates why certificate pinning and certificate transparency logs exist as defensive countermeasures.

## Key facts
- **ARP Poisoning** is the most common LAN-based MitM technique — attacker sends gratuitous ARP replies associating their MAC address with a legitimate IP, redirecting traffic through their machine
- **SSL Stripping** downgrades HTTPS connections to HTTP mid-session; mitigated by HTTP Strict Transport Security (HSTS)
- **Evil Twin attacks** create rogue Wi-Fi access points mimicking legitimate SSIDs to intercept wireless traffic
- **MitB (Man-in-the-Browser)** uses malware injected into the browser to intercept transactions *after* TLS is established — bypassing transport-layer encryption entirely
- Mutual authentication (both parties verify each other's identity) is the primary architectural defense against MitM attacks

## Related concepts
[[ARP Poisoning]] [[SSL Stripping]] [[Certificate Pinning]] [[Evil Twin Attack]] [[Public Key Infrastructure]]