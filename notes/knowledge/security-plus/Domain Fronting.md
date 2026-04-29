# Domain Fronting

## What it is
Imagine mailing a letter addressed to a respected bank, but slipping a secret note inside for a criminal hideout — the postal service sees "bank," but the actual delivery goes elsewhere. Domain fronting exploits how CDN (Content Delivery Network) infrastructure routes HTTPS traffic: the outer TLS SNI field and HTTP Host header show a legitimate, trusted domain, while the inner HTTP request secretly routes traffic to a malicious backend server.

## Why it matters
APT groups and malware C2 frameworks (including early versions of Cobalt Strike) used domain fronting to hide command-and-control traffic behind trusted CDN providers like Amazon CloudFront or Google's infrastructure. Defenders monitoring network traffic would see connections to legitimate cloud giants, making detection and blocking extremely difficult without deep packet inspection of decrypted HTTPS content.

## Key facts
- The **SNI field** (visible in plaintext during TLS handshake) shows a benign domain; the **HTTP Host header** (encrypted) redirects to the actual malicious destination
- Major CDNs — including **AWS CloudFront and Google Cloud** — explicitly banned domain fronting around 2018 after nation-state abuse was identified
- It is categorized as a **C2 obfuscation / traffic tunneling** technique (MITRE ATT&CK T1090.004)
- Detection requires **TLS inspection (SSL decryption)** at the proxy/firewall level to compare SNI vs. Host header mismatches
- **Signal and Telegram** briefly used domain fronting to bypass government censorship, illustrating its dual-use nature

## Related concepts
[[C2 (Command and Control)]] [[TLS Inspection]] [[DNS Sinkholes]] [[CDN Abuse]] [[Traffic Tunneling]]