# DNS over TLS

## What it is
Imagine shouting your home address out loud on a crowded subway every time you ask for directions — that's plain DNS. DNS over TLS (DoT) is a protocol that wraps DNS queries inside a TLS-encrypted tunnel, preventing eavesdroppers from seeing which domain names you're resolving. It operates on TCP port 853 and was standardized in RFC 7858.

## Why it matters
On a corporate network, an attacker performing a man-in-the-middle attack can intercept unencrypted DNS queries to build a precise map of which services employees access — Salesforce, payroll systems, VPN gateways — without touching a single payload packet. DoT eliminates this passive reconnaissance channel by encrypting the query before it leaves the client, so a packet-sniffing adversary sees only a TLS handshake with a known resolver IP, not the actual hostnames being queried.

## Key facts
- DoT uses **TCP port 853** — a distinct, identifiable port that some organizations block to force DNS through monitored channels
- Provides **confidentiality and integrity** for DNS queries but does *not* guarantee the resolver itself is trustworthy or uncensored
- Different from **DNS over HTTPS (DoH)**, which uses port 443 and blends with web traffic, making it harder for network defenders to inspect or filter
- DoT prevents **DNS spoofing in transit** but is complementary to DNSSEC, which validates the authenticity of DNS *responses* via cryptographic signatures
- Supported natively in Android 9+ ("Private DNS" setting) and configurable in major resolvers like Cloudflare (1.1.1.1) and Google (8.8.8.8)

## Related concepts
[[DNS over HTTPS]] [[DNSSEC]] [[Man-in-the-Middle Attack]] [[Transport Layer Security]] [[DNS Spoofing]]
