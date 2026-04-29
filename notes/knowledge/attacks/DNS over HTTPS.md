# DNS over HTTPS

## What it is
Imagine you're asking a librarian for a book, but instead of whispering the title openly across a quiet room where anyone can hear, you pass a sealed envelope through a pneumatic tube. DNS over HTTPS (DoH) works the same way — it wraps traditional DNS queries inside encrypted HTTPS traffic (port 443), preventing observers from seeing which domain names you're resolving. This makes DNS lookups indistinguishable from ordinary web browsing traffic.

## Why it matters
In a corporate network, an attacker performing passive traffic analysis can read plaintext DNS queries to map which internal and external services employees use — without ever breaking encryption on the actual web sessions. DoH defeats this surveillance, but it also creates a defensive blind spot: security tools that rely on DNS monitoring to detect malware C2 beaconing lose visibility when endpoints bypass the internal resolver entirely, which is why many enterprises block DoH at the firewall and enforce their own encrypted DNS resolvers.

## Key facts
- DoH runs over **port 443**, making it difficult to block without disrupting HTTPS traffic broadly
- Defined in **RFC 8484** (2018); major providers include Cloudflare (1.1.1.1), Google (8.8.8.8), and Mozilla's Trusted Recursive Resolver program
- Differs from **DNS over TLS (DoT)**, which uses a dedicated port 853 — easier to monitor or block but also easier to detect
- Threat actors have abused DoH to exfiltrate data and reach C2 servers while evading DNS-layer security controls (e.g., Godlua malware, 2019)
- Security+ and CySA+ treat DoH as both a **privacy control** and a **detection gap** — understanding both sides is testable

## Related concepts
[[DNS Poisoning]] [[DNS Tunneling]] [[Network Traffic Analysis]] [[TLS Inspection]]