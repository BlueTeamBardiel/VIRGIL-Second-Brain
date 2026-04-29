# SSL-VPN

## What it is
Think of it like a secure glass tube inserted through the chaotic plumbing of the internet — anything traveling inside that tube is protected from the mess outside. An SSL-VPN is a type of VPN that uses TLS (formerly SSL) to create an encrypted tunnel between a client and a network gateway, typically accessible through a standard web browser on port 443 without requiring a dedicated client application.

## Why it matters
In 2019, a critical vulnerability in Pulse Secure SSL-VPN (CVE-2019-11510) allowed unauthenticated attackers to read arbitrary files, exposing plaintext credentials. Ransomware groups like REvil actively harvested these credentials to pivot into corporate networks — compromising organizations that had never patched their internet-facing VPN appliances. This incident became a textbook case of why perimeter devices need priority patching.

## Key facts
- Operates over **port 443 (HTTPS)**, making it firewall-friendly and difficult to block without disrupting normal web traffic
- Two modes: **clientless** (browser-only, limited to web apps) and **tunnel mode** (full network access, requires thin client download)
- Uses **TLS handshake** for mutual authentication and session key negotiation — not the older, deprecated SSL protocol despite the name
- Preferred over IPsec VPNs in **BYOD and remote access** scenarios because it requires no pre-installed client or complex firewall rules
- SSL-VPN gateways are high-value targets — they sit on the **network perimeter**, are often internet-exposed 24/7, and historically receive delayed patches

## Related concepts
[[TLS]] [[IPsec-VPN]] [[Split-Tunneling]] [[Zero-Trust-Network-Access]] [[Remote-Access-Trojan]]