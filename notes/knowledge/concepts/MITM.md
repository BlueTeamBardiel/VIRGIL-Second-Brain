# MITM

## What it is
Imagine a postal worker secretly opening your letters, reading them, resealing them perfectly, and forwarding them — both you and the recipient believe you're communicating directly. A Man-in-the-Middle (MITM) attack is precisely this: an adversary secretly intercepts and potentially alters communications between two parties who each believe they have a direct, private connection.

## Why it matters
In 2011, the compromised Dutch certificate authority DigiNotar allowed attackers to issue fraudulent SSL certificates for Google.com, enabling Iranian ISPs to conduct MITM attacks against ~300,000 Gmail users — intercepting credentials in real time while victims saw a valid padlock in their browser. This incident directly accelerated adoption of Certificate Transparency logs and HSTS preloading as defenses.

## Key facts
- **ARP Poisoning** is the most common LAN-based MITM technique — the attacker broadcasts fake ARP replies to associate their MAC address with a legitimate IP, rerouting traffic through their machine
- **SSL Stripping** downgrades HTTPS connections to HTTP silently; HSTS (HTTP Strict Transport Security) is the primary defense
- **Session hijacking** is a MITM variant where the attacker steals an authenticated session token rather than credentials directly
- **Mutual TLS (mTLS)** defeats most MITM attacks by requiring *both* parties to present valid certificates, not just the server
- On Security+, MITM is categorized under **on-path attacks** — the updated, vendor-neutral terminology you'll see on the exam

## Related concepts
[[ARP Poisoning]] [[SSL Stripping]] [[Certificate Authority]] [[Session Hijacking]] [[HSTS]]