# Protocol Security

## What it is
Like building codes that ensure every house has load-bearing walls and fire exits, protocol security defines the mandatory rules that govern how data is transmitted, authenticated, and protected during communication. It encompasses the design, implementation, and auditing of network protocols to ensure confidentiality, integrity, and authenticity of data in transit. Weaknesses in protocol design — not just implementation — can expose systems to fundamental, often unfixable, attacks.

## Why it matters
The POODLE attack (2014) exploited SSL 3.0's flawed padding mechanism, forcing browsers to downgrade from TLS to the broken protocol and exposing encrypted session cookies. Attackers didn't break the encryption math — they broke the *rules of the conversation*. This led to SSL 3.0 being formally deprecated and demonstrated that a protocol flaw affects every application built on top of it, regardless of how well those apps are coded.

## Key facts
- **TLS 1.0 and 1.1 are deprecated** by major browsers and NIST; TLS 1.3 is the current gold standard, removing legacy cipher suites entirely
- **Downgrade attacks** trick endpoints into negotiating weaker protocol versions; mitigated by mechanisms like TLS_FALLBACK_SCSV
- **Cleartext protocols** (Telnet, FTP, HTTP, SNMPv1/v2) transmit credentials without encryption and should be replaced with SSH, SFTP, HTTPS, SNMPv3
- **Replay attacks** exploit protocols lacking nonces or timestamps — Kerberos defends against this with short-lived tickets (default 10-minute skew tolerance)
- **DNSSEC** adds cryptographic signatures to DNS responses, protecting against cache poisoning attacks that exploit the inherently unauthenticated DNS protocol

## Related concepts
[[Transport Layer Security]] [[Cryptographic Attacks]] [[Network Protocols]] [[Man-in-the-Middle Attack]] [[DNS Security]]