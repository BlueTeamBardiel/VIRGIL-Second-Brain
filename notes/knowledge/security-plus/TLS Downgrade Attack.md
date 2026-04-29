# TLS Downgrade Attack

## What it is
Imagine a translator who secretly convinces two diplomats that neither speaks the other's language well enough, so they settle for communicating in pig latin instead of encrypted cipher. A TLS downgrade attack is when a man-in-the-middle adversary manipulates the TLS handshake negotiation to force client and server to use an older, weaker protocol version (like SSL 3.0 or TLS 1.0) or a weaker cipher suite, making traffic easier to crack. The attacker exploits the backward-compatibility mechanisms built into TLS to deliberately degrade security.

## Why it matters
POODLE (Padding Oracle On Downgraded Legacy Encryption), disclosed in 2014, demonstrated this perfectly: attackers forced browsers to fall back to SSL 3.0, then exploited its CBC padding vulnerability to decrypt session cookies and hijack authenticated sessions. This attack prompted major browsers to disable SSL 3.0 entirely and accelerated adoption of TLS 1.2+. Modern defenses include the **TLS_FALLBACK_SCSV** pseudo-cipher suite, which signals that a fallback occurred and lets servers reject it.

## Key facts
- POODLE and BEAST are the canonical exam examples of downgrade attacks exploiting older TLS/SSL versions
- **TLS_FALLBACK_SCSV** (RFC 7507) is the primary cryptographic defense — servers reject handshakes containing it unless no better version exists
- TLS 1.0 and 1.1 are deprecated by RFC 8996 (2021); compliant systems should only accept TLS 1.2 or 1.3
- TLS 1.3 eliminates downgrade risk by removing all legacy cipher suites and weak key exchange methods from its specification entirely
- Downgrade attacks are a form of **protocol manipulation**, often combined with ARP spoofing or DNS poisoning to achieve the required MITM position

## Related concepts
[[Man-in-the-Middle Attack]] [[SSL POODLE Vulnerability]] [[TLS Handshake Process]] [[Cipher Suite Negotiation]] [[Protocol Deprecation]]